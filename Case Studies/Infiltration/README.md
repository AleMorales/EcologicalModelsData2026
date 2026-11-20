# Water infiltration on 30 plots in three erosion classes (Upper Athi River basin, Kenya)

This folder contains material for a possible case study on a non-linear mixed model for the
part of the course up to Chapter 7. It is for the author's reference and is not part of the
website or the PDF books: Quarto renders only the pages listed in `_quarto-prod.yml`,
`_quarto-dev.yml` and the PDF profiles, and nothing in `Case Studies/` is listed there.

| File | Content |
|---|---|
| `infiltration.csv` | The data, copied unchanged from the R package HydroMe |
| `data_description.md` | Description of the study, the measurements and the data for students, based on the dissertation but without its analysis or results |
| `infiltration_analysis.qmd` | Exploration and analysis with the tools of the course (RTMB, RTMBdist, DHARMa, TMB), with alternatives and pitfalls |
| `infiltration_analysis.pdf` | The rendered document (Typst) |
| `slides/infiltration-intro.qmd` | Three Reveal.js slides that introduce the data to students choosing a case study (no results); images, their credits (`slides/assets/CREDITS.md`) and the code of the figures (`slides/assets/figures.R`) are in `slides/assets/` |
| `_quarto.yml` | Makes this folder a Quarto project of its own, so that the document renders without the settings and filters of the course website |
| `README.md` | This description |

