# Decisions: Case study 1 (rock crabs)

Read this before working on `Case_study_1/Theory.qmd`; AGENTS.md points here.

- **Purpose** (author's request of 10 November): a case study placed in the theory between
  Chapters 4 and 5 that reviews Chapters 1 to 4 by application. It follows the recipe for a
  fit at the end of Chapter 4, preceded by two steps that the recipe takes for granted:
  the research question and the exploration of the data. No new theory.
- **Data:** `MASS::crabs` (200 rock crabs, 50 per combination of `sp` and `sex`; Campbell
  and Mahon 1974, Aust. J. Zool. 22: 417–425). Chosen by the author on 10 November from
  the installed data sets that the course does not use. **Two species** (author's decision
  of 10 November, from the paper): the blue and orange forms of *Leptograpsus*, formerly
  regarded as colour morphs of *L. variegatus*; the page follows the paper and ignores the
  help page of `MASS`, which still calls them colour forms of one species. Facts taken
  from the paper: collected at night at Fremantle, captured on sight, all collected and
  measured by Mahon with vernier callipers to 0.1 mm; `FL` is the width of the frontal
  region ("front lip", not a "frontal lobe"), `RW` the width of the posterior carapace,
  `CL` the length along the midline, `CW` the maximum width, `BD` the body depth (abdomen
  displaced in females).
- **Figure from the paper:** `Case_study_1/images/carapace-measurements.png` is Fig. 1 of
  Campbell and Mahon (1974), cropped from the scan without its caption (author's decision
  of 10 November, as fair use in free educational material); the caption of
  `fig-crabs-carapace` credits the source.
- **Research question** (author's): to what extent the species and the sexes can be told
  apart from calliper measurements, phrased as the size of the differences between groups
  compared with the variation within them. Allometry and sexual dimorphism are named as
  other questions. Justification (from the paper): preserved crabs lose their colour, so
  type specimens had to be identified independently of colour, and a difference in shape
  supports the specific status; colour is judged by eye in the field. Sex: sexing needs
  handling, and dimorphism must be accounted for to compare the species. The page says
  that the paper used multivariate methods beyond the course and promises a comparison
  with its conclusions at the end.
- **Register:** closer to the Chapter 1 practical than to the theory chapters (teacher
  speaking to the student about the practicalities), on the author's request.
- **Figures:** base R with visible code (`boxplot()` with `y ~ sex + sp`, `pairs()`,
  `plot()`), as in the Chapter 1 practical, because the page shows what a student would
  do. Colour forms are Okabe–Ito blue `#0072B2` and orange `#E69F00`; females are open
  circles (`pch = 1`) and males filled (`pch = 19`). `dplyr` (`mutate()`, `group_by()`,
  `summarise()`) adds and summarises the ratios, as taught in the Chapter 1 practical.
- **Exploration result:** absolute measurements overlap between groups because size
  dominates; the ratios `fl_cw_ratio` (FL/CW, separates the species) and `rw_cl_ratio`
  (RW/CL, separates the sexes) are the candidate responses. The exploration does not plot
  the ratios against size (author's decision of 10 November): the case study compares
  simple distributions per group, so the dependence of RW/CL on size in males (small males
  have the proportions of females) is left for a possible later case study after Chapter
  7, with continuous predictors and groups.
- **The difference between the species** (`#sec-crabs-species`; author's decisions of 10
  November): response `fl_cw_ratio`, sex ignored because both sexes of a species have
  the same distribution of this ratio (100 crabs per species). Gamma and LogNormal,
  parameterised by the mean and the **coefficient of variation** (author's choice over
  the standard deviation; `dgamma2(sd = cv * mu)`, LogNormal through
  $\sigma^2=\log(1+c^2)$), compared with AIC separately per species: tied (0.09 and 0.32
  units), so the Gamma continues. Then the blue species is the reference and the
  difference of the means $\delta$ is a parameter (not transformed); AIC compares only
  one CV with one CV per species (one CV is lower by 1.1 units, and $\hat\delta$ and its
  standard error are the same in both). No model without a difference is fitted (author's
  decision of 10 November): the page emphasises that the size of an effect is judged from
  the estimate and interval of its parameter, not from a comparison with a model without
  it, and that the interval also shows that zero is not supported. $\delta$ gets a Wald and a
  profile interval (0.041 to 0.047, the same). $\delta$ is not compared with the standard
  deviation within the groups (author's decision of 10 November: not covered in the
  course); the text instead stresses that $\delta$ is a difference between means, not
  between individual crabs, and that later chapters model the mean as a function. A visible simulation (1,000 samples, seed 417, about 10 s)
  checks the bias, the standard deviation against the standard error and the coverage of
  the Wald interval (0.954). `fit_ratio()` avoids repeating four fits.
  `fig-crabs-distributions` is one panel with the four fitted densities (species by
  colour, distribution by line type) and no data, with `dlnorm_cv()` as the only helper
  (author's request of 10 November: code as simple as possible).
- **The difference between the sexes** (`#sec-crabs-sexes`; author's decisions of 10
  November): response `rw_cl_ratio`. Gamma and LogNormal compared per sex with species
  pooled (tied: 0.06 and 0.72 units), Gamma continues. Additive model with blue females
  as reference, `delta_male` and `delta_orange` (species kept as a second effect to show
  the alternative to ignoring a factor); the interaction is only mentioned in the text
  (0.0009, SE 0.0055), not fitted (author's choice). One CV against one CV per sex: per
  sex wins by 34 AIC units and changes the SE of `delta_orange` (about 15%), not of
  `delta_male`; the text explains why. Wald intervals only (profiles differ by less than
  0.0001, stated). No simulation (the text invites the student to adapt the loop).
  `fig-crabs-sexes`: four fitted densities, no data, same style as
  `fig-crabs-distributions`. The size dependence of the male ratio (about 0.42 below 20
  mm, 0.34 above 40 mm) is stated in words as the reason for the larger male CV and left
  to allometry in Chapters 5 to 7.
- **Answer and comparison with the paper** (`#sec-crabs-answer`, `#sec-crabs-paper`):
  overlap is judged **qualitatively from the fitted densities** (author's decision of 10
  November; no `pgamma()` misassignment rates, no comparison with the SD). Species: little
  overlap; sexes: more overlap, one-sided (small males look like females). The paper's
  facts used: canonical variates I (CW against FL and BD) and II (CL against RW) match
  our ratios; single measurements overlap almost completely; bivariate plots show very
  little overlap of species and minimal of sexes; blue males less separated from females
  when heterogeneity was allowed for. The page ends (author's text) by saying that the
  paper went further by building a rule to classify individual crabs, while the case study
  compares groups through means and variation; classification is pointed to machine
  learning. The held-out crabs and the classification results of the paper are not used.
- **Status:** generated draft (10 November, branch `case-study`), awaiting review. Never a
  model of voice.
