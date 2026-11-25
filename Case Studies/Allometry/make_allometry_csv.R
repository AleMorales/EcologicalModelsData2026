# Builds allometry.csv from CocoaAllometry.xlsx. Run from this folder with
# Rscript make_allometry_csv.R. Needs the package readxl, which only this script uses.

library(readxl)

sheet = as.data.frame(read_excel("CocoaAllometry.xlsx", sheet = "CocoaAllometry",
                                 na = "NA"))

# The column Dataset names the person who collected the data; each collector worked at
# one site (Table 1 of the manuscript), so the site replaces the name.
sites = c(Fabian = "CIV1", Tosto = "CIV2", David = "ECU", Olusade = "NGA")
yes_no = function(x) ifelse(x == "Y", "yes", "no")

allometry = data.frame(
  tree = sheet$ID,
  site = unname(sites[sheet$Dataset]),
  age_years = sheet$TreeAge_years,
  # Excel stores 4.14 as 4.1399999999999997; the masses of ECU were calculated and
  # carry many decimals. Three decimals keep 1 g and 0.1 mm.
  dia20_cm = round(sheet$Dia20_cm, 3),
  height_m = round(sheet$Height_m, 2),
  wood_kg = round(sheet$WoodDW_kg, 3),
  leaf_kg = round(sheet$LeafDW_kg, 3),
  agb_kg = round(sheet$AGB_kg, 3),
  taproot_kg = round(sheet$TapRootDW_kg, 3),
  lateral_root_kg = round(sheet$LateralRootDW_kg, 3),
  root_kg = round(sheet$RootDW_kg, 3),
  total_kg = round(sheet$TotBiomass_kg, 3),
  shade = yes_no(sheet$`Shade_Y/N`),
  density_ha = sheet$Density,
  irrigation = yes_no(sheet$`Irrigation_Y/N`),
  fertilisation = yes_no(sheet$`Fertilization_Y/N`)
)

# A field is a plantation of one age at one site (one row of Table 1 of the manuscript).
allometry$field = paste(allometry$site, allometry$age_years, sep = "_")
allometry = allometry[, c("tree", "site", "field", setdiff(names(allometry),
                                                           c("tree", "site", "field")))]

# Sort by site, age and tree number; WD_gcm3 (0.39 for every tree, taken from the
# literature) is left out.
tree_number = as.numeric(sub("^[A-Z]+", "", allometry$tree))
allometry = allometry[order(allometry$site, allometry$age_years, tree_number), ]
write.csv(allometry, "allometry.csv", row.names = FALSE)
