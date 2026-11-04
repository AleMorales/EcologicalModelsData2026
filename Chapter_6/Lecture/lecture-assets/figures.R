# Figures for the Chapter 6 lecture.
# Run in a clean R session from the repository root. Needs the packages RTMB, RTMBdist,
# TMB (tmbprofile()), ggplot2, patchwork, emdbook (ReedfrogFuncresp) and DHARMa. It runs
# in a few seconds. The figures are written into Chapter_6/Lecture/lecture-assets/.
#
# Every PNG is an unchanged copy of a figure chunk:
#   curve-distribution.png      fig-curve_distribution      Chapter_6/Theory.qmd (7 x 5)
#   fitted-curve.png            fig-fitted_curve            Chapter_6/Theory.qmd (7 x 5)
#   curve-band.png              fig-curve_band              Chapter_6/Theory.qmd (7 x 5)
#   residuals-binomial.png      fig-residuals_binomial      Chapter_6/Theory.qmd (9 x 4.5)
#   parameter-derivatives.png   fig-parameter_derivatives   Chapter_5/Theory.qmd (9 x 4)
# The chunks of Chapter 6 run here in the chapter's order, after the chunks that they
# depend on, with the chapter's seed (601), so that the random draws of the simulations
# and of the residuals are the same. Only the last line of each figure chunk changes, to
# assign the plot and save it (ggsave() for ggplot2, png() for DHARMa's base graphics).
# Chunks that no figure needs (the gradient, the Michaelis-Menten form, the Wald interval
# of H) are left out; none of them uses random numbers.

library(ggplot2)
library(patchwork)

out_dir = "Chapter_6/Lecture/lecture-assets"

# Resolution of the figures; each copy keeps the size of its chapter chunk.
fig_dpi = 192

# ---------------------------------------------------------------------------
# Slide 5: curve-distribution.png (copy of fig-curve_distribution; 7 x 5)
# ---------------------------------------------------------------------------

# Reed frog functional response.
data(ReedfrogFuncresp, package = "emdbook")

# Expected number killed with the values read by eye in Chapter 5.
alpha_eye = 0.5
H_eye = 1 / 60
curve_eye = data.frame(initial = seq(from = 0, to = 100, length.out = 200))
curve_eye$killed = curve_eye$initial * alpha_eye /
  (1 + alpha_eye * H_eye * curve_eye$initial)

# Binomial probabilities at three densities, drawn as horizontal bars that start at the
# density. Probabilities below 0.002 are left out.
bar_scale = 40
mass_data = NULL
for (n_tadpoles in c(10, 50, 100)) {
  killed_values = 0:n_tadpoles
  p_eye = alpha_eye / (1 + alpha_eye * H_eye * n_tadpoles)
  probability = dbinom(x = killed_values, size = n_tadpoles, prob = p_eye)
  keep = probability > 0.002
  mass_data = rbind(
    mass_data,
    data.frame(
      initial = n_tadpoles,
      killed = killed_values[keep],
      probability = probability[keep]
    )
  )
}

