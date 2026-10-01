# Course style guide

## Basis and scope

This guide is derived from the completed Chapter 1 practical and Chapter 2 theory
and practical. Chapters 3–5 provide provisional continuity of topics. It governs
new and revised material, without requiring a wholesale rewrite of existing pages.

Explicit conventions, such as `=` for R assignment, are retained. Where existing
files differ, the defaults below are editorial choices for consistency: sentence
case headings, British English, dollar-delimited mathematics, and modern Quarto
chunk options. These choices do not imply that the existing files already follow
them uniformly.

## PRIORITY: transform material into the author's voice

**This section takes priority over the other prose-style preferences in this
guide.** When revising material that predates the author's new Chapter 1 voice,
do more than correct wording or make it more concise. Recast it so that it sounds
like an ecologist speaking candidly to students about the gap between ecological
questions, field data, and conventional statistics. Preserve the scientific claim,
the course sequence, and any necessary qualification; change the route by which
the reader reaches the idea.

The intended voice is personal, direct, curious, and sometimes lightly
provocative. It is not a neutral institutional textbook voice. The author is a
teacher and fellow ecologist, not an all-knowing authority: the text can share
the motivation for the book, acknowledge live debates, and say where a method is
useful without pretending that it solves every problem. Technical precision,
fairness to other approaches, and careful copy editing remain non-negotiable.
Informal language must never become a reason to make a false, unsupported, or
overstated statistical claim.

### What should change in a revision

Use the following contrasts as an editing target. They describe a change in
emphasis and structure, not an instruction to reproduce particular phrases.

- **Old:** begin with an abstract course description or a finished conclusion.
  **New:** begin with a recognisable ecological tension, question, or frustration,
  then show why the chapter's idea helps. For example, connect an elegant model
  learned in class to the messy, unbalanced, non-Normal data that fieldwork often
  produces.
- **Old:** present modelling and statistics as a tidy, predefined sequence of
  tools. **New:** explain why students need to bring the two together: ecological
  theory supplies interpretable relationships, while statistical machinery lets
  us confront those relationships with variable observations.
- **Old:** use detached phrasing such as "this course introduces" or "an analysis
  should". **New:** speak to the reader and reason alongside them: use **you** for
  their questions and actions, **we** for shared reasoning, and occasional **I**
  where the author's experience or judgement genuinely helps orient the reader.
- **Old:** state that a method has limitations in general terms. **New:** name the
  practical consequence. Explain, for instance, why a balanced factorial design,
  a straight-line response, or a zero-effect question may fail to express the
  ecological question or the way the data arose.
- **Old:** contrast methods only at the level of technical labels. **New:** put
  competing questions side by side. Replace a binary question such as "Does
  temperature affect development?" with an estimable ecological question about
  the rate of change, a thermal optimum, effect size, or biological consequence.
- **Old:** hide uncertainty behind polished, impersonal claims. **New:** say what
  is debated, conditional, approximate, or outside the book's scope. Explain the
  practical choice the book makes and why, rather than treating it as inevitable.
- **Old:** avoid any authorial position in the name of neutrality. **New:** allow
  a clear position--explicit probability models and ecologically interpretable
  parameters are more useful than reducing every question to a p-value--while
  recognising that linear, generalised linear, mixed  models remain
  useful in some circumstances.
- **Old:** use an ecological example merely to illustrate a definition. **New:**
  make the example do argumentative work: it should show what an ecologist wants
  to know, what the observation process complicates, and how the model can give a
  more informative answer.

### How to write in this voice

- Let motivation come before formalism. Open a section by identifying what a
  student might be trying to understand, where the familiar approach becomes
  unsatisfying, and what the new idea makes possible. Then define terms, state
  assumptions, introduce equations, and show code.
- Use conversational transitions and well-placed questions: "So what do we do
  then?", "The important point is...", or "Do not confuse...". Use them to move
  the argument forward, not as decoration. Vary sentence length so a dense idea
  can be followed by a short, clear conclusion.
- Make the author visible where it has teaching value. A short first-person
  reflection, a disciplinary observation, or an admission that a concept is
  genuinely subtle can make the explanation more trustworthy. Do not manufacture
  personal anecdotes, opinions, reading history, or experiences on the author's
  behalf.
- Prefer concrete ecological language over generic statistical slogans. Name the
  organism, driver, response, measurement difficulty, and consequence when they
  clarify the point. Show how a parameter answers an ecological question rather
  than calling it merely "meaningful" or "important".
