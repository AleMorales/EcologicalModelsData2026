# Melanism in the two-spot ladybird along transects in the Netherlands, 1980–2004

This folder contains material for a possible case study on a non-linear mixed model for the
part of the course up to Chapter 7. It is for the author's reference and is not part of the
website or the PDF books: Quarto renders only the pages listed in `_quarto-prod.yml`,
`_quarto-dev.yml` and the PDF profiles, and nothing in `Case Studies/` is listed there.

| File | Content |
|---|---|
| `Adalia.xls` | The spreadsheet supplied by the author (sheets `EW`, `NS` and `description`) |
| `Adalia_paper.pdf` | de Jong and Brakefield (1998), supplied by the author (JSTOR copy) |
| `hdy201149.pdf` | Brakefield and de Jong (2011), supplied by the author |
| `make_adalia_csv.R` | Builds `adalia.csv` from the spreadsheet and Table 1 of the 2011 paper (needs `readxl`) |
| `adalia.csv` | The data: both transects in one long table, with three samples added from the 2011 paper (see below) |
| `data_description.md` | Description of the species, the study and the data for students, without analysis or results |
| `adalia_analysis.qmd` | Exploration and analysis with the tools of the course (RTMB, RTMBdist, DHARMa, TMB), with alternatives and pitfalls |
| `adalia_analysis.pdf` | The rendered document (Typst) |
| `slides/adalia-intro.qmd` | Three Reveal.js slides that introduce the data to students choosing a case study (course `lecture.scss`); render from this folder with `quarto render slides/adalia-intro.qmd --to revealjs`. `slides/assets/` holds the photos, the map and the data figure, their sources and licences (`CREDITS.md`) and `figures.R`, which redraws the map and the figure from this folder |
| `_quarto.yml` | Makes this folder a Quarto project of its own, so that the document renders without the settings and filters of the course website |
| `README.md` | This description |

Status: generated draft (20 November 2026), not reviewed by the author.

The two PDFs are copyrighted articles in a folder that git tracks; the author may prefer
to keep them out of the repository (for example in `.gitignore`).

## Sources

- de Jong, P. W. and Brakefield, P. M. (1998). Climate and change in clines for melanism
  in the two-spot ladybird, *Adalia bipunctata* (Coleoptera: Coccinellidae). *Proceedings
  of the Royal Society of London B* 265: 39–43. Surveys of 1980 (collections of 1978 to
  1981, first described by Brakefield 1984a), 1991 and 1995 on the east–west transect
  and 1980 and 1992 on the north–south transect (Figure 1); climate data of the Royal
  Netherlands Meteorological Institute (KNMI).
- Brakefield, P. M. and de Jong, P. W. (2011). A steep cline in ladybird melanism has
  decayed over 25 years: a genetic response to climate change? *Heredity* 107: 574–578.
  doi:10.1038/hdy.2011.49. Adds the 1998 and 2004 surveys of the east–west transect and
  lists every sample of the five surveys in Table 1. The full data are "available on
  request from the authors".
- Brakefield, P. M. (1984a). Ecological studies on the polymorphic ladybird *Adalia
  bipunctata* in The Netherlands. I. Population biology and geographical variation of
  melanism. *Journal of Animal Ecology* 53: 761–774. The original description of the
  1980 cline (not seen).

Where the spreadsheet comes from is not documented; its sheet `description` explains the
columns (and calls the north–south transect `NZ`, Dutch *noord–zuid*, while the data use
`NS`).

## From the spreadsheet to `adalia.csv`

`make_adalia_csv.R` stacks the two sheets, renames the columns (`code` to `transect`,
`distance_KM` to `distance_km`, `nr_black` to `black`, `nr_red` to `red`), rounds the
distances to the one decimal of the paper (Excel stores 87.8 as 87.799999999999997) and
sorts the rows by transect, survey and distance.

**Three samples added from Table 1 of the 2011 paper** (author's decision of 20 November
2026). The 67 east–west samples of the spreadsheet agree exactly with Table 1, but Table 1
has three more, which the CSV now contains and does not mark:

