# Handoff: rewrite of Chapter 4 (maximum likelihood estimation)

Planned with the course author on 5 October 2026. Progress is recorded in the status table
of section 12. Every decision in section 4 was taken by the author during the planning
session; do not reopen them.

**If you were asked to implement one phase** ("implement phase 2 of this plan"), go to
section 12 first. It says what that phase does, what to read, when it is done and what to
hand over. Sections 1 to 11 describe the whole job and are referred to from there.

## 1. Task

Rewrite these three files from scratch, in one pass or in the phases of section 12:

- `Chapter_4/Theory.qmd`
- `Chapter_4/Practicals/no_solution.qmd`
- `Chapter_4/Practicals/solution.qmd`

and make the supporting edits listed in section 8 (glossary, Chapter 1 roadmap, pointers
in Chapters 1, 2 and 6, publication files, `AGENTS.md`, `STYLE_GUIDE.md`).

The current Chapter 4 was generated before the author rewrote Chapters 1 to 3. Do not edit
it into shape. Keep only its four section IDs, which other chapters link to
(`sec-likelihood`, `sec-maximum-likelihood`, `sec-likelihood-surface`,
`sec-likelihood-uncertainty`), and write new text. The result is a draft for the author
to review.

Expected size of the theory page: about the length of `Chapter_3/Theory.qmd` (1,700 to
1,900 source lines including figure code). The author accepted this.

## 2. Read before writing

`CLAUDE.md`, `AGENTS.md` and `STYLE_GUIDE.md` load automatically. Then read, in this order:

1. `Chapter_1/Theory.qmd`: the modelling cycle, the data generating process, and the
   roadmap entries for Chapters 4, 6 and 8.
2. `Chapter_3/Theory.qmd`, all of it. It is the closest model for this chapter: structure,
   register, use of footnotes, how a theorem is presented, how simulation is used, how
   figures are coded. Chapter 4 continues its examples and its numbers.
3. `Chapter_2/Theory.qmd`: notation, the four faces, mass against density, joint
   distributions and independence, expectations, overdispersion.
4. `Chapter_3/Practicals/no_solution.qmd` and `solution.qmd`: the format of a practical
   (one worked exercise on the student page, real data, `### Question n` in solutions).
   Exercise 1 (owls) and Exercise 3 (plug-in simulation with `trees`) return in Chapter 4.
5. `Supplements/distributions.qmd`: the entries for the Binomial, Poisson, Negative
   Binomial, Gamma and LogNormal distributions, and the section "How to make zero-inflated
   distributions" (`#sec-zero_inflated`).
6. `Supplements/glossary.qmd`: format and existing terms.
7. The current Chapter 4 files, only to see what is being replaced.
8. The passages in Chapters 5, 6 and 8 that refer to Chapter 4 (section 8.5 lists them).

**Review status.** The author stated on 5 October 2026 that Chapters 1 to 3, theory and
practicals, are reviewed and approved. Treat all of them as reference for content, depth,
notation and format. The rows of the table in `AGENTS.md` that say "awaiting review" for
those chapters are out of date. Chapter 1 keeps its exception in register (personal and
opinionated); Chapter 4 follows the register of Chapters 2 and 3.

## 3. What is wrong with the current chapter

Use this as a list of things not to reproduce.

- The Normal tree-height model is the main two-parameter example, and its closed-form
  shortcuts drive the profile code and Exercise 4. The special case is the centrepiece.
- In every example, maximum likelihood and the method of moments give the same estimate,
  so the chapter never shows why the new method is needed.
- Large-sample theory is one paragraph. No result is named, there is no history, there are
  no footnotes at all, and nothing is checked by simulation. Chapter 3 ends by promising
  that Chapter 4 will generalise asymptotic normality beyond the mean; the chapter does not.
- The Hessian appears without Fisher information and without any link to the standard
  error that students calculated in Chapter 3.
- Voice: imperative headings ("Find the maximum", "Add logs rather than multiply"), goals
  written as assessment verbs, a caveat in almost every paragraph ("does not establish",
  "is not a probability"), repeated "simulated, not field data" disclaimers, clipped
  stacked sentences, italics for emphasis.
- Format: a per-page `format` and `execute` block with a global `eval: false`, display-only
  ```` ```r ```` fences, base R figures, a five-question quiz.
- R tools used without introduction: `vapply()`, `Vectorize()`, `solve()`, `uniroot()`.
- Practicals: all data simulated or illustrative, and the same three models as the theory.
- Material that belongs to Chapter 8 appears as caveats: sensitivity to starting values,
  global maxima, Hessian invertibility, bracket checking.

## 4. Author decisions

| # | Topic | Decision |
|---|---|---|
| D1 | One-parameter example in the theory | The ten seedling counts of Chapter 3, `seedling_counts = c(3, 5, 2, 7, 4, 3, 4, 1, 6, 5)`, under a Poisson model. The MLE, standard error and Wald interval must be shown to reproduce Chapter 3's numbers. |
| D2 | Two-parameter example in the theory | The owl data of the Chapter 3 practical (Exercise 1: satiated nestlings, female parent, 122 visits) under a Negative Binomial model. Reuse that exercise's approved description of the data and of the i.i.d. simplification. |
| D3 | Normal model | Footnotes only. It does not appear as an example in the main text, the practice callouts, the quiz or the practical tasks. |
| D4 | New data package | `emdbook` is allowed. Add it to `.github/workflows/publish.yml`. |
| D5 | Analytical derivation | One derivation in the main text: the Poisson MLE. State that closed forms exist only for a few models. |
| D6 | Named results in the main text | Consistency and asymptotic normality; the Cramér–Rao bound and efficiency; Wilks' theorem; misspecified models (Kullback–Leibler divergence). Each stated in plain words with a historical footnote. Fisher's origin of likelihood and Wald's name for the interval also get footnotes. |
| D7 | Fisher information | Observed information, with the Poisson case worked by hand so that the standard error equals Chapter 3's plug-in standard error. Expected information only in a footnote. |
| D8 | Delta method | Deferred to Chapter 6. Chapter 4 calculates Wald intervals on the fitted scale and back-transforms the endpoints. One forward pointer. |
| D9 | Reference interval | The profile likelihood interval is the reference method; the Wald interval is the fast approximation. Simulation shows when they differ. |
| D10 | Likelihood ratio test | A footnote only, in the manner of the footnote on p-values in Chapter 2. |
| D11 | Likelihood surface | Include: slice against profile; covariance between estimates; joint confidence region. General treatment of reparameterisation is left to later chapters, with the single exception of D12. |
| D12 | Making D11 visible | The owl data are also shown in R's native parameters (`size` and `prob`), where the estimates are correlated. Limited to "same model, same maximum, differently shaped surface". |
| D13 | Coverage simulation | A figure in the theory with hidden code, and an exercise in the practical. |
| D14 | Notation | Keep the bar: $P(X=x\mid\lambda)$ and $L(\lambda\mid x_1,\ldots,x_n)$, with a footnote at first use saying that the bar reads "for a given value of" and that conditional distributions come in Chapter 7. The shorthand $L(\theta)$ and $\ell(\theta)$ is fine once the data are fixed. |
| D15 | Optimiser | `optim()` with `method = "BFGS"` throughout, including one-parameter fits and the inner fits of a profile. No `optimize()`, no `bbmle`, no `fitdistr()`. One sentence says the method is explained in Chapter 8. |
| D16 | Constraints | Transformations only: logarithm for positive parameters, logit for probabilities (`qlogis()`, `plogis()`). Bounds and box-constrained methods stay in Chapter 8. |
| D17 | Evaluating a likelihood on a grid | `for` loops: one loop filling a vector for a curve, two nested loops filling a matrix for a surface. No `sapply()`, `vapply()`, `Vectorize()` or `outer()` on likelihoods. |
| D18 | Practical structure | One worked exercise on the student page plus four exercises. |
| D19 | Practical data | Reed frog tadpole survival (`emdbook::ReedfrogPred`), glacier lily seedlings (`emdbook::Lily_sum`), black cherry timber volume (`datasets::trees`), Adelie penguin body mass (`datasets::penguins`). |
| D20 | Own mass function | Students write a zero-inflated Poisson mass function themselves and fit it to the lily seedlings. |
| D21 | Penguins | Used twice: for densities and units (grams against kilograms), and as the large sample in the simulation exercise. |
| D22 | Paper work in the practical | In the worked exercise only: a hand calculation of a Binomial likelihood and the derivation of the Binomial MLE. |
| D23 | AIC | Moves forward into Chapter 4: a short section with the definition, its use on differences, and its origin (Akaike, as an estimate of Kullback–Leibler distance) in a footnote. No AICc, no BIC. Chapter 6 recalls AIC and adds BIC and cross-validation. |
| D24 | Asides | Include a footnote linking likelihood to Bayesian inference; a footnote on bias correction and restricted maximum likelihood (REML) with a pointer to Chapter 7; the callout linking to the interactive likelihood page. Do not add a footnote on rounded or censored data. |
| D25 | Order of the theory | Properties of the estimators first, then intervals (outline in section 6). |
| D26 | The author's voice | Where the author's own view belongs, write neutral text and place an HTML comment at the spot: `<!-- AUTHOR: ... -->`. List every comment in the final report. Never write a first-person opinion on the author's behalf. |
| D27 | Later chapters | Keep the four section IDs. Edit only the sentences in Chapters 5, 6 and 8 that the new chapter makes wrong. List everything else for their future rewrites. |
| D28 | Pointers in approved text | Update the Chapter 2 pointer and Chapter 1's modelling-cycle paragraph and roadmap entries so that they say AIC starts in Chapter 4. Report that the red chapter numbers in `Chapter_1/ModelCycle.png` may need a new figure. |
| D29 | Permissions | The implementing agent may, without asking again: edit Chapter 1's roadmap, add glossary entries, record decisions in `AGENTS.md` and `STYLE_GUIDE.md`, and add Chapter 4 to `_quarto-prod.yml`. |
| D30 | Staging | Everything in one pass. |

Consequences the author should be aware of (repeat them in the report):

- With D3, the theory has no worked example with continuous data. Densities in a
  likelihood are explained in one passage and practised in Exercise 4.
- D23 reverses the rule in `AGENTS.md` that model comparison is introduced in Chapter 6.
- D12 brings a limited amount of reparameterisation into Chapter 4 although the general
  topic was left for later.

## 5. How Chapters 2 and 3 are written

The style guide describes the voice. These are the specific patterns the author asked to
be carried into Chapter 4.

### Footnotes

Chapter 2 has ten footnotes and Chapter 3 has ten; the current Chapter 4 has none. They are
inline (`^[...]`), one to five sentences, and they keep the main line of reasoning clean.
The kinds that occur:

- **History and attribution.** "Andrey Kolmogorov first formalised and defined the
  empirical distribution function [...] in 1933." "The $n-1$ divisor is known as Bessel's
  correction. It was originally proved by Gauss in 1823 [...]". Names and years, what the
  person showed, sometimes how the explanation changed later.
- **What a theorem says beyond the main text.** The Glivenko–Cantelli footnote states the
  theorem, relates it to the weak law of large numbers, and names the type of convergence.
- **Special cases.** The $t$ interval for the mean of Normal observations is a footnote to
  the Wald interval, labelled as "a special case that does not extend to other models".
- **Technical qualifications.** Raw against central moments in the method of moments.
- **What the course does not use.** Cumulative probabilities are "the basis for
  calculating p-values, which we will completely ignore in this course".
- **Remarks on terminology and further reading.** Including a link to the author's own
  blog article on variance estimators.

Aim for 12 to 16 footnotes in the new theory page. Section 6 says where each goes.

### How a theorem is presented

Follow what Chapter 3 does with the Glivenko–Cantelli theorem and with consistency:

1. The result is named in bold in the main text, in the sentence where it is needed.
2. A footnote says who proved it and what exactly it states.
3. One displayed equation gives the statement for a concrete case, with symbols explained.
4. "In plain English, ..." translates it.
5. A note callout restates it in one or two sentences.
6. A simulation shows it, with a figure and numbers quoted in the text.

No proofs. Regularity conditions go in one footnote, not in the main text.

### Statistical approach

- General results first. The course is about non-linear models with non-Normal
  distributions, so results that hold for any regular model are the main text, and exact
  results for the Normal model are footnotes.
- In finite samples estimators are in general biased and the shape of their sampling
  distribution is unknown. Large-sample results are approximations for small samples, and
  simulation is how the approximations are checked.
- A sampling distribution describes hypothetical experiments. A simulation that uses
  estimates as parameters is described as in the Chapter 3 practical (Exercise 3): "a model
  whose parameters we know", without the term parametric bootstrap.
- "Model", "data generating process", "the parameter used in the simulation". Avoid "true
  value" and "population" outside a simulation.
- Worked numbers after every general statement, then "We can verify our math with R:" or
  "In R:".
- The concept is said to be for something: where it is used later in the book.

## 6. Theory page

File: `Chapter_4/Theory.qmd`. YAML is only the title; no `format` or `execute` block:

```yaml
---
title: "Maximum likelihood estimation"
---
```

Follow it with the hidden setup chunk that Chapters 2 and 3 use (`library(ggplot2)`), and
load `patchwork` inside the figure chunks that need it. All chunks are ```` ```{r} ````
and are evaluated; hide figure code with `#| echo: false`; give every figure a
`#| label: fig-...` and refer to it with `@fig-...`.

