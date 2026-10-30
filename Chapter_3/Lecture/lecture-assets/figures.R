# Figures for the Chapter 3 lecture slides.
# Run in a clean R session from the repository root. Needs R 4.5.0 or later (penguins)
# and the packages ggplot2, patchwork and boot (fir). The figures are written into
# Chapter_3/Lecture/lecture-assets/.
#
# Every figure is an unchanged copy of a figure chunk of Chapter_3/Theory.qmd. The chunks
# run here in the chapter's order, after the chunks they depend on, with the chapter's
# seeds, so that the random draws are the same. Only the last line of each figure chunk
# changes, to assign the plot and save it. The distribution functions come from base R
# here: for these figures they give the same values as the RTMB and RTMBdist versions that
# the chapter loads.

library(ggplot2)
library(patchwork)

out_dir = "Chapter_3/Lecture/lecture-assets"

# Resolution of the copies; each keeps the size of its chapter chunk.
fig_dpi = 192

# ---------------------------------------------------------------------------
# Chapter chunks that the figures depend on (section "Samples and distributions")
# ---------------------------------------------------------------------------

# Counts of balsam fir seedlings in 50 quadrats (see ?boot::fir).
data(fir, package = "boot")
seedling_counts = fir$count
n_quadrats = length(seedling_counts)

# Count each value from zero to eight seedlings and divide by the sample size.
count_values = seq.int(from = 0, to = 8)
count_table = table(factor(x = seedling_counts, levels = count_values))
relative_frequency = count_table / n_quadrats

# Mean of the Poisson model: the mean of the 50 counts (seedlings per quadrat).
model_mean = 2.14

# Compare relative frequencies for several sample sizes with the model.
set.seed(123)
sample_sizes = 10^(seq_len(length.out = 5))

all_frequencies = matrix(NA, nrow = length(count_values),
                         ncol = length(sample_sizes) + 1)
rownames(all_frequencies) = count_values
colnames(all_frequencies) = c(as.character(sample_sizes), "model")

for (i in seq_along(sample_sizes)) {
  # Simulate the counts of one sample and tabulate the values from zero to eight.
  simulated_counts = rpois(n = sample_sizes[i], lambda = model_mean)
  simulated_table = table(factor(x = simulated_counts, levels = count_values))
  all_frequencies[, i] = as.numeric(simulated_table) / sample_sizes[i]
}
all_frequencies[, length(sample_sizes) + 1] = dpois(x = count_values, lambda = model_mean)

# ---------------------------------------------------------------------------
# Slide 8: relative-frequency-convergence.png (copy of
# fig-relative-frequency-convergence; 7 x 5, the default size)
# ---------------------------------------------------------------------------

# Repeatedly simulate samples and retain the relative frequency of three seedlings.
set.seed(seed = 20261003)
target_count = 3
n_repetitions = 100

repeated_frequencies = data.frame(
  sample_size = numeric(),
  relative_frequency = numeric()
)

for (sample_size in sample_sizes) {
  target_frequency = numeric(length = n_repetitions)

  for (repetition in seq_len(n_repetitions)) {
    simulated_counts = rpois(n = sample_size, lambda = model_mean)
    target_frequency[repetition] = mean(simulated_counts == target_count)
  }

  repeated_frequencies = rbind(
    repeated_frequencies,
    data.frame(
      sample_size = sample_size,
      relative_frequency = target_frequency
    )
  )
}

# Calculate the model probability that the figure uses as a reference line.
probability = dpois(x = target_count, lambda = model_mean)

