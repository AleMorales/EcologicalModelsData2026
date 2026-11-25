# Allometry of cocoa trees under different management

## Cocoa and allometry

**Cocoa**, *Theobroma cacao*, is a small tree of the understorey of tropical rain forests in
South America. It is grown for its seeds (cocoa beans) in plantations throughout the humid
tropics; West Africa produces about 70% of the world's cocoa. Cocoa is grown in very
different systems: under the canopy of shade trees (**agroforestry**), intercropped with
other crops such as plantain while the trees are young, or in full sun as a monoculture,
and at different planting densities and with different inputs (fertiliser, irrigation,
pruning).

The biomass of the cocoa trees in a plantation determines how much carbon the plantation
stores. Weighing a tree requires cutting it down, drying it and weighing every part, so the
biomass of trees is usually predicted from a size that is easy to measure in the field,
such as the diameter of the stem. A relation that predicts one property of an organism from
another is called an **allometric relation**. For trees, it is usually a power law, in
which biomass is proportional to the diameter raised to some power, and it is estimated
from trees that were harvested and weighed. Many such relations have been published for
cocoa, from different countries and production systems.

Whether one relation can serve every plantation is not obvious. A tree that competes for
light, with its neighbours in a dense plantation or with shade trees above it, may grow
taller and more slender (shade avoidance), or spread its crown and grow less in height
(shade tolerance). Either response changes the biomass of a tree with a given stem
diameter. Pruning, fertilisation and irrigation may also change the shape of a tree and how
it allocates biomass to wood and leaves.

## The sites and the fields

Cocoa trees were harvested at four sites:

- **CIV1**: the research station of the Centre National de Recherche Agronomique (CNRA)
  near Divo, Côte d'Ivoire (daily mean temperature 21.7 to 31.6 °C, 1,229 mm of rain per
  year). Hybrid planting material.
- **CIV2**: a research centre in the municipality of Tiassalé, Côte d'Ivoire (22.1 to
  31.0 °C, 1,431 mm/year). Hybrid planting material, intercropped with plantain, irrigated
  and fertilised.
- **ECU**: the commercial La Chola farm in the province of Guayas, Ecuador (23.0 to
  25.3 °C, 2,320 mm/year). An intensively managed full-sun farm: the trees (clone CCN51) are
  irrigated, fertilised, and hedged and pruned regularly.
- **NGA**: the Cocoa Research Institute of Nigeria (CRIN), Ibadan, Nigeria (20.0 to
  33.9 °C, 1,127 mm/year). Agroforestry plantations with shade trees, not irrigated.

At each site, trees were harvested in plantations of different ages. We call the
plantation of one age at one site a **field**; the trees of one field were harvested at the
same time. There are 12 fields:

| Field | Age (years) | Trees | Year | System | Density (trees/ha) | Fertilisation |
|---|---|---|---|---|---|---|
| `CIV1_1.5` | 1.5 | 3 | 2017 | intercropped with plantain | 1,333 | no |
| `CIV1_5` | 5 | 3 | 2017 | monoculture | 1,333 | no |
| `CIV1_10` | 10 | 3 | 2017 | monoculture | 1,333 | no |
| `CIV1_19` | 19 | 3 | 2017 | agroforestry | 1,333 | no |
| `CIV2_2` | 2 | 8 | 2019 | intercropped with plantain | 1,111 | yes |
| `CIV2_3.25` | 3.25 | 9 | 2020 | intercropped with plantain | 1,111 | yes |
| `ECU_1` | 1 | 5 | 2018 | monoculture, full sun | 1,500 | yes |
| `ECU_6` | 6 | 5 | 2018 | monoculture, full sun | 1,500 | yes |
| `ECU_11` | 11 | 5 | 2018 | monoculture, full sun | 1,130 | yes |
| `NGA_8` | 8 | 6 | 2020 | agroforestry | 1,100 | 3 trees yes, 3 no |
| `NGA_12` | 12 | 6 | 2020 | agroforestry | 1,100 | 3 trees yes, 3 no |
| `NGA_47` | 47 | 6 | 2020 | agroforestry | 1,100 | 3 trees yes, 3 no |

The two fields of CIV2 lie at the same place and were sampled one year apart. In the fields
of NGA, half of the harvested trees had received fertiliser and half had not. Whether a
field had shade trees and whether it was irrigated is in the data (see below).

## The measurements

Before a tree was cut, the circumference of its stem was measured 20 cm above the ground
and converted to a diameter, and the height of the tree was measured from the ground to the
highest point of the crown. The tree was then cut and taken apart: the branches were
separated by branching order (the main stem, the branches that grow from the first
whorl of branches, the side branches that grow from these, and so on), the leaves were
removed, and the fresh mass of each fraction was weighed. Samples of wood, bark and leaves
were dried at 65 °C until their mass no longer changed, and the ratio of dry to fresh mass
of the samples was used to calculate the dry mass of the wood and of the leaves of the whole
tree. The **aboveground biomass** of a tree is the dry mass of its wood and leaves.

For most trees the roots were also weighed (the taproot and the lateral roots); for the
3.25-year-old trees of CIV2 they were not.

## The data

The file `allometry.csv` has one row per tree and 17 columns:

| Column | Content | Units |
|---|---|---|
| `tree` | Tree identifier (a letter for the person who collected the data and a number) | none |
| `site` | `CIV1`, `CIV2`, `ECU` or `NGA` (see above) | none |
| `field` | Site and age of the plantation, for example `NGA_47` | none |
| `age_years` | Age of the tree (years since germination) | year |
| `dia20_cm` | Diameter of the stem 20 cm above the ground | cm |
| `height_m` | Height of the tree, from the ground to the top of the crown | m |
| `wood_kg` | Dry mass of all wood (stem and branches, with bark) | kg |
| `leaf_kg` | Dry mass of all leaves | kg |
| `agb_kg` | Aboveground biomass, the dry mass of wood and leaves | kg |
| `taproot_kg` | Dry mass of the taproot (missing, `NA`, for 9 trees) | kg |
| `lateral_root_kg` | Dry mass of the lateral roots (`NA` for 9 trees) | kg |
| `root_kg` | Dry mass of all roots (`NA` for 9 trees) | kg |
| `total_kg` | Total dry mass, above and below ground (`NA` for 9 trees) | kg |
| `shade` | Shade trees present in the field: `yes` or `no` | none |
| `density_ha` | Planting density of the cocoa trees in the field | trees/ha |
| `irrigation` | The field was irrigated: `yes` or `no` (whatever the amount and frequency) | none |
| `fertilisation` | The tree received fertiliser: `yes` or `no` (whatever the amount and frequency) | none |

The rows are sorted by site, age and tree number. The management columns describe the field
in which a tree grew, except `fertilisation`, which differs between trees in the fields of
NGA.

The data were collected by researchers of Wageningen University (the Netherlands) and their
partners in the CocoaSoils programme, and they are analysed in a manuscript by E. Goudsmit
and colleagues that has not been published.
