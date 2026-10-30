# Figures for Lecture 2 of Chapter 4.
# Run in a clean R session from the repository root. Needs the packages RTMB, RTMBdist,
# TMB, ggplot2, patchwork, boot (fir) and glmmTMB (Owls). The simulations refit thousands
# of samples, so the script takes minutes. The figures are written into
# Chapter_4/Lecture_2/lecture-assets/.
#
# profile-interval.png, joint-region.png, coverage.png and sampling-distribution-k.png are
# unchanged copies of figure chunks of Chapter_4/Theory.qmd. The chunks run here in the
# chapter's order, after the chunks they depend on, with the chapter's seeds, so that the
# random draws are the same. Only the last line of each figure chunk changes, to assign
# the plot and save it. curvature-information.png, wald-parabolas.png and
# three-intervals.png are new figures, with the data and estimates of the chapter.

library(RTMB)
library(RTMBdist)
library(ggplot2)
library(patchwork)

out_dir = "Chapter_4/Lecture_2/lecture-assets"

# Resolution of the figures; each copy keeps the size of its chapter chunk.
fig_dpi = 192

# ---------------------------------------------------------------------------
# Chapter chunks on the fir seedlings
# ---------------------------------------------------------------------------

# Counts of balsam fir seedlings in 50 quadrats (see ?boot::fir), as in Chapter 3,
# and the number of quadrats.
data(fir, package = "boot")
seedling_counts = fir$count
n_quadrats = length(seedling_counts)
lambda_hat = mean(seedling_counts)

# The counts of the first ten quadrats and their maximum likelihood estimate.
ten_counts = seedling_counts[1:10]
lambda_hat_ten = mean(ten_counts)

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Negative log-likelihood on the log scale: log_lambda can take any real value
# and exp() turns it into a positive mean.
poisson_nll = function(parms, data) {
  getAll(parms, data)
  # Transform the parameter to the original scale.
  lambda = exp(log_lambda)
  -sum(dpois(x = counts, lambda = lambda, log = TRUE))
}

# The likelihood connected to the counts of the first ten quadrats, fitted with the Hessian.
fir_ten_obj = MakeADFun(
  cmb(poisson_nll, list(counts = ten_counts)),
  list(log_lambda = log(1)),
  silent = TRUE
)
fir_ten_fit = optim(
  par = fir_ten_obj$par, fn = fir_ten_obj$fn, gr = fir_ten_obj$gr,
  method = "BFGS", hessian = TRUE
)
stopifnot(fir_ten_fit$convergence == 0)

# Standard errors of the estimate of lambda (observed information of the ten quadrats)
# and of the estimate of log(lambda) (Hessian of the fit).
observed_information = sum(ten_counts) / lambda_hat_ten^2
standard_error = sqrt(1 / observed_information)
se_log_lambda = sqrt(1 / fir_ten_fit$hessian[1, 1])

# Log-likelihoods at the two estimates, and the Wald and profile cutoffs.
loglik_lambda_hat_ten = sum(dpois(x = ten_counts, lambda = lambda_hat_ten, log = TRUE))
loglik_lambda_hat_all = sum(dpois(x = seedling_counts, lambda = lambda_hat, log = TRUE))
critical_value = qnorm(p = 0.975)
cutoff = qchisq(p = 0.95, df = 1) / 2

# Candidate values of lambda (seedlings per quadrat).
lambda_grid = seq(from = 0.8, to = 5, by = 0.05)

# Relative log-likelihood of each sample on the grid.
relative_ten = rep(NA, times = length(lambda_grid))
relative_all = rep(NA, times = length(lambda_grid))
for (i in seq_along(lambda_grid)) {
  relative_ten[i] =
    sum(dpois(x = ten_counts, lambda = lambda_grid[i], log = TRUE)) - loglik_lambda_hat_ten
  relative_all[i] =
    sum(dpois(x = seedling_counts, lambda = lambda_grid[i], log = TRUE)) - loglik_lambda_hat_all
}

# ---------------------------------------------------------------------------
# Slide 7: curvature-information.png (new; 7 x 5)
# ---------------------------------------------------------------------------

curvature_data = rbind(
  data.frame(lambda = lambda_grid, relative = relative_ten, sample = "First ten quadrats"),
  data.frame(lambda = lambda_grid, relative = relative_all, sample = "All 50 quadrats")
)
curvature_data$sample = factor(
  curvature_data$sample,
  levels = c("First ten quadrats", "All 50 quadrats")
)

