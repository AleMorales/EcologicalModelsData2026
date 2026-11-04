# Live demo of the Chapter 8 lecture: diagnosing a failed fit, for the complete-pooling
# model of the CO2 uptake curves of 12 plants. A fit from a poor starting point stops with
# convergence code 0 in the wrong place; we read the estimates, the gradient and
# sdreport(), look at a slice, fit from multiple random starting values, refine the best
# fit with BFGS and confirm it with a likelihood profile. There is no comparison of
# optimisers in the demo.
#
# Run it section by section in a clean R session (about 16 minutes with explanation; the
# code itself runs in a few seconds). It needs the packages RTMB, RTMBdist and TMB (for
# tmbprofile()); the data set CO2 is built into R. Run section 0 during the break before
# the demo. The sections follow the steps on the slide "Live demo: diagnosing a failed
# fit", and the code and object names are those of Chapter 8, so the numbers agree with
# the chapter.


# ---- 0. Packages, data and the NLL ----------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# CO2 uptake (µmol/m²/s) of 12 plants at seven concentrations of CO2 (µL/L); see ?CO2.
co2 = as.data.frame(CO2)
co2_data = list(conc = co2$conc, uptake = co2$uptake)

# The measurements.
plot(co2$conc, co2$uptake, pch = 1,
     xlab = expression("Ambient CO"[2] * " concentration (µL/L)"),
     ylab = expression("CO"[2] * " uptake (µmol/m²/s)"))

# Negative log-likelihood with one curve for all the plants (complete pooling).
pooled_nll = function(parms, data) {
  getAll(parms, data)
  a = exp(log_asym)
  b = exp(log_rate)
  sd_obs = exp(log_sd_obs)
  # Expected uptake at the concentration of each measurement.
  mu = a * (1 - exp(-b * (conc - c0)))
  -sum(dnorm(x = uptake, mean = mu, sd = sd_obs, log = TRUE))
}

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Process the NLL. The starting values are those of the slow rise: an asymptote of 30
# µmol/m²/s, a rate of 0.001 L/µL, zero uptake at 50 µL/L and a standard deviation of 2
# µmol/m²/s.
pooled_obj = MakeADFun(
  cmb(pooled_nll, co2_data),
  list(log_asym = log(30), log_rate = log(0.001), c0 = 50, log_sd_obs = log(2)),
  silent = TRUE
)


# ---- 1. A fit from a poor start -------------------------------------------------------

# BFGS with the gradient of RTMB.
poor_fit = optim(
  par = pooled_obj$par,
  fn = pooled_obj$fn,
  gr = pooled_obj$gr,
  method = "BFGS"
)

# Convergence code and minimum of the NLL: code 0, NLL 318.7.
poor_fit$convergence
poor_fit$value

# Estimates on the original scale: the rate is about 5e11 L/µL.
c(
  a = exp(poor_fit$par[["log_asym"]]),
  b = exp(poor_fit$par[["log_rate"]]),
  c = poor_fit$par[["c0"]],
  sd_obs = exp(poor_fit$par[["log_sd_obs"]])
)

# The curve over the data: a constant at the mean uptake.
conc_grid = seq(from = 95, to = 1000, length.out = 300)
poor_curve = exp(poor_fit$par[["log_asym"]]) *
  (1 - exp(-exp(poor_fit$par[["log_rate"]]) * (conc_grid - poor_fit$par[["c0"]])))
plot(co2$conc, co2$uptake, pch = 1,
     xlab = expression("Ambient CO"[2] * " concentration (µL/L)"),
     ylab = expression("CO"[2] * " uptake (µmol/m²/s)"))
lines(conc_grid, poor_curve, lty = "dashed")
abline(h = mean(co2$uptake), lty = "dotted")


# ---- 2. Diagnosis ---------------------------------------------------------------------

# The gradient at the solution is tiny, so it does not reveal the problem.
pooled_obj$gr(poor_fit$par)

