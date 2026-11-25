# Allometry of cocoa trees under different management

This folder contains material for a possible case study on a non-linear mixed model for the
part of the course up to Chapter 7. It is for the author's reference and is not part of the
website or the PDF books: Quarto renders only the pages listed in `_quarto-prod.yml`,
`_quarto-dev.yml` and the PDF profiles, and `_quarto-dev.yml` excludes `Case Studies/`.

| File | Content |
|---|---|
| `CocoaAllometry.xlsx` | The spreadsheet supplied by the author (sheets `CocoaAllometry` and `metadata`) |
| `Original manuscript Goudsmit et al. Cocoa Allometry.docx` | The manuscript that analysed the data (unpublished; rejected), supplied by the author |
| `Supplemental manuscript allometry.docx` | Its supplementary material |
| `make_allometry_csv.R` | Builds `allometry.csv` from the spreadsheet (needs `readxl`) |
| `allometry.csv` | The data: 62 trees, with the values of the spreadsheet, renamed columns and a column for the field |
| `data_description.md` | Description of cocoa, allometry, the sites, the measurements and the data for students, without analysis or results |
| `allometry_analysis.qmd` | Exploration and analysis with the tools of the course (RTMB, RTMBdist, DHARMa, TMB), with alternatives and pitfalls |
| `allometry_analysis.pdf` | The rendered document (Typst) |
| `slides/allometry-intro.qmd` | Three Reveal.js slides that introduce the data to students choosing a case study (course `lecture.scss`); render from this folder with `quarto render slides/allometry-intro.qmd --to revealjs`. `slides/assets/` holds the images, their sources (`CREDITS.md`) and `figures.R`, which draws the figures from this folder |
| `_quarto.yml` | Makes this folder a Quarto project of its own, so that the document renders without the settings and filters of the course website |
| `README.md` | This description |

Status: generated draft (25 November 2026), not reviewed by the author.

The manuscript is unpublished and names the people who collected the data. Whether its
co-authors agree that students receive the data (and the sun-and-shade photos of its
Supplement 4, used on the second slide) is for the author to confirm.

## Source

Goudsmit, E., Rozendaal, D. M. A., Tosto, A., Hougni, D.-G., Morales Sierra, A., Vasquez
Zambrano, E., Adet, L., Anten, N. and Slingerland, M. Challenges in aboveground biomass
predictions for cacao using allometric equations: effects of model selection and management
practices. Unpublished manuscript (Wageningen University), with a supplement. It has two
parts: (1) a comparison of eleven published allometric models with the
harvested trees, and (2) a new allometric model with management practices, which is the
part this case study uses (its Figure 3 is the key figure).

The spreadsheet's column `Dataset` names the person who collected the trees, and each
collector worked at one site, which the manuscript's Table 1 identifies by tree ages and
numbers: `Fabian` is Côte d'Ivoire 1 (CNRA station near Divo; Fabian Calvo Romero in the
acknowledgements), `Tosto` Côte d'Ivoire 2 (Tiassalé; Ambra Tosto, a co-author), `David`
Ecuador (La Chola farm, Guayas; presumably David Fisher of the acknowledgements) and
`Olusade` Nigeria (CRIN, Ibadan; Olusade Adeola Ajibona). The sheet `metadata` describes the
columns. Wood density (`WD_gcm3`) is 0.39 g/cm³ for every tree, a value from the literature
and not a measurement.

## From the spreadsheet to `allometry.csv`

`make_allometry_csv.R` replaces the collector by a site code (`CIV1`, `CIV2`, `ECU`, `NGA`),
adds `field` (site and age, for example `NGA_47`, one row of Table 1 of the manuscript),
renames the columns, turns `Y`/`N` into `yes`/`no`, rounds the masses and the diameter to
three decimals and the height to two (Excel stores 4.14 as 4.1399999999999997, and the
masses of Ecuador were calculated and carry nine decimals), drops `WD_gcm3`, and sorts the
rows by site, age and tree number. **No value is changed and no tree is removed**; the
doubtful records below are left to the analysis.

## Columns of `allometry.csv`

