# Live demo of the Chapter 6 lecture: the modelling cycle for one model, the Binomial
# model with the Holling type II curve fitted to the reed frog functional response, from
# the fit to the residuals. There is no model comparison in the demo.
#
# Run it section by section in a clean R session (about 16 minutes with explanation; the
# code itself runs in a few seconds). It needs the packages RTMB, RTMBdist, TMB (for
# tmbprofile()), emdbook (for the data) and DHARMa. Run section 0 during the break before
# the demo. The sections follow the steps on the slide "Live demo: the modelling cycle
# for one model", and the code and object names are those of Chapter 6, so the numbers
# agree with the chapter.


# ---- 0. Packages and data -------------------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# Reed frog functional response (see ?emdbook::ReedfrogFuncresp): the initial number of
# tadpoles (Initial) and the number killed in 14 days (Killed) in each of 16 tanks.
data(ReedfrogFuncresp, package = "emdbook")
ReedfrogFuncresp

# The predictor and the response go in the list of data.
frog_data = list(initial = ReedfrogFuncresp$Initial, killed = ReedfrogFuncresp$Killed)

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)


# ---- 1. The NLL and the fit -----------------------------------------------------------

# Negative log-likelihood of the Binomial model with the Holling type II curve.
binomial_nll = function(parms, data) {
  # Make the elements of both lists available by name.
  getAll(parms, data)
  # Transform the parameters to the original scale.
  alpha = plogis(logit_alpha)
  H = exp(log_H)
  # Probability that a tadpole is killed, at the density of each tank.
  p = alpha / (1 + alpha * H * initial)
  -sum(dbinom(x = killed, size = initial, prob = p, log = TRUE))
}

# The NLL can be called directly with two lists, to check it before processing it.
binomial_nll(list(logit_alpha = qlogis(0.5), log_H = log(1 / 60)), frog_data)

# Process the NLL, starting from the values read by eye in Chapter 5 (alpha = 0.5 per
# experiment, H = 1/60 experiments per tadpole killed), on the transformed scales.
binomial_obj = MakeADFun(
  cmb(binomial_nll, frog_data),
  list(logit_alpha = qlogis(0.5), log_H = log(1 / 60)),
  silent = TRUE
)

# The gradient at the starting values: its signs tell BFGS where to move.
binomial_obj$gr(binomial_obj$par)

# Minimise the NLL with BFGS and check the convergence code (0).
binomial_fit = optim(
  par = binomial_obj$par,
  fn = binomial_obj$fn,
  gr = binomial_obj$gr,
  method = "BFGS"
)
binomial_fit$convergence

# The gradient at the estimates is close to zero.
binomial_obj$gr(binomial_fit$par)


# ---- 2. Estimates on the original scale and the curve over the data -------------------

# Estimates on the original scale.
alpha_mle = unname(plogis(binomial_fit$par["logit_alpha"]))
H_mle = unname(exp(binomial_fit$par["log_H"]))

# Asymptote and half-maximum of the expected number killed, by invariance
# (Chapter 5 read 60 and 120 by eye).
c(
  alpha_mle = alpha_mle,
  H_mle = H_mle,
  max_killed = 1 / H_mle,
  half_maximum = 1 / (alpha_mle * H_mle)
)

# The tanks and the expected number killed under the fitted model (solid) and with the
# values read by eye (dashed).
plot(frog_data$initial, frog_data$killed, xlim = c(0, 100), ylim = c(0, 40),
     xlab = "Initial number of tadpoles per tank", ylab = "Tadpoles killed in 14 days")
curve(alpha_mle * x / (1 + alpha_mle * H_mle * x), add = TRUE, col = "#D55E00")
curve(0.5 * x / (1 + 0.5 * x / 60), add = TRUE, lty = "dashed")


# ---- 3. Uncertainty of the parameters -------------------------------------------------

# Standard errors on the optimised scales, and the correlation between the estimates.
binomial_sd = sdreport(binomial_obj)
summary(binomial_sd)
cov2cor(binomial_sd$cov.fixed)

# Likelihood profile of log(H): the other parameter is re-estimated at every value.
binomial_profile_H = TMB::tmbprofile(binomial_obj, name = "log_H", trace = FALSE)
plot(binomial_profile_H)

