# Live demo of Chapter 4, Lecture 1: a slice and a likelihood profile, with TMB.
#
# Run it section by section in a clean R session (about 16 minutes with explanation).
# It needs the packages RTMB, RTMBdist, TMB and glmmTMB (for the data). Section 0 can run
# before the demo; sections 1 to 5 follow the steps on the slide "Live demo: a likelihood
# profile in R". The owl model is written with the shape k and the probability p, as in
# the chapter section "Parameterisation, slices and profiles", and section 5 draws the
# figure of that section (Figure 4) in base R. The object names are those of the chapter.


# ---- 0. Packages and data -------------------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# Load the Owls data from the glmmTMB package without attaching the package.
data(Owls, package = "glmmTMB")

# Keep the visits of the female parent to nests with satiated nestlings.
satiated_female = Owls[Owls$FoodTreatment == "Satiated" & Owls$SexParent == "Female", ]
call_counts = satiated_female$SiblingNegotiation

# Method-of-moments estimates of the mean and the shape, used for the starting values.
mu_mom = mean(call_counts)
var_mom = mean((call_counts - mu_mom)^2)
k_mom = mu_mom^2 / (var_mom - mu_mom)

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)


# ---- The fit with k and p ----------------------------------------------------------

# The owl model with the shape k (size) and the probability p (prob) of dnbinom(), with
# log(k) and logit(p) as the transformed parameters. The mean is k * (1 - p) / p.
nb_prob_nll = function(parms, data) {
  getAll(parms, data)
  k = exp(log_k)
  p = plogis(logit_p)
  -sum(dnbinom(x = calls, size = k, prob = p, log = TRUE))
}

# Process the NLL, starting from the method-of-moments estimates, and fit it.
owl_prob_obj = MakeADFun(
  cmb(nb_prob_nll, list(calls = call_counts)),
  list(log_k = log(k_mom), logit_p = qlogis(k_mom / (k_mom + mu_mom))),
  silent = TRUE
)
owl_prob_fit = optim(
  par = owl_prob_obj$par,
  fn = owl_prob_obj$fn,
  gr = owl_prob_obj$gr,
  method = "BFGS"
)
owl_prob_fit$convergence

# Estimates on the original scale and the maximum log-likelihood: about 0.33, 0.064 and
# -299.44, the same maximum as with mu and k (invariance).
k_mle_prob = unname(exp(owl_prob_fit$par["log_k"]))
p_mle = unname(plogis(owl_prob_fit$par["logit_p"]))
loglik_nb = -owl_prob_fit$value
c(k_mle_prob = k_mle_prob, p_mle = p_mle, loglik_nb = loglik_nb)


# ---- The slice -----------------------------------------------------------------------

# Slice of k: p stays at its estimate, so each value needs only one call of fn().
k_fine = seq(from = 0.12, to = 0.75, length.out = 127)
slice_relative = rep(NA, times = length(k_fine))
for (i in seq_along(k_fine)) {
  slice_relative[i] = -owl_prob_obj$fn(c(log(k_fine[i]), qlogis(p_mle))) - loglik_nb
}


# ---- The profile -------------------------------------------------------------------

# TMB::tmbprofile() re-estimates logit(p) at every value of log(k). It takes the processed
# object and the name of the parameter as in the list of parameters, and returns a data
# frame with the values of log_k and the NLL (value) at each of them. By default it stops
# about 2 units below the maximum, enough for a 95% interval; ytol = 6 continues it to
# the lower limit of the figure.
owl_prob_profile_k = TMB::tmbprofile(owl_prob_obj, name = "log_k", ytol = 6, trace = FALSE)
head(owl_prob_profile_k)

# Relative profile log-likelihood on the scale of k.
profile_k = exp(owl_prob_profile_k$log_k)
profile_relative = -owl_prob_profile_k$value - loglik_nb

# ---- Both curves -------------------------------------------------------------------



# Relative log-likelihood along the profile and the slice
plot(
  x = profile_k,
  y = profile_relative,
  type = "l",
  col = "#D55E00",
  xlim = c(0.12, 0.75),
  ylim = c(-6, 0),
  xlab = "Shape, k",
  ylab = "Relative log-likelihood"
)
lines(x = k_fine, y = slice_relative, lty = 2, col = "#D55E00")
legend("bottomright", legend = c("Profile", "Slice"), lty = c(1, 2), bty = "n")