# sdreport() at the values of this fit: the Hessian is not positive definite, the standard
# errors are NaN. par.fixed is needed because the object has evaluated many other points.
poor_sd = sdreport(pooled_obj, par.fixed = poor_fit$par)
poor_sd$pdHess
poor_sd

# A slice along the log rate through the solution, the other parameters fixed there.
log_rate_grid = seq(from = log(0.001), to = log(10), length.out = 101)
slice_nll = rep(NA, times = length(log_rate_grid))
for (i in seq_along(log_rate_grid)) {
  slice_par = poor_fit$par
  slice_par[["log_rate"]] = log_rate_grid[i]
  slice_nll[i] = pooled_obj$fn(slice_par)
}
# Relative log-likelihood: flat to the right, and about 12 units higher at 0.015 L/µL.
plot(exp(log_rate_grid), poor_fit$value - slice_nll, type = "l", log = "x",
     ylim = c(-30, 15),
     xlab = "Rate, b (L/µL, logarithmic axis)", ylab = "Relative log-likelihood")
abline(h = 0, lty = "dashed")


# ---- 3. Multiple random starts --------------------------------------------------------

# Box of plausible starting values on the optimised scales: log asymptote (5 to 100
# µmol/m²/s), log rate (1e-4 to 1 L/µL), location (0 to 90 µL/L) and log standard
# deviation (0.5 to 20 µmol/m²/s).
start_lower = c(log(5), log(1e-4), 0, log(0.5))
start_upper = c(log(100), log(1), 90, log(20))

# 50 fits from random starting values within the box.
n_starts = 50
multi_results = data.frame(
  nll = rep(NA, n_starts),
  convergence = NA,
  log_asym = NA, log_rate = NA, c0 = NA, log_sd_obs = NA
)
set.seed(801)
for (i in 1:n_starts) {
  start = runif(4, min = start_lower, max = start_upper)
  names(start) = names(pooled_obj$par)
  fit = optim(par = start, fn = pooled_obj$fn, gr = pooled_obj$gr, method = "BFGS")
  multi_results[i, ] = c(fit$value, fit$convergence, fit$par)
}

# Where the 50 fits ended: 17 at 296.3, 17 at 318.7, 14 at 402.8, one at 298.7 with
# code 1 and one far away.
table(nll = round(multi_results$nll, 1), convergence = multi_results$convergence)


# ---- 4. Refine and confirm ------------------------------------------------------------

# Restart BFGS from the best of the 50 fits.
best = which.min(multi_results$nll)
best_start = unlist(multi_results[best, names(pooled_obj$par)])
best_fit = optim(par = best_start, fn = pooled_obj$fn, gr = pooled_obj$gr, method = "BFGS")
best_fit$value

# sdreport() at the best fit: the Hessian is positive definite.
best_sd = sdreport(pooled_obj, par.fixed = best_fit$par)
best_sd$pdHess
best_sd

# Likelihood profile of the location c0, with TMB (RTMB does not export tmbprofile()).
pooled_obj$par = best_fit$par
pooled_profile_c0 = TMB::tmbprofile(pooled_obj, name = "c0", trace = FALSE)
# confint() warns that it collapses repeated values of the profile; the warning is harmless.
confint(pooled_profile_c0)
plot(pooled_profile_c0)


# ---- 5. The fitted curve over the data ------------------------------------------------

# Curve at the best fit, on the original scale, over the data and the poor fit.
best_curve = exp(best_fit$par[["log_asym"]]) *
  (1 - exp(-exp(best_fit$par[["log_rate"]]) * (conc_grid - best_fit$par[["c0"]])))
plot(co2$conc, co2$uptake, pch = 1,
     xlab = expression("Ambient CO"[2] * " concentration (µL/L)"),
     ylab = expression("CO"[2] * " uptake (µmol/m²/s)"))
lines(conc_grid, best_curve, lty = "solid", col = "#D55E00", lwd = 2)
lines(conc_grid, poor_curve, lty = "dashed")
legend("bottomright", legend = c("Best of 50 starts", "Poor start"),
       lty = c("solid", "dashed"), col = c("#D55E00", "black"), lwd = c(2, 1))