Numbers in this section were computed during planning (Appendix A). Recompute every one
from the final code before quoting it.

### Introduction and learning goals

`# Introduction`. First sentence starts with "In this chapter, we learn how to". Two
paragraphs: what maximum likelihood adds to Chapter 3 (the method of moments used only the
mean and variance; maximum likelihood uses the probability that the model assigns to every
observation, and it applies to any model for which we can write a mass or density
function); the two examples (Poisson seedling counts from Chapter 3, owl nestling calls
from the Chapter 3 practical) and that the chapter ends with a first tool to compare
models. Say once where the data come from.

`# Learning goals`. "In this chapter, we will cover:" followed by topic phrases ending in
semicolons, in chapter order:

- the likelihood function and the log-likelihood;
- maximum likelihood estimation, analytically and by numerical optimisation;
- constraints on parameters and transformations;
- likelihood surfaces, slices and profiles for models with several parameters;
- the properties of maximum likelihood estimators in large and small samples;
- Fisher information, standard errors and Wald intervals;
- profile likelihood intervals and joint confidence regions;
- the comparison of models with the Akaike information criterion.

Closing sentence naming the Poisson and Negative Binomial distributions with links to the
supplement entries.

### `# The likelihood function {#sec-likelihood}`

1. Definition first. The **likelihood function** is the joint probability (or joint
   density) of the observed sample, read as a function of the parameters with the data held
   fixed. Give it for a general parameter $\theta$ and i.i.d. observations as a product,
   and link the product to independence in
   `../Chapter_2/Theory.qmd#sec-joint-independence` (Chapter 2 promised that the i.i.d.
   assumption would be fundamental here). "where ..." clause for every symbol.
2. Footnote on notation (D14): the bar reads "for a given value of"; conditional
   distributions are introduced in Chapter 7.
3. Footnote on history: Fisher introduced the method as a student in 1912, named the
   quantity "likelihood" in 1921 to keep it apart from probability, and set out the theory
   in 1922; similar ideas appear earlier (Lambert, Daniel Bernoulli, Gauss). Verify
   (Appendix B).
4. Example, announced as an example: the ten quadrats of Chapter 3 with
   $X_i\sim\operatorname{Poisson}(\lambda)$. First a small case by hand with the first
   three counts (3, 5, 2): write the three contributions, their product, and evaluate it at
   $\lambda=3$ and $\lambda=4$ (0.00506 and 0.00447). Then "We can verify our math with R:"
   using `prod(dpois(...))`, and the likelihood of all ten counts.
5. Likelihood is not a probability distribution for the parameter. This is one of the few
   contrasts students really confuse, so explain it: in the model the parameter is fixed
   and the data vary (link to aleatoric probability in Chapter 2), and the likelihood does
   not integrate to one over $\lambda$. Show it with `integrate()` from Chapter 2 (for the
   ten counts the integral is about $3.8\times10^{-9}$). `integrate()` calls the function
   with a vector of values, so give it the closed-form expression of the Poisson
   likelihood, $e^{-n\lambda}\lambda^{\sum x_i}/\prod x_i!$, which is vectorised; a function
   built on `prod(dpois(...))` is not. One warning callout; do not repeat the point
   elsewhere in the prose, and at most once in the quiz.
6. Footnote (D24): the likelihood is also the core of Bayesian inference, where it is
   multiplied by a prior distribution to give a probability distribution for the parameter;
   Chapter 1 explains why this book stays with the Frequentist interpretation.

`## The log-likelihood`

- The likelihood of ten counts is already about $2.4\times10^{-9}$. With a large sample the
  product can become smaller than the smallest number the computer can represent, and R
  then returns zero. Do not claim that this happens for a particular dataset without
  checking (it does not for the owl or the lily data). The **log-likelihood**
  $\ell(\theta)=\log L(\theta)$ turns the product into a sum. The logarithm is increasing,
  so both have their maximum at the same value.
- In R: the argument `log = TRUE` of the `d*` functions (new to students), summed.
- Continuous data: the contributions are densities. Recall from
  `../Chapter_2/Theory.qmd#sec-continuous_measurements` that a density has units and can
  exceed one, so a log-likelihood can be positive and its value changes with the units of
  measurement. Only differences between log-likelihoods calculated from the same data mean
  something. State this in words and point to the practical, where students check it
  (Exercise 4). No Normal example (D3).
- Define the **relative log-likelihood** $\ell(\theta)-\ell(\hat\theta)$ here or in the
  next section; all likelihood figures use it.
- Practice callout: a likelihood and a log-likelihood on paper for three new counts, in a
  different ecological setting.

### `# Maximum likelihood estimation {#sec-maximum-likelihood}`

Opening: the **maximum likelihood estimator** is the value of the parameter for which the
likelihood of the observed sample is highest. Give the arg max definition and explain the
notation. Recall estimator and estimate from `../Chapter_3/Theory.qmd#sec-estimates`.

`## The likelihood curve`

- Evaluate the log-likelihood of the ten counts on a grid of values of $\lambda$ with a
  `for` loop that fills a pre-allocated vector (D17). Show this code.
- Figure `fig-likelihood_curve` (hidden ggplot code): relative log-likelihood against
  $\lambda$, with the maximum marked. Read the maximum off the grid: 4 seedlings per
  quadrat.

`## Analytical solution for the Poisson model`

- D5. Write $\ell(\lambda)=-n\lambda+\log\lambda\sum x_i-\sum\log(x_i!)$, differentiate,
  set to zero, obtain $\hat\lambda=\overline x$. Three or four lines in an `aligned`
  block. Say that the second derivative is negative, so it is a maximum, and that
  derivatives return in Chapter 5.
- The result is the method-of-moments estimator of Chapter 3. That is a property of this
  model. Closed-form solutions exist only for a few models; for the others we find the
  maximum numerically.
- Footnote (D3): the Normal model is another such case. Its MLEs are the sample mean and
  the variance with divisor $n$, that is, the method-of-moments estimator of
  `../Chapter_3/Theory.qmd#sec-two_parameters`, which is biased.
- Footnote: the derivative of the log-likelihood is called the score. One sentence.

`## Numerical optimisation`

- `optim()` minimises, so we give it the **negative log-likelihood** (NLL). Introduce the
  arguments `par`, `fn`, extra named arguments passed on to `fn`, and `method = "BFGS"`
  with one sentence that Chapter 8 explains how the methods work (D15). Introduce the
  elements `par`, `value` and `convergence` of the result. A code of zero means that the
  algorithm stopped normally. Keep this to what is needed; no discussion of starting-value
  sensitivity or local maxima (Chapter 8).

`## Constraints and transformations`

- $\lambda$ must be positive, and an optimiser does not know that. We optimise
  $\log\lambda$, which can take any real value, and transform back with `exp()`. For a
  probability the corresponding transformation is the logit (`qlogis()` and its inverse
  `plogis()`), which the next section uses (D16).
- Code: the function in `STYLE_GUIDE.md` (`poisson_nll = function(log_lambda, counts)`),
  the `optim()` call, the back-transformed estimate. It returns 4 with convergence code 0.
- **Invariance**: the MLE of a function of a parameter is that function of the MLE. This
  is what allows us to fit on the log scale and report on the original scale. Footnote
  with the attribution (Appendix B).
- Worked number that ties to Chapter 3: by invariance the MLE of the probability of an
  empty quadrat is $e^{-\hat\lambda}=e^{-4}\approx0.018$. Chapter 3
  (`#sec-sampling_distribution`, "Bias and variance") used this same quantity as an example
  of a biased estimator: invariance carries over the estimate, not unbiasedness.
- Practice callout: an optimiser returns a value on the log (or logit) scale; report it on
  the ecological scale.

### `# Models with several parameters {#sec-likelihood-surface}`

Opening: with several parameters the likelihood is a function of all of them jointly and
the MLE is the combination with the highest likelihood. Announce the example: the owl data
of the Chapter 3 practical. Load them exactly as that practical does
(`data(Owls, package = "glmmTMB")`, same subset, same object names `call_counts`,
`mu_hat`, `k_hat` where they have the same meaning). Restate the model
($X_i\sim\operatorname{NegBin}(\mu,k)$, link to `#sec-negative_binomial`) and recall the
method-of-moments estimates from that practical: $\hat\mu\approx4.75$ calls per visit and
$\hat k\approx0.60$.

- NLL with a vector `par` of two log-transformed parameters, named. Explain indexing the
  vector inside the function. Use the method-of-moments estimates as starting values and
  say why they are a sensible choice. Fit with `hessian = TRUE` (used later).
- Result: $\hat\mu\approx4.75$ (the MLE of the mean of a Negative Binomial is the sample
  mean) and $\hat k\approx0.33$.

`## Comparison with the method of moments`

- The two methods now disagree on $k$ (0.60 against 0.33). The method of moments matches
  the mean and variance of the sample. Maximum likelihood uses the probability of every
  count, and 44% of the visits had no calls: the fitted Negative Binomial gives 41% zeros
  with the MLE and 27% with the method-of-moments estimate. The log-likelihood is $-299.4$
  at the MLE and $-306.6$ at the method-of-moments estimates.
- Figure `fig-owl_fits`: relative frequencies of the counts (`grey90` bars) with the
  fitted probabilities for the Negative Binomial at the MLE, the Negative Binomial at the
  method-of-moments estimates, and the Poisson. Distinguish by colour and by point or line
  type.
- An honest aside: the variance implied by the ML fit, $\hat\mu+\hat\mu^2/\hat k\approx74$,
  is larger than the variance of the sample (42). Neither estimate reproduces every feature
  of the sample; the model is an approximation of the data generating process. Forward
  pointer to "Misspecified models" below.
  `<!-- AUTHOR: your view on what it means that the two estimates differ this much -->`

`## The likelihood surface`

- Evaluate the log-likelihood on a grid of $\mu$ and $k$ with two nested `for` loops that
  fill a matrix created with `matrix(NA, nrow = ..., ncol = ...)` (D17). Show this code.
  Say that the matrix can be drawn with `contour()` as in the Chapter 1 practical.
- Figure `fig-likelihood_surface` (hidden ggplot code with `geom_contour`): contours of the
  relative log-likelihood, the MLE as a point and the method-of-moments estimate as a
  second symbol. The contours are aligned with the axes.

`## Parameterisation and the shape of the surface`

- D12, kept short. R's own parameters for this distribution are `size` ($k$) and `prob`
  ($p=k/(k+\mu)$, the "Inverse" line of the supplement entry). Fit the same data with
  $\log k$ and $\operatorname{logit}p$. The maximum log-likelihood is the same ($-299.4$),
  $\hat k$ is the same and $\hat p\approx0.064$ equals $\hat k/(\hat k+\hat\mu)$, as
  invariance says.
- Figure `fig-surface_size_prob`: the surface in $(k,p)$. The contours are tilted: a
  larger $k$ goes with a larger $p$. Link to the tilted contours of the joint density in
  `../Chapter_2/Theory.qmd#sec-two_continuous_variables`.
- One sentence on why the book writes distributions with their mean (the supplement says
  so), and one forward pointer: the choice of parameters also matters for numerical
  optimisation (Chapter 8). Do not develop further.

`## Slices and profiles`

- Definitions first. A **likelihood slice** fixes the other parameters at one value. A
  **profile likelihood** re-estimates the other parameters at every value of the parameter
  of interest; the parameters that are re-estimated are called **nuisance parameters**.
  Give $\ell_p(k)=\max_p \ell(k,p)$.
- Example on the $(k,p)$ surface. Show the code of the profile: a `for` loop over values of
  $k$ with an inner `optim()` on $\operatorname{logit}p$.
- Figure `fig-slice_profile`, two panels: left, the surface with the slice (a straight
  line at $\hat p$) and the path of the profile (the re-estimated $p$ for each $k$) drawn
  on it; right, the two curves of relative log-likelihood against $k$. The slice is
  narrower: it stays within 1.92 units of the maximum between 0.26 and 0.41, the profile
  between 0.24 and 0.45.
- With the mean as parameter the two coincide for $k$, because the best $\mu$ is the
  sample mean for every $k$. One sentence. A profile does not depend on which
  parameterisation is used for the nuisance parameter.
- Say what each is for: profiles give confidence intervals in `@sec-likelihood-uncertainty`;
  slices are a quick diagnostic that returns in Chapter 8.
- Practice callout: a described procedure, slice or profile.
- Callout note "Explore a likelihood surface" with the link to
  <https://rpsychologist.com/likelihood/> (D24). Say that the page uses a Normal model with
  a mean and a variance, tell students what to try, and say that its last part is about
  hypothesis tests, which this course does not use. Do not write "outside this chapter's
  learning goals".

### `# Properties of maximum likelihood estimators {#sec-mle_properties}`

Opening: an MLE is an estimator, so everything in Chapter 3 applies: it has a sampling
distribution across hypothetical experiments, a bias and a variance. In a finite sample we
do not know that distribution in general. For large samples there are general results,
which are the reason the course uses maximum likelihood. One footnote lists the regularity
conditions in words (the parameter is not on the boundary of its range; the support does
not depend on the parameter; the likelihood is smooth; the number of parameters does not
grow with the sample).

`## Consistency`

- Recall the definition from `../Chapter_3/Theory.qmd#sec-large_samples` and state that
  MLEs are consistent when the data are i.i.d. from the model. Footnote: attribution
  (Appendix B).