| Column | Content | Units |
|---|---|---|
| `tree` | Identifier of the spreadsheet (`F`, `T`, `D`, `O` for the collector, and a number) | none |
| `site` | `CIV1`, `CIV2`, `ECU`, `NGA` | none |
| `field` | Site and age of the plantation (12 fields) | none |
| `age_years` | Years since germination | year |
| `dia20_cm` | Stem diameter 20 cm above the soil (from the circumference) | cm |
| `height_m` | Height from the soil to the top of the crown | m |
| `wood_kg`, `leaf_kg` | Dry mass of wood (with bark) and of leaves | kg |
| `agb_kg` | Aboveground biomass (wood and leaves) | kg |
| `taproot_kg`, `lateral_root_kg`, `root_kg` | Dry mass of the roots (`NA` for the nine trees of `CIV2_3.25`) | kg |
| `total_kg` | Aboveground biomass and roots (`NA` for the same nine trees) | kg |
| `shade` | Shade trees present in the field | none |
| `density_ha` | Planting density of cocoa | trees/ha |
| `irrigation` | Field irrigated | none |
| `fertilisation` | Tree fertilised (differs between trees in the fields of NGA) | none |

## The design and the confounding of management with site

| Site | Fields (age, trees) | Shade | Density (trees/ha) | Irrigation | Fertilisation |
|---|---|---|---|---|---|
| CIV1 | 1.5 (3), 5 (3), 10 (3), 19 (3) | no, no, no, yes | 1,333 | no | no |
| CIV2 | 2 (8), 3.25 (9) | yes | 1,111 | yes | yes |
| ECU | 1 (5), 6 (5), 11 (5) | no | 1,500, 1,500, 1,130 | yes | yes |
| NGA | 8 (6), 12 (6), 47 (6) | yes | 1,100 | no | 3 yes and 3 no per field |

Management varies almost only between sites. The only contrasts within a site are shade in
CIV1 (one field of three 19-year-old trees), density in ECU (the 11-year field against the
two younger ones, so confounded with age) and fertilisation in NGA (within each field, the
only contrast between trees of the same field). Irrigation coincides with CIV2 and ECU. The
sites also differ in country, climate, planting material (hybrids in Côte d'Ivoire, the
clone CCN51 in Ecuador, Amazon and TC-series material in Nigeria), pruning (hedging in
Ecuador), year of sampling and collector. Shaded fields have 1,100 to 1,333 trees/ha, so
the scenario "1,400 trees/ha with shade" of the manuscript's Figure 3 lies outside the data,
and so does 1,000 trees/ha.

## Doubtful records

The spreadsheet has the following problems. The analysis document explains how it handles
each one.

- **F9** (CIV1, 10 years): 37.24 cm and 42.2 kg. The manuscript excluded one tree, "the
  oldest tree from the Côte d'Ivoire dataset", for its "extremely low biomass to stem
  diameter ratio"; F9 is the only such tree, but it is 10 years old (the oldest CIV1 trees
  are 19). Its diameter is twice that of the other 10-year-old trees (17.2 and 19.1 cm);
  17.24 would fit them, but that is a guess.
- **D4 and D5** (ECU, 1 year): diameters 0.695 and 0.644 cm with 0.17 and 0.16 kg of wood.
  A stem of that diameter and the tree's height (0.76 and 0.97 m) at 0.39 g/cm³ weighs about
  11 and 12 g, so the wood is 13 to 15 times the mass of such a cylinder; for every other
  tree the ratio lies between 0.17 (F9) and 2.75. The diameters are physically implausible
  (perhaps measured above a graft, perhaps a recording error). The manuscript kept them.
- **D10 and D14** (ECU): D10 (6 years) has 14.8 cm and 10.0 kg, D14 (11 years) 9.22 cm and
  17.8 kg. Each is an outlier in its field, and with their diameters swapped each fits its
  field. Not verifiable.
- **T17** (CIV2): `AGB_kg` is 1.2, but wood and leaves add up to 2.47 kg. For every other
  tree the sum agrees.
- **F11 and F12** (CIV1, 19 years): identical wood mass (76.49 kg) with diameters of 31.8
  and 20.1 cm, possibly a copied value.