- Use lightly informal, vivid wording to make a difficult idea memorable, but
  keep it deliberate and sparse. A phrase such as "messy field data" can help;
  a stream of jokes, rhetorical questions, or slang makes the explanation feel
  less trustworthy.
- Treat standard statistics as limited defaults, not villains. Explain why
  p-values, significance tests, linear responses, Normal models, and formula
  interfaces can be inadequate for a particular question. Do not imply that they
  are universally wrong, obsolete, or incapable of modelling nonlinearity,
  grouping, or uncertainty.
- Explain statistical debates pragmatically. When discussing frequentist and
  Bayesian ideas, probability interpretations, or model selection, identify the
  practical decision made in this book and its limits. Do not turn an introductory
  chapter into a philosophical survey or make unsupported claims about what an
  entire research community believes.
- Keep the ecology, probability model, data-generating process, and inference
  connected. The voice should make the course feel more grounded, not replace a
  definition, assumption, derivation, or interpretation that students need.

### Revision workflow and final check

When transforming an existing passage, first identify its scientific job: the
question it answers, the prerequisite ideas, the claims that require
qualification, and the examples or equations that must remain consistent with
the surrounding chapter. Rewrite the passage around the reader's problem and
the ecological stakes. Only then tighten the prose, correct grammar, and apply
the conventions elsewhere in this guide.

Before finishing, ask:

1. Does the opening give a student a reason to care before it becomes technical?
2. Does the passage sound like a thoughtful ecologist speaking to students, rather
   than a generic course catalogue or a research-paper introduction?
3. Does it make a concrete connection between the ecological question, the data,
   and the model or parameter?
4. Does it replace a purely binary or method-centred framing with a quantitative,
   ecologically relevant question where appropriate?
5. Are informal turns of phrase serving the explanation rather than obscuring it?
6. Have all personal claims, historical claims, quotations, links, and
   disciplinary generalisations been retained only when supplied or verified?
7. Have grammar, spelling, terminology, mathematical notation, and statistical
   qualifications been checked independently of the voice transformation?

## Voice and vocabulary

- Address students as **you** for actions and use **we** for shared reasoning:
  “We can compare the sample variance with the mean.”
- Use plain, conversational English. Contractions and questions are appropriate
  when they help a student follow the reasoning. Avoid impersonal research-paper
  prose and unexplained technical shorthand.
- Give each paragraph one main idea. Keep related sentences together; avoid
  turning every sentence into its own paragraph or every paragraph into a list.
- Explain a technical term at first use, preferably through an ecological example.
  Expand abbreviations such as maximum likelihood estimation (MLE) and independent
  and identically distributed (i.i.d.) before using them alone.
- Prefer concrete verbs: calculate, simulate, plot, compare, estimate, explain.
  Avoid promotional filler such as “unlock”, “leverage”, “delve into”, “powerful
  tool”, and “it is important to note that”. State the actual point.
- Avoid “obviously”, “trivially”, and “simply” when they dismiss a step a beginner
  may find difficult. Do not label a model “best” without specifying the criterion.
- Use British English for new prose: modelling, behaviour, parameterisation,
  summarise. Preserve R identifiers, quoted text, official titles, and dataset
  names exactly, including `summarize()` if that is the function being discussed.
- Write binomial, negative binomial, normal, lognormal, and beta in lower case in
  running prose; retain Poisson as a proper name. Preserve existing document titles
  unless their revision is part of the task.
- Write function names as code, usually with parentheses: `var()`, `optim()`.
  Write R and RStudio as ordinary proper names; put object and argument names in
  backticks, such as `seed_count`, `mu`, and `lower.tail`.

## Explanations and chapter structure

Start every chapter with a section headed `# Introduction`. Its first sentence
must begin exactly with **“In this chapter, we learn how to...”** and should
state the chapter's main ecological or statistical purpose before connecting it
to earlier material. Follow it with a section headed `# Learning goals`. List
goals as actions students will be able to perform, in the same order as the
ideas appear in the chapter. The goals should cover the chapter's actual
content rather than promising material introduced later. Avoid imposing a fixed
length or a fixed number of goals.

Introduce the general concept before applying it to a concrete example. Explain
what the concept means and why it matters, then use an ecological setting to show
how it works. Do not open a section or subsection with a specific field scenario
and expect students to infer the general principle from it. Once introduced, reuse
an example where it helps connect related concepts.

A useful explanation sequence is:

1. State the general concept and the question it helps answer.
2. Introduce an ecological setting and identify the observational unit.
3. Define the random variable, its possible values, and model assumptions.
4. Introduce the relevant equation and explain each new symbol.
5. Translate the calculation into short R code.
6. Interpret the result in ecological terms, including units and limitations.

