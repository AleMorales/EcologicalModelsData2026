# Figures of the introductory slides on the cocoa allometry data. Run from the folder
# Case Studies/Allometry with Rscript slides/assets/figures.R; writes into slides/assets/.
# Needs ggplot2. Input: allometry.csv, the data of the case study.

library(ggplot2)

assets = "slides/assets"
no_shade_colour = "#0072B2"
shade_colour = "#E69F00"

allometry = read.csv("allometry.csv")
allometry$shade = factor(allometry$shade, levels = c("no", "yes"))

# The twelve fields and their management -------------------------------------------

# One row per field, in the order of the data (site, then age).
fields = allometry[!duplicated(allometry$field),
                   c("site", "field", "age_years", "shade", "density_ha", "irrigation")]
fields$trees = as.vector(table(allometry$field)[fields$field])
# Fertiliser was given to some of the trees of a field at the Nigerian site.
n_fertilised = tapply(allometry$fertilisation == "yes", allometry$field, sum)
fields$fertilisation = ifelse(
  n_fertilised[fields$field] == 0, "no",
  ifelse(n_fertilised[fields$field] == fields$trees, "yes",
         paste(n_fertilised[fields$field], "of", fields$trees))
)
fields$row = rev(seq_len(nrow(fields)))

# Columns of the chart: position on the x axis and header.
columns = data.frame(
  x = c(1, 2.15, 3.1, 4, 5.05, 6.15, 7.2),
  header = c("Site", "Age\n(years)", "Trees", "Shade\ntrees", "Density\n(trees/ha)",
             "Irrigated", "Fertilised")
)

# One block per site, with its code and country.
sites = data.frame(site = c("CIV1", "CIV2", "ECU", "NGA"),
                   country = c("Côte d'Ivoire", "Côte d'Ivoire", "Ecuador", "Nigeria"))
sites$top = tapply(fields$row, fields$site, max)[sites$site] + 0.5
sites$bottom = tapply(fields$row, fields$site, min)[sites$site] - 0.5
sites$middle = (sites$top + sites$bottom) / 2
sites$band = sites$site %in% c("CIV1", "ECU")

cells = rbind(
  data.frame(x = columns$x[2], row = fields$row, label = as.character(fields$age_years)),
  data.frame(x = columns$x[3], row = fields$row, label = fields$trees),
  data.frame(x = columns$x[5], row = fields$row, label = fields$density_ha),
  data.frame(x = columns$x[6], row = fields$row, label = fields$irrigation),
  data.frame(x = columns$x[7], row = fields$row, label = fields$fertilisation)
)
text_size = 6.2
top = max(fields$row) + 0.5

fields_plot = ggplot() +
  geom_rect(data = sites[sites$band, ],
            aes(xmin = 0.35, xmax = 7.75, ymin = bottom, ymax = top),
            fill = "grey93") +
  geom_text(data = sites, aes(x = columns$x[1], y = middle + 0.22, label = site),
            size = text_size, fontface = "bold", colour = "grey15") +
  geom_text(data = sites, aes(x = columns$x[1], y = middle - 0.3, label = country),
            size = text_size * 0.78, colour = "grey30") +
  geom_text(data = cells, aes(x = x, y = row, label = label), size = text_size,
            colour = "grey15") +
  geom_point(data = fields, aes(x = columns$x[4], y = row, colour = shade, shape = shade),
             size = 4.5) +
  geom_text(data = columns, aes(x = x, y = top + 0.95, label = header), size = text_size,
            fontface = "bold", colour = "grey15", lineheight = 0.9) +
  geom_hline(yintercept = top, colour = "grey50", linewidth = 0.4) +
  scale_colour_manual(values = c(no = no_shade_colour, yes = shade_colour), guide = "none") +
  scale_shape_manual(values = c(no = 16, yes = 17), guide = "none") +
  scale_x_continuous(limits = c(0.35, 7.75), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, top + 1.6), expand = c(0, 0)) +
  theme_classic() +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(), axis.title = element_blank(),
        plot.margin = margin(4, 4, 4, 4))

ggsave(file.path(assets, "fields.png"), fields_plot, width = 8, height = 5.8, dpi = 200)

# Aboveground biomass against stem diameter ---------------------------------------

data_plot = ggplot(allometry, aes(x = dia20_cm, y = agb_kg, colour = shade, shape = shade)) +
  geom_point(alpha = 0.7, size = 3.5) +
  scale_x_log10(limits = c(0.5, 40), breaks = c(0.5, 1, 2, 5, 10, 20, 40),
                labels = as.character(c(0.5, 1, 2, 5, 10, 20, 40))) +
  scale_y_log10(limits = c(0.1, 150), breaks = c(0.1, 0.3, 1, 3, 10, 30, 100),
                labels = as.character(c(0.1, 0.3, 1, 3, 10, 30, 100))) +
  scale_colour_manual(values = c(no = no_shade_colour, yes = shade_colour),
                      labels = c("No shade trees", "Shade trees"), name = NULL) +
  scale_shape_manual(values = c(no = 16, yes = 17),
                     labels = c("No shade trees", "Shade trees"), name = NULL) +
  labs(x = "Stem diameter at 20 cm (cm)", y = "Aboveground biomass (kg)") +
  theme_classic(base_size = 20) +
  theme(legend.position = c(0.25, 0.88),
        legend.background = element_rect(fill = "white", colour = "grey80"))

ggsave(file.path(assets, "agb-diameter.png"), data_plot, width = 6.4, height = 4.4, dpi = 200)
