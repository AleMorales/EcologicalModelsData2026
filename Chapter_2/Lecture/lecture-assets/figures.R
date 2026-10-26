# Figures for the Chapter 2 lecture slides.
# Run in a clean R session from the repository root. Needs R 4.5.0 or later (penguins)
# and the packages ggplot2, patchwork and glmmTMB (Salamanders). The figures are written
# into Chapter_2/Lecture/lecture-assets/.
#
# The distribution functions come from base R here: for these figures they give the same
# values as the RTMB and RTMBdist versions that the chapter loads.

library(ggplot2)
library(patchwork)

out_dir = "Chapter_2/Lecture/lecture-assets"

# Size of a figure that fills a 62 to 65% column of a 1440 x 900 slide.
fig_width = 7
fig_height = 5
fig_dpi = 192

# ---------------------------------------------------------------------------
# Slide 8: binomial-four-faces.png (new)
# Same content as fig-four_faces of Chapter_2/Theory.qmd (n = 4, p = 0.4, cutoff 2,
# 20 samples with seed 42), redrawn in the course style.
# ---------------------------------------------------------------------------

size = 4
prob = 0.4
cutoff = 2

# Probabilities at each possible count
binomial = data.frame(
  x = 0:size,
  probability = dbinom(0:size, size = size, prob = prob)
)
binomial$up_to_cutoff = binomial$x <= cutoff

# Cumulative probability at the cutoff
p_cutoff = pbinom(cutoff, size = size, prob = prob)

# Panel 1: probability mass
p1 = ggplot(binomial, aes(x = x, y = probability)) +
  geom_vline(xintercept = cutoff, linetype = "dashed", colour = "grey40") +
  geom_segment(aes(xend = x, yend = 0), colour = "#D55E00", linewidth = 0.8) +
  geom_point(colour = "#D55E00", size = 2.5) +
  annotate(
    "text", x = 2.15, y = 0.38, hjust = 0, size = 3.8,
    label = paste0("P(X = ", cutoff, ") = ", round(dbinom(cutoff, size, prob), 2))
  ) +
  scale_x_continuous(breaks = 0:size) +
  scale_y_continuous(limits = c(0, 0.4)) +
  labs(title = "Probability mass", x = "Surviving seeds", y = "Probability") +
  theme_classic(base_size = 13)

# Panel 2: cumulative probability as the mass up to and including the cutoff
p2 = ggplot(binomial, aes(x = x, y = probability)) +
  geom_segment(
    aes(xend = x, yend = 0, alpha = up_to_cutoff),
    colour = "#D55E00", linewidth = 0.8, show.legend = FALSE
  ) +
  geom_point(aes(alpha = up_to_cutoff), colour = "#D55E00", size = 2.5, show.legend = FALSE) +
  scale_alpha_manual(values = c("TRUE" = 1, "FALSE" = 0.25)) +
  geom_vline(xintercept = cutoff + 0.5, linetype = "dashed", colour = "grey40") +
  annotate(
    "text", x = 2.65, y = 0.38, hjust = 0, size = 3.8,
    label = paste0("P(X ≤ ", cutoff, ") = ", round(p_cutoff, 2))
  ) +
  scale_x_continuous(breaks = 0:size) +
  scale_y_continuous(limits = c(0, 0.4)) +
  labs(title = "Cumulative probability", x = "Surviving seeds", y = "Probability") +
  theme_classic(base_size = 13)

# Panel 3: quantile function
probabilities = seq(0, 1, length.out = 1001)
quantiles = data.frame(
  p = probabilities,
  quantile = qbinom(probabilities, size = size, prob = prob)
)

p3 = ggplot(quantiles, aes(x = p, y = quantile)) +
  geom_step(colour = "#D55E00", linewidth = 0.8) +
  annotate(
    "segment", x = p_cutoff, xend = p_cutoff, y = 0, yend = cutoff,
    linetype = "dashed", colour = "grey40"
  ) +
  annotate("point", x = p_cutoff, y = cutoff, colour = "#D55E00", size = 2.5) +
  annotate(
    "text", x = 0.05, y = 3.5, hjust = 0, size = 3.8,
    label = paste0("qbinom(", round(p_cutoff, 2), ") = ", cutoff)
  ) +
  scale_y_continuous(breaks = 0:size) +
  labs(title = "Quantile", x = "Cumulative probability", y = "Surviving seeds") +
  theme_classic(base_size = 13)