Reuse an example while developing a concept: seeds within quadrats, seedling
survival, wildlife detections, or insect counts. Tree heights, body mass, and
vegetation cover are useful continuations in the later drafts. State whether data
are simulated, built in, or supplied in a file. Do not present simulation as field
evidence or invent the provenance of a dataset.

Use different datasets for a chapter's theory example and its practical
exercises. A dataset from an earlier chapter may return in a later chapter
when the new analysis answers a different question; explain that connection.

For a distribution, describe its support, parameters, ecological interpretation,
mean and variance, and R functions. Where relevant, connect the four faces in the
Chapter 2 order: probability mass or density, cumulative probability, quantiles,
and sampling. Explain useful parameter conversions rather than merely listing
formulas. Put optional detail in a short footnote or a linked supplement.

Use summaries when they consolidate learning; do not repeat the entire chapter.
Keep cross-chapter promises specific and check the destination. For example,
method of moments currently belongs to Chapter 4, despite a Chapter 3 reference
in the Chapter 5 draft.

## Statistical language and notation

| Concept | Required distinction |
|---|---|
| Random variable and observation | Use $X$ or $X_i$ for random variables and $x$ or $x_i$ for possible or observed values. |
| Parameter, estimator, estimate | A parameter describes the model; an estimator is a rule applied to random data; an estimate is its value for observed data. Define hats such as $\hat\lambda$. |
| Mass and density | Discrete values have probability mass. Continuous densities give probabilities through integration over intervals; a density value is not a point probability and may exceed one. |
| Probability and likelihood | Probability varies possible data for fixed parameters. Likelihood varies parameters for the observed data and is not a probability distribution over parameters. |
| Empirical variance and `var()` | `mean((x - mean(x))^2)` uses divisor $n$. `var(x)` uses $n-1$. State which quantity an exercise requests. |
| Standard deviation and standard error | The first describes variation in observations; the second describes variation in an estimator across samples. |
| Overdispersion | Variation exceeds that expected under a specified reference model. A variance-to-mean ratio is exploratory and does not identify the ecological cause. |
| Confidence interval | Explain repeated-sampling coverage. Do not assign a frequentist probability to a fixed parameter lying in an already calculated interval. |
| Independence | State it as a model assumption. Separate locations or observations do not by themselves establish independence. |

Use $E[X]$, $\operatorname{Var}(X)$, and
$X \sim \operatorname{Poisson}(\lambda)$ consistently. Define sample size separately
from binomial trial count when both occur. For the negative binomial, use mean
$\mu$ and shape $k$ with $\operatorname{Var}(X)=\mu+\mu^2/k$, mapped to R's `mu`
and `size`. Explain any alternative parameterisation explicitly. For a normal
model written with variance $\sigma^2$, R's `sd` argument takes $\sigma$.
Use $\sigma^2$ for variance parameters, with descriptive subscripts when a
model has several variance components, such as $\sigma^2_{\mathrm{group}}$
and $\sigma^2_{\mathrm{obs}}$. Describe and parameterise these components
as variances, not precisions; do not use $\tau^2$ for a group variance.
When a density function or fitting code uses a standard deviation
$\sigma$, explain that its square is the corresponding model variance.

Use “approximately” for rounded results and asymptotic approximations. Describe
simulation summaries as varying across samples. Do not promise monotonic
improvement in every realised sample as sample size increases. State the
conditions behind general claims about estimator performance.

## Markdown and Quarto

- Use ATX headings (`#`, `##`, `###`) in sentence case. Do not skip levels.
  Let Quarto number sections; retain meaningful exercise numbers and numbered
  sequences such as the four faces of a distribution.
- Leave blank lines around paragraphs, lists, code blocks, equations, and divs.
  Keep ordinary lists out of four-space indentation, which creates code blocks.
- Use bold for a new term or a short point of emphasis, and italics sparingly.
  Prefer semantic callouts over new inline colours or HTML styling.
- Use `$...$` for inline mathematics and `$$` on separate lines for display
  equations. Use `aligned` for a derivation with several steps. Explain symbols
  in prose; equations are part of the surrounding sentences.
- Use relative `.qmd` links, for example
  `[Chapter 5](../Chapter_5/Theory.qmd)`. Match actual filename case, including
  `solution.qmd`, even when the local filesystem accepts different casing.
- Preserve existing section IDs. Add descriptive `sec-` IDs where a section needs
  a reference, and refer to it with `@sec-name`. Do not invent destination IDs.
- Use tables for genuine comparisons and parameter mappings, with units in column
  labels where applicable. Use numbered lists for exercise tasks and procedures.
