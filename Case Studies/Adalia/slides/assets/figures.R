# Figures of the introductory slides on the ladybird data. Run from the folder
# Case Studies/Adalia with Rscript slides/assets/figures.R; writes into slides/assets/.
# Needs ggplot2. Inputs:
#   adalia.csv                       the data of the case study;
#   slides/assets/localities.csv     coordinates of the localities (OpenStreetMap,
#                                    geocoded with Nominatim on 20 November 2026);
#   slides/assets/map-outline.csv    country outlines (Natural Earth 1:10m admin 0,
#                                    public domain), cut to the region of the map.

library(ggplot2)

assets = "slides/assets"
ew_colour = "#0072B2"
ns_colour = "#E69F00"

# Map of the two transects --------------------------------------------------------

outline = read.csv(file.path(assets, "map-outline.csv"))
localities = read.csv(file.path(assets, "localities.csv"))
localities$transect = factor(localities$transect, levels = c("EW", "NS"),
                             labels = c("East–west", "North–south"))

# Names shown on the map: the ends of each transect and the crossing.
label_names = c("Ouddorp", "Willemstad, Noord-Brabant", "Tilburg", "Waalre", "Delft",
                "Rotterdam", "Antwerpen")
labels = localities[localities$query %in% label_names & !duplicated(localities$query), ]
labels$label = sub(",.*", "", labels$query)
# Position of each label relative to its locality (degrees); Willemstad, where the
# transects cross, gets a label to the side with a leader line.
offsets = data.frame(
  label = c("Ouddorp", "Willemstad", "Tilburg", "Waalre", "Delft", "Rotterdam", "Antwerpen"),
  dx = c(0, 0.24, 0, 0, 0, 0, 0),
  dy = c(0.035, 0.05, 0.035, -0.035, 0.035, 0.035, -0.035)
)
labels = merge(labels, offsets)

map_plot = ggplot() +
  geom_polygon(data = outline, aes(x = lon, y = lat, group = polygon),
               fill = "grey90", colour = "grey60", linewidth = 0.3) +
  geom_point(data = localities, aes(x = lon, y = lat, colour = transect, shape = transect),
             size = 3.6, stroke = 1.1) +
  geom_segment(data = labels[labels$dx != 0, ],
               aes(x = lon, y = lat, xend = lon + 0.75 * dx, yend = lat + 0.75 * dy),
               colour = "grey40", linewidth = 0.3) +
  geom_text(data = labels, aes(x = lon + dx, y = lat + dy, label = label), size = 5.2,
            colour = "grey20") +
  annotate("text", x = 3.75, y = 52.05, label = "North Sea", fontface = "italic",
           colour = "grey45", size = 5.2) +
  annotate("text", x = 5.3, y = 52.1, label = "Netherlands", colour = "grey45",
           size = 5.2) +
  annotate("text", x = 4.9, y = 51.18, label = "Belgium", colour = "grey45", size = 5.2) +
  scale_colour_manual(values = c(ew_colour, ns_colour), name = NULL) +
  scale_shape_manual(values = c(16, 17), name = NULL) +
  coord_quickmap(xlim = c(3.5, 5.7), ylim = c(51.1, 52.2), expand = FALSE) +
  labs(x = NULL, y = NULL) +
  theme_classic(base_size = 18) +
  theme(panel.background = element_rect(fill = "#e6f0f7"),
        panel.border = element_rect(fill = NA, colour = "grey60"),
        axis.text = element_blank(), axis.ticks = element_blank(),
        axis.line = element_blank(),
        legend.position = c(0.86, 0.12),
        legend.key = element_rect(fill = "white", colour = NA),
        legend.background = element_rect(fill = "white", colour = "grey80"))

ggsave(file.path(assets, "transects-map.png"), map_plot, width = 7, height = 5.6,
       dpi = 200)

# One survey of the data ----------------------------------------------------------

adalia = read.csv("adalia.csv")
ew_1980 = adalia[adalia$transect == "EW" & adalia$year == 1980, ]
ew_1980$prop = ew_1980$black / (ew_1980$black + ew_1980$red)

data_plot = ggplot(ew_1980, aes(x = distance_km, y = prop)) +
  geom_point(colour = ew_colour, alpha = 0.7, size = 3.5) +
  scale_y_continuous(limits = c(0, 0.65)) +
  labs(x = "Distance to the coast (km)", y = "Proportion of melanics") +
  theme_classic(base_size = 20)

ggsave(file.path(assets, "data-1980.png"), data_plot, width = 6, height = 4.4, dpi = 200)