curvature_plot = ggplot(curvature_data, aes(x = lambda, y = relative, linetype = sample)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  coord_cartesian(ylim = c(-8, 0)) +
  labs(
    x = expression(paste("Mean seedlings per quadrat, ", lambda)),
    y = "Relative log-likelihood",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "curvature-information.png"),
  plot = curvature_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 11: wald-parabolas.png (new; 7 x 5) and
# Slide 15: three-intervals.png (new; 7 x 5), from one block of code
# ---------------------------------------------------------------------------

# Fine grid for the curves, because the parabolas are drawn over a wide range.
lambda_fine = seq(from = 0.8, to = 5, by = 0.01)
relative_fine = rep(NA, times = length(lambda_fine))
for (i in seq_along(lambda_fine)) {
  relative_fine[i] =
    sum(dpois(x = ten_counts, lambda = lambda_fine[i], log = TRUE)) - loglik_lambda_hat_ten
}

# The log-likelihood and its two quadratic approximations: a parabola on the original
# scale and a parabola on the log scale.
curve_levels = c("Log-likelihood", "Parabola, original scale", "Parabola, log scale")
parabola_data = rbind(
  data.frame(lambda = lambda_fine, relative = relative_fine, curve = curve_levels[1]),
  data.frame(
    lambda = lambda_fine,
    relative = -(lambda_fine - lambda_hat_ten)^2 / (2 * standard_error^2),
    curve = curve_levels[2]
  ),
  data.frame(
    lambda = lambda_fine,
    relative = -(log(lambda_fine) - log(lambda_hat_ten))^2 / (2 * se_log_lambda^2),
    curve = curve_levels[3]
  )
)
parabola_data$curve = factor(parabola_data$curve, levels = curve_levels)

wald_parabolas_plot = ggplot() +
  geom_hline(yintercept = -cutoff, colour = "grey40") +
  geom_line(
    data = parabola_data,
    aes(x = lambda, y = relative, linetype = curve),
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
  coord_cartesian(ylim = c(-6, 0)) +
  labs(
    x = expression(paste("Mean seedlings per quadrat, ", lambda)),
    y = "Relative log-likelihood",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "wald-parabolas.png"),
  plot = wald_parabolas_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# Endpoints of the Wald interval on the original scale and of the Wald interval from the
# log scale.
wald_original = lambda_hat_ten + c(-1, 1) * critical_value * standard_error
wald_log = exp(
  fir_ten_fit$par[["log_lambda"]] + c(-1, 1) * critical_value * se_log_lambda
)

# Relative log-likelihood of the ten quadrats plus the cutoff, as a function of lambda.
# With one parameter the log-likelihood is also the profile.
ten_crossing = function(lambda) {
  sum(dpois(x = ten_counts, lambda = lambda, log = TRUE)) - loglik_lambda_hat_ten + cutoff
}

# uniroot() finds where a function crosses zero inside an interval whose ends give
# values of opposite sign: once below the estimate and once above it.
lambda_lower = uniroot(f = ten_crossing, interval = c(0.8, lambda_hat_ten), tol = 1e-8)$root
lambda_upper = uniroot(f = ten_crossing, interval = c(lambda_hat_ten, 5), tol = 1e-8)$root

# The three intervals, as horizontal segments below the cutoff, each under its label.
interval_data = data.frame(
  label = c("Wald, original scale", "Wald, log scale", "Profile"),
  lower = c(wald_original[1], wald_log[1], lambda_lower),
  upper = c(wald_original[2], wald_log[2], lambda_upper),
  height = c(-3.1, -4.1, -5.1)
)

three_intervals_plot = wald_parabolas_plot +
  geom_segment(
    data = interval_data,
    aes(x = lower, xend = upper, y = height, yend = height),
    colour = "grey20",
    linewidth = 1.2
  ) +
  geom_text(
    data = interval_data,
    aes(x = (lower + upper) / 2, y = height + 0.32, label = label),
    colour = "grey20",
    size = 3.8
  )

ggsave(
  file.path(out_dir, "three-intervals.png"),
  plot = three_intervals_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks on the owls: the first version of the NLL, the fit and the surface
# ---------------------------------------------------------------------------

# Load the Owls data from the glmmTMB package without attaching the package.
data(Owls, package = "glmmTMB")

# Keep the visits of the female parent to nests with satiated nestlings.
satiated_female = Owls[Owls$FoodTreatment == "Satiated" & Owls$SexParent == "Female", ]

# Number of calls at each of these visits, and the number of visits.
call_counts = satiated_female$SiblingNegotiation
n_visits = length(call_counts)

# Method-of-moments estimates, as in the practical of Chapter 3.
mu_hat = mean(call_counts)
variance_hat = mean((call_counts - mu_hat)^2)
k_mom = mu_hat^2 / (variance_hat - mu_hat)

# Negative log-likelihood of the Negative Binomial model with mean mu and shape k.
nb_nll = function(parms, data) {
  getAll(parms, data)
  # Transform the parameters to the original scale.
  mu = exp(log_mu)
  k = exp(log_k)
  -sum(dnbinom2(x = calls, mu = mu, size = k, log = TRUE))
}

# Process the NLL of the owl counts, starting from the method-of-moments estimates
# on the log scale.
owl_obj = MakeADFun(
  cmb(nb_nll, list(calls = call_counts)),
  list(log_mu = log(mu_hat), log_k = log(k_mom)),
  silent = TRUE
)

# Fit the model and check the convergence code.
owl_fit = optim(par = owl_obj$par, fn = owl_obj$fn, gr = owl_obj$gr, method = "BFGS")
stopifnot(owl_fit$convergence == 0)

# Maximum likelihood estimates on the original scale.
mu_mle = unname(exp(owl_fit$par["log_mu"]))
k_mle = unname(exp(owl_fit$par["log_k"]))

# Log-likelihood at the maximum likelihood estimates.
loglik_mle = -owl_fit$value

# Grids of candidate values for the mean (calls per visit) and the shape.
mu_grid = seq(from = 2.5, to = 9, length.out = 91)
k_grid = seq(from = 0.12, to = 0.75, length.out = 91)

# Pre-allocate a matrix and fill it with two nested loops: row i for the i-th mean
# and column j for the j-th shape. fn() takes log(mu) and log(k) and returns the NLL.
loglik_surface = matrix(NA, nrow = length(mu_grid), ncol = length(k_grid))
for (i in seq_along(mu_grid)) {
  for (j in seq_along(k_grid)) {
    loglik_surface[i, j] = -owl_obj$fn(c(log(mu_grid[i]), log(k_grid[j])))
  }
}

# Relative log-likelihood: the difference from the maximum found by optim().
relative_surface = loglik_surface - loglik_mle

# Arrange the matrix as a data frame: mu varies fastest, as in as.vector() of the matrix.
surface_data = expand.grid(mu = mu_grid, k = k_grid)
surface_data$relative = as.vector(relative_surface)

# ---------------------------------------------------------------------------
# Chapter chunks: the NLL with ADREPORT(k), its fit and the profiles
# ---------------------------------------------------------------------------

# The Negative Binomial NLL with one more line.
nb_nll = function(parms, data) {
  getAll(parms, data)
  mu = exp(log_mu)
  k = exp(log_k)
  # Ask for the standard error of k itself.
  ADREPORT(k)
  -sum(dnbinom2(x = calls, mu = mu, size = k, log = TRUE))
}

# Process the new NLL and fit it again.
owl_obj = MakeADFun(
  cmb(nb_nll, list(calls = call_counts)),
  list(log_mu = log(mu_hat), log_k = log(k_mom)),
  silent = TRUE
)
owl_fit = optim(par = owl_obj$par, fn = owl_obj$fn, gr = owl_obj$gr, method = "BFGS")

# The standard errors of log(mu) and log(k), and the row of k from ADREPORT().
owl_sd = sdreport(owl_obj)

# Profiles of log(k) and log(mu), and their 95% intervals transformed back.
owl_profile_k = TMB::tmbprofile(owl_obj, name = "log_k", trace = FALSE)
owl_profile_mu = TMB::tmbprofile(owl_obj, name = "log_mu", trace = FALSE)
owl_interval_k = exp(confint(owl_profile_k))
owl_interval_mu = exp(confint(owl_profile_mu))

# ---------------------------------------------------------------------------
# Slide 18: profile-interval.png (copy of fig-profile_interval; 7 x 5)
# ---------------------------------------------------------------------------

# The profile of mu over a wider range than the default of tmbprofile() (ytol is the
# drop in log-likelihood at which the profile stops), as a relative log-likelihood.
profile_mu_wide = TMB::tmbprofile(owl_obj, name = "log_mu", ytol = 6, trace = FALSE)
mu_lower = owl_interval_mu[1, "lower"]
mu_upper = owl_interval_mu[1, "upper"]
k_lower = owl_interval_k[1, "lower"]
k_upper = owl_interval_k[1, "upper"]

# Quadratic approximation around the estimate, with the standard error of mu from the
# Negative Binomial variance: sqrt((mu + mu^2 / k) / n), in calls per visit.
mu_fine = seq(from = 2.5, to = 9, length.out = 131)
se_mu_nb = sqrt((mu_mle + mu_mle^2 / k_mle) / n_visits)
quadratic_values = -(mu_fine - mu_mle)^2 / (2 * se_mu_nb^2)

curve_data = rbind(
  data.frame(
    mu = exp(profile_mu_wide$log_mu),
    relative = -(profile_mu_wide$value - min(profile_mu_wide$value)),
    curve = "Profile"
  ),
  data.frame(mu = mu_fine, relative = quadratic_values, curve = "Quadratic approximation")
)
profile_interval_plot = ggplot(curve_data, aes(x = mu, y = relative, linetype = curve)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  geom_hline(yintercept = -cutoff, colour = "grey40") +
  geom_vline(xintercept = c(mu_lower, mu_upper), colour = "grey40", linetype = "dotted") +
  coord_cartesian(xlim = c(2.5, 9), ylim = c(-6, 0)) +
  labs(
    x = expression(paste("Mean number of calls per visit, ", mu)),
    y = "Relative log-likelihood",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "profile-interval.png"),
  plot = profile_interval_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 19: joint-region.png (copy of fig-joint_region; 7 x 5)
# ---------------------------------------------------------------------------

# Cutoff for a joint region of two parameters: half the 95% quantile of a chi-squared
# distribution with two degrees of freedom (qchisq(p = 0.95, df = 2) is 5.99).
joint_cutoff = qchisq(p = 0.95, df = 2) / 2

# Contours of the surface, the contour of the joint region, the estimate and the
# profile intervals of the two parameters drawn along the axes.
joint_region_plot = ggplot() +
  geom_contour(
    data = surface_data,
    aes(x = mu, y = k, z = relative),
    breaks = c(-12, -9, -6, -4, -2, -1),
    colour = "grey40"
  ) +
  geom_contour(
    data = surface_data,
    aes(x = mu, y = k, z = relative),
    breaks = -joint_cutoff,
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  geom_point(
    data = data.frame(mu = mu_mle, k = k_mle),
    aes(x = mu, y = k),
    colour = "#D55E00",
    size = 3
  ) +
  annotate(
    "segment",
    x = mu_lower, xend = mu_upper, y = min(k_grid), yend = min(k_grid),
    linewidth = 1.2
  ) +
  annotate(
    "segment",
    x = min(mu_grid), xend = min(mu_grid), y = k_lower, yend = k_upper,
    linewidth = 1.2
  ) +
  labs(
    x = expression(paste("Mean number of calls per visit, ", mu)),
    y = expression(paste("Shape, ", italic(k)))
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "joint-region.png"),
  plot = joint_region_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks: the complete NLL, with OBS() for the simulations
# ---------------------------------------------------------------------------

# The complete NLL of the Negative Binomial model.
nb_nll = function(parms, data) {
  getAll(parms, data)
  # Mark the data as observations, so that they can be simulated.
  calls = OBS(calls)
  mu = exp(log_mu)
  k = exp(log_k)
  ADREPORT(k)
  -sum(dnbinom2(x = calls, mu = mu, size = k, log = TRUE))
}

# Process and fit as before (the estimates do not change).
owl_obj = MakeADFun(
  cmb(nb_nll, list(calls = call_counts)),
  list(log_mu = log(mu_hat), log_k = log(k_mom)),
  silent = TRUE
)
owl_fit = optim(par = owl_obj$par, fn = owl_obj$fn, gr = owl_obj$gr, method = "BFGS")

# ---------------------------------------------------------------------------
# Slide 21: coverage.png (copy of fig-coverage; 9 x 4). Seeds 701 and 702.
# ---------------------------------------------------------------------------

# Poisson model: coverage of the Wald interval on the original scale and of the
# likelihood interval, for a mean of 0.5 seedlings per quadrat and 10 quadrats.
poisson_sim_nll = function(parms, data) {
  getAll(parms, data)
  counts = OBS(counts)
  -sum(dpois(x = counts, lambda = exp(log_lambda), log = TRUE))
}
set.seed(seed = 701)
lambda_sim = 0.5
n_quadrats_sim = 10
# Placeholder data of the right length: the values are not used.
poisson_sim_obj = MakeADFun(
  cmb(poisson_sim_nll, list(counts = rep(0, times = n_quadrats_sim))),
  list(log_lambda = 0),
  silent = TRUE
)
# The estimate is the mean of the counts, so only the total of each sample is kept.
totals = rep(NA, times = 5000)
for (i in seq_along(totals)) {
  totals[i] = sum(poisson_sim_obj$simulate(log(lambda_sim))$counts)
}
estimates = totals / n_quadrats_sim

# Wald interval on the original scale.
se = sqrt(estimates / n_quadrats_sim)
wald_covered = estimates - critical_value * se <= lambda_sim &
  lambda_sim <= estimates + critical_value * se

# The likelihood interval contains lambda when its relative log-likelihood is within
# the cutoff. A sample of zeros has no finite estimate of the interval: a miss.
relative = -n_quadrats_sim * (lambda_sim - estimates) + totals * log(lambda_sim / estimates)
likelihood_covered = totals > 0 & relative >= -cutoff
coverage_poisson_small = c(wald = mean(wald_covered), likelihood = mean(likelihood_covered))

# Negative Binomial model (owl estimates), 20 visits: coverage of the Wald interval for k
# on the log scale and of the profile interval. The profile interval contains the
# generating k when the relative profile log-likelihood at that k is within the cutoff,
# which takes one extra fit with log(k) fixed in place of a whole profile.
set.seed(seed = 702)
n_visits_sim = 20
nb_sim_obj = MakeADFun(
  cmb(nb_nll, list(calls = rep(0, times = n_visits_sim))),
  list(log_mu = 0, log_k = 0),
  silent = TRUE
)
wald_covered = rep(NA, times = 2000)
profile_covered = rep(NA, times = 2000)
for (i in seq_along(wald_covered)) {
  sim_calls = nb_sim_obj$simulate(owl_fit$par)$calls
  # Starting values: the method-of-moments estimates when they exist.
  sim_mu = mean(sim_calls)
  sim_variance = mean((sim_calls - sim_mu)^2)
  k_start = ifelse(sim_variance > sim_mu, sim_mu^2 / (sim_variance - sim_mu), 1)
  sim_obj = MakeADFun(
    cmb(nb_nll, list(calls = sim_calls)),
    list(log_mu = log(sim_mu), log_k = log(k_start)),
    silent = TRUE
  )
  sim_fit = optim(par = sim_obj$par, fn = sim_obj$fn, gr = sim_obj$gr, method = "BFGS")
  se_log_k = tryCatch(
    summary(sdreport(sim_obj))["log_k", "Std. Error"],
    error = function(err) NA
  )
  if (sim_fit$convergence == 0 && !is.na(se_log_k)) {
    wald_covered[i] = abs(log(k_mle) - sim_fit$par[["log_k"]]) <= critical_value * se_log_k
    fixed_obj = MakeADFun(
      cmb(nb_nll, list(calls = sim_calls)),
      list(log_mu = log(sim_mu), log_k = log(k_mle)),
      map = list(log_k = factor(NA)),
      silent = TRUE
    )
    fixed_fit = optim(par = fixed_obj$par, fn = fixed_obj$fn, gr = fixed_obj$gr, method = "BFGS")
    profile_covered[i] = sim_fit$value - fixed_fit$value >= -cutoff
  }
}
coverage_nb_small = c(
  wald = mean(wald_covered, na.rm = TRUE),
  profile = mean(profile_covered, na.rm = TRUE),
  failed = sum(is.na(wald_covered))
)

# Collect the results for the figure.
coverage_results = data.frame(
  case = rep(
    c(
      "Poisson, λ = 0.5,\n10 quadrats",
      "Negative Binomial, k,\n20 visits"
    ),
    each = 2
  ),
  interval = rep(c("Wald", "Likelihood"), times = 2),
  coverage = c(
    coverage_poisson_small[["wald"]], coverage_poisson_small[["likelihood"]],
    coverage_nb_small[["wald"]], coverage_nb_small[["profile"]]
  )
)
coverage_results$case = factor(coverage_results$case, levels = unique(coverage_results$case))
print(coverage_results)

# Coverage by case and type of interval; the dashed line is the intended 0.95.
coverage_plot = ggplot(coverage_results, aes(x = case, y = coverage, shape = interval, linetype = interval)) +
  geom_hline(yintercept = 0.95, linetype = "dashed", colour = "grey40") +
  geom_point(
    position = position_dodge(width = 0.4),
    colour = "#D55E00",
    size = 3
  ) +
  scale_linetype_manual(values = c("solid", "solid")) +
  coord_cartesian(ylim = c(0.8, 1)) +
  labs(x = NULL, y = "Simulated coverage", shape = NULL) +
  guides(linetype = "none") +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "coverage.png"),
  plot = coverage_plot,
  width = 9, height = 4, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 24: sampling-distribution-k.png (copy of fig-sampling_distribution_k; 9 x 4).
# Seed 601.
# ---------------------------------------------------------------------------

# Hypothetical samples from a Negative Binomial model whose parameters are the
# maximum likelihood estimates for the owls, for three numbers of visits.
set.seed(seed = 601)
n_samples = 2000
visit_sizes = c(20, 122, 500)
sim_k_ml = matrix(NA, nrow = n_samples, ncol = length(visit_sizes))
sim_k_mom = matrix(NA, nrow = n_samples, ncol = length(visit_sizes))
for (s in seq_along(visit_sizes)) {
  # Placeholder data of the right length: the values are not used.
  placeholder_obj = MakeADFun(
    cmb(nb_nll, list(calls = rep(0, times = visit_sizes[s]))),
    list(log_mu = 0, log_k = 0),
    silent = TRUE
  )
  for (i in seq_len(n_samples)) {
    # One hypothetical sample at the estimates for the owls.
    sim_calls = placeholder_obj$simulate(owl_fit$par)$calls

    # Method of moments: k exists only when the variance is larger than the mean.
    sim_mu = mean(sim_calls)
    sim_variance = mean((sim_calls - sim_mu)^2)
    if (sim_variance > sim_mu) {
      sim_k_mom[i, s] = sim_mu^2 / (sim_variance - sim_mu)
    }

    # Maximum likelihood, starting from the method-of-moments estimates (or k = 1).
    k_start = ifelse(is.na(sim_k_mom[i, s]), 1, sim_k_mom[i, s])
    sim_obj = MakeADFun(
      cmb(nb_nll, list(calls = sim_calls)),
      list(log_mu = log(sim_mu), log_k = log(k_start)),
      silent = TRUE
    )
    sim_fit = optim(par = sim_obj$par, fn = sim_obj$fn, gr = sim_obj$gr, method = "BFGS")
    sim_k_ml[i, s] = exp(sim_fit$par[["log_k"]])
  }
}

# Histogram of the estimates for one number of visits, with its Normal approximation.
plot_sampling_k = function(column, bin_width) {
  estimates = sim_k_ml[, column]
  estimate_grid = seq(from = min(estimates), to = max(estimates), length.out = 200)
  approximation = data.frame(
    estimate = estimate_grid,
    density = dnorm(x = estimate_grid, mean = mean(estimates), sd = sd(estimates))
  )
  ggplot(data.frame(estimate = estimates), aes(x = estimate)) +
    geom_histogram(
      aes(y = after_stat(density)),
      binwidth = bin_width,
      fill = "grey90",
      colour = "grey40"
    ) +
    geom_line(
      data = approximation,
      aes(x = estimate, y = density),
      colour = "#D55E00",
      linewidth = 0.8
    ) +
    geom_vline(xintercept = k_mle, linetype = "dashed") +
    labs(
      title = paste(visit_sizes[column], "visits"),
      x = expression(paste("Estimated shape, ", italic(k))),
      y = "Density"
    ) +
    theme_classic()
}

ggsave(
  file.path(out_dir, "sampling-distribution-k.png"),
  plot = plot_sampling_k(column = 1, bin_width = 0.04) |
    plot_sampling_k(column = 3, bin_width = 0.01),
  width = 9, height = 4, dpi = fig_dpi
)