- Save text as UTF-8. Aim for readable source lines of roughly 80–100 characters;
  do not break links or code just to meet a line-width target.

Typical theory metadata follows Chapter 2:

```yaml
---
title: "Descriptive chapter title"
format:
  html:
    toc: true
    number-sections: true
execute:
  echo: true
  warning: false
  message: false
  eval: false
---
```

Preserve the target page's settings rather than applying this template blindly.
Practicals also use `date: today`; Chapter 1's material uses the installed
`wordcount-html` extension. Do not remove that setup as an incidental cleanup.

Always use executable Quarto R chunks, written as ```` ```{r}```` rather than
display-only ```` ```r```` blocks. This applies to code examples that students
run themselves as well as code that the document evaluates. When code should be
shown but not run during rendering, keep the executable chunk and set
`#| eval: false` (or disable evaluation globally with `execute: eval: false`).
Use chunk options on `#|` lines. Theory pages usually disable evaluation globally
and enable it for selected figures:

````markdown
```{r}
#| echo: false
#| eval: true
#| fig-cap: "Poisson probability mass for an expected count of three."
count_values = 0:12
plot(count_values, dpois(count_values, lambda = 3), type = "h",
     xlab = "Number of seedlings", ylab = "Probability")
```
````

An evaluated chunk must define its inputs itself or use an earlier evaluated
setup chunk. It cannot rely on a preceding example with `eval: false`. Hide plot
construction when it distracts from the concept; show it when plotting is the
learning objective. Avoid filling practical pages with precomputed output that
students are meant to generate and interpret themselves.

Use notes for definitions and warnings for specific misconceptions:

```markdown
::: {.callout-note title="Probability mass"}
The probability mass function assigns a probability to each possible count.
:::
```

## Exercises and solution patterns

Give a concrete setting, any necessary data or assumptions, and numbered tasks.
Progress from calculation to interpretation. Hints can refer to a previously
taught tool without giving away the answer. Worked solutions should include the
reasoning, executable code, and an answer in the terms of the question.

Chapter 1 is the only shared practical: put its content in `material.qmd` and
retain the wrapper's metadata chunk calling
`quarto::write_yaml_metadata_block(show_solution = TRUE)` for `solution.qmd`
and `FALSE` for `no_solution.qmd`, followed by
`{{< include material.qmd >}}`. From Chapter 2 onward, keep each practical
self-contained: `solution.qmd` and `no_solution.qmd` should each contain their
relevant text and code. Nested exercises and solutions follow Chapter 1:

````markdown
:::::: {.callout-important title="Exercise" collapse="true"}

1. Calculate the expected number of surviving seedlings.
2. Explain what the expected value represents.

::::: {.content-hidden unless-meta="show_solution"}
:::: {.callout-tip title="Solution" collapse="true"}

For 25 seedlings with survival probability 0.65, the expected count is:

```{r}
expected_survivors = 25 * 0.65
```

The value 16.25 is the average across repeated groups, not a possible count in
one group.

::::
:::::
::::::
````

Keep fence lengths matched and nesting intact. Collapsing a solution alone does
not hide it from the student version; retain the conditional div. In Chapter 2's
separate files, retain `# Exercise N: Topic` and `## Solution` as appropriate.
The first exercise on its student page currently includes a worked solution. Do not
assume every `no_solution.qmd` must contain no explanatory answers at all.

## R coding patterns

- Always use `=` for assignment in existing and new course code, including function
  definitions. This is an explicit author requirement. Use spaces around binary
  operators and after commas, two spaces for indentation, and double-quoted strings.
- Prefer beginner-friendly literals in teaching examples. Use `NA` for a missing
  value and ordinary numeric literals such as `2` rather than `NA_real_`,
  `NA_integer_`, or `2L`. Use a typed literal only when the distinction is part
  of the lesson or is needed to demonstrate a specific programming issue.
- Prefer short, meaningful `snake_case` names. Mathematical names such as `x`, `mu`,
  and `k` are appropriate when their meaning has just been defined. Avoid extremely
  long names that make the statistical calculation difficult to read.
- Name distribution arguments explicitly: `dbinom(x = 15, size = 25, prob = 0.65)`.
  Separate long calls over several lines. Use `TRUE` and `FALSE`, not `T` and `F`.
- Default to `ggplot2` for new author-generated, rendered figures that show data,
  fitted models, or uncertainty; follow the figure style below. Base R remains
  appropriate for compact probability, simulation, and numerical examples when its
  simpler code helps teach the point. Students may use either base R or `ggplot2`
  unless an exercise explicitly teaches one system. Use `package::function()` or
  load the package explicitly. Explain any newly introduced dependency; do not
  introduce a framework for a small example.
