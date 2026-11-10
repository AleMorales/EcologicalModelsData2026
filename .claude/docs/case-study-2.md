# Decisions: Case study 2 (soybean leaves)

Read this before working on `Case_study_2/Theory.qmd`; AGENTS.md points here.

- **Purpose** (author's request of 10 November): a case study placed in the theory between
  Chapters 7 and 8 that reviews Chapters 5 to 7 (and the tools they build on) by
  application to a non-linear mixed model. Structure follows Case study 1: data, research
  question, exploration, then the recipe for a grouped response curve of Chapter 7
  (`#sec-grouped-recipe`, an ID added for this link), the answer and a comparison with the
  published analyses. No new theory; register as in Case study 1.
- **Data:** `nlme::Soybean` (48 plots, 412 measurements of average leaf weight per plant of
  six plants dug up per plot and date; Forrest and PI 416937; 1988–1990; 8 plots per
  variety and year). Chosen by the author on 10 November from installed data sets with a
  publication. `nlme` was added to `publish.yml`. Sources: Davidian and Giltinan (1995,
  Section 1.1.3) and Pinheiro and Bates (2000, Section 6.3; the author supplied the PDF of
  pp. 287–294). **Original study confirmed** (author supplied the PDF of Hudak and Patterson
  1995, *Crop Science* 35: 464–471, on 10 November): same design, years and harvest dates,
  and its Table 1 logistic parameters for leaf mass (asymptotes 19.27/20.91, 10.34/18.18,
  15.99/17.72 g; rates 0.122–0.137/day) agree with fits to the data. The page now introduces
  the data as theirs (Clayton, NC; 12.2 m plots; irrigation; blocks, Latin square in 1990;
  12 plants per sample in 1988 and six in 1989–90, where the books say six; leaf mass is dry
  mass of leaflets) and uses their account of the seasons (1989: soil crust, wet soil, low
  light) and their Table 1 in the comparison.
- **Research question** (from Hudak and Patterson's objective, author approved the
  research step): how much leaf mass PI develops compared with Forrest at the same age
  under non-limiting water, and whether the difference is the same in every year. Context
  from Sloane, Patterson and Carter (1990), *Crop Science* 30: 118–123 (slow wilting,
  turgor maintenance, drought reduced Forrest's yield by more than half and PI's by a
  third; Crossref abstract). Water was optimised, so the 1989 result is not explained by
  drought; the page says the data do not tell why.
- **Exploration:** base R figures with visible code (as Case study 1): growth curves per
  plot by year (Forrest `#0072B2`, open circles; PI `#E69F00`, filled), SD against mean of
  plots per date (constant CV), and the relative growth rate from plot means between
  dates (`dplyr::lead()`) on a log axis, which motivates the Gompertz curve and gives its
  starting values (b ≈ 0.03/day from the slope, c ≈ 65 days where RGR = b, a ≈ e × 15 g).
- **Model decisions (author's, 10 November):** compare logistic and Gompertz (Gompertz
  wins by about 55 AIC units; Gamma and LogNormal tied); **Gompertz main**, LogNormal
  (tied; Gamma fits about 7 times slower in RTMBdist, which matters for the simulation),
  one random effect per plot on the log asymptote only (no second random effect); candidate
  structures compared with AIC and leave-one-plot-out (asymptote only, additive = Pinheiro
  and Bates's final structure, full); additive wins. One NLL takes the curve and the
  distribution as elements of the list of data; candidates are `map` lists that fix
  effects at zero. Indicators are `is_pi`, `is_1989`, `is_1990` (one value per
  combination of year and variety).
- **The answer is a quantity inside the data** (author's decision): the ratio PI/Forrest of
  typical leaf mass at 6, 8 and 10 weeks per year, by `ADREPORT()` on the log scale with
  Wald intervals transformed back. The Gompertz asymptotes (67 g for Forrest 1988) lie far
  beyond the data and the logistic ones close to the last measurements; the page uses this
  as the lesson that parameters beyond the data depend on the assumed shape.
- **Checks (author's choice):** DHARMa residuals of measurements and plots (a wave against
  the typical curve: the Gompertz curve does not level off fast enough at the end; two
  Forrest plots, 1989F6 and 1990F2, have residuals below 0.01, and a refit without them is
  shown); the logistic as a sensitivity check (same ratios within about 0.1); a simulation
  of 500 samples (seed 1995) of bias, SD against SE and coverage of the log ratio at 10
  weeks (coverage 92.8% in 1988, 94.6% in 1989 and 1990) and the bias of the SD among plots
  (about 15% too small). No bands on typical curves and no REML fit (author's choice).
  Render time with the dev profile: about 2 minutes 45 seconds.
- **Comparison with Pinheiro and Bates:** their route (nlsList, correlated random effects,
  power variance 0.95, covariates chosen from plots of random effects and tests) reached
  the same additive structure; their logistic estimates agree with ours.
- **Status:** generated draft (10 November, branch `case-study-2`), awaiting review. Never
  a model of voice.