- Intuition that uses Chapter 3: the log-likelihood divided by $n$ is the mean of
  $\log P(x_i\mid\theta)$ over the sample, that is, an expectation under the empirical
  distribution. As the sample grows the empirical distribution converges to the
  distribution that generated the data (Glivenko–Cantelli), so the function we maximise
  converges too.

`## Asymptotic normality and Fisher information`

- This is the generalisation that Chapter 3 promised at the end of `#sec-large_samples`:
  the central limit theorem is about means; for an MLE of any parameter, the sampling
  distribution approaches a Normal distribution centred on the parameter as the sample
  grows. Display the statement for one parameter.
- The variance of that Normal distribution is the inverse of the **Fisher information**.
  Define the **observed information** as $-\ell''(\hat\theta)$: the curvature of the
  log-likelihood at its maximum. A sharply curved log-likelihood means that the data
  discriminate well among parameter values, hence a small variance.
- Worked case (D7): for the Poisson model $\ell''(\lambda)=-\sum x_i/\lambda^2$, so the
  observed information at $\hat\lambda=\overline x$ is $n/\hat\lambda=10/4=2.5$, the
  approximate variance is $\hat\lambda/n=0.4$ and the standard error is $0.63$ seedlings
  per quadrat. This is exactly the plug-in standard error of
  `../Chapter_3/Theory.qmd#sec-standard_errors`.
- With several parameters the information is a matrix of second derivatives, the
  **Hessian** of the negative log-likelihood, which `optim(hessian = TRUE)` returns. Its
  inverse approximates the covariance matrix of the estimates. Used in the next section.
- Footnotes: (a) expected information, an expectation over hypothetical experiments, and
  that the two agree in large samples; (b) history (Fisher, made rigorous by Cramér).
- Note callout restating asymptotic normality in two sentences.
- Simulation, hidden code: 2,000 hypothetical experiments from a Negative Binomial model
  with the owl estimates as parameters, for 20, 122 (the size of the owl sample) and 500
  visits. For each experiment store the ML estimate and the method-of-moments estimate of
  $k$; the next two subsections use them. Figure `fig-sampling_distribution_k`: histograms
  of the ML estimate for 20 and for 500 visits, a vertical line at the $k$ used to
  simulate, and a Normal curve with the mean and standard deviation of the estimates (say
  so in the caption). Planning values: with 20 visits the estimates average 0.40 against
  0.33 and are strongly skewed; with 500 visits they average 0.33 and are nearly
  symmetric. Use the same structure as `fig-asymptotic_normality` in Chapter 3.

`## Efficiency`

- Recall mean squared error from Chapter 3. State the **Cramér–Rao bound**: no unbiased
  estimator has a variance smaller than the inverse of the Fisher information. An MLE
  reaches that bound as the sample grows, so it is **asymptotically efficient**: in large
  samples no other regular estimator is more precise. Footnote with attribution.
- This is the answer to "why not the method of moments?". Check it with the estimates
  stored in the simulation above. Planning values for 122 visits: standard deviation 0.054
  (ML) against 0.086 (method of moments); mean squared error 0.0029 against 0.0084. Report
  the mean, standard deviation and mean squared error of both estimators for the three
  sample sizes in a small table.

`## Bias in finite samples`

- From the same simulation: with 20 visits $\hat k$ is biased upward by about 20%. MLEs are
  in general biased in finite samples and the bias decreases as the sample grows. Refer to
  the warning callout "Finite samples and special cases" in Chapter 3; do not repeat it.
- Footnote (D24): bias corrections exist for particular models; the divisor $n-1$ for the
  variance is one, and restricted maximum likelihood (REML) is the general approach for
  variance parameters, see Chapter 7.

`## Misspecified models`

- Everything above assumes that the data are a random sample from the model. Chapter 1
  says that the model is an approximation of the data generating process. State the result:
  when the data generating process is not in the model, the MLE converges to the parameter
  values for which the model distribution is closest to the distribution of the data
  generating process, with closeness measured by the **Kullback–Leibler divergence**. Give
  the divergence for a discrete variable as an expectation of a log ratio (Chapter 2
  defined expectations), explain the symbols, then "In plain English".
- Footnote: Kullback and Leibler; White for the result on MLEs under misspecification; one
  clause that the standard errors from the Hessian are then also approximate.
- Return to the owls: the Negative Binomial fitted by maximum likelihood reproduces the
  zeros better than the variance, and the visits come from only 24 nests (the Chapter 3
  practical already said that treating them as i.i.d. is a simplification, with a pointer
  to Chapter 7).
  `<!-- AUTHOR: your view on what a wrong model means in practice -->`

### `# Uncertainty from the likelihood {#sec-likelihood-uncertainty}`

Opening: two ways of calculating a confidence interval from a likelihood. The Wald
interval uses asymptotic normality and the curvature at the maximum. The profile
likelihood interval uses the whole shape of the log-likelihood. State the position of the
book (D9): the profile interval is the reference; the Wald interval is the fast
approximation that software reports.
`<!-- AUTHOR: why you prefer profile intervals -->`

`## Standard errors and Wald intervals`

- Poisson by hand: SE 0.63, so the Wald interval of
  `../Chapter_3/Theory.qmd#sec-confidence_intervals` is recovered exactly (2.76 to 5.24).
  Footnote: the interval is named after Abraham Wald; Chapter 3 introduced the name
  without its origin.
- The same from `optim()`. The Hessian is on the scale that was optimised, here
  $\log\lambda$ (Hessian 40, SE 0.158). Calculate the interval on that scale and
  back-transform the endpoints: 2.93 to 5.45. It differs from the first interval. A Wald
  interval depends on the scale on which it is calculated; on the log scale it cannot
  include negative values (Chapter 3 noted that the lower endpoint can be negative). A
  standard error on the original scale from one on the log scale needs the delta method,
  which comes in Chapter 6 (D8).
- The Wald interval amounts to replacing the log-likelihood by a parabola with the same
  curvature at the maximum, which is why it is also called a quadratic approximation.
  Keep this sentence: Chapter 5 links here for it, and Chapter 6 and its practical use the
  term "quadratic interval".
- Owls, two parameters: introduce `solve()` (the inverse of a matrix; matrices were taught
  in the Chapter 1 practical), `diag()` and `sqrt()`. Wald intervals on the log scales,
  back-transformed: 3.45 to 6.55 calls per visit for $\mu$ and 0.24 to 0.45 for $k$.
- Compare with the interval for $\mu$ in the Chapter 3 practical (3.60 to 5.91). The
  estimate is the same; the standard error is larger (about 0.78 against 0.59) because it
  now comes from the fitted Negative Binomial, whose variance is larger than the variance
  of the sample. The interval depends on the model. To quote a standard error in calls per
  visit, use the formula of that practical, $\sqrt{(\hat\mu+\hat\mu^2/\hat k)/n}$, with the
  ML estimate of $k$; do not use the delta method (D8).

`## Covariance between estimates`

- The off-diagonal elements of the inverse Hessian are covariances between estimates;
  `cov2cor()` turns the matrix into correlations. For $(\log\mu,\log k)$ the correlation is
  zero to four decimals; for $(\log k,\operatorname{logit}p)$ it is 0.71, which is the
  tilt of `@fig-surface_size_prob`. In large samples the estimates follow a bivariate
  Normal distribution whose contours have the shape of the likelihood contours near the
  maximum.
- Signpost: the parameters of response curves are usually strongly correlated (Chapter 6).

`## Profile likelihood intervals`

- State **Wilks' theorem** in the pattern of section 5: twice the difference between the
  maximum log-likelihood and the profile log-likelihood at the parameter value that
  generated the data follows approximately a chi-squared distribution with one degree of
  freedom in large samples. Introduce the chi-squared distribution in one sentence as the
  distribution of the square of a standard Normal variable, and `qchisq(p = 0.95, df = 1)`,
  which is 3.84, the square of 1.96. Footnote: Wilks, 1938. Footnote (D10): the same
  result is the basis of the likelihood ratio test, which the course does not use.
- The interval contains every value whose profile log-likelihood is within $3.84/2=1.92$
  of the maximum.
- Poisson: one parameter, so the profile is the log-likelihood itself. Introduce
  `uniroot()` (finds where a function crosses zero inside an interval that we give it) and
  find the two crossings: 2.89 to 5.37. Small table with the three intervals for
  $\lambda$ (Wald on the original scale, Wald on the log scale, likelihood). The likelihood
  interval is the same whichever scale is used, and it follows the asymmetry of the curve.
- Owls: write a function that returns the profile NLL for a value of $\mu$ (inner
  `optim()` on $\log k$), and use `uniroot()` on it. Profile intervals: 3.49 to 6.68 for
  $\mu$ and 0.24 to 0.45 for $k$. Compare with the Wald intervals.
- Figure `fig-profile_interval`: profile relative log-likelihood for $\mu$, the horizontal
  line at $-1.92$, the endpoints, and the parabola of the quadratic approximation.
- Practice callout: read a relative profile log-likelihood against the cutoff.

`## Joint confidence regions`

- D11. The contour of the surface at $-\texttt{qchisq(0.95, 2)}/2\approx-3.00$ is an
  approximate joint 95% confidence region for both parameters. Figure `fig-joint_region`:
  the $(\mu,k)$ surface with that contour highlighted and the two profile intervals marked
  along the axes. Explain in three or four sentences why the region extends beyond the
  profile interval of each parameter: it is a statement about both parameters at once, so
  the cutoff uses two degrees of freedom (3.00 instead of 1.92).

`## Coverage checked by simulation`

- Same heading and reasoning as in Chapter 3. Hidden code (D13); describe the procedure in
  words.
- Case 1 continues a remark of Chapter 3 (the Wald interval for a Poisson mean does badly
  when the expected total count is small): $\lambda=0.5$ and 10 quadrats. Planning values:
  coverage 0.87 for the Wald interval on the original scale and 0.93 for the likelihood
  interval. Add $\lambda=4$ with 30 quadrats as the well-behaved case (0.945 and 0.946).
- Case 2: the owl model with 20 and with 122 visits, interval for $k$. Planning values:
  Wald on the log scale 0.94 and 0.96; profile 0.94 and 0.96. Say plainly that here the
  two intervals perform equally well.
- Figure `fig-coverage`: simulated coverage by case and interval type, with a dashed line
  at 0.95.
- Implementation note for the hidden code: a profile interval contains the parameter used
  to simulate exactly when the profile log-likelihood at that value is within 1.92 of the
  maximum, so no `uniroot()` call is needed inside the simulation. For the Poisson case use
  the closed-form estimate; a sample of all zeros gives an estimate of zero and counts as a
  miss for both intervals.

### `# Model comparison with AIC {#sec-aic}`

- D23. Opening: more than one model can be plausible for the same data (Chapter 2,
  "Choosing a distribution", said formal tools would come). The maximum log-likelihood
  cannot be compared directly between models with different numbers of parameters, because
  the more flexible model fits the same data at least as well.
- Definition: $\mathrm{AIC}=2K-2\ell(\hat\theta)$, where $K$ is the number of estimated
  parameters. Use $K$, not $k$, which is the shape of the Negative Binomial. Lower is
  better among models fitted to the same data; only differences matter.
- Origin, following "Misspecified models": AIC estimates, up to a constant shared by all
  models, the Kullback–Leibler distance between the fitted model and the data generating
  process for new data; the term $2K$ corrects for having used the same data to fit and to
  evaluate. Footnote: Akaike, 1973 and 1974.
- Example: owls. Poisson ($K=1$): log-likelihood $-634.2$, AIC 1270.3. Negative Binomial
  ($K=2$): $-299.4$, AIC 602.9. Refer back to `@fig-owl_fits`.
- One caveat, placed here once: AIC ranks the candidates; it does not say whether the best
  of them describes the data well.
- Forward pointer: Chapter 6 adds BIC, cross-validation and checks of goodness of fit.
  `<!-- AUTHOR: your take on AIC and how you use differences in practice -->`
- Practice callout: AIC arithmetic for two fitted models.

### Summary and quiz

`# Summary`: four or five short paragraphs, no new material, last paragraph pointing to
Chapters 5 and 6.

Practice callouts follow the format of Chapters 2 and 3 (`callout-important` titled
"Practice: ...", with a collapsed `callout-tip` solution) and use ecological settings other
than the two running examples. Aim for one per main section, seven or eight in total.

`# Chapter quiz`: ten questions in chapter order, each titled with an ecological setting
as in Chapters 2 and 3 ("Question 2: caddisfly larvae"), each with a collapsed answer.
Suggested topics: what varies in a likelihood; a hand calculation; log-likelihood and
`log = TRUE`; the sign of the NLL and a transformation; invariance; why ML and method of
moments can differ; slice or profile; information and standard error; reading a profile
interval; AIC for two models. Do not use the Normal model (D3).

### Footnote list

Target footnotes, by section: bar notation; history of likelihood (Fisher); Bayesian link;
Normal special case; score; invariance attribution; regularity conditions; consistency
attribution; expected information; history of asymptotic normality; Cramér–Rao
attribution; REML; Kullback–Leibler and White; Wald; Wilks; likelihood ratio test; Akaike.

## 7. Practical

Files: `Chapter_4/Practicals/no_solution.qmd` and `solution.qmd`, each self-contained
(no shared `material.qmd`). YAML as in Chapter 3:

```yaml
---
title: "Chapter 4: Maximum likelihood estimation"
date: today
---
```

and "Chapter 4: Maximum likelihood estimation — solutions" for the solutions page.

Student page: a short opening paragraph (which exercises use which data; that Exercises 1
to 3 need the package `emdbook` installed; work through Exercise 1 first; link to the
theory), then Exercise 1 with its full solution (`## Solution`, `### Question n`), then
the statements of Exercises 2 to 5.

Solutions page: the same opening lines as `Chapter_3/Practicals/solution.qmd`, then for
each of Exercises 2 to 5 the statement, `## Solution` and `### Question n`. Solutions
explain the reasoning in prose, use commented code, quote results with units, and answer
the ecological question.

Load data with `data(name, package = "pkg")`. Say once per dataset what it is and where it
comes from, using only what the package documentation states (Appendix B). All exercises
treat the observations as independent; where that is a simplification (tanks, quadrats on
a grid) say so once and point to Chapter 7, as the Chapter 3 practical does.

The practical must not use the theory's datasets (owls, the ten seedling counts).

### Exercise 1 (worked): survival of reed frog tadpoles

Data: `ReedfrogPred` from `emdbook`. Keep the 24 tanks with predators
(`pred == "pred"`). `density` is the initial number of tadpoles in a tank (10, 25 or 35)
and `surv` the number surviving. Model: $X_i\sim\operatorname{Binomial}(n_i,p)$ with one
survival probability $p$ and the tanks independent. The tanks are not identically
distributed because $n_i$ differs; the likelihood is still the product of the
contributions. Say this explicitly, since it prepares Chapter 6.

1. On paper: the likelihood contributions and the likelihood of the first three tanks
   (4, 9 and 7 survivors out of 10) as a function of $p$; evaluate the likelihood and
   log-likelihood at $p=0.5$ and $p=2/3$ (D22).
2. On paper: derive the MLE of $p$ for all tanks by differentiating the log-likelihood
   ($\hat p=\sum x_i/\sum n_i=264/560\approx0.471$).
3. In R: NLL on the logit scale, `optim()` with BFGS and `hessian = TRUE`, convergence,
   estimate back-transformed with `plogis()`, standard error on the logit scale, Wald
   interval back-transformed (0.430 to 0.513).
4. Likelihood interval with `uniroot()` (0.430 to 0.513). The two agree because 560
   tadpoles is a large sample.
5. Is the Binomial model adequate? Compare the variance of the number of survivors among
   tanks of the same density with $n\hat p(1-\hat p)$ (3.7 against 2.5; 24.8 against 6.2;
   64.3 against 8.7). The counts are overdispersed relative to the Binomial distribution
   (Chapter 2), so the interval is too narrow. Point to the Beta-Binomial entry of the
   supplement and to Chapter 7; mention that tadpole size (`size`) is a candidate
   predictor. Do not fit another model here.

### Exercise 2: glacier lily seedlings in quadrats

Data: `Lily_sum` from `emdbook`, column `seedlings`: counts in 256 quadrats of 2 m by 2 m.
Model: Negative Binomial with mean $\mu$ and shape $k$.

1. Method-of-moments estimates of $\mu$ and $k$, as in the Chapter 3 practical
   (3.96 and 0.31).
2. NLL with two log-transformed parameters; fit with `optim()`, method-of-moments
   estimates as starting values, `hessian = TRUE`; estimates on the original scale (3.96
   and 0.26); log-likelihood at the MLE and at the method-of-moments estimates.
3. Likelihood surface with two nested `for` loops and `contour()` of the relative
   log-likelihood; add both estimates and the contour of the joint 95% region.
4. Wald interval (log scale, back-transformed) and profile interval with `uniroot()` for
   $k$; compare.
5. Plot relative frequencies with the fitted Negative Binomial and Poisson probabilities.
   Compare the fraction of empty quadrats (observed 0.50; Negative Binomial 0.48; Poisson
   0.02) and the AIC of the two models (1132.4 against 2731.8).

### Exercise 3: empty quadrats and zero inflation

Same data. Half of the quadrats are empty. A different explanation for that is a
zero-inflated Poisson model: a fraction of the quadrats cannot have seedlings, and the
rest follow a Poisson distribution. Refer to `#sec-zero_inflated` in the supplement and
use its notation (`pzero`).

1. Write `dzipois = function(x, lambda, pzero, log = FALSE)` (D20). Check that its
   probabilities add up to one over a wide range of counts.
2. NLL with $\log\lambda$ and $\operatorname{logit}$ `pzero`; choose starting values from
   the data (fraction of empty quadrats; mean of the non-empty ones); fit; interpret both
   estimates (about 7.9 seedlings and 0.50).
3. Compare with the Negative Binomial of Exercise 2 by AIC (1700.0 against 1132.4). Both
   models have two parameters, so this is the same as comparing log-likelihoods.
4. Plot both fitted distributions over the relative frequencies. The zero-inflated Poisson
   matches the empty quadrats exactly but gives almost no probability to 20 or more
   seedlings (0.0001 against 4% of quadrats observed and 5% under the Negative Binomial).
   What does each model say about how the counts arise, and can the comparison identify
   the ecological cause? (Chapter 2: a distribution does not identify the cause.)

### Exercise 4: timber volume and body mass

Continuous data and a Gamma model with shape $k$ and rate $r$ (supplement entry; add the
ID `sec-gamma` to its heading so the practical can link to it).

Part A, `trees$Volume` (cubic feet, the 31 black cherry trees whose heights were used in
the Chapter 3 practical):

1. NLL with `dgamma(..., log = TRUE)` and log-transformed parameters; method-of-moments
   starting values from the mean and variance formulas of the supplement; fit; report the
   estimates with units (shape 3.89; rate 0.129 per cubic foot) and, by invariance, the
   estimated mean $\hat k/\hat r$ (30.2 cubic feet).
2. Likelihood surface in shape and rate; the correlation between the estimates from
   `cov2cor(solve(fit$hessian))` (0.94 on the log scales). What does the tilt mean?
3. Slice and profile for the shape, and the range of each within 1.92 of the maximum
   (slice 3.26 to 4.56; profile 2.32 to 6.06). Which is a confidence interval, and why is
   the slice too narrow?

Part B, `penguins$body_mass` for the Adelie penguins (grams; one missing value, which must
be removed explicitly and mentioned):

4. Fit the Gamma model to the masses in grams and again in kilograms. The shape is the
   same (66.1), the rate changes by a factor of 1,000, and the maximum log-likelihood
   changes by $151\log(1000)\approx1043.1$. Explain with the units of a density (D21).
5. Fit a LogNormal model (`dlnorm()`, numerically) in both units and compare with the
   Gamma by AIC. The difference is about 0.5 in both units: differences in AIC do not
   depend on the units, and these data do not distinguish the two models.

Note for students on the page: `penguins` ships with R 4.5.0 and later. Say what to do
with an older version (the `palmerpenguins` package has the same data with different
column names) in a footnote or a hint.

### Exercise 5: estimators and intervals across hypothetical experiments

Frame it as the Chapter 3 practical frames Exercise 3: we use the estimates as the
parameters of a model that we know and simulate hypothetical experiments from it.

1. For the tree volumes: Wald interval (log scale, back-transformed) and profile interval
   for the shape (2.41 to 6.27 and 2.32 to 6.06).
2. Simulate hypothetical experiments of 31 trees from the fitted Gamma model. For each,
   calculate the ML estimate and the method-of-moments estimate of the shape. Compare
   their means, standard deviations and mean squared errors with the shape used to
   simulate (ML: mean 4.26, SD 1.09; method of moments: mean 4.37, SD 1.22; shape 3.89).
3. In the same simulation, record whether each interval contains the shape used to
   simulate (coverage about 0.93 for Wald and 0.94 for profile). Give the hint that the
   profile interval contains a value whenever the profile log-likelihood at that value is
   within `qchisq(0.95, 1) / 2` of the maximum, so `uniroot()` is not needed inside the
   simulation.
4. Repeat questions 2 and 3 with experiments of 151 penguins from the Gamma model fitted
   in Exercise 4 (bias about 2%, both coverages about 0.95). The two simulations differ in
   sample size and in the model; ask how to check that the sample size is what matters
   (simulate 151 trees from the tree model).
5. Why do these results only approximate the behaviour of the estimators for the real
   trees and penguins?

Use 1,000 hypothetical experiments if 2,000 makes the page slow (section 10).

## 8. Other files

### 8.1 Glossary (`Supplements/glossary.qmd`)

Add entries in alphabetical order, in the existing format, with wording taken from the new
chapter: Akaike information criterion (AIC); Asymptotic efficiency; Cramér–Rao bound;
Fisher information; Hessian; Invariance; Joint confidence region; Kullback–Leibler
divergence; Likelihood function; Likelihood slice; Log-likelihood; Maximum likelihood
estimator (MLE); Misspecified model; Negative log-likelihood (NLL); Nuisance parameter;
Profile likelihood; Profile likelihood interval; Relative log-likelihood; Wilks' theorem;
Zero-inflated distribution. Extend the existing entries "Asymptotically normal" and "Wald
interval" with one sentence each instead of duplicating them.

### 8.2 Distribution supplement (`Supplements/distributions.qmd`)

Add `{#sec-gamma}` to the heading "Gamma distribution". No other change.

### 8.3 Chapter 1 (`Chapter_1/Theory.qmd`), author-finalised text

Minimal edits in the author's own wording style; show the before and after in the report.

- Roadmap, "Chapter 4: Maximum likelihood estimation": bring the three paragraphs in line
  with the new content. Key concepts: add the properties of the estimators, Wald (instead
  of "quadratic") and profile intervals, joint regions, AIC. R skills: `optim()`,
  transformations, grids with loops and contour plots, the Hessian and `solve()`,
  `uniroot()`, AIC, a zero-inflated mass function. Keep the sentence about the Negative
  Binomial example.
- Roadmap, "Chapter 6": model comparison now extends what Chapter 4 started (BIC and
  cross-validation are new there).
- "The modelling cycle", bullet "Model comparison and answer": say that the Akaike
  information criterion is introduced in Chapter 4 and that Chapter 6 adds the rest.
- Do not touch `ModelCycle.png`. Report that its red chapter numbers may need updating.

### 8.4 Chapter 2

`Chapter_2/Theory.qmd`, section "Choosing a distribution": the sentence that says formal
methods for model comparison come in Chapter 6 should point to Chapter 4 (`#sec-aic`) and
Chapter 6. The sentence in `Chapter_2/Practicals/solution.qmd` ("later in the book")
remains correct; leave it.

### 8.5 Chapters 5, 6 and 8 (D27)

Links that must keep working (all four IDs are kept):

- `Chapter_5/Theory.qmd`: link to `#sec-likelihood-uncertainty` for the quadratic
  approximation near a maximum.
- `Chapter_8/Theory.qmd`: links to `#sec-maximum-likelihood`, `#sec-likelihood`,
  `#sec-likelihood-surface` (slice against profile) and `#sec-likelihood-uncertainty`.

Sentences to fix now:

- `Chapter_6/Theory.qmd`, "Information criteria": it introduces AIC as new and writes the
  number of parameters as $k$. Reword the opening to recall AIC from Chapter 4
  (`#sec-aic`) and use $K$ in the two formulas and the sentences that refer to them.

After writing, search Chapters 5 to 8 (theory and practicals) for "Chapter 4" and
"Chapter_4" and check each sentence against the new chapter. Fix only what is wrong.

For the future rewrites of those chapters, put this list in the report:

- Chapter 6: cut the re-explanation of Hessian intervals and of checking an interval by
  simulation, which Chapter 4 now owns; introduce the delta method (needed for confidence
  bands of curves and for standard errors on the original scale); use "Wald interval"
  consistently with "quadratic" as its explanation; use loops in place of `vapply()`.
- Chapter 8: `optimize()`, bounds, scaling, starting values, local maxima, Hessian
  problems, and the effect of parameterisation on the search all start there.
- Chapter 7: conditional distributions and REML are still owed.

### 8.6 Publication

- `.github/workflows/publish.yml`: add `any::emdbook`.
- `_quarto-prod.yml`: add the three Chapter 4 pages to `project: render` and to the
  sidebar sections "Theory", "Practicals" and "Solutions", following the existing entries.
- `_freeze` is ignored by git, so the published build runs every chunk. See section 10 for
  the time budget.

### 8.7 `AGENTS.md` and `STYLE_GUIDE.md`

`AGENTS.md`:

- Review-status table: mark Chapters 1 to 3 as reviewed and approved by the author (5
  October 2026) and simplify their rows accordingly. Replace the note that points to this
  plan with a row for Chapter 4: rewritten draft awaiting review, with the decisions of
  section 4 that are durable (D3, D8, D9, D14, D15, D16, D17, D19, D23).
- "Teaching scope and progression": replace the bullet that says Chapter 6 introduces
  model comparison with: AIC is introduced in Chapter 4; Chapter 6 adds BIC,
  cross-validation and goodness of fit. Add that the delta method belongs to Chapter 6 and
  that bounds, `optimize()` and the effect of parameterisation on optimisation belong to
  Chapter 8.
- Dependencies sentence: `emdbook` is in `publish.yml` because the Chapter 4 practical
  loads its data.

`STYLE_GUIDE.md`:

