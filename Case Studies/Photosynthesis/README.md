# Light response curves of *Arabidopsis* grown at two temperatures, with and without drought

This folder contains material for a possible case study on a non-linear mixed model for the
part of the course up to Chapter 7. It is for the author's reference and is not part of the
website or the PDF books: Quarto renders only the pages listed in `_quarto-prod.yml`,
`_quarto-dev.yml` and the PDF profiles, and `_quarto-dev.yml` excludes `Case Studies/`.

| File | Content |
|---|---|
| `PhotosynthesisArabidopsisRaw.csv` | The data, supplied by the author |
| `data_description.md` | Description of the data and their context for students, handed out with the CSV; gives no hints on the analysis (draft with gaps marked `[TO FILL]`) |
| `photosynthesis_analysis.qmd` | Exploration and analysis with the tools of the course (RTMB, RTMBdist, DHARMa, TMB), with alternatives and pitfalls |
| `photosynthesis_analysis.pdf` | The rendered document (Typst) |
| `slides/photosynthesis-intro.qmd` | Three introductory slides (reveal.js, course style) that present the data to students choosing a case study; `slides/assets/` holds the photos (credits in `CREDITS.md`) and `figures.R`, which draws the figure of the curves |
| `_quarto.yml` | Makes this folder a Quarto project of its own, so that the document renders without the settings and filters of the course website |
| `README.md` | This description |

Status: generated draft (20 November 2026), not reviewed by the author.

## Source

The author supplied the file and described the experiment as follows: photosynthetic light
response curves (net photosynthesis against light, both in µmol/m²/s) measured on
*Arabidopsis* plants grown in batches at a low (`LT`, 22 °C) or a high (`HT`, 28 °C)
temperature, either watered every other day (`C`) or subjected to progressive drought (`D`:
watering stopped and photosynthesis measured after 7 days). Several replicates (one replicate
is one curve) were measured in each batch. All curves were measured at the same standard
temperature, because the aim was to capture acclimation to the growth temperature, not the
direct response of photosynthesis to temperature. The data were collected by the author
(Alejandro Morales) at Utrecht University in 2019 and 2020 and are unpublished.

Details supplied by the author on 20 November (also in `data_description.md`):

- **Plants:** *Arabidopsis thaliana* Col-0, sown on a moist soil:perlite mix (1:2; Primasta
  BV, Asten, The Netherlands), stratified in darkness at 4 °C for 4 days, then grown in two
  climate rooms (one per temperature, same day and night temperature), 70% relative
  humidity, 120 µmol/m²/s PAR at plant height from fluorescent tubes, 8-hour photoperiod.
- **Batches:** plants sown on one date and grown together; batches were sown one week
  apart. The treatments started in each batch when the plants were large enough for a leaf
  to fill the cuvette.
- **Drought:** controls watered every other day from the bottom (several pots per tray);
  droughted plants not watered for 7 days. Pot weights were checked from time to time, but
  soil water content and plant water status were not recorded.
- **Measurement:** LI-6800 (LI-COR) with a 6 cm² cuvette; each curve is a different plant,
  on the youngest leaf large enough to fill the cuvette (so the leaf always covered the
  whole chamber); CO₂ 400 ppm, leaf temperature 22 °C (thermocouple), relative humidity
  70%, LED light of 90% red and 10% blue.
- **Protocol:** light from low to high, 5 to 8 minutes per step. According to the author,
  stomatal conductance had not reached steady state at high light, so $p_{\max}$ is
  probably underestimated; the emphasis of the experiment was on the light-use efficiency at
  low light, given the growth light of the plants. (The student description mentions the
  stomata but not this emphasis, which would point at a parameter.)

## Columns

| Column | Content | Units |
|---|---|---|
| `Batch` | Batch of plants, 1 to 5 | none |
| `T` | Growth temperature: `LT` (22 °C) or `HT` (28 °C) | none |
| `W` | Water: `C` (control) or `D` (drought) | none |
| `Replicate` | Curve, numbered 1 to 27 across batches | none |
| `P` | Net photosynthesis (CO₂ uptake) | µmol/m²/s |
| `I` | Light intensity | µmol/m²/s |

The file is plain UTF-8 (the byte order mark of the original file was removed on 20
November, and its line endings became LF; the values are unchanged). There are 243 rows, nine per curve, at nominal light
intensities of 25, 50, 100, 150, 250, 350, 500, 750 and 1000 µmol/m²/s (the recorded values
differ from these by at most 0.011), sorted by curve and increasing light.

## What the analysis found about the data

These properties follow from the data (Section 2 of the analysis document).

