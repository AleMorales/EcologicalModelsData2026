# Course style guide

## Basis and scope

This guide is derived from the material the author has written or rewritten by
hand: `Chapter_1/Theory.qmd`, `Chapter_2/Theory.qmd`, the Chapter 1 practical,
and the Chapter 2 practical. These are the only references for voice. The theory
pages of Chapters 3 to 9 were generated from learning goals and have not been
rewritten by the author, apart from the introduction, learning goals, and a few
cuts in Chapter 3. Use them for topic coverage and continuity, never as a model
of how to write. The guide governs new and revised material, without requiring a
wholesale rewrite of existing pages.

Explicit conventions, such as `=` for R assignment, are retained. Where existing
files differ, the defaults below are editorial choices for consistency: sentence
case headings, British English, dollar-delimited mathematics, and modern Quarto
chunk options. These choices do not imply that the existing files already follow
them uniformly. The author's chapters contain typos and slips of grammar; those
are not part of the voice and should not be imitated.

## PRIORITY: the author's voice and how generated text differs from it

**This section takes priority over the other prose preferences in this guide.**
It comes from comparing the author's Chapters 1 and 2 with the generated
Chapters 3 to 9, and from the edits the author made when rewriting generated
text (the rewrite of Chapter 2 and the first edits to Chapter 3). Scientific
accuracy and the course scope stay mandatory.

An earlier attempt to describe this voice asked for an "ecologist speaking
candidly", openings built on "a recognisable ecological tension", and "lightly
provocative" wording. Applied to Chapters 3 and 4, it produced quips and
slogans that the author then deleted. Do not write to that brief. The author's
voice is plainer than that: a teacher who defines a concept, shows it on one
example, says what it is for in this book, and adds an honest aside when one is
useful.

### What the author's voice is

- **Definition first.** A section opens with the concept, usually in bold in the
  first sentence, and then brings in the example: "A **random variable** is the
  quantity whose value is uncertain before we make that observation. [...] We
  will use a hypothetical experiment on seed survival to illustrate how to model
  ecological count data." The example is announced as an example.
- **A guide through the book.** The author keeps telling the reader what a
  concept is for and where it returns: "We will use quantiles to describe a
  distribution numerically [...] We will also use quantiles to quantify
  parameter uncertainty as confidence intervals (see Chapter 4)." The author
  also says what the course will not use: "We will not use it much in this
  course", with a footnote explaining that cumulative probabilities are the
  basis of p-values. Write these signposts; they replace generic motivation.
- **First person where the author is really speaking.** "I" marks the author's
  own choices and judgement: "I call them the four faces; this is terminology
  that I completely made up", "Below I go over three important examples", "My
  best example of this is...". "We" is for shared reasoning and "you" for what
  the student does. Never invent an anecdote, opinion, or reading history for
  the author. When a passage would need one, write it neutrally and flag it for
  the author to fill in.
- **Connected reasoning in full paragraphs.** Sentences are linked by plain
  connectives: "Note that", "That is,", "In other words", "However,", "So",
  "Also,", "It turns out that", "Now, if". One step leads to the next, and a
  paragraph usually carries a whole argument. Parentheses hold short asides and
  examples, often with "e.g." or "i.e.".
- **Mathematics stated properly, then translated.** The author uses the correct
  term and symbol (countably infinite, product space, weak law of large numbers,
  convergence in probability), gives the equation, and then says what it means:
  "In plain English, as $n$ grows, the chance that the relative frequency
  differs from the model probability by at least $\varepsilon$ becomes small."
  When rewriting generated text the author added rigour of this kind. Do not
  water the mathematics down to sound friendly. Symbols are explained in a
  "where ..." clause directly after the equation.
- **Worked numbers.** A general statement is followed by a small case the
  student can check: a table of joint probabilities filled in with
  $0.4 \times 0.7 = 0.28$, a probability calculated by hand and then "We can
  verify our math with R:". Code is introduced by a short lead-in ending in a
  colon ("In R:", "We can calculate it in R:").