- "Basis and scope": Chapters 1 to 3 are approved in full.
- The sentence "method of moments belongs to Chapter 3 and model comparison to Chapter 6":
  update for AIC.
- Notation table: add rows for the likelihood (bar notation, $L$ and $\ell$, NLL), for
  Wald against profile likelihood intervals (profile is the reference), and for $K$ as the
  number of parameters in AIC.
- R coding patterns, maximum likelihood paragraph: `optim()` with BFGS, transformations
  for constraints, loops for grids, `uniroot()` for interval endpoints.

## 9. R conventions and traps for this chapter

- `=` for assignment, named arguments, two-space indentation, double quotes, no pipes,
  short comments on groups of lines, as in Chapter 3.
- New functions that need one sentence of introduction at first use: `optim()`, the
  argument `log = TRUE`, `qlogis()` and `plogis()`, `solve()`, `cov2cor()`, `uniroot()`,
  `qchisq()`.
- Pass data to the NLL as a named extra argument of `optim()` (`counts = call_counts`).
- Name the elements of `par` and index them by position inside the NLL; say so.
- A one-parameter fit returns a 1 by 1 Hessian. Use `fit$hessian[1, 1]` before doing
  arithmetic with it, otherwise R warns about recycling an array.
- `optim()` with BFGS works for one parameter without a warning (the warning that R gives
  for one-parameter problems concerns the default method).
- In a profile, start each inner `optim()` at the joint estimate of the nuisance
  parameter.
- `integrate()` needs a function that is vectorised over the parameter (see the likelihood
  section); a likelihood written with `prod()` or `sum()` over the data is not.
- `dnbinom()` must be called with `mu` and `size` named, or `size` and `prob` named.
- `uniroot()` needs an interval whose ends give values of opposite sign. Choose the ends
  from the plotted curve (for example from a small positive value to the estimate, and
  from the estimate to a large multiple of it) and say how you chose them.
- Optimisers can step to extreme values and produce `NaNs produced` warnings from
  `dgamma()` or `dnbinom()`. The site profiles suppress warnings, so they will not show,
  but do not describe output that students will see differently without saying so.
- Rendered figures: `ggplot2`, `theme_classic()`, observations in `#0072B2`, empirical
  bars `grey90` with `grey40` outline, fitted models in `#D55E00`, distinguish series by
  geometry or line type as well as colour. Solutions may use base R (`contour()`).
- Set a seed before each simulation; do not reset it inside repetitions.
- Reuse Chapter 3's object names when the object is the same (`seedling_counts`,
  `lambda_hat`, `critical_value`, `call_counts`, `mu_hat`, `k_hat`, `n_experiments`).

## 10. Verification

R is installed at `C:\Program Files\R\R-4.6.1\bin\Rscript.exe` and is not on the Git Bash
path; Quarto 1.5.43 is on the path. The packages needed (`ggplot2`, `patchwork`,
`glmmTMB`, `emdbook`) are installed locally. Do not install packages.

1. Run every chunk of the three pages in a clean R session, in order, and recompute every
   number quoted in the prose. Appendix A gives planning values to compare against; a
   difference in the last digit with another seed is expected for simulations, a larger
   difference is a bug.
2. Check that every `optim()` call returns `convergence == 0` and that each profile
   function has its minimum at the joint estimate.
3. Render the three pages with the development profile, for example
   `quarto render Chapter_4/Theory.qmd --profile dev`, and inspect the HTML: figures,
   cross-references (`@fig-`, `@sec-`), footnotes, callouts, and that the student page
   shows the solution of Exercise 1 only.
4. Time the render. The published build has no freeze, so keep each simulation chunk under
   about 30 seconds and the theory page under about two minutes; reduce the number of
   hypothetical experiments or the larger sample size if needed, and say what you used.
5. Check all links into and out of the chapter: the four kept IDs, the links from
   Chapters 1, 2, 3, 5, 6 and 8, and the supplement IDs (`sec-poisson`,
   `sec-negative_binomial`, `sec-binomial`, `sec-beta_binomial`, `sec-lognormal`,
   `sec-zero_inflated`, the new `sec-gamma`).
6. Run the checklist at the end of the priority section of `STYLE_GUIDE.md` on every
   section. Search the three pages for "not ", "does not" and "simulated" and delete the
   caveats that are not needed. Search for `vapply`, `sapply`, `Vectorize`, `optimize`,
   `<-`, "normal" in lower case, American spellings, and `|>`.
7. Check D3: the Normal model appears only in footnotes and in the callout about the
   interactive page.
8. Render `Supplements/glossary.qmd`, `Chapter_1/Theory.qmd` and `Chapter_2/Theory.qmd`
   after editing them.

## 11. Report to the author

- What was written and changed, file by file.
- Which checks ran, with the render times.
- Every `<!-- AUTHOR: ... -->` comment with file and line.
- Every historical attribution, marked as verified (with the source used) or unverified.
- Before and after of each edit to Chapters 1, 2 and 6.
- The three consequences listed under the table in section 4.
- The list for later chapters from section 8.5, and the note about `ModelCycle.png`.
- Whether `AGENTS.md` and `STYLE_GUIDE.md` were updated.

## 12. Running the work in phases

D30 means one review by the author at the end. The work itself is run as separate
sessions, each with a fresh context, so that no session has to hold all the reference
chapters, write both pages and debug R at the same time. The phases separate what is
specified and checkable (code, figures, numbers, file edits, verification) from what needs
the author's voice and statistical judgement (prose).

### Status

Each phase updates its row when it finishes. The notes are the only thing the next session
knows about your session, so put there whatever it needs: deviations from this plan,
values that differ from Appendix A, problems left open.

