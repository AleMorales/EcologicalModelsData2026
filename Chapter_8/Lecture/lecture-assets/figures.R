# Figures for the Chapter 8 lecture.
# Run in a clean R session from the repository root. Needs the packages RTMB, RTMBdist,
# ggplot2 and emdbook; the data set CO2 is built into R. It runs in a few seconds. The
# figures are written into Chapter_8/Lecture/lecture-assets/.
#
# Every PNG is an unchanged copy of a figure chunk of Chapter_8/Theory.qmd (7 x 5 inches,
# the size of the chapter's chunks):
#   co2-stops.png      fig-co2_stops     slide 5
#   search-paths.png   fig-search_paths  slide 7
#   ridge-slice.png    fig-ridge_slice   slide 10
# and one schematic without numerical scales, written as SVG:
#   minima-schematic.svg                 slide 6
# The chunks of the chapter run here in the chapter's order, after the chunks that they
# depend on. None of them draws random numbers. Only the line that starts each figure
# chunk changes, to assign the plot, and the saving is added after it.

library(ggplot2)

out_dir = "Chapter_8/Lecture/lecture-assets"

# Resolution of the figures; each copy keeps the size of its chapter chunk.
fig_dpi = 192

# ---------------------------------------------------------------------------
# Set-up of the chapter: data, NLL, the fit of Chapter 7 and the three poor starts
# ---------------------------------------------------------------------------

# Load RTMB first and RTMBdist second.
library(RTMB)
library(RTMBdist)

# CO2 uptake (µmol/m²/s) of 12 plants at seven concentrations of CO2 (µL/L), see ?CO2.
co2 = as.data.frame(CO2)
co2_data = list(conc = co2$conc, uptake = co2$uptake)

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

# Process the NLL with the starting values of Chapter 7, and fit it.
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
# Three other sets of starting values on the original scale: asymptote (µmol/m²/s),
# rate (L/µL), location (µL/L) and standard deviation (µmol/m²/s).
other_starts = rbind(
  slow_rise = c(a = 30, b = 0.001, c = 50, sd_obs = 2),
  high_asymptote = c(a = 100, b = 0.01, c = 50, sd_obs = 2),
  early_plateau = c(a = 10, b = 1, c = 90, sd_obs = 2)
)

# Fit the model from each set, transformed to the optimised scales.
stop_fits = list()
for (start_name in rownames(other_starts)) {
  s = other_starts[start_name, ]
  start = c(
    log_asym = log(s[["a"]]),
    log_rate = log(s[["b"]]),
    c0 = s[["c"]],
    log_sd_obs = log(s[["sd_obs"]])
  )
  stop_fits[[start_name]] = optim(
    par = start,
    fn = pooled_obj$fn,
    gr = pooled_obj$gr,
    method = "BFGS"
  )
}
# Every fit, with the one from the starting values of Chapter 7 first.
co2_fits = c(list(chapter_7 = pooled_fit), stop_fits)

# Convergence code, minimum of the NLL and estimates on the original scale.
stop_table = data.frame(
  convergence = rep(NA, length(co2_fits)),
  nll = NA, a = NA, b = NA, c = NA, sd_obs = NA,
  row.names = names(co2_fits)
)
for (fit_name in names(co2_fits)) {
  fit = co2_fits[[fit_name]]
  stop_table[fit_name, ] = c(
    fit$convergence,
    fit$value,
    exp(fit$par[["log_asym"]]),
    exp(fit$par[["log_rate"]]),
    fit$par[["c0"]],
    exp(fit$par[["log_sd_obs"]])
  )
}
signif(stop_table, 4)

# ---------------------------------------------------------------------------
# Slide 5: co2-stops.png (copy of fig-co2_stops; 7 x 5)
# ---------------------------------------------------------------------------

# Curve of each fit on a grid of concentrations.
conc_grid = seq(from = 95, to = 1000, length.out = 300)
stop_labels = c(
  chapter_7 = "Chapter 7: maximum",
  slow_rise = "Slow rise: constant",
  high_asymptote = "High asymptote: zero",
  early_plateau = "Early plateau: c near 90 µL/L"
)
stop_curves = NULL
for (fit_name in names(co2_fits)) {
  p = co2_fits[[fit_name]]$par
  curve_values = exp(p[["log_asym"]]) *
    (1 - exp(-exp(p[["log_rate"]]) * (conc_grid - p[["c0"]])))
  stop_curves = rbind(
    stop_curves,
    data.frame(conc = conc_grid, uptake = curve_values, fit = stop_labels[[fit_name]])
  )
}
stop_curves$fit = factor(stop_curves$fit, levels = stop_labels)

