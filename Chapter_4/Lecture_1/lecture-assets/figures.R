# Figures for Lecture 1 of Chapter 4.
# Run in a clean R session from the repository root. Needs the packages RTMB, RTMBdist,
# ggplot2, patchwork, boot (fir) and glmmTMB (Owls). The figures are written into
# Chapter_4/Lecture_1/lecture-assets/.
#
# The two figures of slide 7 are made for the lecture and have no counterpart in the
# chapter. Every other figure is an unchanged copy of a figure chunk of
# Chapter_4/Theory.qmd. The chunks run here in the chapter's order, after the chunks they
# depend on. Only the last line of each figure chunk changes, to assign the plot and save
# it. No chunk uses random numbers.

library(RTMB)
library(RTMBdist)
library(ggplot2)
library(patchwork)

out_dir = "Chapter_4/Lecture_1/lecture-assets"

# Resolution of the copies; each keeps the size of its chapter chunk.
fig_dpi = 192

# Counts of balsam fir seedlings in 50 quadrats (see ?boot::fir), as in Chapter 3,
# and the number of quadrats.
data(fir, package = "boot")
seedling_counts = fir$count
n_quadrats = length(seedling_counts)

# ---------------------------------------------------------------------------
# Slide 7: poisson-mass.png and fir-likelihood.png (made for the lecture; 7 x 5 each)
# ---------------------------------------------------------------------------

# The value of lambda that is fixed on the left and marked on the right.
lambda_fixed = 2

# Probability: lambda is fixed and the count varies.
mass_data = data.frame(count = 0:10)
mass_data$probability = dpois(x = mass_data$count, lambda = lambda_fixed)

poisson_mass_plot = ggplot(mass_data, aes(x = count, y = probability)) +
  geom_segment(aes(xend = count, yend = 0), colour = "#D55E00", linewidth = 1.2) +
  geom_point(colour = "#D55E00", size = 3) +
  scale_x_continuous(breaks = 0:10) +
  labs(
    x = expression(paste("Seedlings in a quadrat, ", italic(x))),
    y = "Probability"
  ) +
  theme_classic(base_size = 20)

