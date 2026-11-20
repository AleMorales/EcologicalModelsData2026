# Builds adalia.csv from Adalia.xls and Table 1 of Brakefield and de Jong (2011).
# Run from this folder with Rscript make_adalia_csv.R. Needs the package readxl, which
# only this script uses.

library(readxl)

# Both sheets of the spreadsheet have the same six columns.
ew = as.data.frame(read_excel("Adalia.xls", sheet = "EW"))
ns = as.data.frame(read_excel("Adalia.xls", sheet = "NS"))
sheet = rbind(ew, ns)

adalia = data.frame(
  transect = sheet$code,
  place = sheet$place,
  year = as.integer(sheet$year),
  # Excel stores 87.8 as 87.799999999999997; the paper gives one decimal.
  distance_km = round(sheet$distance_KM, 1),
  black = as.integer(sheet$nr_black),
  red = as.integer(sheet$nr_red)
)

# Three samples of the east-west transect that are in Table 1 of Brakefield and de Jong
# (2011, Heredity 107: 574-578) but not in the spreadsheet. "# Melanic" is black and
# "# Typica" is red.
table_1 = data.frame(
  transect = "EW",
  place = c("Oudenbosch", "Oudenbosch", "Waalre"),
  year = c(1980L, 1998L, 1998L),
  distance_km = c(50.3, 50.3, 118.8),
  black = c(1207L, 51L, 33L),
  red = c(1139L, 94L, 80L)
)
adalia = rbind(adalia, table_1)

# Sort by transect (EW first), year and distance. The three rows from Table 1 are not
# marked in the file; README.md lists them.
adalia = adalia[order(adalia$transect != "EW", adalia$year, adalia$distance_km), ]
write.csv(adalia, "adalia.csv", row.names = FALSE)