- **CIV1, 1.5 years**: Table 1 of the manuscript describes the field as intercropped with
  plantain and shaded; the spreadsheet says no shade. CIV2, also intercropped with plantain,
  has shade `yes`.
- **CIV2**: the fields of 2 and 3.25 years have the same coordinates and were sampled in
  2019 and 2020 (Table 1 gives 3 years); they may be one plantation sampled twice.

## How the manuscript analysed the data

For the author only; `data_description.md` leaves this out.

- Part 2 fitted six equations of $\log(\mathrm{AGB})$ that are linear in their parameters
  (following Nam et al. 2016), with all numerical predictors scaled and a random effect of
  the data set (four levels, `lme4`), and chose by AICc, BIC, leave-one-out cross-validation
  and RMSE a cubic polynomial in $\log(D)$ (equation 5). Its $\log(\mathrm{WD})$ term is a
  constant, so it is part of the intercept.
- It then compared all combinations of planting density, an interaction of density with the
  cross-sectional area of the stem (CSA), shade, fertilisation and irrigation (`MuMIn::dredge`)
  and chose density, CSA × density and shade (Table 6, Supplement 1).
- The cubic polynomial is not monotonic: the curves of Figure 3 reach a maximum (about 25 cm
  at high density, 35 cm without management) after which biomass falls as the diameter
  grows, which the text calls an inflection point.
- With four data sets and management constant within most of them, the random effect of the
  data set and the management effects describe the same differences between sites.
- The published equation cannot be applied as printed: Supplement 2 labels its scaling
  constants $\log(\mathrm{CSA})$ and $\log(\text{density})$, but the means (174.64 and
  1,209.66) are on the original scale; it computes CSA as $\pi\,\mathrm{dia20}/2$ (not an
  area); and it writes $\log(\mathrm{dia}^2)$ for $(\log(\mathrm{dia}))^2$.
- AICc and BIC are used for a mixed model, for which $n$ is ambiguous (the course uses AIC
  only for grouped models).

## What is still not known

- the correct diameters of F9, D4, D5, D10 and D14, and the AGB of T17;
- whether F11 and F12 really have the same wood mass;
- whether the 1.5-year field of CIV1 had shade (plantain);
- whether the two CIV2 fields are one plantation;
- how the planting material differs among the fields of NGA (Table 1 gives TC series 2012
  for 8 years, mix F3 Amazon for 12 and 47 years);
- whether a field's trees were chosen at random, and how the roots were excavated.

## Suitability for a case study after Chapter 7

The analysis document fits the data with the recipe of Chapter 7:

- a power law $\mu = a(D/10)^b$ for the mean aboveground biomass (functions supplement,
  `sec-fn-power`), a LogNormal distribution written with its mean (so that the manuscript's
  correction factor is not needed), a random effect per field on $\log(a)$, and management
  or the site as predictors of $\log(a)$ and $b$ through `model.matrix()`;
- the main data set has 59 trees: F9, D4 and D5 are excluded because their wood mass is
  implausible for their diameter and height (a form factor that students can calculate);
  the manuscript's 61 trees, the D10/D14 swap and shade in the 1.5-year CIV1 field are
  sensitivity checks;