| Locality | Distance (km) | Survey | Melanic (`black`) | Typica (`red`) |
|---|---|---|---|---|
| Oudenbosch | 50.3 | 1980 | 1,207 | 1,139 |
| Oudenbosch | 50.3 | 1998 | 51 | 94 |
| Waalre (Waalre/Eindhoven in the paper) | 118.8 | 1998 | 33 | 80 |

With them the east–west transect has 16 localities and 15, 15, 14, 16 and 10 samples in
the five surveys, as the paper describes. They do not change the answer (Section 8.3 of
the analysis). Why the spreadsheet lacks them is not known.

The paper gives the smallest sample (35), the mean (818, standard error 288) and the median
(152) of the sample sizes. The 70 samples of the CSV give 35, 840 (standard error 285) and
155.5, close but not identical; the 2004 mean (115) agrees exactly. The paper may have
summarised a slightly different set of samples.

## Columns of `adalia.csv`

| Column | Content | Units |
|---|---|---|
| `transect` | `EW` (east–west) or `NS` (north–south) | none |
| `place` | Locality, spelled as in the spreadsheet (`Etten L.` for Etten-Leur, `Mijnsheerenl.` for Mijnsheerenland, `Bergen op z.` for Bergen op Zoom, `Waalre` for Waalre/Eindhoven) | none |
| `year` | Survey (1980 stands for 1978 to 1981) | year |
| `distance_km` | `EW`: distance to the coast; `NS`: distance from Delft | km |
| `black` | Melanic beetles in the sample ("# Melanic" in Table 1) | beetles |
| `red` | Non-melanic beetles ("# Typica" in Table 1) | beetles |

99 samples: 70 on the east–west transect and 29 on the north–south one (14 in 1980, 14 in
1991 and Numansdorp in 2004). Samples have 35 to 15,217 beetles (58,806 on the east–west
transect).

## What the papers document

- **Morphs:** melanics are "predominantly black with red spots", non-melanics red with
  black spots; a series of melanic alleles is dominant over the non-melanic (*typica*)
  allele (2011). Which melanic morphs occur is not listed.
- **Sampling:** adults and pupae collected in the field, mainly on *Rosa rugosa*, *Tilia*
  and *Euonymus* (1998), "lime trees (*Tilia* spp.) and various shrubs and herbs" (2011);
  pupae reared to adults in the laboratory, then all beetles scored. Each transect was
  "about 10 km wide" (1998). About two generations per year (2011, citing Brakefield
  1984a, b).
- **The 1980 survey** pools collections from 1978 to 1981 (both papers); which years
  contributed to which sample is not given. Its samples are much larger (mean 3,306 beetles
  against 115 to 194 in later surveys).
- **2004:** the invasion of *Harmonia axyridis* from about 2002 reduced the numbers of
  *A. bipunctata*; the 10 samples are small (mean 115) and five localities sampled in at
  least two earlier surveys could not be sampled (2011). The transect can no longer be
  resurveyed.
- **North–south transect:** sampled in 1980 and, according to the 1998 paper, in 1992; the
  spreadsheet says 1991 (the east–west resurvey was in 1991). Its distances are measured
  from Delft (Figure 1c of the 1998 paper). The 2004 sample of Numansdorp is in neither
  paper. Willemstad belongs to both transects; its 1980 sample (2,565 and 3,144) is the
  same in both sheets, but its 1991 samples differ (75/128 on the east–west sheet, 83/143
  on the north–south sheet), consistent with two resurveys in different years.

## How the papers analysed the data

For the author only; `data_description.md` leaves this out.

- **1998:** clines drawn by eye (Figure 1); change at each locality tested with chi-square
  tests (1 degree of freedom, minimum sample 50); significant decreases inland in the
  south-east and some increases in the west. Climate: two-factor ANOVAs and correlations
  of monthly sunshine, wind and temperature (March to September) with year; spring
  temperatures (April, May) increased at most stations; sunshine showed no trend and wind
a decline at one station (Eindhoven) only.
- **2011:** a general linear model of the arcsine-square-root transformed percentages with
  survey as a factor and distance to the coast as a covariate (F = 8.03 for survey and
  10.08 for distance, both P < 0.0001), which weights every sample equally and is linear in
  distance; pairwise comparisons per site (Supplementary Table S1, not seen); a
  heterogeneity chi-square for the 2004 samples (25.86, 9 df, P < 0.01; 8.26, 8 df without
  Goedereede); Figure 2b, the difference between the medians of the five westernmost and
  the five easternmost localities, falls from about 40 percentage points in 1980 to about 4
  in 2004 (read from the figure). A selection coefficient against melanics inland of 0.036
  from a decline of 55 to 20% over 50 generations (Hartl 1980). The authors attribute the
  decay to climate change through thermal melanism, "although no direct test is available".