- **Design:** 27 curves; LT-C 12 (two or three per batch), HT-C 5, LT-D 5 (none in batch 4,
  two in batch 5), HT-D 5 (one per batch).
- **No measurement in the dark:** 11 curves have a negative net rate at 25 µmol/m²/s, and
  the dark respiration can only be extrapolated.
- **The curves do not saturate** by 1000 µmol/m²/s, so the asymptote $p_{\max}$ lies beyond
  the data.
- **The curves are smooth:** single fits of the non-rectangular hyperbola leave residuals
  with a standard deviation of about 0.08 µmol/m²/s, with no trend against the fitted rate.
- **Plants differ much more than measurements:** curves of the same combination differ by up
  to a factor of two at high light; the HT-D curves range from 3.8 to 8.9 µmol/m²/s at the
  highest light, and the two lowest are those of batches 1 and 2.

## What is not known

The author's details answer most questions about the method. What remains unknown:

- any measure of soil water content or plant water status in the drought treatment (pot
  weights were checked but not recorded). This is the main gap: the effect of drought at
  28 °C varies greatly between plants, and the analysis cannot tell whether the soil dried
  more in some batches;
- the exact age of the plants at the measurement (the treatments started at a stage of
  development, not at a fixed age) and the dates of the batches;
- a publication to cite (the data are unpublished).

The analysis mentions, without a citation, that respiration in the light can differ from
respiration in the dark at low light; the author may want to add a reference or remove the
remark.

## Suitability for a case study after Chapter 7

The analysis document fits the data with the recipe of Chapter 7 and Case study 2:

- the non-rectangular hyperbola (or the saturating exponential) minus the dark respiration,
  with Normal deviations of constant standard deviation, one random effect per curve that
  multiplies the whole net curve, and temperature, water and their interaction as
  group-level predictors through `model.matrix()`; the batch as a block;
- candidates compared with AIC, the answer as the typical $\alpha$, $p_{\max}$ and $r_d$ of
  each combination and their ratios with `ADREPORT()`, a likelihood profile of $\theta$,
  DHARMa residuals per measurement and per curve, sensitivity checks and a simulation of the
  coverage of the Wald intervals.

Model choices (author's decisions of 20 November): the batch enters as a fixed block effect
compared by AIC, and the answer is given in terms of the curve parameters, with a pitfall on
$p_{\max}$ lying beyond the data.

The main results: the non-rectangular hyperbola beats the saturating exponential by about 53
AIC units; a random effect on the whole net curve beats one on $p_{\max}$ only by about 42; a
standard deviation that changes with the expected rate is not supported (with one random
effect); the batch block is not supported (1.4 AIC units worse). In the controls, plants
grown at 28 °C have a typical $p_{\max}$ 21% lower than plants grown at 22 °C (ratio 0.79,
95% interval 0.65 to 0.95). Drought hardly changes the curve at 22 °C, but at 28 °C it lowers
$p_{\max}$ by about 21% and halves $\alpha$. Strengths and weaknesses for teaching:

- **Strengths:** a clear physiological question (acclimation to growth temperature, and its
  interaction with drought); a standard mechanistic curve that is already in the functions
  supplement; an obvious grouping (27 curves) with group-level predictors in a factorial
  design; clear lessons on starting values, numerical stability of a formula, parameters at a
  boundary, parameters beyond the data, the placement of a random effect, and the difference
  between variation among plants and measurement error.
- **Weaknesses:** a small and unbalanced design (five curves in three of the four
  combinations); $\theta$ is poorly determined (profile interval from 0 to about 0.4); a
  single random effect cannot describe differences in shape (deviations within a curve have
  a correlation of about 0.76, and a second random effect on $\alpha$ improves AIC by about
  190 units, which is beyond Chapter 7); the plants of HT-D differ much more among
  themselves than those of HT-C and LT-D (a standard deviation among curves per combination
  improves AIC by about 8 units and widens the intervals for HT-D); the data are not yet
  documented or citable.

## Rendering the document

From this folder, run

```
quarto render photosynthesis_analysis.qmd
```

which writes `photosynthesis_analysis.pdf` with Typst (no LaTeX needed). Because of the
`_quarto.yml` in this folder, the render does not use the profiles, filters or settings of
the course website. The document needs RTMB, RTMBdist, DHARMa, TMB and knitr, all of which
the course already uses, and takes about two and a half minutes. The chunks can also be run
one by one in RStudio, with this folder as the working directory. For a plain R script,
`knitr::purl("photosynthesis_analysis.qmd")` extracts the code.