# Panel 4: relative frequencies of 20 simulated quadrats
set.seed(42)
simulated_seeds = rbinom(20, size = size, prob = prob)
sample_frequency = data.frame(
  x = 0:size,
  relative_frequency = tabulate(simulated_seeds + 1, nbins = size + 1) / 20
)

p4 = ggplot(sample_frequency, aes(x = x, y = relative_frequency)) +
  geom_col(fill = "grey90", colour = "grey40", width = 0.7) +
  scale_x_continuous(breaks = 0:size) +
  labs(title = "20 simulated quadrats", x = "Surviving seeds", y = "Relative frequency") +
  theme_classic(base_size = 13)

ggsave(
  file.path(out_dir, "binomial-four-faces.png"),
  plot = (p1 | p2) / (p3 | p4),
  width = fig_width, height = fig_height, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 16: normal-four-faces.png (copy)
# The chunk fig-four_faces_normal of Chapter_2/Theory.qmd, unchanged, with the data
# loading that it needs. Only the last line saves the figure instead of printing it.
# ---------------------------------------------------------------------------

# Load the penguin data and keep the Gentoo penguins.
data(penguins, package = "datasets")
gentoo = penguins[penguins$species == "Gentoo", ]
gentoo = gentoo[!is.na(gentoo$flipper_len), ]

# Distribution parameters, a highlighted interval and a chosen cutoff
mean_flipper = 217
sd_flipper = 6.5
interval_lower = 210.5
interval_upper = 223.5
cutoff = 223.5

# Density and cumulative probability over a range of flipper lengths
normal = data.frame(x = seq(from = 194, to = 240, length.out = 461))
normal$density = dnorm(normal$x, mean = mean_flipper, sd = sd_flipper)
normal$cumulative_probability = pnorm(normal$x, mean = mean_flipper, sd = sd_flipper)

# Probability of the highlighted interval and cumulative probability at the cutoff
p_interval = pnorm(interval_upper, mean = mean_flipper, sd = sd_flipper) -
  pnorm(interval_lower, mean = mean_flipper, sd = sd_flipper)
p_cutoff = pnorm(cutoff, mean = mean_flipper, sd = sd_flipper)

# Panel 1: probability density function with an interval probability as an area
p1 = ggplot(normal, aes(x = x, y = density)) +
  geom_area(
    data = subset(normal, x >= interval_lower & x <= interval_upper),
    fill = "#D55E00",
    alpha = 0.2
  ) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  annotate(
    "text", x = 217, y = 0.022,
    label = paste0("P(210.5 < X ≤ 223.5)\n= ", round(p_interval, 2)),
    size = 2.5
  ) +
  labs(
    title = "Probability density function",
    x = "Flipper length (mm)",
    y = "Density (1/mm)"
  ) +
  theme_classic()

# Panel 2: cumulative probability function
p2 = ggplot(normal, aes(x = x, y = cumulative_probability)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  annotate(
    "segment", x = cutoff, xend = cutoff, y = 0, yend = p_cutoff,
    linetype = "dashed", colour = "grey40"
  ) +
  annotate(
    "segment", x = 194, xend = cutoff, y = p_cutoff, yend = p_cutoff,
    linetype = "dashed", colour = "grey40"
  ) +
  annotate(
    "text", x = 207, y = 0.92,
    label = paste0("P(X ≤ ", cutoff, ") = ", round(p_cutoff, 2)),
    size = 3
  ) +
  labs(
    title = "Cumulative probability function",
    x = "Flipper length (mm)",
    y = "Cumulative probability"
  ) +
  theme_classic()

# Panel 3: quantile function
probabilities = seq(0.001, 0.999, length.out = 999)

quantiles = data.frame(
  p = probabilities,
  quantile = qnorm(probabilities, mean = mean_flipper, sd = sd_flipper)
)

p3 = ggplot(quantiles, aes(x = p, y = quantile)) +
  geom_line(colour = "#D55E00", linewidth = 0.8) +
  geom_point(
    data = data.frame(p = p_cutoff, quantile = cutoff),
    colour = "#D55E00",
    size = 3
  ) +
  annotate(
    "text", x = 0.5, y = 232,
    label = paste0("qnorm(", round(p_cutoff, 2), ") = ", cutoff),
    size = 3
  ) +
  labs(
    title = "Quantile function",
    x = "Cumulative probability",
    y = "Quantile (mm)"
  ) +
  theme_classic()

# Panel 4: the measured flipper lengths as a density-scaled histogram
sample_data = data.frame(x = gentoo$flipper_len)

p4 = ggplot(sample_data, aes(x = x)) +
  geom_histogram(
    aes(y = after_stat(density)),
    binwidth = 3,
    boundary = 201.5,
    fill = "grey90",
    colour = "grey40"
  ) +
  geom_line(
    data = normal,
    aes(x = x, y = density),
    colour = "#D55E00",
    linewidth = 0.8
  ) +
  labs(
    title = "123 measured flipper lengths",
    x = "Flipper length (mm)",
    y = "Density (1/mm)"
  ) +
  theme_classic()

ggsave(
  file.path(out_dir, "normal-four-faces.png"),
  plot = (p1 | p2) / (p3 | p4),
  width = fig_width, height = fig_height, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 22: joint-density.png (copy)
# The chunk fig-joint_density of Chapter_2/Theory.qmd, unchanged; the plot is assigned
# to an object so that it can be saved. It uses gentoo from above.
# ---------------------------------------------------------------------------

# Parameters of the joint distribution of flipper length (mm) and body mass (g).
mean_flipper = 217
sd_flipper = 6.5
mean_mass = 5100
sd_mass = 500
rho = 0.7

# Calculate the joint density on a grid of flipper length and body mass combinations.
density_grid = expand.grid(
  flipper_len = seq(from = 195, to = 240, length.out = 100),
  body_mass = seq(from = 3400, to = 6800, length.out = 100)
)
z_x = (density_grid$flipper_len - mean_flipper) / sd_flipper
z_y = (density_grid$body_mass - mean_mass) / sd_mass
density_grid$joint_density =
  exp(-(z_x^2 - 2 * rho * z_x * z_y + z_y^2) / (2 * (1 - rho^2))) /
  (2 * pi * sd_flipper * sd_mass * sqrt(1 - rho^2))

# Plot the measured penguins with the contours of the joint density.
joint_plot = ggplot(gentoo, aes(x = flipper_len, y = body_mass)) +
  geom_point(colour = "#0072B2", alpha = 0.7, size = 2) +
  geom_contour(
    data = density_grid,
    aes(z = joint_density),
    colour = "#D55E00",
    linewidth = 0.8,
    bins = 8
  ) +
  labs(x = "Flipper length (mm)", y = "Body mass (g)") +
  theme_classic()

ggsave(
  file.path(out_dir, "joint-density.png"),
  plot = joint_plot,
  width = fig_width, height = fig_height, dpi = fig_dpi
)

# ---------------------------------------------------------------------------
# Slide 28: salamander-counts.png (new)
# Relative frequencies of the 48 counts of spring salamanders (GP) at the 12 unmined
# sites, with the Poisson mass for the sample mean. No Negative Binomial: fitting it is
# the topic of Chapter 4.
# ---------------------------------------------------------------------------

data(Salamanders, package = "glmmTMB")
spring_salamanders = Salamanders[Salamanders$spp == "GP" & Salamanders$mined == "no", ]
counts = spring_salamanders$count

# Relative frequency of each count from zero to the largest count
count_values = 0:max(counts)
salamander_frequency = data.frame(
  x = count_values,
  relative_frequency = tabulate(counts + 1, nbins = max(counts) + 1) / length(counts),
  poisson = dpois(count_values, lambda = mean(counts))
)

salamander_plot = ggplot(salamander_frequency, aes(x = x)) +
  geom_col(aes(y = relative_frequency), fill = "grey90", colour = "grey40", width = 0.7) +
  geom_segment(aes(xend = x, y = 0, yend = poisson), colour = "#D55E00", linewidth = 0.8) +
  geom_point(aes(y = poisson), colour = "#D55E00", size = 2.5) +
  scale_x_continuous(breaks = count_values) +
  labs(x = "Number of salamanders", y = "Relative frequency or probability") +
  theme_classic(base_size = 13)

ggsave(
  file.path(out_dir, "salamander-counts.png"),
  plot = salamander_plot,
  width = fig_width, height = fig_height, dpi = fig_dpi
)
