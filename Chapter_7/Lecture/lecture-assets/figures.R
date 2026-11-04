# Figures for the Chapter 7 lecture.
# Run in a clean R session from the repository root. Needs the packages RTMB, RTMBdist,
# ggplot2 and DHARMa; the data set CO2 is built into R. It runs in about 15 seconds. The
# figures are written into Chapter_7/Lecture/lecture-assets/.
#
# Every PNG is an unchanged copy of a figure chunk of Chapter_7/Theory.qmd:
#   co2-data.png             fig-co2_data            slide 5   (7 x 5)
#   laplace.png              fig-laplace             slide 14  (7 x 5)
#   shrinkage.png            fig-shrinkage           slide 19  (7 x 6)
#   new-plants.png           fig-new_plants          slide 23  (7 x 5)
#   residuals-grouped.png    fig-residuals_grouped   slide 25  (9 x 4.5)
# The chunks of the chapter run here in the chapter's order, after the chunks that they
# depend on, with the chapter's seed (701) for the simulations behind the residuals, so
# that the random draws are the same. Only the last line of each figure chunk changes, to
# assign the plot and save it (ggsave() for ggplot2, png() for DHARMa's base graphics).
# Chunks that no figure needs (complete pooling, the Wald intervals of the chilling
# factors, the likelihood profiles, REML, the Practice callouts, the comparison) are left
# out; none of them draws random numbers before the simulations.

library(ggplot2)

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

out_dir = "Chapter_7/Lecture/lecture-assets"

# Resolution of the figures; each copy keeps the size of its chapter chunk.
fig_dpi = 192

# ---------------------------------------------------------------------------
# Slide 5: co2-data.png (copy of fig-co2_data; 7 x 5)
# ---------------------------------------------------------------------------

# CO2 uptake of 12 plants at seven concentrations (see ?CO2), as an ordinary data frame.
co2 = as.data.frame(CO2)

# Names of the plants in the order of the rows, and the index (1 to 12) of the plant of
# each measurement.
plant_names = unique(as.character(co2$Plant))
plant = match(as.character(co2$Plant), plant_names)

# List of data: the predictor, the response and the plant of each measurement.
co2_data = list(conc = co2$conc, uptake = co2$uptake, plant = plant)

# Measurements with the number of each plant within its origin and treatment.
co2_plot = co2
co2_plot$plant_number = substr(as.character(co2_plot$Plant), 3, 3)
co2_plot$Treatment = factor(co2_plot$Treatment, labels = c("Non-chilled", "Chilled"))

co2_data_plot = ggplot(co2_plot, aes(x = conc, y = uptake, group = Plant)) +
  geom_line(aes(linetype = plant_number), colour = "#0072B2", alpha = 0.7) +
  geom_point(aes(shape = plant_number), colour = "#0072B2", alpha = 0.7, size = 2) +
  facet_grid(Treatment ~ Type) +
  labs(
    x = expression("Ambient CO"[2] * " concentration (µL/L)"),
    y = expression("CO"[2] * " uptake (µmol/m²/s)"),
    linetype = "Plant",
    shape = "Plant"
  ) +
  theme_classic()
