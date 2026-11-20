# Figure of the introductory slides on the photosynthesis data. Run from the folder
# Case Studies/Photosynthesis with Rscript slides/assets/figures.R; writes into
# slides/assets/. Needs ggplot2. Input: PhotosynthesisArabidopsisRaw.csv.

library(ggplot2)

assets = "slides/assets"

photo = read.csv("PhotosynthesisArabidopsisRaw.csv")
photo$Temperature = factor(photo$T, levels = c("LT", "HT"),
                           labels = c("Grown at 22 °C", "Grown at 28 °C"))
photo$Water = factor(photo$W, levels = c("C", "D"), labels = c("Control", "Drought"))

# Light response curves: one line per plant, one panel per combination of treatments.
curves_plot = ggplot(photo, aes(x = I, y = P, group = Replicate)) +
  geom_hline(yintercept = 0, colour = "grey60", linetype = "dotted") +
  geom_line(colour = "#0072B2", alpha = 0.5, linewidth = 0.6) +
  geom_point(colour = "#0072B2", alpha = 0.7, size = 1.6) +
  facet_grid(Water ~ Temperature) +
  scale_x_continuous(breaks = c(0, 500, 1000)) +
  labs(x = "Light (µmol/m²/s)", y = "Net photosynthesis (µmol/m²/s)") +
  theme_classic(base_size = 18) +
  theme(strip.background = element_rect(fill = "#f0f6f2", colour = NA),
        strip.text = element_text(colour = "#164c43"),
        panel.border = element_rect(fill = NA, colour = "grey80"),
        panel.spacing.x = unit(1.6, "lines"))

ggsave(file.path(assets, "curves.png"), curves_plot, width = 7, height = 5.6, dpi = 200)