Neither paper fits a cline function or estimates its parameters.

## What is still not known

- why the spreadsheet lacks three samples of Table 1, and whether the north–south resurvey
  was in 1991 or 1992;
- which years (1978 to 1981) and how many collections make up each 1980 sample;
- how the distances were measured (straight line to the coast, or along the transect), and
  the coordinates of the localities;
- whether a sample comes from one or several trees (pupae from one tree may be siblings);
- the contents of Supplementary Table S1 of the 2011 paper.

## Suitability for a case study after Chapter 7

The analysis document fits the data with the recipe of Chapter 7:

- a logistic cline with a coastal and an inland plateau, a centre and a steepness (the
  logistic function of the functions supplement, raised and scaled), Binomial counts, a
  random effect per sample on the logit scale (as for the tadpole tanks of the Chapter 7
  practical) and the survey as a predictor of the plateaus through `model.matrix()`;
- comparisons with AIC of the distribution (Binomial, Beta-Binomial) and of the random
  effect (none, per site, per sample), of the cline against a GLMM that is linear on the
  logit scale, and of candidates for the change over time; the answer as quantities inside
  the data (the typical frequency at 10 and 60 km from the coast in each survey and the odds
  ratio between them) with `ADREPORT()`; a likelihood profile of the standard deviation
  among samples; DHARMa residuals per sample and per locality; sensitivity checks; the
  north–south transect as an extension; a simulation of the coverage of the Wald
  intervals; a REML estimate.

The main result is that the cline decayed because the inland populations lost melanics:
the typical frequency 60 km from the coast fell from 53% (49 to 58%) in 1980 to 26% (21 to
32%) in 2004, while 10 km from the coast it stayed at 14 to 19%; the odds ratio between the
two fell from 7.2 (5.0 to 10.3) to 1.8 (1.2 to 2.8). The centre (36 km) and the width
(23 km) do not change detectably; a steady decline of the inland plateau (odds × 0.62 per
decade) is the best candidate by AIC. On the north–south transect the cline also became
shallower between 1980 and 1991, mainly through an increase of melanics near Delft.

Strengths and weaknesses for teaching:

- **Strengths:** a classic and well-documented example (evolution in response to climate,
  thermal melanism) with published sources; a non-linear curve whose parameters (plateaus,
  centre, width) are what ecologists report and which a GLMM cannot provide; a clear answer
  with a strong signal; Binomial counts, which complement the continuous data of Case
  study 2 and of the infiltration data; clear lessons on the choice of the group (site or
  sample), on the weight of very large samples, on overdispersion that grows with the
  sample size, on the identifiability of the shape of a flat cline, and on the difference
  between a change over time and its cause.
- **Weaknesses:** the obvious random effect (per site) collapses to zero, so the mixed
  model has one random effect per row, which students may find less intuitive than a
  random effect per site (but it is exactly the tank model of the Chapter 7 practical); the
  Beta-Binomial model, without a random effect, fits slightly better (3.8 AIC units); the
  survey is a factor with only five levels, so the trend over time rests on five points;
  unbalanced design and very unequal sample sizes; the 1980 survey pools four years; the
  Wald intervals cover about 90% under the model (Section 11 of the analysis); the climate
  is not in the data; the north–south transect is short (two surveys).

## Rendering the document

From this folder, run

```
quarto render adalia_analysis.qmd
```

which writes `adalia_analysis.pdf` with Typst (no LaTeX needed). Because of the
`_quarto.yml` in this folder, the render does not use the profiles, filters or settings of
the course website. The document needs RTMB, RTMBdist, DHARMa, TMB and knitr, all of which
the course already uses, and takes about a minute and a half (R 4.6.1, Quarto 1.9.36). The
chunks can also be run one by one in RStudio, with this folder as the working directory.
`readxl` is needed only to rebuild the CSV with `Rscript make_adalia_csv.R`.