convergence_plot = ggplot(
  repeated_frequencies,
  aes(
    x = sample_size,
    y = relative_frequency,
    group = sample_size
  )
) +
  geom_point(colour = "grey40",
             position = position_jitter(width = 0.05, height = 0.005)) +
  geom_hline(
    yintercept = probability,
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  scale_x_log10(
    breaks = sample_sizes,
    labels = c("10", "100", "1,000", "10,000", "100,000")
  ) +
  labs(
    x = "Sample size (log10 scale)",
    y = "Relative frequency of three seedlings"
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "relative-frequency-convergence.png"),
  plot = convergence_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 9: fir-empirical-distribution.png (copy of fig-ecdf; 9 x 4)
# ---------------------------------------------------------------------------

# Probability mass and cumulative probability of the model and of the sample.
model_mass = dpois(x = count_values, lambda = model_mean)
model_cumulative = ppois(q = count_values, lambda = model_mean)
sample_frequency = as.numeric(count_table) / n_quadrats
sample_cumulative = cumsum(sample_frequency)

model_comparison_data = rbind(
  data.frame(
    seedlings = count_values,
    value = model_mass,
    quantity = "Probability mass",
    series = "Model"
  ),
  data.frame(
    seedlings = count_values,
    value = sample_frequency,
    quantity = "Probability mass",
    series = "Sample"
  ),
  data.frame(
    seedlings = count_values,
    value = model_cumulative,
    quantity = "Cumulative probability",
    series = "Model"
  ),
  data.frame(
    seedlings = count_values,
    value = sample_cumulative,
    quantity = "Cumulative probability",
    series = "Sample"
  )
)
model_comparison_data$quantity = factor(
  model_comparison_data$quantity,
  levels = c("Probability mass", "Cumulative probability")
)

# Use different geometries as well as colours to distinguish the model and sample.
ecdf_plot = ggplot() +
  geom_linerange(
    data = subset(
      model_comparison_data,
      quantity == "Probability mass" & series == "Model"
    ),
    aes(x = seedlings, ymin = 0, ymax = value, colour = series),
    linewidth = 0.8
  ) +
  geom_point(
    data = subset(
      model_comparison_data,
      quantity == "Probability mass" & series == "Sample"
    ),
    aes(x = seedlings, y = value, colour = series),
    alpha = 0.7,
    size = 2
  ) +
  geom_step(
    data = subset(model_comparison_data, quantity == "Cumulative probability"),
    aes(x = seedlings, y = value, colour = series, linetype = series),
    direction = "hv",
    linewidth = 0.8
  ) +
  facet_wrap(~quantity, nrow = 1, scales = "free_y") +
  scale_colour_manual(values = c(Model = "#D55E00", Sample = "#0072B2")) +
  scale_linetype_manual(values = c(Model = "solid", Sample = "dashed")) +
  scale_x_continuous(breaks = count_values) +
  labs(
    x = "Seedlings per quadrat",
    y = "Probability or relative frequency",
    colour = NULL,
    linetype = NULL
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "fir-empirical-distribution.png"),
  plot = ecdf_plot,
  width = 9, height = 4, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 12: histogram-density.png (copy of fig-histogram_density; 10 x 3.5)
# It needs flipper_lengths and flipper_density from the chapter chunks below.
# ---------------------------------------------------------------------------

# Load the penguin data, keep the Gentoo penguins and remove the one without measurements.
data(penguins, package = "datasets")
gentoo = penguins[penguins$species == "Gentoo", ]
gentoo = gentoo[!is.na(gentoo$flipper_len), ]
# Flipper lengths (in mm) of the 123 penguins.
flipper_lengths = gentoo$flipper_len

# Kernel density estimate of the sample; bw is the bandwidth that R chose (in mm).
flipper_density = density(x = flipper_lengths)

# Density of the model and kernel density estimate of the sample on the same grid.
flipper_grid = seq(from = 195, to = 240, length.out = 300)
model_curve = data.frame(
  flipper = flipper_grid,
  density = dnorm(x = flipper_grid, mean = 217, sd = 6.5)
)
kernel_curve = data.frame(flipper = flipper_density$x, density = flipper_density$y)
flipper_data = data.frame(flipper = flipper_lengths)

# Draw one density-scaled histogram for a given bin width and legend placement.
# The limits of the bins are at half millimetres (boundary = 202.5).
plot_histogram = function(bin_width, legend_theme) {
  ggplot(flipper_data, aes(x = flipper)) +
    geom_histogram(
      aes(y = after_stat(density)),
      binwidth = bin_width,
      boundary = 202.5,
      fill = "grey90",
      colour = "grey40"
    ) +
    geom_line(
      data = model_curve,
      aes(x = flipper, y = density, colour = "Normal model", linetype = "Normal model"),
      linewidth = 0.8
    ) +
    geom_line(
      data = kernel_curve,
      aes(
        x = flipper,
        y = density,
        colour = "Kernel density estimate",
        linetype = "Kernel density estimate"
      ),
      linewidth = 0.8
    ) +
    # Same name and breaks for both scales, so they merge into a single legend.
    scale_colour_manual(
      name = NULL,
      values = c("Normal model" = "#D55E00", "Kernel density estimate" = "#0072B2")
    ) +
    scale_linetype_manual(
      name = NULL,
      values = c("Normal model" = "solid", "Kernel density estimate" = "dashed")
    ) +
    coord_cartesian(xlim = c(195, 240), ylim = c(0, 0.13)) +
    labs(
      title = paste("Bin width:", bin_width, "mm"),
      x = "Flipper length (mm)",
      y = "Density (1/mm)"
    ) +
    theme_classic() +
    legend_theme
}

# Legend inside the top-right corner of the first panel only; it applies to all panels.
histogram_plot = plot_histogram(bin_width = 1, legend_theme = theme(
  legend.position = "inside",
  legend.position.inside = c(0.98, 0.98),
  legend.justification = c(1, 1)
)) |
  plot_histogram(bin_width = 4, legend_theme = theme(legend.position = "none")) |
  plot_histogram(bin_width = 12, legend_theme = theme(legend.position = "none"))

ggsave(
  file.path(out_dir, "histogram-density.png"),
  plot = histogram_plot,
  width = 10, height = 3.5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 20: sampling-distribution.png (copy of fig-sampling_distribution; 7 x 5)
# It uses lambda_estimates from the chapter chunk with seed 401.
# ---------------------------------------------------------------------------

# Parameter of the model, quadrats per sample and number of hypothetical samples.
set.seed(seed = 401)
true_lambda = 2.14
n_quadrats = 50
n_samples = 2000

# Each run simulates one sample of 50 quadrats and returns its estimate of lambda.
lambda_estimates = replicate(
  n = n_samples,
  expr = mean(rpois(n = n_quadrats, lambda = true_lambda))
)

# Plot the simulated sampling distribution and mark the parameter of the model.
sampling_plot = ggplot(data.frame(estimate = lambda_estimates), aes(x = estimate)) +
  geom_histogram(
    aes(y = after_stat(density)),
    binwidth = 0.06,
    center = true_lambda,
    fill = "grey90",
    colour = "grey40"
  ) +
  geom_vline(xintercept = true_lambda, colour = "#D55E00", linewidth = 0.8) +
  labs(
    x = "Estimated seedlings per quadrat",
    y = "Density"
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "sampling-distribution.png"),
  plot = sampling_plot,
  width = 7, height = 5, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 28: dance-ci.png (copy of fig-dance_ci; 7 x 6)
# The top panel uses lambda_estimates from above; the chunk sets seed 1 itself.
# ---------------------------------------------------------------------------

# Simulate 20 hypothetical samples and calculate a 95% Wald interval for each.
# The parameter, quadrats per sample and 2,000 estimates come from the simulation above.
set.seed(seed = 1)
n_shown = 20
critical_value = qnorm(p = 0.975)
shown_estimates = replicate(
  n = n_shown,
  expr = mean(rpois(n = n_quadrats, lambda = true_lambda))
)
shown_se = sqrt(shown_estimates / n_quadrats)
intervals = data.frame(
  sample_number = seq_len(length.out = n_shown),
  estimate = shown_estimates,
  lower = shown_estimates - critical_value * shown_se,
  upper = shown_estimates + critical_value * shown_se
)

# Record whether each interval contains the parameter of the model.
intervals$contains = ifelse(
  test = intervals$lower <= true_lambda & true_lambda <= intervals$upper,
  yes = "Contains the parameter",
  no = "Misses the parameter"
)

# Top panel: simulated sampling distribution of the estimator.
sampling_panel = ggplot(data.frame(estimate = lambda_estimates), aes(x = estimate)) +
  geom_histogram(
    aes(y = after_stat(density)),
    binwidth = 0.06,
    center = true_lambda,
    fill = "grey90",
    colour = "grey40"
  ) +
  geom_vline(xintercept = true_lambda, linetype = "dashed", colour = "grey40") +
  coord_cartesian(xlim = c(1.2, 3.1)) +
  labs(x = NULL, y = "Density") +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.line.x = element_blank()
  )

# Bottom panel: one estimate and interval for each hypothetical sample.
interval_panel = ggplot(intervals, aes(y = sample_number, colour = contains)) +
  geom_vline(xintercept = true_lambda, linetype = "dashed", colour = "grey40") +
  geom_linerange(aes(xmin = lower, xmax = upper), linewidth = 0.6) +
  geom_point(aes(x = estimate), size = 2) +
  scale_colour_manual(
    name = NULL,
    values = c("Contains the parameter" = "#0072B2", "Misses the parameter" = "#D55E00")
  ) +
  scale_y_reverse() +
  coord_cartesian(xlim = c(1.2, 3.1)) +
  labs(x = "Estimated seedlings per quadrat", y = "Hypothetical sample") +
  theme_classic() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "bottom"
  )