| Phase | Status | Date | Notes for later phases |
|---|---|---|---|
| 1. Attributions | done | 2026-10-05 | All 11 rows of B.1 filled. Sources read in full text: Aldrich 1997, Stigler 2007, Akaike 1973 (reprint), Wald 1943 (title page and pp. 426-427 only, scan), a Wellner handout stating Wald 1949. Project Euclid, JSTOR and OUP block scripted access, so Wilks 1938, Wald 1949, Kullback-Leibler 1951, Zehna 1966, Efron-Hinkley 1978, Huber 1967 and White 1982 are verified as citations only (record or secondary summary), not read. Corrected: Wald interval (the 1943 paper is about tests, not intervals); asymptotic normality (add Wald 1943; Fisher's proofs were not rigorous); Cramér-Rao (add Fisher 1925 as a precursor). Refined: origin of likelihood (the 1912 paper did not use the word; 'likelihood' is 1921, 'maximum likelihood' is 1922). Pitfall: a search returned Wald 1948 (euclid.aoms/1177730288) in place of Wald 1949. Phase 4 must follow the 'Supports' column and omit page numbers in footnotes. B.2 untouched (phase 3). |
| 2. Theory skeleton | done | 2026-10-05 | `Chapter_4/Theory.qmd` replaced (1,183 lines; 21 `VALUES` comments, all filled). `any::emdbook` added to `publish.yml`. Renders with `--profile dev` in 36 s without warnings; all chunks also run in a clean session via `knitr::purl` (25 s). Every `optim()` call returns 0 (also all 6,000 simulation fits and the 127 inner fits of the profile). **Object names**: Chapter 3's `k_hat` is the method-of-moments shape, so Chapter 4 uses `k_mom` for it, `mu_mle` and `k_mle` for the ML estimates (`mu_hat` is the sample mean, as in Chapter 3), `owl_fit` / `owl_fit_prob` for the two fits, `lambda_hat` for the Poisson MLE, `poisson_fit` for the log-scale fit, `n_quadrats` and `n_visits`. **Simulations**: 2,000 hypothetical experiments for each of 20, 122 and 500 visits (about 15 s together, hidden chunk, seed 601); coverage chunk: 5,000 Poisson experiments per case and 2,000 Negative Binomial experiments for 20 and 122 visits (seed 701 and 702, about 10 s). **Deviations from the plan**: (1) extra chunk in the log-likelihood section that simulates 1,000 counts and shows that `prod(dpois())` returns 0 while the sum of log probabilities is -2094.6 (the plan asked to check any underflow claim; delete if not wanted); (2) `integrate()` needs `rel.tol = 1e-8, abs.tol = 0`: with defaults it returns 3.80e-9 with a stated error larger than the value, the exact area is 3.765e-9, so the value in Appendix A (3.80e-9) was a tolerance artefact; (3) hidden check chunk (no output) that the profile of `k` in the (mu, k) parameters equals the slice at `mu_mle` (maximum difference 1.2e-7), supporting the one-sentence remark in the slices section; (4) the base-R `contour()` call is a separate `eval: false` chunk so it does not produce an unlabelled second figure; (5) `fit_negbin()` (hidden, defined in the asymptotic-normality simulation chunk) is reused by the coverage chunk; (6) the quadratic approximation in `fig-profile_interval` uses the standard error of mu from the Negative Binomial variance (0.778), not the Hessian, because the Hessian is on the log scales (delta method is deferred, D8). **Differences from Appendix A** (all within simulation or grid error): skewness of the ML estimate of k at 20 visits is 2.59 (Appendix 1.9; different formula and seed); MSE at 122 visits 0.00306 and 0.00851 (0.0029, 0.0084; the MSE here is taken around the ML estimate 0.327, not 0.33); coverage Poisson lambda = 4: 0.952 and 0.954 (0.945, 0.946); the 1.92 ranges for k in the (k, p) parameters are 0.260 to 0.405 (slice) and 0.240 to 0.450 (profile) on a grid with step 0.005 (Appendix 0.258 to 0.407; 0.235 to 0.451). Every other quoted value agrees to the printed digits. Not computed in the skeleton: nothing for the Consistency subsection (no chunk in the plan). Figures were inspected: contours in the (mu, k) surface are symmetric about the line mu = mu_hat but not elliptical (the surface is skewed along mu), so phase 4 should not describe them as ellipses. |
| 3. Practical skeleton | done | 2026-10-05 | Both pages replaced and render with `--profile dev` without errors or warnings (solutions 30 s, student page 4 s); all chunks also run in a clean session via `knitr::purl` (solutions 24 s). Every `optim()` call returns 0. `no_solution.qmd`: YAML, a `<!-- PHASE 5 -->` comment for the opening paragraph, Exercise 1 (data chunk, then `## Solution` and `### Question 1` to `5` with code and `VALUES` comments), and bare headings for Exercises 2 to 5. `solution.qmd`: hidden `library(ggplot2)` chunk, Exercises 2 to 5 with the data chunk after the heading, `## Solution`, `### Question n`; Question 5 of Exercise 5 has no code. Exercise statements are `<!-- PHASE 5 -->` comments. `{#sec-gamma}` added to the Gamma heading of the supplement. **Object names** (solutions page): `lily_counts`, `n_lily`, `mu_mom_lily`, `k_mom_lily`, `lily_fit`, `mu_mle_lily`, `k_mle_lily`, `nb_nll`, `dzipois`, `zip_nll`, `zip_fit`, `tree_volume`, `gamma_nll`, `volume_fit`, `shape_volume`, `rate_volume`, `gamma_nll_given_shape`, `gamma_profile_relative`, `mass_g`, `mass_kg`, `penguin_fit_g`, `penguin_fit_kg`, `simulate_gamma_experiments()`, `summarise_experiments()`; student page: `tadpoles`, `survivors`, `frog_fit`, `binomial_nll`. **Deviations from the plan**: (1) `control = list(reltol = 1e-12)` in the penguin Gamma and LogNormal fits and in the fits inside the simulation: the default `reltol` of `optim()` is relative to the NLL, which is about 1,138 in grams, so the Gamma fit in grams stopped after one step at almost the method-of-moments start (shape 65.56 and rate 0.01772 instead of 66.09 and 0.01786; convergence code still 0, difference between units 1043.0735 instead of 1043.071). Phase 5 needs one sentence on it in the solution to Exercise 4 (it is the stopping rule, a Chapter 8 topic); the student statement can hint at it. (2) 2,000 hypothetical experiments instead of 1,000 in Exercise 5 (3 s for 31 trees, about 19 s for the penguin and 151-tree simulations together, seeds 801 and 802), so that the quoted SD is steadier: with 1,000 experiments the SD of the ML estimate for 31 trees ranged from 1.09 to 1.22 across five seeds because the distribution is skewed. (3) Exercise 4 Question 3 and Exercise 5 Question 1 use a grid of 261 values for the shape, so the slice and profile ranges are accurate to about 0.025. **Differences from Appendix A**: Wald and likelihood intervals, estimates, AIC and all Exercise 1 to 4 values agree to the printed digits (slice 3.275 to 4.55, profile 2.325 to 6.05; Appendix 3.26 to 4.56 and 2.32 to 6.06). Exercise 5, 31 trees: ML mean 4.33, SD 1.20 (Appendix 4.26, 1.09); method of moments mean 4.43, SD 1.30 (4.37, 1.22); coverage 0.931 and 0.939 (0.931, 0.944); relative bias of the ML estimate for 151 penguins 1.6% (about 2%), coverage 0.947 and 0.946; 151 trees: bias 1.5%, coverage 0.951 and 0.956. Extra numbers computed: lily NB log-likelihood at the method-of-moments estimates -565.34; Wald interval for the lily shape 0.208 to 0.329 and profile 0.207 to 0.328; the lily method-of-moments estimate lies inside the joint region; 8 tanks at each density in Exercise 1. Not computed: the 0.0211 standard error on the probability scale of Exercise 1 (it follows from sqrt(p(1-p)/560); the delta method is deferred, D8, so the code does not calculate it). The penguin masses are in grams (`body_mass`), 151 Adelie penguins after removing 1 missing value; `penguins` needs R 4.5.0 or later, as the memory file says. **Appendix B.2 additions** (from the help pages): `ReedfrogPred`: `surv` is the number surviving, `propsurv` = `surv/density`; Vonesh and Bolker (2005), *Ecology* 86: 1580-1591. `Lily_sum`: 16 x 16 grid of 2 x 2 m quadrats in Washington Gulch, sampled in 1992; Thomson et al. (1996), *Untangling multiple factors in spatial distributions*, *Ecology* 77: 1698-1715, data from James D. Thomson. `trees`: the diameter in inches is labelled `Girth`; sources Meyer (1953), *Forest Mensuration*, and Ryan, Joiner and Ryan (1976), *The Minitab Student Handbook*. `penguins`: Adelie data from Palmer Station Antarctica LTER, Gorman KB (2020), doi:10.6073/pasta/98b16d7d563f265cb52372c8ca99e60f; Gorman, Williams and Fraser (2014) used the data for sexual dimorphism; the `palmerpenguins` package has the same data with `body_mass_g` instead of `body_mass`. |
| 4. Theory prose | done | 2026-10-05 | `Chapter_4/Theory.qmd` is complete: all prose, 17 footnotes, 7 practice callouts, a warning callout, 3 note callouts, summary, 10 quiz questions; no `VALUES` comment left. Renders with `--profile dev` in 37 to 40 s without warnings; all chunks also run in a clean session via `knitr::purl` (29 s); 9 figures, all `@fig-` and `@sec-` references resolve. Every `optim()` call returns 0 (4 visible fits, 127 inner fits of the profile, 6,000 simulation fits, no failed fit in the coverage simulation); both profile functions are zero at the joint estimate. Every number in the prose was compared with the output of the final code. Steps 1, 3, 5, 6 and 7 of section 10 pass for the theory page. **Size**: 2,645 source lines, of which 1,088 are code chunks (the skeleton was 1,183 lines), so the page is above the 1,700 to 1,900 lines expected in section 1; the author should decide whether to cut (candidates: the underflow demonstration with 1,000 simulated counts, the check of the standard error of log k against the simulation, one or two practice callouts). **AUTHOR comments**: line 823 (what it means that the two estimates differ), line 1650 (what a wrong model means in practice), line 1662 (why profile intervals are preferred), line 2408 (AIC and differences in practice). No first-person text was written. **Attributions**: every footnote follows the 'Supports' column of B.1; no row was 'not verified'. Not read by phase 1 (citation only): Wilks 1938, Wald 1949, Kullback and Leibler 1951, Zehna 1966, Efron and Hinkley 1978, Huber 1967, White 1982; Fréchet 1943 and Darmois 1945 come from secondary listings; the roles of Cramér 1946 and Hodges 1951 rest on Stigler. Page numbers are given only for Aldrich 1997 and Stigler 2007 (read in full) and for the one-page note of Zehna (from the DOI record). The REML footnote says that REML 'is used with the models for grouped observations of Chapter 7' and promises no explanation there, because Chapter 7 does not cover REML yet. The interactive page (rpsychologist.com/likelihood) was fetched and matches the callout (Normal model, sliders for mean and variance, ten observations, hypothesis tests at the end). **Changes to the skeleton's chunks** (numbers unchanged unless stated): (1) first chunk split in two, `lambda_candidates` removed, the likelihood of the ten counts is also calculated at lambda = 3 (5.2e-10, a ratio of 4.5 against lambda = 4); (2) likelihood-curve chunk also prints the relative log-likelihood at 3 and at 5 (-1.51 and -1.07); (3) the chunks of the constraints section, of the owl fit, of the owl Wald intervals and of the owl profiles are each split into smaller chunks with prose between them; (4) the hidden simulation chunk moved to the opening of `#sec-mle_properties`, so that the Consistency subsection can use it: a new visible chunk gives the fraction of estimates of k that miss by 0.1 or more (0.457, 0.067 and 0 for 20, 122 and 500 visits); (5) efficiency table without the skewness column and without `na.rm` (a visible `sum(is.na(sim_k_mom))` shows that no method-of-moments estimate is missing), printed with `signif(, 3)`; (6) one added line, `sd(log(sim_k_ml[, 2]))` = 0.161, to compare with the standard error of log k from the Hessian (0.165); (7) the hidden check chunk and the coverage chunk are now `include: false`, because with `echo: false` they printed output without code; (8) axis labels use plotmath for mu, lambda, k and p, the coverage labels use the lambda character, and the captions of `fig-likelihood_curve` and `fig-profile_interval` were reworded. The visible chunks of the Consistency, Efficiency and Bias subsections use `sim_k_ml`, `sim_k_mom` and `visit_sizes` from the hidden simulation chunk; the prose says what these objects are. **For phase 5** (notation and promises): the method-of-moments estimate of the shape is written $\hat k_{\mathrm{MM}}$; the profile log-likelihood is $\ell_{\mathrm{prof}}$ (the plan's $\ell_p$ clashes with the probability p); Fisher information $\mathcal I(\theta)$ and observed information $\hat{\mathcal I}$; 'relative log-likelihood'; 'profile likelihood interval' ('likelihood interval' for a model with one parameter) with cutoff 1.92; 'joint confidence region' with cutoff 3.00; MLE and NLL as abbreviations. New section IDs: `sec-mle_properties`, `sec-misspecified`, `sec-profile_intervals`, `sec-aic`. The theory promises three things of the practical: that students check the effect of units on a log-likelihood 'with measurements of body mass' (Exercise 4), that they 'write a simulation of this kind' of estimators across hypothetical experiments (Exercise 5), and that they 'run a simulation of this kind for another model' for coverage (Exercise 5). **Edits to approved text.** `Chapter_2/Theory.qmd`, 'Choosing a distribution'. Before: 'In [Chapter 6](../Chapter_6/Theory.qmd) we will learn formal methods for model comparison'. After: 'In [Chapter 4](../Chapter_4/Theory.qmd#sec-aic) and [Chapter 6](../Chapter_6/Theory.qmd) we will learn formal methods for model comparison'. `Chapter_1/Theory.qmd`, modelling cycle, bullet 'Model comparison and answer'. Before: 'More than one model may be plausible. In [Chapter 6], we compare fitted candidate models using information criteria and cross-validation, check how well they describe the data, and interpret [...]'. After: 'More than one model may be plausible. [Chapter 4] introduces the Akaike information criterion to compare fitted candidate models. In [Chapter 6], we add other information criteria and cross-validation, check how well the models describe the data, and interpret [...]'. Roadmap, Chapter 4, key concepts. Before: 'The chapter connects likelihood curvature to standard errors and compares quadratic and profile likelihood confidence intervals.' After: 'You learn the properties of maximum likelihood estimators (consistency, asymptotic normality and efficiency) and what happens with small samples and with misspecified models. The chapter connects likelihood curvature to standard errors, compares Wald and profile likelihood confidence intervals, and introduces joint confidence regions for several parameters. It ends with the Akaike information criterion (AIC) as a first tool to compare models.' (the sentence on the Negative Binomial example is kept). Roadmap, Chapter 4, R skills. Before: 'You learn how to deal with constraints on parameters. You use grids and contour plots to explore likelihoods, the Hessian to approximate standard errors, and `uniroot()` to compute likelihood profiles.' After: 'You learn how to deal with constraints on parameters by transforming them. You use grids filled with loops and contour plots to explore likelihoods, the Hessian and `solve()` to approximate standard errors, and `uniroot()` to compute profile likelihood intervals. You also calculate AIC and write your own zero-inflated probability mass function.' The third paragraph of that entry is unchanged. Roadmap, Chapter 6. Before: 'but also compare candidate models using information criteria and cross-validation, and assess goodness-of-fit'. After: 'extend the comparison of candidate models that Chapter 4 started with AIC by adding BIC and cross-validation, and assess goodness-of-fit'. Chapters 1 and 2 render with `--profile dev` after the edits. `ModelCycle.png` was not touched. Not done here (phase 6): glossary, `_quarto-prod.yml`, Chapter 6, `AGENTS.md` and `STYLE_GUIDE.md` (reviewed, left unchanged). |
| 5. Practical prose | done | 2026-10-05 | Both practical pages are complete: opening paragraphs, the statements of Exercises 1 to 5 (identical text on both pages for Exercises 2 to 5), the full solution of Exercise 1 on the student page and the solutions of Exercises 2 to 5 on the solutions page; no `PHASE 5`, `VALUES` or `NO CODE` comment left. Both render with `--profile dev` without errors or warnings (student page about 5 s, solutions 30 to 31 s); all `@fig-` references and links resolve; the student page has one `## Solution` (Exercise 1). Every number in the prose was compared with the rendered output; the five figures were inspected. Step 6 of section 10 passes for both pages (no `<-`, pipes, `sapply`/`vapply`/`Vectorize`, `optimize`, lower-case distribution names or American spellings; the remaining "does not"/"cannot" sentences each carry a point). No `<!-- AUTHOR: ... -->` comment and no first-person text in the practical. **Notation**: as in the theory ($\hat k_{\mathrm{MM}}$, MLE, NLL, relative log-likelihood, profile likelihood interval, cutoffs 1.92 and 3.00, $K$ in AIC); the zero-inflation probability is $p_0$ in the mathematics and `pzero` in code, as in the supplement. **Changes to the skeleton's chunks** (existing numbers unchanged): Exercise 1 Question 3 is split in two chunks and also prints the Hessian (139.54) next to `sum(n) * p * (1 - p)` and the standard error on the probability scale from `sqrt(p_hat * (1 - p_hat) / total_tadpoles)` (0.0211, a formula, no delta method); Question 4 prints the relative log-likelihood at the ends of the search intervals (-103.7 at 0.2, -148.1 at 0.8). Exercise 3 Question 2 prints the starting values on the original scale (7.853, 0.496) and `dpois(x = 0, lambda = lambda_zip)` (0.0004). Exercise 4 Question 4 prints the fitted mean (3,700.7 g, 3.70 kg). Exercise 5 Question 2 prints the relative bias of both estimators (11.5% and 14.1%) and the median of the ML estimates (4.13). **Differences from the plan**: the AIC of the Negative Binomial model for the lilies is 1132.46, quoted as 1132.5 (sections 7 and Appendix A say 1132.4), and that of the zero-inflated Poisson model is 1700.06, quoted as 1700.1 (plan: 1700.0); the differences quoted are 1,599 and 567.6. Slice and profile ranges of Exercise 4 are quoted from the grid (3.28 to 4.55; 2.33 to 6.05), the exact profile interval (2.32 to 6.06) in Exercise 5. **Things the statements fix for students**: seeds 801 (31 trees) and 802 (151 penguins, then 151 trees without resetting the seed), 2,000 experiments, `control = list(reltol = 1e-12)` in the penguin fits and in the simulation; the hint for `reltol` is in the statement of Exercise 4 Question 4, and its solution explains it in one paragraph (with the default the fit in grams stops at shape 65.56, 0.0025 NLL units above the minimum, with convergence code 0), pointing to Chapter 8. The note for R older than 4.5.0 (`palmerpenguins`, `body_mass_g`) is a footnote in the statement of Exercise 4. **For the author to check**: (1) the ecological readings that are mine and not from the package documentation: "no seeds arrive there" as an example of a quadrat that cannot have seedlings, "dispersal of seeds around the parent plants" and "suitability of the quadrats for germination" as possible sources of overdispersion (Exercise 3), and "tadpoles in the same tank share their predators and their conditions" (Exercise 1 Question 5); they are worded as possibilities; (2) the i.i.d. simplification for the grid of quadrats points to Chapter 7, which covers grouped and not spatial dependence; (3) citations are given as author and year only (Vonesh and Bolker 2005; Thomson et al. 1996; Gorman, Williams and Fraser 2014), as in the Chapter 3 practical; the location "Washington Gulch" is given without a region because the help page gives none. **For phase 6**: glossary entry "Zero-inflated distribution" can take its wording from the statement of Exercise 3; the three promises of the theory to the practical are kept (units of a log-likelihood in Exercise 4 Question 4, simulation of estimators in Exercise 5 Question 2, coverage for another model in Exercise 5 Question 3). `AGENTS.md` and `STYLE_GUIDE.md` were reviewed and left unchanged (phase 6). |
| 6. Close-out | not started | | |

### Rules for every phase

1. Do your phase only. Do not start the next one, and do not do part of another phase
   because it looks convenient.
2. Check the status table first. If a phase that yours depends on is not marked done,
   stop and tell the author.
3. Read section 4 (decisions) and section 9 (R conventions), then what your phase lists.
   The reading that `CLAUDE.md` requires before changing course content still applies.
4. If something in this plan cannot be done as written, do not improvise a different
   design. Do what is unaffected, describe the problem in the status notes and in your
   report, and stop.
5. Leave `AGENTS.md` and `STYLE_GUIDE.md` to phase 6. In your report, say that they were
   reviewed and left unchanged.
6. When you finish: update your row of the status table, then report to the author what
   you did, which checks ran and their results, and anything they should look at. Do not
   commit unless the author asks.

