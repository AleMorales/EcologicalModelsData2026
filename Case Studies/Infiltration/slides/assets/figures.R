# Figures of the introductory slides on the infiltration data. Run from the folder
# Case Studies/Infiltration with Rscript slides/assets/figures.R; writes into
# slides/assets/. Needs ggplot2. Inputs:
#   infiltration.csv                  the data of the case study;
#   slides/assets/kenya-outline.csv   country outlines and lakes (Natural Earth 1:50m
#                                     admin 0 countries and lakes, public domain), cut to
#                                     the region of the map.

library(ggplot2)

assets = "slides/assets"
class_colours = c(E0 = "#0072B2", E1 = "#E69F00", E2 = "#009E73")
class_shapes = c(E0 = 16, E1 = 17, E2 = 15)

# Map of Kenya with the study area ---------------------------------------------------

outline = read.csv(file.path(assets, "kenya-outline.csv"))
countries = outline[outline$layer == "country", ]
lakes = outline[outline$layer == "lake", ]
countries$kenya = countries$name == "Kenya"

# Towns that locate the basin (approximate coordinates, decimal degrees).
towns = data.frame(
  name = c("Nairobi", "Machakos"),
  lon = c(36.82, 37.26),
  lat = c(-1.29, -1.52)
)

map_plot = ggplot() +
  geom_polygon(data = countries, aes(x = lon, y = lat, group = polygon, fill = kenya),
               colour = "grey55", linewidth = 0.3) +
  geom_polygon(data = lakes, aes(x = lon, y = lat, group = polygon),
               fill = "#e6f0f7", colour = "grey55", linewidth = 0.3) +
  # Approximate position of the Upper Athi River basin, south-east of Nairobi.
  annotate("point", x = 37.1, y = -1.55, shape = 21, size = 22, stroke = 1.2,
           colour = "#D55E00", fill = NA) +
  geom_point(data = towns, aes(x = lon, y = lat), size = 2.8, colour = "grey15") +
  geom_text(data = towns, aes(x = lon, y = lat, label = name),
            nudge_x = c(-1.05, 1.15), nudge_y = c(0.15, -0.1), size = 5.2,
            colour = "grey15") +
  annotate("text", x = 37.3, y = -2.75, label = "Upper Athi\nRiver basin",
           colour = "#D55E00", size = 5.2, lineheight = 0.9) +
  annotate("text", x = 37.9, y = 1.2, label = "KENYA", colour = "grey35", size = 6) +
  annotate("text", x = 41.6, y = -3.6, label = "Indian\nOcean", fontface = "italic",
           colour = "grey45", size = 5, lineheight = 0.9) +
  annotate("text", x = 33.6, y = -0.45, label = "Lake\nVictoria", fontface = "italic",
           colour = "grey45", size = 4.6, lineheight = 0.9) +
  scale_fill_manual(values = c(`TRUE` = "grey85", `FALSE` = "grey96"), guide = "none") +
  coord_quickmap(xlim = c(33, 42.3), ylim = c(-5, 5), expand = FALSE) +
  labs(x = NULL, y = NULL) +
  theme_classic(base_size = 18) +
  theme(panel.background = element_rect(fill = "#e6f0f7"),
        panel.border = element_rect(fill = NA, colour = "grey60"),
        axis.text = element_blank(), axis.ticks = element_blank(),
        axis.line = element_blank())

ggsave(file.path(assets, "kenya-map.png"), map_plot, width = 5.6, height = 6, dpi = 200)

# Readings of three plots ----------------------------------------------------------

infil = read.csv("infiltration.csv")
infil$PlotNo = factor(infil$PlotNo, levels = unique(infil$PlotNo))

# Depth infiltrated in the first 30 minutes of each plot (cm): the running sum of rate
# times interval, interpolated at 30 minutes.
infil$Interval = ave(infil$Time, infil$PlotNo, FUN = function(t) diff(c(0, t)))
infil$Depth = ave(infil$Rate * infil$Interval, infil$PlotNo, FUN = cumsum)
by_plot = split(infil, infil$PlotNo)
depth_30 = sapply(by_plot, function(p) approx(c(0, p$Time), c(0, p$Depth), xout = 30)$y)
plot_class = sapply(by_plot, function(p) p$Erosion[1])

# One plot per class: the plot whose depth in 30 minutes is closest to the median of
# its class, so that the figure shows typical runs and not the extremes.
chosen = sapply(c("E0", "E1", "E2"), function(e) {
  d = depth_30[plot_class == e]
  names(d)[which.min(abs(d - median(d)))]
})
shown = infil[infil$PlotNo %in% chosen, ]
shown$Erosion = factor(shown$Erosion, levels = c("E0", "E1", "E2"))
print(chosen)

data_plot = ggplot(shown, aes(x = Time, y = Rate, colour = Erosion, shape = Erosion)) +
  geom_line(linewidth = 0.4, alpha = 0.6) +
  geom_point(alpha = 0.8, size = 2.6) +
  scale_colour_manual(values = class_colours, name = "Class") +
  scale_shape_manual(values = class_shapes, name = "Class") +
  labs(x = "Time since the start of the run (min)",
       y = "Infiltration rate (cm/min)") +
  theme_classic(base_size = 20) +
  theme(legend.position = c(0.85, 0.75))

ggsave(file.path(assets, "data-three-plots.png"), data_plot, width = 6.4, height = 4.6,
       dpi = 200)