curve_distribution_plot = ggplot() +
  geom_segment(
    data = mass_data,
    aes(
      x = initial, xend = initial + bar_scale * probability,
      y = killed, yend = killed
    ),
    colour = "#D55E00",
    linewidth = 0.6
  ) +
  geom_line(
    data = curve_eye,
    aes(x = initial, y = killed),
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  geom_point(
    data = ReedfrogFuncresp,
    aes(x = Initial, y = Killed),
    colour = "#0072B2",
    alpha = 0.7,
    size = 2
  ) +
  labs(x = "Initial number of tadpoles per tank", y = "Tadpoles killed in 14 days") +
  theme_classic()

ggsave(
  file.path(out_dir, "curve-distribution.png"),
  plot = curve_distribution_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks: the data, the Binomial NLL, the fit and the estimates
# ---------------------------------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# Reed frog functional response (see ?emdbook::ReedfrogFuncresp): the initial number of
# tadpoles (Initial) and the number killed in 14 days (Killed) in each of 16 tanks.
data(ReedfrogFuncresp, package = "emdbook")
frog_data = list(initial = ReedfrogFuncresp$Initial, killed = ReedfrogFuncresp$Killed)

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

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Process the NLL, starting from the values read by eye in Chapter 5.
binomial_obj = MakeADFun(
  cmb(binomial_nll, frog_data),
  list(logit_alpha = qlogis(0.5), log_H = log(1 / 60)),
  silent = TRUE
)

# Minimise the NLL with BFGS and check the convergence code.
binomial_fit = optim(
  par = binomial_obj$par,
  fn = binomial_obj$fn,
  gr = binomial_obj$gr,
  method = "BFGS"
)
stopifnot(binomial_fit$convergence == 0)

# Estimates on the original scale.
alpha_mle = unname(plogis(binomial_fit$par["logit_alpha"]))
H_mle = unname(exp(binomial_fit$par["log_H"]))

# ---------------------------------------------------------------------------
# Slide 11: fitted-curve.png (copy of fig-fitted_curve; 7 x 5)
# ---------------------------------------------------------------------------

# Expected number killed with the maximum likelihood estimates and with the values by eye.
initial_values = seq(from = 0, to = 100, length.out = 200)
fitted_curves = data.frame(
  initial = rep(initial_values, times = 2),
  killed = c(
    initial_values * alpha_mle / (1 + alpha_mle * H_mle * initial_values),
    initial_values * alpha_eye / (1 + alpha_eye * H_eye * initial_values)
  ),
  curve = rep(c("Maximum likelihood", "By eye (Chapter 5)"), each = length(initial_values))
)

fitted_curve_plot = ggplot() +
  geom_point(
    data = ReedfrogFuncresp,
    aes(x = Initial, y = Killed),
    colour = "#0072B2",
    alpha = 0.7,
    size = 2
  ) +
  geom_line(
    data = fitted_curves,
    aes(x = initial, y = killed, linetype = curve),
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  scale_linetype_manual(
    values = c("Maximum likelihood" = "solid", "By eye (Chapter 5)" = "dashed")
  ) +
  labs(
    x = "Initial number of tadpoles per tank",
    y = "Tadpoles killed in 14 days",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")

ggsave(
  file.path(out_dir, "fitted-curve.png"),
  plot = fitted_curve_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks: standard errors, profile intervals, the grid and the band
# ---------------------------------------------------------------------------

# Standard errors on the optimised scales.
binomial_sd = sdreport(binomial_obj)

# Profiles of logit(alpha) and log(H). Each profile contains the estimate twice, so
# confint() warns that it collapses repeated values; the warning can be ignored.
binomial_profile_alpha = TMB::tmbprofile(binomial_obj, name = "logit_alpha", trace = FALSE)
binomial_profile_H = TMB::tmbprofile(binomial_obj, name = "log_H", trace = FALSE)

# 95% intervals transformed back to the original scale.
alpha_interval = plogis(confint(binomial_profile_alpha))
H_interval = exp(confint(binomial_profile_H))

# 1 / H decreases with H, so the endpoints swap.
profile_intervals = rbind(alpha_interval, H_interval, rev(1 / H_interval))
dimnames(profile_intervals) = list(c("alpha", "H", "1/H"), c("lower", "upper"))

# A grid of densities (tadpoles per tank), added to the list of data.
initial_grid = seq(from = 0, to = 100, by = 1)
frog_data$initial_grid = initial_grid

# The Binomial NLL with three more lines.
binomial_nll = function(parms, data) {
  getAll(parms, data)
  alpha = plogis(logit_alpha)
  H = exp(log_H)
  p = alpha / (1 + alpha * H * initial)
  # The logit of the probability of being killed at every density of the grid.
  p_grid = alpha / (1 + alpha * H * initial_grid)
  logit_p_grid = qlogis(p_grid)
  ADREPORT(logit_p_grid)
  -sum(dbinom(x = killed, size = initial, prob = p, log = TRUE))
}

# Process the new NLL, fit it again and calculate the standard errors.
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

# ---------------------------------------------------------------------------
# Slide 17: curve-band.png (copy of fig-curve_band; 7 x 5)
# ---------------------------------------------------------------------------

# Model, estimates and profile intervals for the inset.
format_interval = function(estimate, interval, digits) {
  paste0(
    formatC(estimate, format = "f", digits = digits),
    " [", formatC(interval[1], format = "f", digits = digits),
    ", ", formatC(interval[2], format = "f", digits = digits), "]"
  )
}
model_inset = paste(
  "Model: K ~ Binomial(N, p(N))",
  "p(N) = α / (1 + α H N)",
  "",
  "Estimates (95% profile intervals):",
  paste("α =", format_interval(alpha_mle, profile_intervals["alpha", ], 3)),
  paste("H =", format_interval(H_mle, profile_intervals["H", ], 4)),
  paste("1/H =", format_interval(1 / H_mle, profile_intervals["1/H", ], 1)),
  sep = "\n"
)

curve_band_plot = ggplot() +
  geom_ribbon(
    data = curve_band,
    aes(x = initial, ymin = lower, ymax = upper),
    fill = "#D55E00",
    alpha = 0.2
  ) +
  geom_line(
    data = curve_band,
    aes(x = initial, y = killed),
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  geom_point(
    data = ReedfrogFuncresp,
    aes(x = Initial, y = Killed),
    colour = "#0072B2",
    alpha = 0.7,
    size = 2
  ) +
  annotate(
    geom = "label",
    x = 0,
    y = 42,
    label = model_inset,
    hjust = 0,
    vjust = 1,
    size = 3.2,
    fill = "grey99",
    colour = "black",
    linewidth = 0.25
  ) +
  coord_cartesian(ylim = c(0, 42)) +
  labs(x = "Initial number of tadpoles per tank", y = "Tadpoles killed in 14 days") +
  theme_classic()

ggsave(
  file.path(out_dir, "curve-band.png"),
  plot = curve_band_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Chapter chunks: OBS() and the simulations (seed 601)
# ---------------------------------------------------------------------------

# The Binomial NLL with one more line.
binomial_nll = function(parms, data) {
  getAll(parms, data)
  # Mark the response as observations, so that they can be simulated.
  killed = OBS(killed)
  alpha = plogis(logit_alpha)
  H = exp(log_H)
  p = alpha / (1 + alpha * H * initial)
  p_grid = alpha / (1 + alpha * H * initial_grid)
  logit_p_grid = qlogis(p_grid)
  ADREPORT(logit_p_grid)
  -sum(dbinom(x = killed, size = initial, prob = p, log = TRUE))
}

# Process the new NLL and fit it again.
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
stopifnot(binomial_fit$convergence == 0)

# 1,000 hypothetical samples of the 16 tanks at the estimates: one row per tank and one
# column per hypothetical sample.
n_sim = 1000
binomial_simulations = matrix(NA, nrow = length(frog_data$killed), ncol = n_sim)
set.seed(seed = 601)
for (j in seq_len(n_sim)) {
  binomial_simulations[, j] = binomial_obj$simulate(binomial_fit$par)$killed
}

# ---------------------------------------------------------------------------
# Slide 21: residuals-binomial.png (copy of fig-residuals_binomial; 9 x 4.5)
# ---------------------------------------------------------------------------

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
png(
  file.path(out_dir, "residuals-binomial.png"),
  width = 9, height = 4.5, units = "in", res = fig_dpi
)
plot(binomial_residuals)
dev.off()

# The dispersion statistic quoted on slide 21 (2.93).
print(DHARMa::testDispersion(binomial_residuals, plot = FALSE)$statistic)

# ---------------------------------------------------------------------------
# Slide 14: parameter-derivatives.png (copy of fig-parameter_derivatives of
# Chapter_5/Theory.qmd; 9 x 4). The chunk uses no data and no random numbers.
# ---------------------------------------------------------------------------

x_values = seq(0, 600, length.out = 300)
wrt_a = data.frame(x = x_values, y = x_values / (120 + x_values))
wrt_b = data.frame(x = x_values, y = -60 * x_values / (120 + x_values)^2)

panel_wrt_a = ggplot(wrt_a, aes(x = x, y = y)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  labs(x = "x", y = "Partial derivative with respect to a") +
  theme_classic()

panel_wrt_b = ggplot(wrt_b, aes(x = x, y = y)) +
  geom_vline(xintercept = 120, linetype = "dashed", colour = "grey40") +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  labs(x = "x", y = "Partial derivative with respect to b") +
  theme_classic()

ggsave(
  file.path(out_dir, "parameter-derivatives.png"),
  plot = panel_wrt_a + panel_wrt_b,
  width = 9, height = 4, dpi = fig_dpi
)