Status: generated draft (19 November 2026), not reviewed by the author. The sections on the
dissertation and `data_description.md` were added on 20 November 2026 from the
dissertation (Omuto 2006), which the author supplied, and the text of
`infiltration_analysis.qmd` was brought in line with it (classes, method, design,
comparison with the dissertation's analysis); its code and results did not change.

## Source

The data are the data set `infilt` of the R package **HydroMe** (version 2.1.2, published on
CRAN on 26 February 2026, author Christian Thine Omuto, licence GPL). HydroMe was
**archived on CRAN on 27 September 2026** ("issues were not corrected in time"), so it
cannot be installed from CRAN as a dependency of the course. Version 2.1.2 is still
available from the CRAN archive. The CSV was written with
`write.csv(infilt, row.names = FALSE)` and contains the six columns of the package in the
same order.

The help page of `infilt` describes the data as "part of a dataset from a PhD study which
measured water infiltration characteristics from the Upper Athi River basin in Eastern
Kenya", grouped by plot, and gives as source:

- Omuto, C. T. (2006). *Large-area soil physical degradation assessment using GIS, remote
  sensing, and infrared spectroscopy in arid and semi-arid Kenya.* PhD dissertation,
  University of Nairobi, Kenya.

The package is described in:

- Omuto, C. T. and Gumbe, L. O. (2009). Estimating water infiltration and retention
  characteristics using a computer program in R. *Computers & Geosciences* 35: 579–585.
  doi:10.1016/j.cageo.2008.08.011

The paper (Section 3.1) calls the data set `Infilt`. It says that it contains "30 groups
of infiltration measurements", with **Rate in cm/min and Time in min**, and uses it to
fit Philip's equation to all groups together with `nls(log(Rate) ~ SSphilip(Time, fc, S))`,
reporting fc = −1.637 (SE 0.044) and S = 4.480 (SE 0.277), with a residual standard error
of 0.80 on 1,103 degrees of freedom. Because the response there is `log(Rate)`, this fc
is on the log scale (exp(−1.64) ≈ 0.19 cm/min); that reading is ours, as the paper does
not comment on it. Table 1 of the paper lists the infiltration equations of the package:

- Philip (1957): i(t) = fc + 0.5 S t^(−0.5), with steady infiltration rate fc and
  sorptivity S;
- Horton (1940): i(t) = fc + (f0 − fc) exp(−k t), with initial rate f0 and decay rate k
  (the table prints f_c twice; f0 is meant);
- Green and Ampt (1911): i(t) = Ks + A / I(t), with I(t) the cumulative infiltration.

The paper presents a two-step mixed-effects approach (first `nlsList()` per group, then
`nlme()`, with covariates added to the fixed effects) and refers for its rationale to
Omuto, Minasny, McBratney and Biamah (2006), *Nonlinear mixed effect modelling for improved
estimation of water retention and infiltration parameters*, Journal of Hydrology 330:
748–758. Its mixed-effects examples use water-retention data (`isric`, `Wret`), not the
infiltration data. We have not checked whether the 2006 paper analyses these plots.

## Columns

| Column | Content | Units |
|---|---|---|
| `Sample` | Row number (1 to 1,105) | none |
| `PlotNo` | Plot, 30 levels named `1lP3` to `30lP3` (the meaning of `lP3` is not documented; see below) | none |
| `Erosion` | Visual degradation class of the plot: `E0`, `E1`, `E2` (defined below) | none |
| `Time` | Time since the start of the run at which the reading was taken | min |
| `Rate` | Infiltration rate | cm/min |
| `Cumrate` | Running sum of `Rate` within the plot (see below: not a depth) | (cm/min) |

The rows are sorted by plot (in the order of the plot numbers) and time. There are 7 plots
in E0, 19 in E1 and 4 in E2, with 15 to 54 readings per plot (1,105 in total). Runs
last 33 to 88 minutes. Rates range from 0.025 to 4 cm/min (no zeros).

## What the analysis found about the data

These properties are not documented; they follow from the data (Section 2 of the
analysis document).

- **A reading is a depth in whole millimetres divided by the length of its interval.**
  Rate × (Time − previous Time) × 10 is a whole number of millimetres for every reading
  (time 0 before the first one). So `Rate` is the mean rate over the interval, read to
  the nearest millimetre: one millimetre more or less changes the rate by a quarter or
  more for 41% of the readings, and low rates take only a few values (0.05, 0.1,
  0.15 cm/min over 2-minute intervals).
- **Intervals** are 1 minute at first and 2 minutes later (525 and 483 intervals), with a
  few of 3 to 10 minutes and two of 0.5 minutes. 27 plots were first read after 1 minute,
  the others after 2, 3 and 4 minutes.
- **`Cumrate` is not the cumulative infiltration.** It adds up the rates without
  multiplying them by the length of the intervals, so it falls behind the depth as soon as
  the intervals last 2 minutes. The cumulative depth is the running sum of
  Rate × interval.
- **Early rises:** in 12 plots the rate rises before it falls, mostly within the first 2 to
  6 minutes. Neither Philip's nor Horton's equation can describe this.
- **The spread** of the readings within a plot grows in proportion to the rate (median
  coefficient of variation 0.20 among the last ten readings of each plot).
- **Plots differ much more than classes:** the depth infiltrated in the first 30 minutes
  ranges from 2.9 to 57 cm, and the three classes overlap almost completely.

## What the dissertation documents

The dissertation (Omuto 2006, Chapter 3) describes the survey from which the data come.
Page numbers refer to the dissertation.

- **Study area** (Section 3.1, p. 60): Upper Athi River basin, eastern Kenya, 4,513 km²;
  mostly below 1,000 m and gently sloping, with steep slopes (> 20%) above 1,500 m in the
  north and south; annual rainfall 800 to 1,100 mm in the high parts and 600 to 800 mm in
  the low parts, with long rains from late March to early June and short rains in
  September and October; mostly silty loams to sands (Ferralsols in the centre, Cambisols
  along the Athi River, Arenosols in the highlands), low in nutrients; savannah and forest
  converted to agriculture over about five decades.
- **Design** (Section 3.2.1, pp. 61–63): survey from December 2002 to March 2003; 45
  randomly placed blocks of 1 km × 1 km, each with 13 plots of 30 m × 30 m (the size of a
  Landsat pixel) along a Y-shaped frame. Infiltration and water retention were measured on
  4 plots per block (the centre plot and the outermost plot of each arm), 180 plots in
  all. Land use was recorded as forest, woodlots, shrubland, cropland or grassland.
- **Method** (Section 3.2.2, p. 64): single-ring infiltrometers with an inner diameter of
  30 cm, inserted into pre-wetted soil surfaces; rates by the falling-head approach
  (Elrick and Reynolds 2002); topsoil (0 to 20 cm); three positions per plot, P1, P2 and
  P3, along the slope at 5, 15 and 25 m from the plot edge. This confirms the inference
  from the whole millimetres. The dissertation does not say how a run was stopped.
- **Classes** (Section 3.2.1 and Table 3.1, p. 63): the classes are visual classes of
  physical degradation, assigned from signs observed on the plot. `E0` non-degraded (no
  visible sign); `E1` moderately degraded (signs of degradation in place: crusting,
  sealing or compaction); `E2` severely degraded (several signs, including degradation in
  place and/or erosion: sheet, rill or gully). The survey had 26 E0, 107 E1 and 47 E2
  plots. Table 3.1 lists the observed signs; `data_description.md` reproduces them.
- **`lP3` in the plot names:** probably position P3 (25 m from the plot edge), which
  would make the data set one run at the same position on each of 30 plots. This is our
  reading; neither the package nor the dissertation says so.

`data_description.md` gives these facts to students. It credits the collector and the
package but does not name the dissertation, so that students are not pointed to an
analysis of the same data; the author may prefer to add the full reference.

## How the dissertation analysed the infiltration data

For the author only; `data_description.md` leaves this out. The dissertation fitted
Philip's equation (and Green and Ampt for comparison, Table 4.1) to all 180 plots with
`nlme` (Section 4.1.1), with the visual class as a covariate of the fixed effects
(Section 4.1.2, Table 4.5, p. 94). The fixed effects decrease from E0 to E2: fc = 0.47,
0.21 and 0.10 cm/min, S = 5.37, 2.48 and 1.23 cm/min^0.5 (standard errors 0.01 to 0.57;
the table labels fc in cm/min, but Table 4.6 gives fc in cm/hour, so the units in the
dissertation are not consistent). It reports that all parameters except the residual
water content of the retention curve differ significantly between classes. Philip's
equation was fitted to the rate with a constant residual standard deviation (0.38).

With all 180 plots, the classes therefore differ clearly in the fitted parameters,
whereas the 30 plots of HydroMe cannot separate the classes in the depth infiltrated in 30
minutes (see below). How the 30 plots were chosen from the 180 is not documented; with 7,
19 and 4 plots per class (23%, 63% and 13%), E2 is under-represented compared with the
survey (14%, 59% and 26%). A case study could use this contrast, but its parameters are not on the same
scale as ours (Philip with additive errors versus a multiplicative plot effect and
LogNormal or Gamma readings).

## What is still not known

- which of the 180 plots (and blocks) the 30 plots are, and so their land use, slope,
  soil and location;
- how the 30 plots were selected, and whether `lP3` means position P3;
- when a run was stopped (runs last 33 to 88 minutes).

## Suitability for a case study after Chapter 7

The analysis document fits the data with the recipe of Chapter 7 and Case study 2:

- Horton or Philip curve for the rate, LogNormal or Gamma readings with a constant
  coefficient of variation, one random effect per plot that multiplies the whole curve,
  and the erosion class as a group-level predictor through `model.matrix()`;
- candidates compared with AIC, the answer as a quantity within the data (the ratio of the
  typical depth infiltrated in the first 30 minutes) with `ADREPORT()`, a likelihood
  profile of the standard deviation among plots, DHARMa residuals per reading and per plot,
  sensitivity checks and a simulation of the coverage of the Wald intervals.

The main result is that the classes differ in the shape of the decline but the 30 plots
cannot tell whether they take up different amounts of water: the typical depth in 30
minutes is 14.8 cm (E0), 13.7 cm (E1) and 11.0 cm (E2), with ratios E1/E0 = 0.93 (95%
interval 0.48 to 1.80) and E2/E0 = 0.74 (0.29 to 1.90). Strengths and weaknesses for
teaching:

- **Strengths:** a real environmental question (soil degradation and infiltration);
  equations with a physical meaning and a published source; an obvious grouping (30
  plots); a group-level predictor; clear lessons on what a measurement is, on the
  placement of a random effect, on candidates that tie on AIC but answer the question
  differently, and on quantities inside and outside the data.
- **Weaknesses:** the classes are a visual judgement and the selection of the 30 plots
  is undocumented (the classes and the method are documented in the dissertation, see
  above); unbalanced design with only 4 plots in E2; a null answer for the level; correlated successive readings (0.36 within plots),
  which the course cannot model; the better curve by AIC (Philip) puts the steady rate of
  E0 at a boundary, which is Chapter 8 material; the data come from an archived package.

## Rendering the document

From this folder, run

```
quarto render infiltration_analysis.qmd
```

which writes `infiltration_analysis.pdf` with Typst (no LaTeX needed). Because of the
`_quarto.yml` in this folder, the render does not use the profiles, filters or settings of
the course website. The document needs RTMB, RTMBdist, DHARMa, TMB and knitr, all of which
the course already uses, and takes a little over a minute. The chunks can also be run one
by one in RStudio, with this folder as the working directory (RStudio does this when the
document is open). For a plain R script, `knitr::purl("infiltration_analysis.qmd")`
extracts the code.