# Stack the panels so that both use the same horizontal axis.
dance_plot = sampling_panel / interval_panel + plot_layout(heights = c(1, 3))

ggsave(
  file.path(out_dir, "dance-ci.png"),
  plot = dance_plot,
  width = 7, height = 6, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 32: asymptotic-normality.png (copy of fig-asymptotic_normality; 9 x 4)
# ---------------------------------------------------------------------------

# Simulate the sampling distribution of the mean for two sample sizes.
set.seed(seed = 404)
true_lambda = 2.14
sample_sizes = c(5, 100)

# Draw the simulated sampling distribution with its Normal approximation.
plot_sampling_distribution = function(sample_size, bin_width) {
  # One estimate of lambda per simulated sample.
  estimates = replicate(
    n = 2000,
    expr = mean(rpois(n = sample_size, lambda = true_lambda))
  )
  # Normal approximation with the standard error derived from the model.
  model_se = sqrt(true_lambda / sample_size)
  estimate_grid = seq(
    from = true_lambda - 4 * model_se,
    to = true_lambda + 4 * model_se,
    length.out = 200
  )
  approximation = data.frame(
    estimate = estimate_grid,
    density = dnorm(x = estimate_grid, mean = true_lambda, sd = model_se)
  )
  ggplot(data.frame(estimate = estimates), aes(x = estimate)) +
    geom_histogram(
      aes(y = after_stat(density)),
      binwidth = bin_width,
      center = true_lambda,
      fill = "grey90",
      colour = "grey40"
    ) +
    geom_line(
      data = approximation,
      aes(x = estimate, y = density),
      colour = "#D55E00",
      linewidth = 0.8
    ) +
    labs(
      title = paste(sample_size, "quadrats"),
      x = "Estimated seedlings per quadrat",
      y = "Density"
    ) +
    theme_classic()
}

normality_plot = plot_sampling_distribution(sample_size = 5, bin_width = 0.2) |
  plot_sampling_distribution(sample_size = 100, bin_width = 0.05)

ggsave(
  file.path(out_dir, "asymptotic-normality.png"),
  plot = normality_plot,
  width = 9, height = 4, dpi = fig_dpi
)