- Do not use pipe operators (`|>` or `%>%`) in course code. Functions from packages
  such as `dplyr` remain appropriate; call them directly, nesting calls when clear or
  assigning intermediate results to named objects. Prefer transparent steps over
  long nested expressions. For example, assign the result of `group_by()` to an
  object, then pass that object to `summarise()`.
- Set a seed before each reproducible simulation example or batch of repetitions.
  Do not reset the same seed inside every repetition when independent simulated
  samples are intended. Explicitly varied seeds are appropriate for the Chapter 2
  exercise about variation across samples.
- Define objects in teaching order and pass data explicitly to functions. Examples
  must work without objects left in the author's interactive workspace.
- Use project or document-relative data paths consistent with execution context.
  Avoid absolute paths and `setwd()` in teaching examples. Do not silently discard
  missing values; explain any use of `na.rm = TRUE`.
- Add short, useful comments to code chunks, especially when a chunk introduces
  a new R operation, simulation step, loop, or plotting decision. Comments can
  identify inputs, explain the purpose of a group of lines, and point out what
  the output represents. They should help a beginner read the code without
  commenting every obvious line. Put the broader statistical lesson in prose.
  Do not include console prompts in runnable examples; label literal output
  with a `text` fence when output is needed.

For maximum likelihood, show the model and assumptions before the implementation.
Sum log probabilities or densities using `log = TRUE` rather than computing a
product and then taking its logarithm. Name a negative log-likelihood clearly and
explain that `optim()` minimises it by default. For example, after defining
independent Poisson observations:

```r
poisson_nll = function(log_lambda, counts) {
  lambda = exp(log_lambda)
  -sum(dpois(x = counts, lambda = lambda, log = TRUE))
}
```

Explain why a transformation is used and report estimates on the ecological scale.
Discuss starting values, convergence, parameter constraints, and uncertainty when
teaching a complete fit. An optimiser returning a number does not establish model
adequacy. Distinguish a likelihood slice from a profile that refits nuisance
parameters. Introduce these details as their concepts arise, without inserting
advanced optimisation machinery into early probability lessons.

## Figures and numerical interpretation

Give axes descriptive labels and units, and distinguish probability, frequency,
relative frequency, and density. Use bars or vertical lines for discrete mass,
steps for cumulative probabilities, and appropriately scaled histograms when
overlaying continuous densities. Label empirical and theoretical quantities.

### Default style for author-generated figures

Use `ggplot2` as the default for new rendered figures in theory pages and in
practicals after Chapter 1. Apply `theme_classic()` unless a different theme has
a clear teaching purpose. This is a visual convention for author-generated
figures and worked examples, not a restriction on students' plotting choices.
The Chapter 1 practical is the deliberate exception: it teaches and compares both
base R graphics and `ggplot2`, so its examples should continue to use both.

Use a restrained, consistent palette:

- Plot raw observations in Okabe–Ito blue (`#0072B2`), normally with `alpha = 0.7`
  and `size = 2`; use jitter only when overlapping observations would conceal the
  data.
- Use `grey90` fills and `grey40` outlines for empirical bars, histograms, and
  boxplots. Suppress boxplot outliers when the raw observations are already drawn.
- Draw fitted distributions and response curves in Okabe–Ito vermillion (`#D55E00`),
  usually with `linewidth = 0.8`. Use the same vermillion confidence band with
  `alpha = 0.2` when showing uncertainty in a fitted mean response. These colours
  are distinguishable under common red–green colour-vision deficiencies; retain
  different point, line, and fill geometries so figures also work in greyscale.

For a figure that reports a fitted ecological response, show the raw data, fitted
curve, and uncertainty together where this remains legible. State the model and
the meaning of its uncertainty in the caption or surrounding text. When a figure
is intended as a model-reporting example, include a compact inset or accompanying
table giving the model formula, parameter estimates, and confidence intervals.
Transform axes only when this makes the relationship or model easier to interpret;
state the transformation and keep units in the axis labels.

Choose simple, legible figures that answer the question in the text. Use captions
for rendered theory figures and legends for multiple series. Where practical,
distinguish series by line type or symbol as well as colour. Restore graphics
settings after changing them with `par()`.

Retain unrounded values for subsequent calculations and round for presentation.
Check any numerical result quoted in prose against the actual code and seed.
Explain what the result means for the ecological question, and distinguish what
the calculation shows from what the assumed model cannot establish.