co2_stops_plot = ggplot() +
  geom_point(
    data = co2,
    aes(x = conc, y = uptake),
    colour = "#0072B2",
    alpha = 0.7,
    size = 2
  ) +
  geom_line(
    data = stop_curves,
    aes(x = conc, y = uptake, colour = fit, linetype = fit),
    linewidth = 0.8
  ) +
  scale_colour_manual(values = c("#D55E00", "grey20", "grey20", "grey20")) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash")) +
  labs(
    x = expression("Ambient CO"[2] * " concentration (µL/L)"),
    y = expression("CO"[2] * " uptake (µmol/m²/s)"),
    colour = NULL,
    linetype = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top", legend.direction = "vertical")
ggsave(file.path(out_dir, "co2-stops.png"), plot = co2_stops_plot,
       width = 7, height = 5, dpi = fig_dpi)

# ---------------------------------------------------------------------------
# Slide 7: search-paths.png (copy of fig-search_paths; 7 x 5)
# ---------------------------------------------------------------------------

# Reed frog functional response and the Binomial NLL of Chapter 6.
data(ReedfrogFuncresp, package = "emdbook")
frog_data = list(initial = ReedfrogFuncresp$Initial, killed = ReedfrogFuncresp$Killed)
binomial_nll = function(parms, data) {
  getAll(parms, data)
  alpha = plogis(logit_alpha)
  H = exp(log_H)
  p = alpha / (1 + alpha * H * initial)
  -sum(dbinom(x = killed, size = initial, prob = p, log = TRUE))
}
binomial_obj = MakeADFun(
  cmb(binomial_nll, frog_data),
  list(logit_alpha = qlogis(0.5), log_H = log(1 / 60)),
  silent = TRUE
)

# Paths of BFGS from three starts: gr is wrapped so that it records where it is called.
frog_starts = list(
  "From Chapter 6: maximum" = c(0.5, 1 / 60),
  "From α = 0.01: α to 1" = c(0.01, 1 / 60),
  "From α = 0.05, H = 0.03: H to 0" = c(0.05, 0.03)
)
frog_paths = NULL
frog_fits = list()
for (start_name in names(frog_starts)) {
  s = frog_starts[[start_name]]
  path = NULL
  recording_gr = function(p) {
    path <<- rbind(path, p)
    binomial_obj$gr(p)
  }
  frog_fits[[start_name]] = optim(
    par = c(logit_alpha = qlogis(s[1]), log_H = log(s[2])),
    fn = binomial_obj$fn,
    gr = recording_gr,
    method = "BFGS"
  )
  frog_paths = rbind(
    frog_paths,
    data.frame(alpha = plogis(path[, 1]), H = exp(path[, 2]), start = start_name)
  )
}
frog_paths$start = factor(frog_paths$start, levels = names(frog_starts))
frog_mle = frog_fits[[1]]$par

# Relative log-likelihood on a grid of the original scales.
alpha_grid = seq(from = 0.01, to = 0.999, length.out = 121)
H_grid = seq(from = 0.0002, to = 0.06, length.out = 121)
frog_surface = matrix(NA, nrow = length(alpha_grid), ncol = length(H_grid))
for (i in seq_along(alpha_grid)) {
  for (j in seq_along(H_grid)) {
    frog_surface[i, j] =
      frog_fits[[1]]$value - binomial_obj$fn(c(qlogis(alpha_grid[i]), log(H_grid[j])))
  }
}
frog_surface_data = expand.grid(alpha = alpha_grid, H = H_grid)
frog_surface_data$relative = as.vector(frog_surface)

search_paths_plot = ggplot() +
  geom_contour(
    data = frog_surface_data,
    aes(x = alpha, y = H, z = relative),
    breaks = c(-100, -50, -20, -10, -5, -2, -1),
    colour = "grey70"
  ) +
  geom_path(
    data = frog_paths,
    aes(x = alpha, y = H, linetype = start),
    colour = "grey20"
  ) +
  geom_point(
    data = frog_paths,
    aes(x = alpha, y = H, shape = start),
    colour = "grey20",
    size = 2
  ) +
  geom_point(
    data = data.frame(alpha = plogis(frog_mle[1]), H = exp(frog_mle[2])),
    aes(x = alpha, y = H),
    colour = "#D55E00",
    size = 4
  ) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 0.06)) +
  labs(
    x = expression(paste("Attack rate, ", alpha, " (per experiment)")),
    y = "Handling time, H (experiments per tadpole killed)",
    linetype = NULL,
    shape = NULL
  ) +
  theme_classic() +
  theme(legend.position = "top", legend.direction = "vertical")
