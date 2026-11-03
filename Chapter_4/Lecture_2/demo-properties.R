# Live demo of Chapter 4, Lecture 2: properties of maximum likelihood estimators,
# checked by simulation with obj$simulate().
#
# Run it section by section in a clean R session (about 16 minutes with explanation).
# It needs the packages RTMB, RTMBdist and glmmTMB (for the data). The sections follow
# the steps on the slide "Live demo: properties by simulation". The simulation is the one
# of the chapter (section "Properties of maximum likelihood estimators", seed 601), so the
# numbers agree with the chapter and the slides when n_samples is 2,000. Section 3 takes
# a little over a minute; start it, then explain the loop while it runs.


# ---- 0. Packages, data and the fit --------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# Load the Owls data from the glmmTMB package without attaching the package.
data(Owls, package = "glmmTMB")

# Keep the visits of the female parent to nests with satiated nestlings.
satiated_female = Owls[Owls$FoodTreatment == "Satiated" & Owls$SexParent == "Female", ]
call_counts = satiated_female$SiblingNegotiation

# Method-of-moments estimates, used as starting values.
mu_mom = mean(call_counts)
var_mom = mean((call_counts - mu_mom)^2)
k_mom = mu_mom^2 / (var_mom - mu_mom)

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# The complete NLL of the Negative Binomial model: OBS() marks the data, so that the
# processed object can simulate them.
nb_nll = function(parms, data) {
  getAll(parms, data)
  calls = OBS(calls)
  mu = exp(log_mu)
  k = exp(log_k)
  ADREPORT(k)
  -sum(dnbinom2(x = calls, mu = mu, size = k, log = TRUE))
}

# Process the NLL, fit it and calculate the standard errors.
owl_obj = MakeADFun(
  cmb(nb_nll, list(calls = call_counts)),
  list(log_mu = log(mu_mom), log_k = log(k_mom)),
  silent = TRUE
)
owl_fit = optim(par = owl_obj$par, fn = owl_obj$fn, gr = owl_obj$gr, method = "BFGS")
owl_fit$convergence
owl_sd = sdreport(owl_obj)
summary(owl_sd)

# The estimates are the parameters of the simulation.
k_mle = unname(exp(owl_fit$par["log_k"]))


# ---- 1. One hypothetical sample -------------------------------------------------------

# simulate() takes the parameters on the scale that was optimised and returns a list with
# the simulated data under the name that they have in the NLL.
set.seed(seed = 700)
sim_calls = owl_obj$simulate(owl_fit$par)$calls
sim_calls[1:20]

# Same design and sample size as the data, so different values.
c(length(sim_calls), mean(sim_calls), mean(call_counts))


# ---- 2. Both estimates from one hypothetical sample ---------------------------------

# Method of moments: k exists only when the variance is larger than the mean.
sim_mu = mean(sim_calls)
sim_var = mean((sim_calls - sim_mu)^2)
sim_k_mom_one = ifelse(sim_var > sim_mu, sim_mu^2 / (sim_var - sim_mu), NA)

# Maximum likelihood: process the NLL with the simulated data and fit it, starting from
# log(mu) = 0 and log(k) = 0.
sim_obj = MakeADFun(
  cmb(nb_nll, list(calls = sim_calls)),
  list(log_mu = 0, log_k = 0),
  silent = TRUE
)
sim_fit = optim(par = sim_obj$par, fn = sim_obj$fn, gr = sim_obj$gr, method = "BFGS")
c(mom = sim_k_mom_one, ml = exp(sim_fit$par[["log_k"]]), used_to_simulate = k_mle)


# ---- 3. Many hypothetical samples: the sampling distributions -----------------------