- **Footnotes for asides.** History and sources (Bernoulli 1713), remarks on
  terminology ("In some texts this is called subjective probability, but this
  has an unwarranted pejorative connotation"), technical qualifications, and
  further reading go in footnotes, so the main line of reasoning stays clean.
- **Frank and occasionally dry.** The author says when something is confusing
  or debated and takes a position: "language in applied statistics is often
  used lazily and inconsistently", "those pesky assumptions". This happens a few
  times per chapter and is always about something real. It is not decoration.
- **Model, not truth.** The author writes "model probability", "model
  distribution", and "data generating process", and replaced "theoretical" and
  "population" wording when rewriting. Data are "treated as if they were a
  random sample from the model".
- **Chapter 1 is the exception in register.** The author confirmed this. It is
  a personal introduction to the book, written with more candour: personal
  history, rhetorical questions ("So what is the issue?"), and opinion on
  p-values. From Chapter 2 onward the chapters describe mathematics and
  statistics and take a more formal tone: the same person, but mostly
  definitions, equations, examples, and signposts. Chapter 2 is the register
  to match. Do not carry Chapter 1's candour or level of opinion into the
  technical chapters.

### What generated text does instead

These patterns separate the generated chapters from the author's. Remove them
when revising and do not produce them in new text.

- **Scene-setting hooks before the concept.** "When we put a quadrat in the
  field, we do not know in advance how many of its seeds will survive." "When we
  measure a tree, there is no ecological reason for its height to jump only
  from 22 m to 23 m." The author deleted both and started with the definition.
- **Quips, personification, and slogans.** "measurements that refuse to stay
  neatly in whole numbers", "it is not a prize awarded because data were
  collected in the same way", "neither one gives a model a free pass", "not a
  rubber stamp", "a body-mass column does not come with 'lognormal' written on
  it", "not a magic label". Say the plain thing.
- **"X, not Y" as a reflex.** Generated paragraphs keep ending on a correction
  of a mistake nobody made: "These are assumed population values, not estimates
  from a forest." "It is a model prediction, not the height of a particular
  observed tree." "That is a mathematical convenience, not permission to forget
  how precisely the field measurement was made." State what is true. Keep a
  contrast only where students really do confuse the two things (density and
  probability, standard deviation and standard error), and then explain the
  difference instead of asserting it. The author kept a handful of these in all
  of Chapter 2; treat that as the ceiling.
- **A caveat after every statement.** "does not establish", "does not
  guarantee", "does not, by itself", "is not proof that" appear in almost every
  paragraph of Chapters 5 to 9. One caveat, placed where the risk is, teaches
  more than twenty. Put a recurring misconception in a single warning callout
  and stop repeating it in the prose and again in the quiz.
- **Repeated provenance disclaimers.** "These are simulated observations, not
  field measurements" after each example. State once, where the data are
  introduced, whether they are simulated, built in, or supplied.
- **Leaking the authoring process.** "The author supplied the mapping below",
  "author-supplied leaf identifier", "supplied 2007 PDF", "This verified
  piecewise structure", "outside this chapter's learning goals", "replace these
  labels with physical units when they are available". The reader is a student;
  write what the data are and where they come from, in the author's voice ("In
  the original experiment, each leaf was measured at every light level").
- **Clipped, stacked declaratives.** "A peak shows an estimate. Its width helps
  describe uncertainty." "Independence is an assumption that permits this
  product." Each sentence is correct, but nothing links them and nobody is
  speaking. Rewrite as reasoning with connectives, and say why the step matters.
- **Lists and tables in place of explanation.** Chapter 8 defines fixed effects,
  random effects, mixed-effects, hierarchical, and multilevel models as five
  bullets. The author explains one idea at a time in prose and keeps lists for
  things that are really parallel (the four faces, sources of process error).
- **Imperative and slogan headings.** "Find the maximum", "Add logs rather than
  multiply", "Read the ends of a curve", "What larger samples change". The
  author's headings name the topic: "Joint distributions and independence",
  "Expectations", "Samples and distributions", "A simple diagnostic for
  overdispersion". A question heading is fine now and then ("What do these
  probabilities mean?").
- **Italics for emphasis on ordinary words.** "the *estimated mean*", "its
  *mean*", "that *procedure*". The author rarely does this. Use bold for a new
  term and let the sentence carry the emphasis.
- **Splitting what belongs together.** The generated four faces were four
  numbered subsections, each with its own plot and code. The author merged them
  into one section with one list, one code block, and one composite figure.
  Prefer the integrated treatment when ideas are introduced as a set.
- **Defensive links.** "These conditions also appear in R's AIC documentation."
  The author cites to credit a source, point to a debate, or recommend reading,
  not to back up a routine statement.

### Before and after

The author's own rewrite of the opening of the independence section shows the
change. Generated:

> Independence is one of those assumptions that makes probability calculations
> beautifully neat and ecological data rather awkward. Two random variables are
> **independent** if knowing the value of one does not change the probabilities
> for the other. Consider germination of two planted seeds.

Author:

> Two random variables are said to be **independent** if knowledge about one of
> them does not change the probabilities for the other. Understanding this
> concept requires understanding joint distributions of multiple random
> variables. Let's first illustrate it with a simple example involving two
> binary random variables (for variety, I will use seed germination).

The quip is gone, the definition comes first, the prerequisite is named, and
the example is announced as an example in the first person. The author then
added a joint-probability table with numbers, which the generated text lacked.

### Checklist for a revised or new passage

1. Does the section open with the concept, with the example announced after it?
2. Does it say what the concept is for in this book and where it comes back?
3. Is the mathematics stated correctly and then put in plain words, with a small
   numerical case?
4. Can any "not Y", "does not establish", or "simulated, not field data"
   sentence be deleted without losing a point the student needs?
5. Are there quips, personified data, or slogan-like closing sentences? Remove
   them.
6. Does anything refer to how the text or data were supplied to the writer?
7. Is every "I" a real choice or view of the author, and is nothing invented on
   their behalf?

## Voice and vocabulary

- Address students as **you** for actions and use **we** for shared reasoning:
  “We can compare the sample variance with the mean.” Use **I** only for the
  author's own choices and views, as described in the priority section.
- Use plain, conversational English. Contractions and questions are appropriate
  when they help a student follow the reasoning. Avoid impersonal research-paper
  prose and unexplained technical shorthand.
- Give each paragraph one main idea. Keep related sentences together; avoid
  turning every sentence into its own paragraph or every paragraph into a list.
  Link sentences with plain connectives so the paragraph reads as an argument.
- Say “model probability”, “model distribution”, and “data generating process”
  in preference to “theoretical” or “true” values, except in a simulation where
  the generating parameter is known and that is the point being made.
- Explain a technical term at first use, preferably through an ecological example.
  Expand abbreviations such as maximum likelihood estimation (MLE) and independent
  and identically distributed (i.i.d.) before using them alone.
- Prefer concrete verbs: calculate, simulate, plot, compare, estimate, explain.
  Avoid promotional filler such as “unlock”, “leverage”, “delve into”, “powerful
  tool”, and “it is important to note that”. State the actual point.
- Avoid “obviously”, “trivially”, and “simply” when they dismiss a step a beginner
  may find difficult. Do not label a model “best” without specifying the criterion.
- Use British English throughout: modelling, behaviour, parameterisation,
  summarise, generalise, randomisation, optimisation. This is an author
  decision. The author's own chapters mix British and American spellings, and
  the author has asked for spelling to be corrected, so change American
  spellings to British when editing any page, including Chapters 1 and 2.
  Preserve R identifiers, quoted text, official titles, and dataset names
  exactly, including `summarize()` if that is the function being discussed.
- Capitalise the names of distributions everywhere, in prose, headings,
  captions, and callouts: Binomial, Poisson, Negative Binomial, Normal,
  LogNormal, Beta, Gamma. This is an author decision. Write “the Binomial
  distribution”, “a Negative Binomial model”, “Normal errors”. In a sentence-case
  heading the distribution name keeps its capital: “The Negative Binomial
  distribution”. Words that are not distribution names stay in lower case
  (“distribution”, “model”, “density”). Correct lower-case forms when editing a
  page.
- Write function names as code, usually with parentheses: `var()`, `optim()`.
  Write R and RStudio as ordinary proper names; put object and argument names in
  backticks, such as `seed_count`, `mu`, and `lower.tail`.

## Explanations and chapter structure

Start every chapter with a section headed `# Introduction`. Its first sentence
must begin exactly with **“In this chapter, we learn how to...”** and should
state the chapter's main ecological or statistical purpose before connecting it
to earlier material. Keep the introduction short: one or two paragraphs that
say what the chapter covers, how it differs from the previous one, and which
distributions or examples it uses. Follow it with a section headed
`# Learning goals`, in the format of Chapter 2: the lead-in “In this chapter,
we will cover:”, then a list of short topic phrases ending in semicolons
(“discrete random variables and probability;”, “the assumption of
independence;”), in the same order as the ideas appear in the chapter. Do not
use “After studying this chapter, you should be able to:” with a list of
assessment verbs; the author replaced that format in Chapters 2 and 3. A closing
sentence may name the distributions or tools the chapter practises with and
point to a supplement. The goals should cover the chapter's actual content
rather than promising material introduced later. Avoid imposing a fixed length
or a fixed number of goals.

Use headings that name the topic as a noun phrase (“Expectations”, “Samples
and distributions”, “The Poisson distribution”). Avoid imperative or slogan
headings. Within a distribution section, put the worked case under a subsection
titled `### Example: ...`.

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

The distribution sections of Chapter 2 give the order to follow: when the
distribution is useful and what it assumes; its probability mass or density
function with the symbols explained; its mean and variance as displayed
equations; an `### Example:` subsection that calculates a probability by hand
and then verifies it in R; a figure; and a practice exercise.

After the prose has explained a concept, a short note callout may restate the
definition in one or two sentences for later reference. The callout does not
replace the explanation.

End every theory chapter with a `# Summary` section, placed before
`# Chapter quiz`. This is an author decision; Chapter 2 currently lacks one and
needs it added. A summary consolidates the main ideas in a few short paragraphs
and does not repeat the entire chapter or introduce new material. Keep cross-chapter promises specific and check the destination. For example,
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
from Binomial trial count when both occur. For the Negative Binomial, use mean
$\mu$ and shape $k$ with $\operatorname{Var}(X)=\mu+\mu^2/k$, mapped to R's `mu`
and `size`. Explain any alternative parameterisation explicitly. For a Normal
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

Theory metadata follows Chapters 1 to 3, which contain only a title:

```yaml
---
title: "Descriptive chapter title"
---
```

The table of contents and section numbering are set once in `_quarto.yml`. The
author removed the per-page `format` and `execute` blocks from Chapters 2 and 3;
Chapters 4 to 9 still carry them, including a global `eval: false`. Do not add
those blocks to new pages. When removing them from an existing page, check every
chunk first: without the global setting, chunks are evaluated unless they carry
`#| eval: false`. Chapters 4 to 9 also still contain display-only ```` ```r ````
fences, which the rule below replaces.

Preserve the target page's other settings rather than changing them in passing.
Practicals also use `date: today`; Chapter 1's material uses the installed
`wordcount-html` extension. Do not remove that setup as an incidental cleanup.

Always use executable Quarto R chunks, written as ```` ```{r}```` rather than
display-only ```` ```r```` blocks. This applies to code examples that students
run themselves as well as code that the document evaluates. When code should be
shown but not run during rendering, keep the executable chunk and set
`#| eval: false` (or disable evaluation globally with `execute: eval: false`).
Use chunk options on `#|` lines. A figure chunk that the page evaluates and hides
looks like this:

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