ggsave(file.path(out_dir, "search-paths.png"), plot = search_paths_plot,
       width = 7, height = 5, dpi = fig_dpi)

# ---------------------------------------------------------------------------
# Slide 10: ridge-slice.png (copy of fig-ridge_slice; 7 x 5)
# ---------------------------------------------------------------------------

# Slice through the end of the fit from the slow rise along the log rate; the other
# parameters stay where the fit stopped.
ridge_par = stop_fits$slow_rise$par
log_rate_grid = seq(from = log(0.001), to = log(10), length.out = 101)
ridge_slice = rep(NA, times = length(log_rate_grid))
for (i in seq_along(log_rate_grid)) {
  slice_par = ridge_par
  slice_par[["log_rate"]] = log_rate_grid[i]
  ridge_slice[i] = -pooled_obj$fn(slice_par)
}

# Relative log-likelihood: the difference from the log-likelihood where the fit stopped.
ridge_relative = ridge_slice - (-stop_fits$slow_rise$value)
ridge_slice_plot = ggplot(
  data.frame(rate = exp(log_rate_grid), relative = ridge_relative),
  aes(x = rate, y = relative)
) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey40") +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  scale_x_log10() +
  coord_cartesian(ylim = c(-30, 15)) +
  labs(
    x = "Rate, b (L/µL, logarithmic axis)",
    y = "Relative log-likelihood"
  ) +
  theme_classic()
ggsave(file.path(out_dir, "ridge-slice.png"), plot = ridge_slice_plot,
       width = 7, height = 5, dpi = fig_dpi)

# ---------------------------------------------------------------------------
# Slide 6: minima-schematic.svg (a curve without numerical scales)
# ---------------------------------------------------------------------------

# A curve of the NLL against one parameter: a local minimum, the global minimum and a
# flat stretch (a ridge). Drawn from a smooth function; the axes carry no numbers.
x = seq(from = 0, to = 10, length.out = 400)
nll = 2.2 - 1.3 * exp(-(x - 2.2)^2 / 0.5) - 2.0 * exp(-(x - 7)^2 / 0.6)
nll[x > 8.2] = nll[which(x > 8.2)[1]]
svg_x = 80 + x * 60
svg_y = 80 + (2.5 - nll) * 85
points_attr = paste(sprintf("%.1f,%.1f", svg_x, svg_y), collapse = " ")
mark = function(px, label, dy) {
  i = which.min(abs(x - px))
  sprintf(
    paste0('<circle cx="%.1f" cy="%.1f" r="7" fill="#D55E00"/>',
           '<text x="%.1f" y="%.1f" text-anchor="middle" font-size="26" ',
           'fill="#263530">%s</text>'),
    svg_x[i], svg_y[i], svg_x[i], svg_y[i] + dy, label
  )
}
svg_lines = c(
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 400" font-family="Segoe UI, Arial, sans-serif">',
  '<rect width="720" height="400" fill="white"/>',
  '<line x1="60" y1="350" x2="700" y2="350" stroke="#263530" stroke-width="2"/>',
  '<line x1="60" y1="350" x2="60" y2="20" stroke="#263530" stroke-width="2"/>',
  '<text x="380" y="390" text-anchor="middle" font-size="22" fill="#52605a">Parameter</text>',
  '<text x="22" y="185" text-anchor="middle" font-size="22" fill="#52605a" transform="rotate(-90 22 185)">Negative log-likelihood</text>',
  sprintf('<polyline points="%s" fill="none" stroke="#0072B2" stroke-width="4"/>', points_attr),
  mark(2.2, "Local minimum", 38),
  mark(7, "Global minimum", 38),
  mark(9.3, "Ridge", -22),
  '</svg>'
)
writeLines(svg_lines, file.path(out_dir, "minima-schematic.svg"))