# 95% interval of H, and of the largest number killed in one experiment, 1 / H (a
# decreasing function, so the endpoints swap). confint() warns that it collapses repeated
# values, because the profile contains the estimate twice; the warning can be ignored.
H_interval = exp(confint(binomial_profile_H))
H_interval
rev(1 / H_interval)


# ---- 4. Uncertainty of the curve ------------------------------------------------------

# A grid of densities (tadpoles per tank), added to the list of data.
initial_grid = seq(from = 0, to = 100, by = 1)
frog_data$initial_grid = initial_grid

# The NLL gains the curve on the grid with ADREPORT() (for this section) and OBS() on the
# response (for section 5).
binomial_nll = function(parms, data) {
  getAll(parms, data)
  # Mark the response as observations, so that they can be simulated.
  killed = OBS(killed)
  alpha = plogis(logit_alpha)
  H = exp(log_H)
  p = alpha / (1 + alpha * H * initial)
  # The logit of the probability of being killed at every density of the grid.
  p_grid = alpha / (1 + alpha * H * initial_grid)
  logit_p_grid = qlogis(p_grid)
  ADREPORT(logit_p_grid)
  -sum(dbinom(x = killed, size = initial, prob = p, log = TRUE))
}

# Process the new NLL, fit it again (the estimates do not change) and calculate the
# standard errors.
binomial_obj = MakeADFun(
  cmb(binomial_nll, frog_data),
  list(logit_alpha = qlogis(0.5), log_H = log(1 / 60)),
  silent = TRUE
)
binomial_fit = optim(
  par = binomial_obj$par,
  fn = binomial_obj$fn,
  gr = binomial_obj$gr,
  method = "BFGS"
)
binomial_sd = sdreport(binomial_obj)

# Rows of logit_p_grid: one per density of the grid.
band_summary = summary(binomial_sd, select = "report")
head(band_summary)

# Wald intervals on the logit scale.
critical_value = qnorm(p = 0.975)
logit_lower = band_summary[, "Estimate"] - critical_value * band_summary[, "Std. Error"]
logit_upper = band_summary[, "Estimate"] + critical_value * band_summary[, "Std. Error"]

# The curve and its band for the expected number killed.
curve_band = data.frame(
  initial = initial_grid,
  killed = initial_grid * plogis(band_summary[, "Estimate"]),
  lower = initial_grid * plogis(logit_lower),
  upper = initial_grid * plogis(logit_upper)
)
curve_band[curve_band$initial == 100, ]

# The tanks, the fitted curve and its pointwise 95% band (dashed).
plot(frog_data$initial, frog_data$killed, xlim = c(0, 100), ylim = c(0, 40),
     xlab = "Initial number of tadpoles per tank", ylab = "Tadpoles killed in 14 days")
lines(curve_band$initial, curve_band$killed, col = "#D55E00")
lines(curve_band$initial, curve_band$lower, col = "#D55E00", lty = "dashed")
lines(curve_band$initial, curve_band$upper, col = "#D55E00", lty = "dashed")


# ---- 5. Simulation and scaled quantile residuals --------------------------------------

# One hypothetical sample: the numbers killed in 16 tanks with the densities of the data.
binomial_obj$simulate(binomial_fit$par)$killed

# 1,000 hypothetical samples of the 16 tanks at the estimates: one row per tank and one
# column per hypothetical sample.
n_sim = 1000
binomial_simulations = matrix(NA, nrow = length(frog_data$killed), ncol = n_sim)
set.seed(seed = 601)
for (j in seq_len(n_sim)) {
  binomial_simulations[, j] = binomial_obj$simulate(binomial_fit$par)$killed
}

# Expected number killed in each tank under the fitted model.
binomial_expected = frog_data$initial * alpha_mle /
  (1 + alpha_mle * H_mle * frog_data$initial)

# Scaled quantile residuals from the simulations, and the two standard panels.
binomial_residuals = DHARMa::createDHARMa(
  simulatedResponse = binomial_simulations,
  observedResponse = frog_data$killed,
  fittedPredictedResponse = binomial_expected,
  integerResponse = TRUE
)
plot(binomial_residuals)

# The residual of each tank: the tank with 5 of 50 killed lies below all its simulations.
data.frame(
  initial = frog_data$initial,
  killed = frog_data$killed,
  residual = round(binomial_residuals$scaledResiduals, 3)
)

# Observed spread around the curve relative to the simulated spread.
DHARMa::testDispersion(binomial_residuals, plot = FALSE)$statistic
