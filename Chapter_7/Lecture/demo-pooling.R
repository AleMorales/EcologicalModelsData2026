# Live demo of the Chapter 7 lecture: from pooling to partial pooling, for the CO2 uptake
# curves of 12 plants. Complete pooling, no pooling, a random asymptote, then the effects
# of origin and chilling, shrinkage and the curves of observed and new plants. There is no
# model comparison in the demo.
#
# Run it section by section in a clean R session (about 16 minutes with explanation; the
# code itself runs in a few seconds). It needs the packages RTMB and RTMBdist; the data
# set CO2 is built into R. Run section 0 during the break before the demo. The sections
# follow the steps on the slide "Live demo: from pooling to partial pooling", and the code
# and object names are those of Chapter 7, so the numbers agree with the chapter.


# ---- 0. Packages and data -------------------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# CO2 uptake (µmol/m²/s) of 12 plants of Echinochloa crus-galli at seven ambient
# concentrations of CO2 (µL/L); see ?CO2. An ordinary data frame of 84 rows.
co2 = as.data.frame(CO2)
head(co2)

# Names of the plants in the order of the rows, and the index (1 to 12) of the plant of
# each measurement. Q or M: origin; n or c: non-chilled or chilled.
plant_names = unique(as.character(co2$Plant))
plant = match(as.character(co2$Plant), plant_names)
plant_names

# List of data: the predictor, the response and the plant of each measurement.
co2_data = list(conc = co2$conc, uptake = co2$uptake, plant = plant)

# The 12 plants: one line per plant; solid for non-chilled, dashed for chilled; circles
# for Quebec, triangles for Mississippi.
first_row = match(seq_along(plant_names), plant)
plot(co2_data$conc, co2_data$uptake, type = "n", ylim = c(0, 50),
     xlab = expression("Ambient CO"[2] * " concentration (µL/L)"),
     ylab = expression("CO"[2] * " uptake (µmol/m²/s)"))
for (j in seq_along(plant_names)) {
  rows = co2_data$plant == j
  chilled_plant = co2$Treatment[first_row[j]] == "chilled"
  mississippi_plant = co2$Type[first_row[j]] == "Mississippi"
  lines(co2_data$conc[rows], co2_data$uptake[rows], type = "b",
        lty = ifelse(chilled_plant, "dashed", "solid"),
        pch = ifelse(mississippi_plant, 2, 1))
}
legend("bottomright", legend = c("Quebec", "Mississippi", "Non-chilled", "Chilled"),
       pch = c(1, 2, NA, NA), lty = c(NA, NA, "solid", "dashed"))

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)


# ---- 1. Complete pooling: one curve for all the plants --------------------------------

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

# Starting values read from the plot: asymptote 30, zero uptake at 50 µL/L, 63% of the
# asymptote 100 µL/L higher (b = 0.01), standard deviation 2.
pooled_obj = MakeADFun(
  cmb(pooled_nll, co2_data),
  list(log_asym = log(30), log_rate = log(0.01), c0 = 50, log_sd_obs = log(2)),
  silent = TRUE
)
pooled_fit = optim(
  par = pooled_obj$par,
  fn = pooled_obj$fn,
  gr = pooled_obj$gr,
  method = "BFGS"
)
pooled_fit$convergence

# Standard deviation of the measurements around the common curve: about 8.2.
exp(pooled_fit$par[["log_sd_obs"]])


# ---- 2. No pooling: one asymptote for each plant --------------------------------------

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

# The same starting asymptote for every plant.
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
separate_fit$convergence

# Standard deviation around the curves of the plants: about 1.9.
exp(separate_fit$par[["log_sd_obs"]])

# Asymptotes of the 12 plants without pooling: 14.2 (Mc2) to 45.0 (Qn3).
separate_asym = exp(separate_fit$par[names(separate_fit$par) == "log_asym"])
names(separate_asym) = plant_names
round(separate_asym, 1)


# ---- 3. Partial pooling: a random asymptote -------------------------------------------

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

# par holds only the five other parameters: the deviations were integrated out.
mixed_obj$par

# Minimise the marginal NLL with BFGS.
mixed_fit = optim(
  par = mixed_obj$par,
  fn = mixed_obj$fn,
  gr = mixed_obj$gr,
  method = "BFGS"
)
mixed_fit$convergence

# Estimates on the original scale: a about 30.9 (the median asymptote), sd_plant about
# 0.34 (log scale, no units), sd_obs about 2.0.
c(
  a = exp(mixed_fit$par[["log_asym"]]),
  b = exp(mixed_fit$par[["log_rate"]]),
  c = mixed_fit$par[["c0"]],
  sd_plant = exp(mixed_fit$par[["log_sd_plant"]]),
  sd_obs = exp(mixed_fit$par[["log_sd_obs"]])
)

# Standard errors on the optimised scales.
mixed_sd = sdreport(mixed_obj)
summary(mixed_sd, select = "fixed")

# Predicted plant effects (log scale of the asymptote) and their standard errors:
# positive for Quebec, most negative for Mc1, Mc2 and Mc3 (-0.370, -0.755, -0.422).
mixed_effects = summary(mixed_sd, select = "random")
rownames(mixed_effects) = plant_names
round(mixed_effects, 3)