- comparisons with AIC of the distribution, the grouping, the curve (power law against
  the manuscript's quadratic and cubic polynomials) and 13 candidates for management, an
  answer at 4 and 16 cm with `ADREPORT()`, DHARMa residuals per tree and per field, a
  likelihood profile and a REML estimate of the variation among fields, an extension to the
  height–diameter relation (a saturating exponential with a random effect per field), and a
  simulation of the Wald intervals and of AIC with no shade effect.

Main results (59 trees; see the document for intervals):

- The power law is enough: the quadratic and cubic polynomials are within 0.6 AIC units of
  it. On the manuscript's 61 trees the cubic wins by 31.5 units, with a minimum at 1.1 cm
  that passes through D4 and D5 and a maximum at 36.6 cm. Its curvature comes from these
  two records.
- LogNormal and Gamma fit equally well (0.8 AIC units apart). A Normal distribution with
  constant variance is 134 units worse. A random effect per field beats one per site.
- Shade or density on both parameters improves the model without management by about 16
  to 17 AIC units, but the site on both parameters is better still (7.4 units better than
  the best management model). The only contrasts within sites show nothing clear:
  fertilisation within NGA multiplies the mean biomass by 0.88 (0.73 to 1.05); shade
  within CIV1 and density within ECU have standard errors as large as the effects and are
  confounded with age.
- Under the shade model, shaded trees are lighter at 4 cm (ratio 0.25) and heavier at
  16 cm (2.02, interval including 1). At 4 cm this compares CIV2 with CIV1 and ECU; at
  16 cm it compares NGA with CIV1 and ECU. No shaded tree has a diameter between 9.2 and
  15.1 cm.
- With D10 and D14 swapped, the shade and density model beats the site model by 7.9
  units. So the verdict of AIC depends on two uncertain diameters.
- **Two maxima of the likelihood** (found by the analysis): for several candidates,
  `optim()` converges either to a small or to a large standard deviation among fields. The
  exponent is then the exponent across fields or the exponent within fields, and these
  differ (1.53 within and 2.42 between fields, when the field mean of $\log(D/10)$ is a
  predictor, which removes the second maximum). Whether the allometry of interest is the
  relation within a stand or along the development of stands is a question for the author.
- In a simulation with no shade effect, AIC prefers the shade model by more than 2 units in
  about 11% of samples, and the Wald intervals of the ratio cover about 86%.
- Height saturates with diameter, at about 3.8 m in the hedged ECU trees against 5 to 7 m
  elsewhere. Here too the site beats every management variable.

**The answer the data support:** the allometry differs among sites and fields, but these
data cannot attribute the differences to shade, density, irrigation or fertilisation
rather than to country, planting material, climate, age or collector. This differs from
the manuscript's conclusion. The manuscript's Figure 3 scenarios (1,000 and 1,400
trees/ha, with and without shade) lie partly outside the data.

Strengths and weaknesses for teaching:

- **Strengths:**
  - A real and current question (carbon stocks of cocoa) from the author's own group, with
    a published-style analysis to compare with.
  - Continuous, positive data whose variance grows with the mean, which complements the
    counts of the ladybird case.
  - Clear lessons:
    - checking records for physical plausibility before fitting;
    - the mean and the median of a LogNormal (the "correction factor");
    - why a polynomial is a poor allometric curve;
    - the choice of group (field or site);
    - confounding of a predictor with the groups, and that a better AIC for a
      management variable does not show that management is the reason;
    - extrapolation in the space of predictors;
    - a likelihood with two maxima (Chapter 8 material that students meet naturally);
    - the difference between within-group and between-group relations.
- **Weaknesses:**
  - Small (59 to 62 trees, 12 fields, 3 to 9 trees per field).
  - The research question as the manuscript framed it cannot be answered: students who
    expect to estimate a management effect will find that they cannot, which needs a
    careful framing of the task (for example "Can these data show an effect of management
    on the allometry?").
  - The result depends on decisions about doubtful records that cannot be checked without
    the collectors.
  - The power law is linear on logarithmic axes, so the main model could be fitted as a
    linear mixed model of $\log(\mathrm{AGB})$. The non-linear parts are the mean
    parameterisation, the comparison with the polynomial and the height extension.
  - The two maxima can confuse students who are not warned.

Before giving the case to students, it would help to ask the collectors (or the manuscript's
authors) about the diameters of F9, D4, D5, D10 and D14 and the shade of the 1.5-year CIV1
field. The answer would change the main analysis more than any modelling choice.

## Rendering the document

From this folder, run

```
quarto render allometry_analysis.qmd
```

which writes `allometry_analysis.pdf` with Typst (no LaTeX needed). Because of the
`_quarto.yml` in this folder, the render does not use the profiles, filters or settings of
the course website. The document needs RTMB, RTMBdist, DHARMa, TMB and knitr, all of which
the course already uses, and takes about a minute (R 4.6.1, Quarto 1.9.36). `readxl` is
needed only to rebuild the CSV with
`Rscript make_allometry_csv.R`.