### Phase 1: attributions (Sonnet, with web search)

Depends on: nothing. Must be done before phase 4.

Scope: the table in Appendix B.1 and nothing else. Appendix B.2 (data provenance) is not
part of this phase.

Read: Appendix B, and the "Footnote list" at the end of section 6 to see what each
footnote will say.

For each row of B.1:

1. Find the publication or publications named. Confirm authors, year, title and where it
   appeared (journal with volume and pages, or book and publisher).
2. Confirm what the work showed, to the extent that the footnote will claim it. For
   example, the row on the origin of likelihood supports three claims (a first paper in
   1912, the word "likelihood" in 1921, the theory set out in 1922), and each needs
   confirming.
3. Fill in the three empty columns of the table:
   - **Status**: `verified`, `corrected` (the candidate was wrong or imprecise; say what
     changed) or `not verified` (say what you tried).
   - **Reference**: the full reference or references.
   - **Supports**: one or two plain sentences stating what phase 4 may write in the
     footnote on the strength of this source, and anything it must not claim.

Sources, in order of preference: the publication itself or its record at the publisher,
JSTOR or Project Euclid; the two histories named in Appendix B (Aldrich 1997, Stigler
2007); a standard graduate textbook of mathematical statistics. An encyclopaedia page may
be used to find sources but is not itself a source for the status `verified`.

Verification from memory does not count. If web search or page fetching is not available
in your session, stop and tell the author instead of filling the table from what you
remember. Do not invent page numbers, and do not record a quotation that you have not
seen.

Done when: every row of B.1 has a status, the status table is updated, and your report
lists the rows that were corrected or could not be verified.

### Phase 2: theory skeleton (Sonnet)

Depends on: nothing.

Scope: replace `Chapter_4/Theory.qmd` (the old page is in git; overwrite it) with a
skeleton that contains

- the YAML and the hidden setup chunk of section 6;
- every heading of section 6 with its ID, in order, including `# Summary` and
  `# Chapter quiz` as empty headings;
- every code chunk that section 6 describes, in teaching order, both the visible ones and
  the hidden figure and simulation chunks, written to the conventions of section 9 with
  comments, `#| label:` and a draft `#| fig-cap:`;
- under each heading, after its chunks, one HTML comment of the form
  `<!-- VALUES: ... -->` listing the numbers computed there that the prose will quote,
  with their units.

No explanatory prose, no footnotes, no callouts, no practice exercises, no quiz questions:
phase 4 writes them with the reference chapters in context. Captions and code comments
are part of the skeleton.

Also add `any::emdbook` to `.github/workflows/publish.yml`. Do not add Chapter 4 to
`_quarto-prod.yml` (phase 6).

Read: section 6, section 10 and Appendix A; `Chapter_3/Theory.qmd` for how chunks,
figures and simulations are coded; Exercise 1 of `Chapter_3/Practicals/no_solution.qmd`
for the owl code and object names.

Done when: the page renders with the development profile without errors; every
`optim()` call returns convergence code 0; every value has been compared with Appendix A
and the differences are listed in the status notes; the render time and the number of
hypothetical experiments used in each simulation are in the status notes.

### Phase 3: practical skeleton (Sonnet)

Depends on: phase 2, for object names and the form of the NLL and profile functions. May
be done in the same session as phase 2.

Scope: replace both practical pages with skeletons that contain the YAML of section 7,
the exercise headings (`# Exercise n: ...`, `## Solution`, `### Question n`), and all the
code that answers Exercises 1 to 5, with comments and `<!-- VALUES: ... -->` comments as
in phase 2. Exercise 1's code goes on the student page, the code of Exercises 2 to 5 on
the solutions page. No exercise statements and no solution prose. Also add `{#sec-gamma}`
to the Gamma heading of `Supplements/distributions.qmd`.

Read: section 7, section 10 and Appendix A; both Chapter 3 practical pages; the supplement
entries for the Binomial, Negative Binomial and Gamma distributions and `#sec-zero_inflated`;
the theory skeleton. Read `?ReedfrogPred`, `?Lily_sum`, `?trees` and `?penguins` in R and
add to Appendix B.2 anything the statements will need (units, the full source to credit).

Done when: both pages render without errors; the values are compared with Appendix A and
differences noted; the time of the simulation exercise is noted.

### Phase 4: theory prose (Opus)

Depends on: phases 1 and 2.

Scope: all the prose of `Chapter_4/Theory.qmd`, following section 6 and the patterns of
section 5: definitions and explanations, lead-ins to the code, footnotes built on the
"Supports" column of Appendix B.1 (a row that is `not verified` gets a footnote without
the uncertain detail), callouts, practice exercises, summary, the ten quiz questions, and
the `<!-- AUTHOR: ... -->` comments. Replace each `<!-- VALUES: ... -->` comment by prose
that quotes those values, and delete the comment. You may reorder or change chunks where
the teaching order needs it; rerun what you change and keep the numbers in the text
correct. Then make the edits to approved text in sections 8.3 and 8.4.

Read: everything in section 2, the skeleton, and Appendix B.1.

Done when: the page renders; steps 1, 3, 5, 6 and 7 of section 10 pass for the theory
page; Chapters 1 and 2 render after their edits; the status notes list every `<!-- AUTHOR: ... -->` comment with its line, every
unverified attribution, and the before and after of each edit to Chapters 1 and 2.

### Phase 5: practical prose (Opus)

Depends on: phases 3 and 4.

Scope: the opening paragraph, the exercise statements and the prose of all solutions on
both practical pages, following section 7. Take notation, terms and object names from the
finished theory. Replace the `<!-- VALUES: ... -->` comments as in phase 4. Use Appendix
B.2 for what is said about each dataset.

Read: the finished `Chapter_4/Theory.qmd`; both Chapter 3 practical pages; the two worked
exercises of `Chapter_2/Practicals/no_solution.qmd`; section 7; Appendix B.2.

Done when: both pages render; the student page shows the solution of Exercise 1 only; the
statements and solutions agree in numbering, data and notation; steps 1 and 6 of section
10 pass for both pages.

### Phase 6: close-out (Sonnet)

Depends on: phases 4 and 5.

Scope: sections 8.1 (glossary, with wording taken from the finished theory), 8.5 (the
Chapter 6 sentence and the search of Chapters 5 to 8), 8.6 (`_quarto-prod.yml`) and 8.7
(`AGENTS.md` and `STYLE_GUIDE.md`); every step of section 10 on the finished pages; and
the report of section 11, compiled from the status notes of all phases and from the diff.
Do not rewrite prose in the Chapter 4 pages. If a check fails because of the prose (a
wrong number, a broken reference), fix that item only and list it in the report.

Read: sections 8, 10 and 11; the status table; the three finished Chapter 4 pages.

Done when: all steps of section 10 pass or their failures are listed, and the report of
section 11 is given to the author.

## Appendix A: values computed during planning

Computed with R 4.6.1 on 5 October 2026. They show that the design works and give targets.
Recompute all of them; do not copy them into the text.

**Ten seedling counts, Poisson**

| Quantity | Value |
|---|---|
| MLE | 4 |
| Log-likelihood at the MLE; likelihood | $-19.860$; $2.37\times10^{-9}$ |
| Integral of the likelihood over $\lambda$ | $3.80\times10^{-9}$ |
| Likelihood of the first three counts at 3 and at 4 | 0.00506; 0.00447 |
| Observed information; SE | 2.5; 0.632 |
| Wald interval, original scale | 2.76 to 5.24 |
| Hessian and SE on the log scale | 40; 0.158 |
| Wald interval, log scale, back-transformed | 2.93 to 5.45 |
| Likelihood interval | 2.89 to 5.37 |

**Owls (satiated, female parent; 122 visits), Negative Binomial**

| Quantity | Value |
|---|---|
| Mean; variance with divisor $n$ | 4.754; 42.35 |
| Method of moments $k$ | 0.601 |
| MLE of $\mu$ and $k$ | 4.754; 0.327 |
| Log-likelihood: MLE; method-of-moments estimates; Poisson | $-299.44$; $-306.55$; $-634.16$ |
| Fraction of zeros: observed; NB at MLE; NB at MoM; Poisson | 0.443; 0.407; 0.269; 0.009 |
| Variance implied by the ML fit | about 73.8 |
| Correlation of estimates, $(\log\mu,\log k)$ | 0.00006 |
| Wald intervals (log scale, back-transformed): $\mu$; $k$ | 3.45 to 6.55; 0.237 to 0.453 |
| Profile intervals: $\mu$; $k$ | 3.49 to 6.68; 0.235 to 0.451 |
| Slice for $\mu$ at $\hat k$, within 1.92 | 3.50 to 6.66 |
| Approximate SE of $\mu$; Chapter 3 practical SE and interval | 0.78; 0.59, 3.60 to 5.91 |
| `size` and `prob` estimates | 0.327; 0.0644 |
| Correlation of estimates, $(\log k,\operatorname{logit}p)$ | 0.71 |
| $k$ in $(k,p)$: slice at $\hat p$; profile | 0.258 to 0.407; 0.235 to 0.451 |
| AIC: Poisson; Negative Binomial | 1270.3; 602.9 |

**Simulations from the owl model ($\mu=4.75$, $k=0.33$; 2,000 experiments)**

| Visits | Mean of $\hat k$ | Skewness | Coverage Wald (log) | Coverage profile |
|---:|---:|---:|---:|---:|
| 20 | 0.398 | 1.9 | 0.942 | 0.936 |
| 50 | 0.357 | 0.9 | 0.944 | 0.943 |
| 122 | 0.339 | 0.4 | 0.957 | 0.956 |
| 500 | 0.332 | 0.2 | 0.952 | 0.950 |

ML against method of moments for $k$: 20 visits, SD 0.19 against 0.27 and MSE 0.040
against 0.107; 122 visits, SD 0.054 against 0.086 and MSE 0.0029 against 0.0084. No fit
failed. Time: 6 seconds for 2,000 fits of 122 visits, 21 seconds for 500 visits.

**Poisson coverage (5,000 experiments; Wald on the original scale against likelihood)**

| $\lambda$ | Quadrats | Wald | Likelihood |
|---:|---:|---:|---:|
| 4 | 30 | 0.945 | 0.946 |
| 1 | 5 | 0.873 | 0.930 |
| 0.5 | 10 | 0.869 | 0.927 |
| 0.3 | 10 | 0.792 | 0.916 |

**Reed frogs (24 tanks with predators), Binomial**

| Quantity | Value |
|---|---|
| Survivors; tadpoles; MLE | 264; 560; 0.4714 |
| Log-likelihood | $-98.94$ |
| SE on the logit scale; on the original scale | 0.085; 0.0211 |
| Wald interval (logit, back-transformed); likelihood interval | 0.430 to 0.513; 0.430 to 0.513 |
| First three tanks (4, 9, 7 of 10): likelihood at 0.5 and 2/3 | $2.35\times10^{-4}$; $1.28\times10^{-3}$ |
| Same, log-likelihood | $-8.357$; $-6.658$ |
| Variance of survivors against Binomial variance, density 10; 25; 35 | 3.71, 2.49; 24.84, 6.23; 64.27, 8.72 |

**Glacier lily seedlings (256 quadrats)**

| Quantity | Value |
|---|---|
| Mean; variance with divisor $n$; fraction of zeros; maximum | 3.96; 54.35; 0.496; 72 |
| Method of moments $k$; MLE of $k$ | 0.311; 0.262 |
| NLL: Poisson; zero-inflated Poisson; Negative Binomial | 1364.9; 848.0; 564.2 |
| Zero-inflated Poisson estimates: $\lambda$; `pzero` | 7.85; 0.496 |
| AIC: Poisson; zero-inflated Poisson; Negative Binomial | 2731.8; 1700.0; 1132.4 |
| $P(X=0)$: Poisson; ZIP; NB | 0.019; 0.496; 0.483 |
| $P(X\ge20)$: observed; ZIP; NB | 0.039; 0.0001; 0.049 |

**Black cherry volume (31 trees), Gamma**

| Quantity | Value |
|---|---|
| Shape; rate; mean | 3.886; 0.1288 per ft³; 30.17 ft³ |
| NLL; method of moments shape | 125.73; 3.48 |
| Correlation of estimates (log scales) | 0.94 |
| Shape: Wald (log scale); profile; slice at $\hat r$ | 2.41 to 6.27; 2.32 to 6.06; 3.26 to 4.56 |
| Plug-in simulation (1,000): ML mean, SD; MoM mean, SD | 4.26, 1.09; 4.37, 1.22 |
| Coverage: Wald (log); profile | 0.931; 0.944 |

**Adelie body mass (151 penguins after removing one missing value), Gamma**

| Quantity | Value |
|---|---|
| Shape; rate per g; rate per kg | 66.09; 0.01786; 17.86 |
| NLL in g: Gamma; LogNormal | 1137.72; 1137.48 |
| NLL in kg: Gamma; LogNormal | 94.65; 94.41 |
| $151\log(1000)$ | 1043.07 |
| Correlation of estimates (log scales) | 0.996 |
| Shape: Wald (log scale); profile | 52.8 to 82.8; 52.3 to 82.1 |
| Plug-in simulation (1,000): relative bias; skewness; coverage Wald, profile | 1.9%; 0.35; 0.951, 0.953 |

The simulation of 1,000 experiments with profile checks took 3 to 4 seconds.