ggsave(
  file.path(out_dir, "co2-data.png"),
  plot = co2_data_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# No pooling (needed for slide 19)
# ---------------------------------------------------------------------------

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Negative log-likelihood with one asymptote for each plant (no pooling).
separate_nll = function(parms, data) {
  getAll(parms, data)
  a = exp(log_asym)
  b = exp(log_rate)
  sd_obs = exp(log_sd_obs)
  # a[plant] is the asymptote of the plant of each measurement.
  mu = a[plant] * (1 - exp(-b * (conc - c0)))
  -sum(dnorm(x = uptake, mean = mu, sd = sd_obs, log = TRUE))
}

# Process the NLL, with the same starting asymptote for every plant, and fit it.
separate_obj = MakeADFun(
  cmb(separate_nll, co2_data),
  list(log_asym = rep(log(30), 12), log_rate = log(0.01), c0 = 50, log_sd_obs = log(2)),
  silent = TRUE
)
separate_fit = optim(
  par = separate_obj$par,
  fn = separate_obj$fn,
  gr = separate_obj$gr,
  method = "BFGS"
)

# Asymptotes of the 12 plants without pooling (µmol/m²/s).
separate_asym = exp(separate_fit$par[names(separate_fit$par) == "log_asym"])
names(separate_asym) = plant_names

# ---------------------------------------------------------------------------
# Slide 14: laplace.png (copy of fig-laplace; 7 x 5)
# ---------------------------------------------------------------------------

# The model with a random asymptote, fitted as in the section on random effects in RTMB.
laplace_nll = function(parms, data) {
  getAll(parms, data)
  nll = -sum(dnorm(x = u, mean = 0, sd = exp(log_sd_plant), log = TRUE))
  a = exp(log_asym + u)
  mu = a[plant] * (1 - exp(-exp(log_rate) * (conc - c0)))
  nll - sum(dnorm(x = uptake, mean = mu, sd = exp(log_sd_obs), log = TRUE))
}
laplace_obj = MakeADFun(
  cmb(laplace_nll, co2_data),
  list(
    log_asym = log(30), log_rate = log(0.01), c0 = 50,
    log_sd_plant = log(0.1), log_sd_obs = log(2), u = rep(0, 12)
  ),
  random = "u",
  silent = TRUE
)
laplace_fit = optim(
  par = laplace_obj$par, fn = laplace_obj$fn, gr = laplace_obj$gr, method = "BFGS"
)
laplace_par = as.list(laplace_fit$par)

# Logarithm of the integrand for plant Mc2 (plant 11) at the estimates, for each value of u.
mc2 = co2_data$plant == 11
log_integrand = function(u) {
  values = numeric(length(u))
  for (i in seq_along(u)) {
    mu = exp(laplace_par$log_asym + u[i]) *
      (1 - exp(-exp(laplace_par$log_rate) * (co2_data$conc[mc2] - laplace_par$c0)))
    values[i] = sum(dnorm(x = co2_data$uptake[mc2], mean = mu,
                          sd = exp(laplace_par$log_sd_obs), log = TRUE)) +
      dnorm(x = u[i], mean = 0, sd = exp(laplace_par$log_sd_plant), log = TRUE)
  }
  values
}

# Peak: the predicted effect of Mc2. Curvature of the logarithm at the peak from a second
# difference.
u_peak = summary(sdreport(laplace_obj), select = "random")[11, "Estimate"]
step = 1e-4
curvature = -(log_integrand(u_peak + step) - 2 * log_integrand(u_peak) +
  log_integrand(u_peak - step)) / step^2

# Areas under the integrand and under its approximation, both relative to the peak.
area_exact = integrate(
  function(v) exp(log_integrand(v) - log_integrand(u_peak)),
  lower = u_peak - 1, upper = u_peak + 1, rel.tol = 1e-10
)$value
area_laplace = sqrt(2 * pi / curvature)
laplace_ratio = area_laplace / area_exact

# Both curves on a grid around the peak.
u_grid = seq(from = u_peak - 4 / sqrt(curvature), to = u_peak + 4 / sqrt(curvature),
             length.out = 200)
laplace_curves = data.frame(
  u = rep(u_grid, times = 2),
  value = c(
    exp(log_integrand(u_grid) - log_integrand(u_peak)),
    exp(-curvature * (u_grid - u_peak)^2 / 2)
  ),
  curve = rep(c("Integrand", "Laplace approximation"), each = length(u_grid))
)

laplace_plot = ggplot(laplace_curves, aes(x = u, y = value, linetype = curve)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  scale_linetype_manual(
    values = c("Integrand" = "solid", "Laplace approximation" = "dashed")
  ) +
  labs(
    x = "Deviation of plant Mc2, u (log scale of the asymptote)",
    y = "Integrand relative to its peak",
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top")
ggsave(
  file.path(out_dir, "laplace.png"),
  plot = laplace_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# The numbers quoted on slide 14: area 0.3% smaller, log-likelihood changed by 0.003.
print(c(
  percent_smaller = round(100 * (1 - laplace_ratio), 1),
  loglik_change = round(abs(log(laplace_ratio)), 3)
))

# ---------------------------------------------------------------------------
# The random asymptote, with and without origin and chilling (needed for slide 19)
# ---------------------------------------------------------------------------

# Joint negative log-likelihood with a random asymptote.
mixed_nll = function(parms, data) {
  getAll(parms, data)
  sd_plant = exp(log_sd_plant)
  # Minus the log density of the deviations of the plants, before they are used.
  nll = -sum(dnorm(x = u, mean = 0, sd = sd_plant, log = TRUE))
  # Asymptote of each plant, and minus the log density of the measurements for given u.
  a = exp(log_asym + u)
  b = exp(log_rate)
  sd_obs = exp(log_sd_obs)
  mu = a[plant] * (1 - exp(-b * (conc - c0)))
  nll - sum(dnorm(x = uptake, mean = mu, sd = sd_obs, log = TRUE))
}

# Process the joint NLL; random = "u" integrates the deviations out of the likelihood.
mixed_obj = MakeADFun(
  cmb(mixed_nll, co2_data),
  list(
    log_asym = log(30), log_rate = log(0.01), c0 = 50,
    log_sd_plant = log(0.1), log_sd_obs = log(2), u = rep(0, 12)
  ),
  random = "u",
  silent = TRUE
)

# Minimise the marginal NLL with BFGS: par holds only the five other parameters.
mixed_fit = optim(
  par = mixed_obj$par,
  fn = mixed_obj$fn,
  gr = mixed_obj$gr,
  method = "BFGS"
)
mixed_sd = sdreport(mixed_obj)

# Row of the first measurement of each plant.
first_row = match(seq_along(plant_names), plant)

# Indicators for each plant: 1 for Mississippi and 0 for Quebec; 1 for chilled and 0
# for non-chilled.
co2_data$mississippi = as.numeric(co2$Type[first_row] == "Mississippi")
co2_data$chilled = as.numeric(co2$Treatment[first_row] == "chilled")

# Joint NLL with a random asymptote and the effects of origin and chilling.
treatment_nll = function(parms, data) {
  getAll(parms, data)
  sd_plant = exp(log_sd_plant)
  nll = -sum(dnorm(x = u, mean = 0, sd = sd_plant, log = TRUE))
  # Log asymptote of each plant: baseline, effects of its origin and treatment, deviation.
  log_a = log_asym + beta_miss * mississippi + beta_chill * chilled +
    beta_int * mississippi * chilled + u
  a = exp(log_a)
  b = exp(log_rate)
  sd_obs = exp(log_sd_obs)
  # Logarithms of the factors by which chilling multiplies the asymptote (Quebec,
  # Mississippi).
  log_chill_factor = c(beta_chill, beta_chill + beta_int)
  ADREPORT(log_chill_factor)
  mu = a[plant] * (1 - exp(-b * (conc - c0)))
  nll - sum(dnorm(x = uptake, mean = mu, sd = sd_obs, log = TRUE))
}

# Process the joint NLL, integrating out u, and fit it.
treatment_obj = MakeADFun(
  cmb(treatment_nll, co2_data),
  list(
    log_asym = log(30), beta_miss = 0, beta_chill = 0, beta_int = 0,
    log_rate = log(0.01), c0 = 50,
    log_sd_plant = log(0.1), log_sd_obs = log(2), u = rep(0, 12)
  ),
  random = "u",
  silent = TRUE
)
treatment_fit = optim(
  par = treatment_obj$par,
  fn = treatment_obj$fn,
  gr = treatment_obj$gr,
  method = "BFGS"
)

# Standard errors on the optimised scales.
treatment_sd = sdreport(treatment_obj)

# ---------------------------------------------------------------------------
# Slide 19: shrinkage.png (copy of fig-shrinkage; 7 x 6)
# ---------------------------------------------------------------------------

# Typical asymptote (u = 0) of the group of each plant under the model with predictors.
treatment_par = treatment_fit$par
typical_treatment = exp(
  treatment_par[["log_asym"]] +
    treatment_par[["beta_miss"]] * co2_data$mississippi +
    treatment_par[["beta_chill"]] * co2_data$chilled +
    treatment_par[["beta_int"]] * co2_data$mississippi * co2_data$chilled
)
typical_mixed = rep(exp(mixed_fit$par[["log_asym"]]), times = 12)

# Asymptotes without pooling, predicted by each mixed model, and typical.
shrink_data = data.frame(
  plant = rep(1:12, times = 2),
  model = rep(
    c("Random asymptote", "Random asymptote with origin and chilling"),
    each = 12
  ),
  separate = rep(separate_asym, times = 2),
  predicted = c(
    typical_mixed * exp(summary(mixed_sd, select = "random")[, "Estimate"]),
    typical_treatment * exp(summary(treatment_sd, select = "random")[, "Estimate"])
  ),
  typical = c(typical_mixed, typical_treatment)
)

shrinkage_plot = ggplot(shrink_data) +
  geom_segment(
    aes(x = plant - 0.4, xend = plant + 0.4, y = typical, yend = typical),
    colour = "#D55E00",
    linetype = "dashed",
    linewidth = 0.6
  ) +
  geom_segment(
    aes(x = plant, xend = plant, y = separate, yend = predicted),
    colour = "grey40"
  ) +
  geom_point(aes(x = plant, y = separate), colour = "#0072B2", shape = 1, size = 2) +
  geom_point(aes(x = plant, y = predicted), colour = "#D55E00", size = 2) +
  facet_wrap(~ model, ncol = 1) +
  scale_x_continuous(breaks = 1:12, labels = plant_names) +
  labs(x = "Plant", y = "Asymptote (µmol/m²/s)") +
  theme_classic()
ggsave(
  file.path(out_dir, "shrinkage.png"),
  plot = shrinkage_plot,
  width = 7, height = 6, dpi = fig_dpi
)

# The numbers quoted on slide 19: Mc2 without pooling, predicted without and with the
# predictors, and the typical asymptote of its group.
print(round(c(
  separate = separate_asym[["Mc2"]],
  mixed = shrink_data$predicted[11],
  treatment = shrink_data$predicted[23],
  typical = typical_treatment[11]
), 2))

# ---------------------------------------------------------------------------
# Slide 23: new-plants.png (copy of fig-new_plants; 7 x 5)
# ---------------------------------------------------------------------------

# Estimates, the standard deviation among plants, and the log typical asymptote of each
# combination of origin and treatment.
treatment_par = treatment_fit$par
sd_plant = exp(treatment_par[["log_sd_plant"]])
mississippi_group = c(0, 0, 1, 1)
chilled_group = c(0, 1, 0, 1)
log_typical = treatment_par[["log_asym"]] +
  treatment_par[["beta_miss"]] * mississippi_group +
  treatment_par[["beta_chill"]] * chilled_group +
  treatment_par[["beta_int"]] * mississippi_group * chilled_group

# Typical asymptote and the range that contains the asymptotes of 95% of new plants
# (µmol/m²/s).
new_plant_asym = exp(cbind(
  typical = log_typical,
  lower = log_typical + qnorm(p = 0.025) * sd_plant,
  upper = log_typical + qnorm(p = 0.975) * sd_plant
))
rownames(new_plant_asym) = c(
  "Quebec, non-chilled", "Quebec, chilled", "Mississippi, non-chilled",
  "Mississippi, chilled"
)
print(round(new_plant_asym, 1))

# Concentrations at which the curves are drawn, and the shared part of the curve.
conc_grid = seq(from = 95, to = 1000, length.out = 200)
curve_shape = 1 - exp(-exp(treatment_par[["log_rate"]]) * (conc_grid - treatment_par[["c0"]]))

# Measurements and conditional curves of the chilled plants from Mississippi (10 to 12).
mc_rows = co2_data$plant %in% 10:12
mc_points = data.frame(
  conc = co2_data$conc[mc_rows],
  uptake = co2_data$uptake[mc_rows],
  plant = plant_names[co2_data$plant[mc_rows]]
)
mc_asym = typical_treatment[10:12] *
  exp(summary(treatment_sd, select = "random")[10:12, "Estimate"])
mc_curves = data.frame(
  conc = rep(conc_grid, times = 3),
  uptake = rep(curve_shape, times = 3) * rep(mc_asym, each = length(conc_grid)),
  plant = rep(plant_names[10:12], each = length(conc_grid))
)

# Typical curve and the range of new plants.
mc_range = data.frame(
  conc = conc_grid,
  typical = new_plant_asym["Mississippi, chilled", "typical"] * curve_shape,
  lower = new_plant_asym["Mississippi, chilled", "lower"] * curve_shape,
  upper = new_plant_asym["Mississippi, chilled", "upper"] * curve_shape
)

new_plants_plot = ggplot() +
  geom_ribbon(
    data = mc_range,
    aes(x = conc, ymin = lower, ymax = upper),
    fill = "#D55E00",
    alpha = 0.2
  ) +
  geom_line(data = mc_range, aes(x = conc, y = typical), colour = "#D55E00", linewidth = 0.8) +
  geom_line(data = mc_curves, aes(x = conc, y = uptake, linetype = plant), colour = "#0072B2") +
  geom_point(
    data = mc_points,
    aes(x = conc, y = uptake, shape = plant),
    colour = "#0072B2",
    alpha = 0.7,
    size = 2
  ) +
  labs(
    x = expression("Ambient CO"[2] * " concentration (µL/L)"),
    y = expression("CO"[2] * " uptake (µmol/m²/s)"),
    linetype = "Plant",
    shape = "Plant"
  ) +
  theme_classic()
ggsave(
  file.path(out_dir, "new-plants.png"),
  plot = new_plants_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 25: residuals-grouped.png (copy of fig-residuals_grouped; 9 x 4.5)
# ---------------------------------------------------------------------------

# The NLL with origin and chilling, with one more line.
treatment_nll = function(parms, data) {
  getAll(parms, data)
  # Mark the response as observations, so that they can be simulated.
  uptake = OBS(uptake)
  sd_plant = exp(log_sd_plant)
  nll = -sum(dnorm(x = u, mean = 0, sd = sd_plant, log = TRUE))
  log_a = log_asym + beta_miss * mississippi + beta_chill * chilled +
    beta_int * mississippi * chilled + u
  a = exp(log_a)
  b = exp(log_rate)
  sd_obs = exp(log_sd_obs)
  log_chill_factor = c(beta_chill, beta_chill + beta_int)
  ADREPORT(log_chill_factor)
  mu = a[plant] * (1 - exp(-b * (conc - c0)))
  nll - sum(dnorm(x = uptake, mean = mu, sd = sd_obs, log = TRUE))
}

# Process the new NLL and fit it again.
treatment_obj = MakeADFun(
  cmb(treatment_nll, co2_data),
  list(
    log_asym = log(30), beta_miss = 0, beta_chill = 0, beta_int = 0,
    log_rate = log(0.01), c0 = 50,
    log_sd_plant = log(0.1), log_sd_obs = log(2), u = rep(0, 12)
  ),
  random = "u",
  silent = TRUE
)
treatment_fit = optim(
  par = treatment_obj$par,
  fn = treatment_obj$fn,
  gr = treatment_obj$gr,
  method = "BFGS"
)

# 1,000 hypothetical samples: new plant deviations, then new measurements for them.
n_sim = 1000
treatment_simulations = matrix(NA, nrow = length(co2_data$uptake), ncol = n_sim)
set.seed(seed = 701)
for (j in seq_len(n_sim)) {
  treatment_simulations[, j] = treatment_obj$simulate(treatment_fit$par)$uptake
}

# Expected uptake of each measurement on the typical curve (u = 0) of its plant's group.
typical_asym = exp(log_typical)
plant_group = 1 + 2 * co2_data$mississippi + co2_data$chilled
treatment_expected = typical_asym[plant_group[co2_data$plant]] *
  (1 - exp(-exp(treatment_par[["log_rate"]]) * (co2_data$conc - treatment_par[["c0"]])))

# Scaled quantile residuals and the two standard panels.
treatment_residuals = DHARMa::createDHARMa(
  simulatedResponse = treatment_simulations,
  observedResponse = co2_data$uptake,
  fittedPredictedResponse = treatment_expected
)
png(
  file.path(out_dir, "residuals-grouped.png"),
  width = 9, height = 4.5, units = "in", res = fig_dpi
)
plot(treatment_residuals)
dev.off()

# The numbers quoted on slide 25: the dispersion statistic (0.80) and the residuals of
# the plants (Mc2 0.010).
print(DHARMa::testDispersion(treatment_residuals, plot = FALSE)$statistic)
plant_residuals = DHARMa::recalculateResiduals(treatment_residuals, group = co2_data$plant)
plant_scaled = residuals(plant_residuals)
names(plant_scaled) = plant_names
print(round(plant_scaled, 3))