# simulate() draws samples of the size of the data of its object, so for each sample
# size we process the NLL with placeholder data of that length (the values are not used).
# Each sample is fitted by maximum likelihood from log(mu) = 0 and log(k) = 0, and we keep
# the estimate of k and the sample itself (for the method of moments in section 4). With
# 2,000 samples per size this takes a little over a minute; fewer samples run faster but
# the numbers then differ from the chapter.
set.seed(seed = 601)
n_samples = 2000
visit_sizes = c(20, 122, 500)
sim_k_ml = matrix(NA, nrow = n_samples, ncol = length(visit_sizes))
sim_samples = list()
for (s in seq_along(visit_sizes)) {
  placeholder_obj = MakeADFun(
    cmb(nb_nll, list(calls = rep(0, times = visit_sizes[s]))),
    list(log_mu = 0, log_k = 0),
    silent = TRUE
  )
  # One row per hypothetical sample.
  sim_samples[[s]] = matrix(NA, nrow = n_samples, ncol = visit_sizes[s])
  for (i in seq_len(n_samples)) {
    # One hypothetical sample at the estimates for the owls.
    sim_calls = placeholder_obj$simulate(owl_fit$par)$calls
    sim_samples[[s]][i, ] = sim_calls

    # Maximum likelihood, starting from log(mu) = 0 and log(k) = 0.
    sim_obj = MakeADFun(
      cmb(nb_nll, list(calls = sim_calls)),
      list(log_mu = 0, log_k = 0),
      silent = TRUE
    )
    sim_fit = optim(par = sim_obj$par, fn = sim_obj$fn, gr = sim_obj$gr, method = "BFGS")
    sim_k_ml[i, s] = exp(sim_fit$par[["log_k"]])
  }
}

# One column per sample size: 20, 122 and 500 visits.
head(sim_k_ml)


# ---- 4. Properties from the simulated estimates -------------------------------------

# Consistency: fraction of the estimates that miss k by 0.1 or more, per sample size.
colMeans(abs(sim_k_ml - k_mle) >= 0.1)

# Asymptotic normality: histograms of the estimates with a Normal curve that has their
# mean and standard deviation; the vertical line is the k used to simulate.
estimates = sim_k_ml[, 1]
hist(estimates, breaks = 50, freq = FALSE,
     main = "20 visits", xlab = "Estimated shape, k")
curve(dnorm(x, mean = mean(estimates), sd = sd(estimates)), add = TRUE)
abline(v = k_mle, lty = "dashed")

estimates = sim_k_ml[, 3]
hist(estimates, breaks = 30, freq = FALSE,
     main = "500 visits", xlab = "Estimated shape, k")
curve(dnorm(x, mean = mean(estimates), sd = sd(estimates)), add = TRUE)
abline(v = k_mle, lty = "dashed")

# The standard error from one fit against the spread across hypothetical samples of the
# size of the data (122 visits), both for log(k).
c(sd_simulated = sd(log(sim_k_ml[, 2])),
  se_one_fit = summary(owl_sd)["log_k", "Std. Error"])

# Efficiency: method-of-moments estimates of k from the same hypothetical samples (k exists
# only when the variance is larger than the mean; otherwise the estimate stays NA).
sim_k_mom = matrix(NA, nrow = n_samples, ncol = length(visit_sizes))
for (s in seq_along(visit_sizes)) {
  for (i in seq_len(n_samples)) {
    sim_mu = mean(sim_samples[[s]][i, ])
    sim_var = mean((sim_samples[[s]][i, ] - sim_mu)^2)
    if (sim_var > sim_mu) {
      sim_k_mom[i, s] = sim_mu^2 / (sim_var - sim_mu)
    }
  }
}

# Standard deviation and mean squared error of both estimators.
# na.rm = TRUE skips the samples without a method-of-moments estimate.
efficiency_table = data.frame(
  visits = visit_sizes,
  sd_ml = apply(sim_k_ml, 2, sd),
  sd_mom = apply(sim_k_mom, 2, sd, na.rm = TRUE),
  mse_ml = colMeans((sim_k_ml - k_mle)^2),
  mse_mom = colMeans((sim_k_mom - k_mle)^2, na.rm = TRUE)
)
signif(efficiency_table, digits = 3)

# How many times as many visits the method of moments needs for the same precision.
(efficiency_table$sd_mom / efficiency_table$sd_ml)^2

# Bias in finite samples: the mean of the estimates relative to the k used to simulate.
data.frame(visits = visit_sizes, relative_bias = colMeans(sim_k_ml) / k_mle - 1)