## Appendix B: attributions and sources to verify

Check each of these against a primary source or an authoritative history before writing
the footnote. Do not invent page numbers or quotations. If one cannot be verified, write
the footnote without the uncertain detail and list it in the report. Two histories cover
most of them: Aldrich (1997), "R. A. Fisher and the making of maximum likelihood
1912–1922", *Statistical Science*; and Stigler (2007), "The epic story of maximum
likelihood", *Statistical Science*.

### B.1 Historical attributions

The candidates come from the planner's memory and have not been checked. Phase 1 of
section 12 fills in the last three columns.

| Footnote | Candidate attribution | Status | Reference | Supports |
|---|---|---|---|---|
| Origin of likelihood | Fisher: first paper in 1912; the word "likelihood" in 1921; "On the mathematical foundations of theoretical statistics", 1922. Earlier related ideas: Lambert, Daniel Bernoulli, Gauss. | verified, with refinements (checked against Aldrich 1997 and Stigler 2007, both read in full text) | Fisher, R. A. (1912). On an absolute criterion for fitting frequency curves. *Messenger of Mathematics* 41: 155–160. Fisher, R. A. (1921). On the "probable error" of a coefficient of correlation deduced from a small sample. *Metron* 1: 3–32. Fisher, R. A. (1922). On the mathematical foundations of theoretical statistics. *Philosophical Transactions of the Royal Society of London A* 222: 309–368. Aldrich, J. (1997). R. A. Fisher and the making of maximum likelihood 1912–1922. *Statistical Science* 12(3): 162–176. Stigler, S. M. (2007). The epic story of maximum likelihood. *Statistical Science* 22(4): 598–620. | Fisher published the 1912 paper as a third-year undergraduate (Aldrich, p. 162). That paper presents an "absolute criterion" and does not use the word likelihood. The word likelihood, set against probability, comes from the 1921 paper (Aldrich, section 9). The name "maximum likelihood" first appears in the 1922 paper (p. 323), which also develops its sampling properties, sufficiency and efficiency (Aldrich, section 13). Earlier forms of the idea (Stigler 2007): Lambert 1760 made early remarks; Daniel Bernoulli (1769, 1778) multiplied densities and maximised the product; Gauss (1809) took the posterior mode under a uniform prior, which gives least squares for Normal errors. Stigler notes that none of these had a reasoned defence of the method. Write "anticipated", not "introduced"; do not say that the 1912 paper used the word likelihood. Aldrich also credits Edgeworth (1908) with anticipating much of the 1922 theory (after Pratt 1976); optional. |
| Asymptotic normality, information | Fisher 1922 and 1925 ("Theory of statistical estimation"); rigorous treatment in Cramér, *Mathematical Methods of Statistics*, 1946. | corrected (additions: Wald 1943; Fisher's arguments were not rigorous) | Fisher, R. A. (1925). Theory of statistical estimation. *Proceedings of the Cambridge Philosophical Society* 22: 700–725. Cramér, H. (1946). *Mathematical Methods of Statistics*. Princeton University Press. Wald, A. (1943). Tests of statistical hypotheses concerning several parameters when the number of observations is large. *Transactions of the American Mathematical Society* 54: 426–482. Aldrich (1997); Stigler (2007). | Fisher (1922) used the large-sample standard error of the maximum likelihood estimator to compare estimation methods (Aldrich, section 13), and the 1925 paper developed the information and an argument for the lower bound 1/I (Stigler). Stigler states that Fisher's proofs were not rigorous, that Hotelling's 1930 proof of consistency and asymptotic normality does not hold at the generality claimed, and that the treatments of Wald (1943) and Cramér (1946) were the most satisfactory; Cramér followed the structure of Fisher's work with explicit conditions. Phase 4 may write: stated by Fisher, made rigorous by Wald and by Cramér. Do not credit Cramér alone, and do not say that Fisher proved it. I did not read Cramér's book; its role rests on Stigler. |
| Consistency | Wald 1949, "Note on the consistency of the maximum likelihood estimate". | verified (citation from the Project Euclid record; content from a course handout and Stigler) | Wald, A. (1949). Note on the consistency of the maximum likelihood estimate. *Annals of Mathematical Statistics* 20(4): 595–601. doi:10.1214/aoms/1177729952. Wellner, J. A. (2001). Statistics 581, revision of section 4.4 (handout; Theorem 3 after Wald 1949, adapted from Ferguson 1996, *A Course in Large Sample Theory*). Stigler (2007). | Wald (1949) proves that maximum likelihood estimates of i.i.d. observations are consistent (almost surely) under conditions that include a compact parameter space (Wellner handout, Theorem 3). Stigler lists Doob (1934, 1936), Wald (1943, 1949) and Cramér (1946) as the first rigorous efforts and says Doob and Dugué made errors. Write "proved rigorously under regularity conditions by Wald (1949) and others"; do not say that Wald was first. Warning: the Project Euclid address euclid.aoms/1177730288 returned by a search is Wald (1948), a different paper on dependent observations (*Annals of Mathematical Statistics* 19(1): 40–46); do not cite that one. |
| Cramér–Rao bound | Rao 1945; Cramér 1946; also found independently by Fréchet and Darmois. | corrected (adds Fisher's asymptotic version of 1925; Fréchet and Darmois references found only in secondary listings) | Rao, C. R. (1945). Information and accuracy attainable in the estimation of statistical parameters. *Bulletin of the Calcutta Mathematical Society* 37(3): 81–91. Cramér (1946), as above. Fréchet, M. (1943). Sur l'extension de certaines évaluations statistiques au cas de petits échantillons. *Revue de l'Institut International de Statistique* 11: 182–205. Darmois, G. (1945). Sur les limites de la dispersion de certaines estimations. *Revue de l'Institut International de Statistique* 13: 9–15. Stigler (2007). | Rao (1945) is verified from the repository record (volume, issue, pages). Fréchet (1943) and Darmois (1945) were found only in search listings and secondary summaries (not opened). All four are consistently described as independent derivations in the 1940s. Stigler shows that Fisher (1925) had already derived the lower bound 1/I for the asymptotic variance of estimators in a class, so the finite-sample bound for unbiased estimators carries the names of Cramér and Rao but the idea has precursors. Stigler also mentions the superefficient estimator of Hodges (1951), which is why "regular" estimators must be named in the efficiency statement. Phase 4 may write: derived independently in the 1940s by Fréchet, Darmois, Rao and Cramér. |
| Observed against expected information | Efron and Hinkley 1978. | verified (citation only; content not read) | Efron, B. and Hinkley, D. V. (1978). Assessing the accuracy of the maximum likelihood estimator: observed versus expected Fisher information. *Biometrika* 65(3): 457–483 (the publisher's listing; Stigler's bibliography gives 457–482). doi:10.1093/biomet/65.3.457. | The paper exists and is the standard reference for comparing the two. Search summaries say that it argues, with many examples, that the observed information is the better estimate of the variance of the estimator (in the cases it treats); the text was not read. Phase 4 may write only: Efron and Hinkley (1978) compared observed and expected information and argued for the observed information. Omit page numbers in the footnote. Stigler also names it among later discussions of Fisher's 1925 paper. |
| Invariance | Zehna 1966 for the general statement. | verified (citation only; the note itself was not read) | Zehna, P. W. (1966). Invariance of maximum likelihood estimators. *Annals of Mathematical Statistics* 37(3): 744. doi:10.1214/aoms/1177699475. | A one-page note. Secondary sources (a statistics blog, and textbook citations seen in search results, including a mention of Casella and Berger) cite it for the invariance property for functions of the parameter that are not necessarily one-to-one. Phase 4 may write: "see Zehna (1966) for the general statement". Do not write that Zehna was the first to state invariance, and do not describe the class of functions more precisely (one source says continuous, which I could not confirm). |
| Wald interval | Wald 1943. | corrected (the 1943 paper is about tests, not intervals) | Wald (1943), as above. Read: title page, contents and pp. 426–427 of the scanned paper. | Wald (1943) develops large-sample tests for hypotheses about several parameters, based on the maximum likelihood estimates and their approximate Normal distribution; its first pages use the critical region of the form (n^(1/2) times the distance between the estimate and the hypothesised value) greater than or equal to a constant. The paper does not mention an interval in the pages read. The interval is the one obtained by inverting that test; phase 4 may say "named after Abraham Wald, who developed the large-sample test on which it is based (1943)". Do not say that Wald proposed the interval. The contents also list a section "Large sample distribution of the likelihood ratio" (pp. 478–481), unread. |
| Wilks' theorem | Wilks 1938. | verified (citation only; the paper was not accessible) | Wilks, S. S. (1938). The large-sample distribution of the likelihood ratio for testing composite hypotheses. *Annals of Mathematical Statistics* 9(1): 60–62. doi:10.1214/aoms/1177732360. | Title, journal, pages and year are confirmed from the Project Euclid record. Search summaries describe it as a short proof that, for a composite hypothesis that fixes m of h parameters, minus twice the log likelihood ratio is asymptotically chi-squared with degrees of freedom equal to the difference in dimension. I could not read the paper or a textbook statement; the statement is standard but unchecked here. The footnote can say "Wilks (1938)" and the plan's wording of the theorem; the result concerns the likelihood ratio statistic, so say that the profile interval follows from it, without attributing the interval to Wilks. Mention interior-of-parameter-space and nested hypotheses only in the regularity-conditions footnote. |
| Kullback–Leibler divergence | Kullback and Leibler 1951. | verified (citation; name confirmed in Akaike 1973, which was read) | Kullback, S. and Leibler, R. A. (1951). On information and sufficiency. *Annals of Mathematical Statistics* 22(1): 79–86. (Akaike's reference list misprints the volume as 12.) | Akaike (1973), which was read, calls the expectation of the log density ratio "Kullback–Leibler's mean information for discrimination" and cites this paper. Write that Kullback and Leibler (1951) introduced this measure of "information for discrimination" and that it is now called the Kullback–Leibler divergence. Do not write that they called it divergence, and do not describe the original notation. The text of the paper was not accessible. |
| MLE under misspecification | White 1982, "Maximum likelihood estimation of misspecified models"; earlier Huber 1967. | verified (citations only; the KL statement rests on secondary summaries) | White, H. (1982). Maximum likelihood estimation of misspecified models. *Econometrica* 50(1): 1–25 (the publisher lists 1–26; a corrigendum appeared in 1983, details not checked). Huber, P. J. (1967). The behavior of maximum likelihood estimates under nonstandard conditions. *Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability*, vol. 1: 221–233. University of California Press. | White's abstract (publisher): the quasi-maximum likelihood estimator converges to a well-defined limit, and may or may not be consistent for the parameters of interest; ordinary standard errors and tests are invalid under misspecification and robust versions are given. The statement that the limit minimises the Kullback–Leibler divergence comes from search summaries of the literature, not from a text I read. Phase 4 may write: "White (1982) studies this; Huber (1967) is an earlier treatment", and state the Kullback–Leibler result in the main text as the standard result, without page or theorem numbers. Omit page numbers in footnotes. |
| AIC | Akaike 1973 (symposium paper) and 1974 ("A new look at the statistical model identification"). | verified (the 1973 paper was read in full text; the 1974 record was read, not the paper) | Akaike, H. (1973). Information theory and an extension of the maximum likelihood principle. In Petrov, B. N. and Csáki, F. (eds), *Second International Symposium on Information Theory*, pp. 267–281. Akadémiai Kiadó, Budapest. Akaike, H. (1974). A new look at the statistical model identification. *IEEE Transactions on Automatic Control* 19(6): 716–723. | Akaike (1973) adopts the Kullback–Leibler information between the estimated and the true distribution as the loss of an estimate, and derives a selection criterion equal to minus two times the maximised log-likelihood plus twice the number of parameters (equation 4.21, as an estimate of the expected loss). The 1974 paper (title, journal, volume, pages confirmed from IEEE Xplore and a memorial page; abstract seen only through search snippets) defines AIC with the same formula. I did not confirm whether the name "AIC" occurs in the 1973 paper. Phase 4 may cite both papers for the origin; the reading "2K corrects for fitting and evaluating on the same data" is the standard interpretation of the penalty, not Akaike's wording, so state it as ours. |

### B.2 Data provenance

As stated in the package documentation read during planning. Not part of phase 1; phase 3
adds what it finds in the help pages.

| Data | Documentation says |
|---|---|
| `glmmTMB::Owls` | Roulin and Bersier (2007), *Animal Behaviour* 74: 1099–1106. Use the description approved in the Chapter 3 practical. |
| `emdbook::ReedfrogPred` | Laboratory experiments on predation of the African reed frog *Hyperolius spinigularis*; `density` is the initial number of tadpoles in a 1.2 × 0.8 × 0.4 m tank. Vonesh and Bolker (2005), *Ecology* 86: 1580–1591. |
| `emdbook::Lily_sum` | Quadrats of the glacier lily *Erythronium grandiflorum*, from Thomson et al. 1996; a 16 × 16 grid of 2 × 2 m quadrats in Washington Gulch, sampled in 1992. |
| `datasets::trees` | Use the description approved in the Chapter 3 practical (31 felled black cherry trees; `Volume` in cubic feet). |
| `datasets::penguins` | Adult penguins of three species near Palmer Station, Antarctica; `body_mass` in grams. Read `?penguins` for the sources to credit. |