# ---- 4. Origin and chilling, and shrinkage --------------------------------------------

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

# The effects start at zero, the other parameters as before.
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
treatment_fit$convergence
treatment_sd = sdreport(treatment_obj)
summary(treatment_sd, select = "fixed")

# Standard deviation among plants without and with origin and chilling: 0.34 and 0.079.
c(
  without = exp(mixed_fit$par[["log_sd_plant"]]),
  with = exp(treatment_fit$par[["log_sd_plant"]])
)

# Factors by which chilling multiplies the asymptote, with Wald intervals from the log
# scale: Quebec about 0.90 (0.79 to 1.03), Mississippi about 0.59 (0.52 to 0.69).
chill_summary = summary(treatment_sd, select = "report")
critical_value = qnorm(p = 0.975)
chill_factor = exp(cbind(
  estimate = chill_summary[, "Estimate"],
  lower = chill_summary[, "Estimate"] - critical_value * chill_summary[, "Std. Error"],
  upper = chill_summary[, "Estimate"] + critical_value * chill_summary[, "Std. Error"]
))
rownames(chill_factor) = c("Quebec", "Mississippi")
chill_factor

# Typical asymptote (u = 0) of the group of each plant, and the predicted asymptote of
# each plant.
treatment_par = treatment_fit$par
typical_treatment = exp(
  treatment_par[["log_asym"]] +
    treatment_par[["beta_miss"]] * co2_data$mississippi +
    treatment_par[["beta_chill"]] * co2_data$chilled +
    treatment_par[["beta_int"]] * co2_data$mississippi * co2_data$chilled
)
treatment_asym = typical_treatment *
  exp(summary(treatment_sd, select = "random")[, "Estimate"])
names(treatment_asym) = plant_names

# Mc2: 14.2 without pooling, 15.6 predicted, typical asymptote of its group 18.5.
round(cbind(separate = separate_asym, predicted = treatment_asym,
            typical = typical_treatment), 1)

# Shrinkage: asymptote without pooling (open circles), predicted (filled circles) and the
# typical asymptote of each origin and treatment (dashed).
plot(1:12, separate_asym, ylim = c(10, 50), xaxt = "n",
     xlab = "Plant", ylab = "Asymptote (µmol/m²/s)")
axis(1, at = 1:12, labels = plant_names)
segments(x0 = 1:12, y0 = separate_asym, y1 = treatment_asym)
segments(x0 = 1:12 - 0.4, x1 = 1:12 + 0.4, y0 = typical_treatment, lty = "dashed")
points(1:12, treatment_asym, pch = 19, col = "#D55E00")
legend("topright", legend = c("No pooling", "Predicted", "Typical"),
       pch = c(1, 19, NA), lty = c(NA, NA, "dashed"), col = c("black", "#D55E00", "black"))


# ---- 5. Curves of observed plants and the range of new plants -------------------------

# Typical asymptote of chilled plants from Mississippi, and the range that contains the
# asymptotes of 95% of new plants of this group: 18.5 (15.8 to 21.5).
sd_plant = exp(treatment_par[["log_sd_plant"]])
log_typical_mc = treatment_par[["log_asym"]] + treatment_par[["beta_miss"]] +
  treatment_par[["beta_chill"]] + treatment_par[["beta_int"]]
new_plant_mc = exp(log_typical_mc + qnorm(p = c(0.5, 0.025, 0.975)) * sd_plant)
new_plant_mc

# The shared part of the curve, on a grid of concentrations.
conc_grid = seq(from = 95, to = 1000, length.out = 200)
curve_shape = 1 - exp(-exp(treatment_par[["log_rate"]]) * (conc_grid - treatment_par[["c0"]]))

# The chilled plants from Mississippi (10 to 12): their measurements and curves, the
# typical curve (thick) and the range of new plants (dashed).
mc_rows = co2_data$plant %in% 10:12
plot(co2_data$conc[mc_rows], co2_data$uptake[mc_rows], pch = co2_data$plant[mc_rows] - 9,
     ylim = c(0, 25), xlab = expression("Ambient CO"[2] * " concentration (µL/L)"),
     ylab = expression("CO"[2] * " uptake (µmol/m²/s)"))
for (j in 10:12) {
  lines(conc_grid, treatment_asym[j] * curve_shape, lty = j - 9)
}
lines(conc_grid, new_plant_mc[1] * curve_shape, col = "#D55E00", lwd = 3)
lines(conc_grid, new_plant_mc[2] * curve_shape, col = "#D55E00", lty = "dashed")
lines(conc_grid, new_plant_mc[3] * curve_shape, col = "#D55E00", lty = "dashed")
legend("bottomright", legend = c(plant_names[10:12], "Typical", "New plants (95%)"),
       pch = c(1, 2, 3, NA, NA), lty = c(1, 2, 3, 1, 2),
       col = c("black", "black", "black", "#D55E00", "#D55E00"), lwd = c(1, 1, 1, 3, 1))