ggsave(
  file.path(out_dir, "poisson-mass.png"),
  plot = poisson_mass_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# Likelihood: the 50 counts are fixed and lambda varies. Pre-allocate a vector and fill
# it with a loop over candidate values of lambda (seedlings per quadrat).
lambda_values = seq(from = 1.3, to = 3.1, by = 0.01)
likelihood_values = rep(NA, times = length(lambda_values))
for (i in seq_along(lambda_values)) {
  likelihood_values[i] = prod(dpois(x = seedling_counts, lambda = lambda_values[i]))
}

# The likelihood is plotted in units of 10^-39; its maximum is about 1.7e-39.
likelihood_data = data.frame(lambda = lambda_values, likelihood = likelihood_values / 1e-39)

fir_likelihood_plot = ggplot(likelihood_data, aes(x = lambda, y = likelihood)) +
  geom_line(colour = "#D55E00", linewidth = 1.2) +
  geom_vline(xintercept = lambda_fixed, linetype = "dashed", colour = "grey40") +
  labs(
    x = expression(paste("Mean seedlings per quadrat, ", lambda)),
    y = expression(paste("Likelihood (" %*% 10^-39, ")"))
  ) +
  theme_classic(base_size = 20)

ggsave(
  file.path(out_dir, "fir-likelihood.png"),
  plot = fir_likelihood_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 15: likelihood-curve.png (copy of fig-likelihood_curve; 7 x 5, the default size)
# ---------------------------------------------------------------------------

# The counts of the first ten quadrats and their maximum likelihood estimate.
ten_counts = seedling_counts[1:10]
lambda_hat_ten = mean(ten_counts)

# Candidate values of lambda (seedlings per quadrat).
lambda_grid = seq(from = 0.8, to = 5, by = 0.05)

# Pre-allocate a vector for the log-likelihood and fill it with a loop over the grid.
loglik_grid = rep(NA, times = length(lambda_grid))
for (i in seq_along(lambda_grid)) {
  loglik_grid[i] = sum(dpois(x = ten_counts, lambda = lambda_grid[i], log = TRUE))
}

# Relative log-likelihood: the difference from the log-likelihood at the estimate.
loglik_lambda_hat_ten = sum(dpois(x = ten_counts, lambda = lambda_hat_ten, log = TRUE))
relative_loglik = loglik_grid - loglik_lambda_hat_ten

# Plot the relative log-likelihood curve and mark its maximum.
curve_data = data.frame(lambda = lambda_grid, relative = relative_loglik)
likelihood_curve_plot = ggplot(curve_data, aes(x = lambda, y = relative)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  geom_vline(
    xintercept = lambda_hat_ten,
    linetype = "dashed",
    colour = "grey40"
  ) +
  coord_cartesian(ylim = c(-8, 0)) +
  labs(
    x = expression(paste("Mean seedlings per quadrat, ", lambda)),
    y = "Relative log-likelihood"
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "likelihood-curve.png"),
  plot = likelihood_curve_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks that the owl figures depend on (section "Models with several parameters")
# ---------------------------------------------------------------------------

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Load the Owls data from the glmmTMB package without attaching the package.
data(Owls, package = "glmmTMB")

# Keep the visits of the female parent to nests with satiated nestlings.
satiated_female = Owls[Owls$FoodTreatment == "Satiated" & Owls$SexParent == "Female", ]

# Number of calls at each of these visits, and the number of visits.
call_counts = satiated_female$SiblingNegotiation
n_visits = length(call_counts)

# Method-of-moments estimates, as in the practical of Chapter 3.
mu_mom = mean(call_counts)
var_mom = mean((call_counts - mu_mom)^2)
k_mom = mu_mom^2 / (var_mom - mu_mom)

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
  list(log_mu = log(mu_mom), log_k = log(k_mom)),
  silent = TRUE
)

# Fit the model and check the convergence code.
owl_fit = optim(par = owl_obj$par, fn = owl_obj$fn, gr = owl_obj$gr, method = "BFGS")
stopifnot(owl_fit$convergence == 0)

# Maximum likelihood estimates on the original scale.
mu_mle = unname(exp(owl_fit$par["log_mu"]))
k_mle = unname(exp(owl_fit$par["log_k"]))

# Log-likelihood at the maximum likelihood estimates.
loglik_nb = -owl_fit$value

# ---------------------------------------------------------------------------
# Slide 26: owl-fits.png (copy of fig-owl_fits; 9 x 4.5)
# ---------------------------------------------------------------------------

# Relative frequencies of each count in the sample.
count_values = 0:max(call_counts)
observed_data = data.frame(
  count = count_values,
  frequency = tabulate(call_counts + 1, nbins = length(count_values)) / n_visits
)

# Fitted probabilities for each model at every possible count.
fitted_data = rbind(
  data.frame(
    count = count_values,
    probability = dnbinom2(x = count_values, mu = mu_mle, size = k_mle),
    model = "Negative Binomial (maximum likelihood)"
  ),
  data.frame(
    count = count_values,
    probability = dpois(x = count_values, lambda = mu_mom),
    model = "Poisson"
  )
)

# Bars for the sample and lines with points for the models.
owl_fits_plot = ggplot() +
  geom_col(
    data = observed_data,
    aes(x = count, y = frequency),
    fill = "grey90",
    colour = "grey40"
  ) +
  geom_line(
    data = fitted_data,
    aes(x = count, y = probability, colour = model, linetype = model),
    linewidth = 0.8
  ) +
  geom_point(
    data = fitted_data,
    aes(x = count, y = probability, colour = model, shape = model)
  ) +
  scale_colour_manual(
    values = c("#D55E00", "grey20")
  ) +
  labs(
    x = "Number of calls per visit",
    y = "Relative frequency or probability",
    colour = NULL,
    linetype = NULL,
    shape = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top", legend.direction = "vertical")

ggsave(
  file.path(out_dir, "owl-fits.png"),
  plot = owl_fits_plot,
  width = 9, height = 4.5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 27: likelihood-surface.png (copy of fig-likelihood_surface; 7 x 5)
# ---------------------------------------------------------------------------

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
relative_surface = loglik_surface - loglik_nb

# Arrange the matrix as a data frame: mu varies fastest, as in as.vector() of the matrix.
surface_data = expand.grid(mu = mu_grid, k = k_grid)
surface_data$relative = as.vector(relative_surface)

# Contours of the relative log-likelihood with the maximum likelihood estimate.
likelihood_surface_plot = ggplot() +
  geom_contour(
    data = surface_data,
    aes(x = mu, y = k, z = relative),
    breaks = c(-12, -9, -6, -4, -3, -2, -1),
    colour = "grey40"
  ) +
  geom_point(
    data = data.frame(mu = mu_mle, k = k_mle),
    aes(x = mu, y = k),
    colour = "#D55E00",
    size = 3
  ) +
  labs(
    x = expression(paste("Mean number of calls per visit, ", mu)),
    y = expression(paste("Shape, ", italic(k)))
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "likelihood-surface.png"),
  plot = likelihood_surface_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slides 28 and 30: slice-profile.png (copy of fig-slice_profile; 10 x 4.5)
# Chapter chunks of the section "Parameterisation, slices and profiles".
# ---------------------------------------------------------------------------

# The owl model with the shape k (size) and probability p (prob) of dnbinom(), with log(k)
# and logit(p) as the transformed parameters.
nb_prob_nll = function(parms, data) {
  getAll(parms, data)
  k = exp(log_k)
  p = plogis(logit_p)
  -sum(dnbinom(x = calls, size = k, prob = p, log = TRUE))
}
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
stopifnot(owl_prob_fit$convergence == 0)

# Same maximum and same k as the first fit; p equals k / (k + mu) by invariance.
k_mle_prob = unname(exp(owl_prob_fit$par["log_k"]))
p_mle = unname(plogis(owl_prob_fit$par["logit_p"]))

# Surface in k and p.
k_grid_prob = seq(from = 0.12, to = 0.75, length.out = 91)
p_grid = seq(from = 0.02, to = 0.16, length.out = 91)
loglik_surface_prob = matrix(NA, nrow = length(k_grid_prob), ncol = length(p_grid))
for (i in seq_along(k_grid_prob)) {
  for (j in seq_along(p_grid)) {
    loglik_surface_prob[i, j] =
      -owl_prob_obj$fn(c(log(k_grid_prob[i]), qlogis(p_grid[j])))
  }
}
surface_prob_data = expand.grid(k = k_grid_prob, p = p_grid)
surface_prob_data$relative = as.vector(loglik_surface_prob - loglik_nb)

# Slice: p is fixed at its estimate.
k_fine = seq(from = 0.12, to = 0.75, length.out = 127)
slice_loglik = rep(NA, times = length(k_fine))
for (i in seq_along(k_fine)) {
  slice_loglik[i] = -owl_prob_obj$fn(c(log(k_fine[i]), qlogis(p_mle)))
}

# Profile: tmbprofile() re-estimates p for each k. ytol = 10 continues it to 10 units
# below the maximum, beyond the lower limit of the figure.
owl_prob_profile_k = TMB::tmbprofile(owl_prob_obj, name = "log_k", ytol = 10, trace = FALSE)
profile_data = data.frame(
  k = exp(owl_prob_profile_k$log_k),
  relative = -owl_prob_profile_k$value - loglik_nb
)

# Path of the profile: for every k the MLE of the mean is the mean of the counts, so the
# best p is k / (k + mu_mle).
profile_data$p = profile_data$k / (profile_data$k + mu_mle)

# Left panel: contours with the slice and the path of the profile.
left_panel = ggplot() +
  geom_contour(
    data = surface_prob_data,
    aes(x = k, y = p, z = relative),
    breaks = c(-12, -9, -6, -4, -3, -2, -1),
    colour = "grey40"
  ) +
  geom_hline(yintercept = p_mle, linetype = "dashed", colour = "#D55E00") +
  geom_line(data = profile_data, aes(x = k, y = p), colour = "#D55E00", linewidth = 0.8) +
  geom_point(
    data = data.frame(k = k_mle_prob, p = p_mle),
    aes(x = k, y = p),
    colour = "#D55E00",
    size = 3
  ) +
  labs(
    x = expression(paste("Shape, ", italic(k))),
    y = expression(paste("Probability, ", italic(p)))
  ) +
  theme_classic()

# Right panel: relative log-likelihood along the slice and along the profile.
slice_profile_data = rbind(
  data.frame(k = k_fine, relative = slice_loglik - loglik_nb, curve = "Slice"),
  data.frame(k = profile_data$k, relative = profile_data$relative, curve = "Profile")
)
right_panel = ggplot(slice_profile_data, aes(x = k, y = relative, linetype = curve)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  coord_cartesian(ylim = c(-6, 0)) +
  labs(
    x = expression(paste("Shape, ", italic(k))),
    y = "Relative log-likelihood",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "slice-profile.png"),
  plot = left_panel | right_panel,
  width = 10, height = 4.5, dpi = fig_dpi
)

# Ranges of k within 1.92 units of the maximum (quoted on the slide "Slice against profile").
within_slice = k_fine[slice_loglik - loglik_nb >= -1.92]
within_profile = profile_data$k[profile_data$relative >= -1.92]
print(round(c(slice = range(within_slice), profile = range(within_profile)), digits = 3))
