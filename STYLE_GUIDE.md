# Course style guide

## Basis and scope

This guide is derived from the text that the author wrote by hand. `AGENTS.md` lists
which sections and exercises are references for voice and which are generated drafts;
generated text, even when approved, is a reference for content, depth, notation and
format and never a model of how to write. The guide governs new and revised material and
does not require a wholesale rewrite of existing pages. Where existing files differ from
it, the guide holds. The author's chapters contain typos and slips of grammar; those are
not part of the voice.

## PRIORITY: the author's voice

**This section takes priority over the other prose preferences in this guide and over
generic textbook concision.** Scientific accuracy and the course scope stay mandatory.

An earlier brief asked for an "ecologist speaking candidly", openings built on "a
recognisable ecological tension" and "lightly provocative" wording. It produced quips and
slogans that the author deleted; do not write to it. The author's voice is plainer: a
teacher who defines a concept, shows it on one example, says what it is for in this book
and adds an honest aside when one is useful.

### What the author's voice is

- **Definition first.** A section opens with the concept, usually in bold in the first
  sentence, and then announces the example as an example: "A **random variable** is the
  quantity whose value is uncertain before we make that observation. [...] We will use a
  hypothetical experiment on seed survival to illustrate how to model ecological count
  data."
- **A guide through the book.** The author says what a concept is for, where it returns
  and what the course will not use: "We will also use quantiles to quantify parameter
  uncertainty as confidence intervals (see Chapter 3)", "We will not use it much in this
  course". These signposts replace generic motivation.
- **First person where the author is really speaking.** "I" marks the author's own
  choices and judgement ("I call them the four faces; this is terminology that I
  completely made up"), "we" shared reasoning and "you" what the student does. Never
  invent an anecdote, opinion or reading history for the author: write the passage
  neutrally and flag it for the author to fill in.
- **Connected reasoning in full paragraphs.** Sentences are linked by plain connectives
  ("Note that", "That is,", "In other words", "However,", "So", "It turns out that"), and
  a paragraph usually carries a whole argument. Parentheses hold short asides, often with
  "e.g." or "i.e.".
- **Mathematics stated properly, then translated.** The correct term and symbol
  (countably infinite, convergence in probability), the equation, symbols explained in a
  "where ..." clause directly after it, and then the meaning: "In plain English, as $n$
  grows, ...". Do not water the mathematics down to sound friendly.
- **Worked numbers.** A general statement is followed by a small case that the student
  can check ($0.4 \times 0.7 = 0.28$ in a table of joint probabilities; a probability by
  hand and then "We can verify our math with R:"). Code is introduced by a short lead-in
  that ends in a colon ("In R:").
- **Footnotes for asides:** history and sources, remarks on terminology, technical
  qualifications and further reading, so that the main line of reasoning stays clean.
- **Frank and occasionally dry.** The author says when something is confusing or debated
  and takes a position ("those pesky assumptions"). A few times per chapter, always about
  something real.
- **Model, not truth.** "Model probability", "model distribution" and "data generating
  process", not "theoretical", "true" or "population" (except in a simulation where the
  known generating parameter is the point). Data are "treated as if they were a random
  sample from the model".
- **Register.** Chapter 1 is the only personal, candid chapter (personal history,
  rhetorical questions, opinion on p-values). From Chapter 2 onward the tone is more
  formal: the same person, but mostly definitions, equations, examples and signposts. Do
  not carry the candour of Chapter 1 into technical chapters.

### What generated text does instead

Remove these patterns when revising and do not produce them.

- **Scene-setting hooks before the concept:** "When we put a quadrat in the field, we do
  not know in advance how many of its seeds will survive."
- **Quips, personification and slogans:** "measurements that refuse to stay neatly in
  whole numbers", "not a rubber stamp", "neither one gives a model a free pass".
- **"X, not Y" as a reflex:** paragraphs that end on the correction of a mistake nobody
  made ("These are assumed population values, not estimates from a forest."). State what
  is true. Keep a contrast only where students really confuse two things (density and
  probability, standard deviation and standard error), and then explain the difference.
  A handful per chapter is the ceiling.
- **A caveat after every statement:** "does not establish", "does not guarantee", "is not
  proof that". Place one caveat where the risk is, and put a recurring misconception in a
  single warning callout instead of repeating it in the prose and in the quiz.
- **Repeated provenance disclaimers.** State once, where the data are introduced,
  whether they are simulated, built in or supplied in a file. Do not present a simulation
  as field evidence.
- **Leaking the authoring process:** "The author supplied the mapping below", "This
  verified piecewise structure", "outside this chapter's learning goals". The reader is a
  student; say what the data are and where they come from.
- **Clipped, stacked declaratives:** "A peak shows an estimate. Its width helps describe
  uncertainty." Rewrite as reasoning with connectives and say why the step matters.
- **Lists and tables in place of explanation.** The author explains one idea at a time in
  prose and keeps lists for things that are really parallel (the four faces) and for the
  items of a recipe (see "Presenting code in the text").
- **Imperative and slogan headings:** "Find the maximum", "Add logs rather than
  multiply". Headings name the topic as a noun phrase ("Joint distributions and
  independence", "A simple diagnostic for overdispersion"); a question heading is fine
  now and then.
- **Italics for emphasis on ordinary words.** Use bold for a new term and let the
  sentence carry the emphasis.
- **Splitting what belongs together.** Ideas introduced as a set get one section, one
  list, one code block and one composite figure (the four faces), not a numbered
  subsection each.
- **Defensive links.** Cite to credit a source, point to a debate or recommend reading,
  not to back up a routine statement.

### Before and after

Generated:

> Independence is one of those assumptions that makes probability calculations
> beautifully neat and ecological data rather awkward. Two random variables are
> **independent** if knowing the value of one does not change the probabilities for the
> other. Consider germination of two planted seeds.

Author:

> Two random variables are said to be **independent** if knowledge about one of them does
> not change the probabilities for the other. Understanding this concept requires
> understanding joint distributions of multiple random variables. Let's first illustrate
> it with a simple example involving two binary random variables (for variety, I will use
> seed germination).

The quip is gone, the definition comes first, the prerequisite is named and the example
is announced. The author then added a joint-probability table with numbers.

### Checklist for a revised or new passage

1. Does the section open with the concept, with the example announced after it?
2. Does it say what the concept is for in this book and where it comes back?
3. Is the mathematics stated correctly and then put in plain words, with a small
   numerical case?
4. Can any "not Y", "does not establish" or "simulated, not field data" sentence be
   deleted without losing a point the student needs?
5. Are there quips, personified data or slogan-like closing sentences?
6. Does anything refer to how the text or data were supplied to the writer?
7. Is every "I" a real choice or view of the author, with nothing invented?
8. Is each piece of code next to the sentences that explain it?
9. Does the text repeat a number that the chunk above prints, without comparing it with
   anything?

## Voice and vocabulary

- Plain, conversational English. Contractions and questions are fine when they help.
  Avoid research-paper prose and unexplained shorthand. One main idea per paragraph; do
  not turn every sentence into a paragraph or every paragraph into a list.
- Explain a technical term at first use, preferably through an ecological example, and
  expand abbreviations (maximum likelihood estimation, MLE; independent and identically
  distributed, i.i.d.) before using them alone.
- Prefer concrete verbs: calculate, simulate, plot, compare, estimate, explain. No
  promotional filler ("unlock", "leverage", "delve into", "powerful tool", "it is
  important to note that"). Avoid "obviously", "trivially" and "simply" for a step that a
  beginner may find difficult. Do not call a model "best" without naming the criterion.
- **British English throughout** (modelling, behaviour, parameterisation, summarise,
  optimisation). Correct American spellings on any page that you edit, including the
  author's text. Preserve R identifiers, quoted text, official titles and data set names
  (`summarize()` stays).
- **Capitalise distribution names everywhere:** Binomial, Poisson, Negative Binomial,
  Normal, LogNormal, Beta, Gamma ("the Binomial distribution", "Normal errors", "The
  Negative Binomial distribution" in a heading). Other words stay in lower case
  ("distribution", "model", "density"). Correct lower-case forms when editing.
- Function names as code with parentheses (`var()`, `optim()`); object and argument names
  in backticks (`seed_count`, `lower.tail`); R and RStudio as ordinary proper names.

## Explanations and chapter structure

Every chapter starts with `# Introduction`, whose first sentence begins exactly with
**"In this chapter, we learn how to..."** and states the main ecological or statistical
purpose. Keep it to one or two paragraphs: what the chapter covers, how it differs from
the previous one, which distributions or examples it uses. Then `# Learning goals`, in
the format of Chapter 2: the lead-in "In this chapter, we will cover:" and a list of
short topic phrases ending in semicolons ("the assumption of independence;"), in the
order of the chapter, covering what the chapter actually contains. Do not use "After
studying this chapter, you should be able to:" with assessment verbs. A closing sentence
may name the distributions or tools of the chapter and point to a supplement. Every
theory chapter ends with `# Summary` (a few short paragraphs, no new material) before
`# Chapter quiz`; Chapters 6 and 7 still lack one. Keep cross-chapter promises specific
and check the destination.

Introduce the general concept before the concrete example; do not open a section with a
field scenario and expect students to infer the principle. A useful sequence:

1. State the general concept and the question it helps answer.
2. Introduce an ecological setting and identify the observational unit.
3. Define the random variable, its possible values and the model assumptions.
4. Introduce the equation and explain each new symbol.
5. Translate the calculation into short R code.
6. Interpret the result in ecological terms, with units and limitations. When the code
   teaches a tool and not an ecological result, say instead how to read its output.

Reuse an example while a concept is developed. Running examples of the theory are real
data wherever the concept allows it (`AGENTS.md` lists them); a hypothetical example is
kept where its parameters must be known and round. When the parameters of a model for
real data come before estimation has been taught (Chapter 2), give rounded values that
describe the data well and point to the chapter that explains how they are obtained. Use
different data for the theory example of a chapter and its exercises (another species or
group of the same data set is allowed). A data set from an earlier chapter may return
when the new analysis answers a different question; explain the connection.

Within a distribution section, the worked case goes under `### Example: ...`. For a
distribution, describe its support, parameters, ecological interpretation, mean and
variance, and R functions, and connect the four faces in the Chapter 2 order: mass or
density, cumulative probability, quantiles, sampling. Explain parameter conversions and
do not merely list formulas. Optional detail goes in a footnote or a supplement.

**Supplement entries for distributions** (`Supplements/distributions.qmd`, `sec-` IDs
such as `distributions.qmd#sec-negative_binomial`) follow the author's entries (Binomial,
Poisson, Negative Binomial): summary table; when the distribution is useful and what it
assumes; the mass or density function with its symbols explained; the mean and variance
as displayed equations; an `### Example:` that calculates a probability by hand and
verifies it in R; a figure; a `Practice` callout with a collapsed solution.

**Supplement entries for deterministic functions**
(`Supplements/deterministic-functions.qmd`, `sec-fn-` IDs) have: a summary block in
`aligned` display mathematics (R, shape, domain, range, parameters, value at zero, value
at infinity, special points, alternative forms); one or two paragraphs on uses, with
author–year citations and a sentence on whether a mechanistic derivation exists; and the
formula with a "where" clause and its landmarks derived. They have no example, figure or
`Practice` callout; do not add them back. A statement about how a function is used must
rest on Chapter 3 of Bolker's *Ecological Models and Data in R*, which the page names as
its source and the author trusts, or on a citation that was checked against the
publication and is in the reference list of the page. Inside display mathematics use
`\verb|...|` and not `\texttt{...}` for R code that contains `^` or `_`: MathJax refuses
those characters in `\texttt{}`, and a render without warnings does not show it (look at
the page in a browser).

After the prose has explained a concept, a short note callout may restate the definition
for later reference. It does not replace the explanation.

## Presenting code in the text

These rules come from the author's rewrite of the passage on `cmb()`, `MakeADFun()` and
`optim()` in Chapter 4. They apply to theory pages, supplements and the explanatory text
of practicals, and matter most where the text teaches a recipe that students will repeat.

- **One step, one chunk, next to its explanation.** Sentences for the first step, its
  chunk, sentences for the second step, its chunk. Do not describe three steps in one
  paragraph above one long chunk. A step is something that can be named in a clause:
  define a helper, process the NLL, minimise it, read the results.
- **Explain before the chunk what it uses and returns.** The arguments of a call and the
  elements of its result are introduced in the preceding text, so that the comments only
  label the lines.
- **Keep together what is read as a unit:** a function definition, a loop with its
  set-up, a figure with its data. Split where a new idea starts, not at every line.
- **Bullets for the items of a recipe.** When students must learn what the items are (the
  arguments of a function, the elements of an object, the steps of a procedure), give
  each its own bullet: the name in code format, then a short description. Keep running
  prose when the items are only illustrations or reasons. The test is whether the student
  will later need to find, name or remember each item.
- **Do not repeat in the text what the chunk prints.** When teaching a tool, say what
  each element of the output is and how to read it, by name and not by value. Quote a
  number only when it is used: compared with another value, answering a question of an
  exercise, or interpreted ecologically. A quoted number must agree with the code and
  the seed.

## Statistical language and notation

| Concept | Required distinction |
|---|---|
| Random variable and observation | $X$ or $X_i$ for random variables, $x$ or $x_i$ for possible or observed values. |
| Parameter, estimator, estimate | A parameter describes the model; an estimator is a rule applied to random data; an estimate is its value for observed data. Define hats such as $\hat\lambda$. |
| Mass and density | Discrete values have probability mass. A density gives probabilities through integration over intervals; its value is not a point probability and may exceed one. |
| Probability and likelihood | Probability varies the data for fixed parameters. Likelihood varies the parameters for the observed data and is not a probability distribution over parameters. |
| Likelihood notation | Keep the bar in $P(X=x\mid\theta)$ and $L(\theta\mid x_1,\ldots,x_n)$, and say at first use that it reads "for a given value of". $\ell$ is the log-likelihood; once the data are fixed write $L(\theta)$ and $\ell(\theta)$. The negative log-likelihood (NLL) is $-\ell$. Draw likelihood figures on the relative scale $\ell(\theta)-\ell(\hat\theta)$, because only differences are meaningful. |
| Wald and profile intervals | The profile likelihood interval (cutoff 1.92 for one parameter, 3.00 for a joint region of two) is the reference method. The Wald interval is the fast approximation: explain it as a quadratic approximation of the log-likelihood, calculate it on the optimised scale and transform the endpoints back. A standard error cannot be transformed back like an endpoint (see "R coding patterns" for `ADREPORT()`). |
| Number of parameters in AIC | $K$, because $k$ is the shape of the Negative Binomial: $\mathrm{AIC}=2K-2\ell(\hat\theta)$. Only differences between models fitted to the same observations in the same units are meaningful, and AIC ranks candidates without showing that the best one describes the data well. |
| Deterministic functions | Generic parameters $a,b,c,d$ for every function, as positions in a formula; say what each controls. Ecological symbols ($\alpha$ and $H$; $K$, $r$, $n_0$) only for a specific parameterisation. $f'(x)$ and $f''(x)$ in running text, $df/dx$ where the variable matters, $\partial f/\partial a$ for a partial derivative. $\log$ is the natural logarithm. Derive the units of every parameter from the formula: the argument of an exponential or a logarithm has no units, a parameter that multiplies $x$ has the inverse units of $x$, one that divides $x$ has the units of $x$. |
| Names of functions | Michaelis–Menten (en dash) is the primary name of $ax/(b+x)$; Holling type II is its predator–prey parameterisation; Monod and Beverton–Holt are named in a footnote. The saturating exponential has the ID `sec-fn-monomolecular`. |
| Half-maximum and reparameterisation | The half-maximum is a value of $x$ at which a saturating function reaches half of its asymptote (a value of $y$). A reparameterisation changes the parameters and not the curve: check it by evaluating both forms at the same $x$. |
| Empirical variance and `var()` | `mean((x - mean(x))^2)` divides by $n$, `var(x)` by $n-1$. State which one an exercise requests. |
| Sampling distribution | The distribution of an estimate across repeated hypothetical experiments with the same design and sample size: imaginary and never observed. Keep it distinct from the replicates (for example quadrats) within one experiment. |
| Exact results and approximations | In finite samples estimators are in general biased and their sampling distribution is unknown. Label exact results as special cases and other statements for small samples as approximations that rely on large-sample results or simulation. |
| Standard deviation and standard error | Variation in observations; variation in an estimator across hypothetical experiments. |
| Overdispersion | Variation exceeds that expected under a stated reference model. A variance-to-mean ratio is exploratory and does not identify the ecological cause. |
| Confidence interval | Explain repeated-sampling coverage. Do not assign a probability to a fixed parameter lying in a calculated interval. |
| Independence | A model assumption. Separate locations or observations do not by themselves establish it. |

Write $E[X]$, $\operatorname{Var}(X)$ and $X \sim \operatorname{Poisson}(\lambda)$. Define
sample size separately from the Binomial trial count when both occur. The Negative
Binomial has mean $\mu$ and shape $k$ with $\operatorname{Var}(X)=\mu+\mu^2/k$ (`mu` and
`size` in R); explain any other parameterisation. Variance parameters are $\sigma^2$,
with descriptive subscripts for several components ($\sigma^2_{\mathrm{group}}$,
$\sigma^2_{\mathrm{obs}}$); describe them as variances, not precisions, and do not use
$\tau^2$. When a density or the fitting code takes a standard deviation $\sigma$ (R's
`sd`), say that its square is the model variance.

Use "approximately" for rounded results and asymptotic approximations. Describe
simulation summaries as varying across samples, and do not promise monotonic improvement
in every realised sample as sample size grows. State the conditions behind general claims
about estimators.

## Units

Write compound units with a slash and not with "per": µmol/m²/s, g/day, kg/ha, seeds/m²,
prey/day. This applies wherever a unit is attached to a quantity: prose, tables,
captions, callouts, mathematics and axis labels.

- Use the symbol where a common one exists (µmol, g, kg, mm, cm, m, ha, L, mL, s, min)
  and the full name for longer units of time (hour, day, night, week, month, year) and
  for counted things in the numerator (seeds, prey, tadpoles, species). Names stay
  singular after the slash: seeds/m², cm/year.
- A space between number and unit, none around slashes: 90 kg/ha, 18 kg/ha/week.
- A rate without a unit in the numerator takes the slash directly after the number:
  $b=0.2$/week, $0.0614$/mm. Standing alone (parentheses, axis label, code comment) write
  1/day, 1/mm: `"Density (1/mm)"`.
- Bracket a ratio of two compound units: (µmol/g/hour)/(µmol/L), species/(t/ha/year).
- A substance follows the unit: 40 µg/L of carbon.
- In prose use the characters ² and µ. Inside mathematics set units upright with
  `\text{}` or `\mathrm{}` (`\text{ prey/day}`, `\text{ g/m}^2`, `\text{/day}`). In an
  axis label the unit follows the quantity in parentheses: `"Nitrogen released (kg/ha)"`.
- "Per" remains when the denominator is an object or sampling unit and not a unit of
  measurement (2.14 seedlings per quadrat, 4.75 calls per visit, 0.02 days per prey, 9.5
  survivors per 0.1 m²), in "per unit of $x$", "per unit of time", "species per percent"
  and "parts per million", and in description without a number or symbol ("the number of
  prey that the spider eats per day").

## Markdown and Quarto

- ATX headings in sentence case, without skipping levels. Quarto numbers the sections;
  keep meaningful exercise numbers.
- Blank lines around paragraphs, lists, code blocks, equations and divs. No four-space
  indentation of ordinary lists.
- Bold for a new term or a short point of emphasis. Prefer callouts over inline colours
  or HTML styling.
- `$...$` inline and `$$` on separate lines for display equations; `aligned` for a
  derivation with several steps. Equations are part of the surrounding sentences.
- **The argument of a logarithm is in parentheses, as in R:** $\log(3)$, $\log(2)/b$,
  $\log(f(x))=\log(a)-bx$, never $\log 3$ or $\log a$. This applies to $\log$ and $\ln$
  everywhere. Use `\log\left(...\right)` around a tall argument, keep `\log` bare only
  where the function is named and not applied, and write another base as a subscript
  before the bracket, $\log_{10}(x)$.
- Relative `.qmd` links, for example `[Chapter 5](../Chapter_5/Theory.qmd)`, with the
  actual filename case (`solution.qmd`).
- Preserve existing section IDs. Add descriptive `sec-` IDs where a section needs a
  reference and refer to it with `@sec-name`. Do not invent destination IDs.
- Tables for real comparisons and parameter mappings, with units in the column labels.
  Numbered lists for exercise tasks and procedures.
- UTF-8, source lines of roughly 80 to 100 characters; do not break links or code to
  meet the width.

Theory front matter holds only `title:`. The table of contents and section numbering are
set once in `_quarto.yml`; do not add per-page `format` or `execute` blocks. Chapters 6
to 8 still carry them, including a global `eval: false`, and display-only ```` ```r ````
fences. Before removing such a block, check every chunk: without the global setting,
chunks are evaluated unless they carry `#| eval: false`. Preserve the other settings of a
page: practicals use `date: today`, and the Chapter 1 material uses the `wordcount-html`
extension.

Always use executable chunks (```` ```{r} ````), also for code that students run
themselves; set `#| eval: false` when the code should be shown but not run. Chunk options
go on `#|` lines. An evaluated chunk must define its inputs or use an earlier evaluated
chunk; it cannot rely on a chunk with `eval: false`. Hide plot construction when it
distracts from the concept and show it when plotting is the lesson. Do not fill practical
pages with output that students are meant to generate themselves. A hidden figure chunk:

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

Callouts: notes for definitions, warnings for specific misconceptions, and the caution
type only for collapsed boxes that a student can skip:

```markdown
::: {.callout-note title="Probability mass"}
The probability mass function assigns a probability to each possible count.
:::

::: {.callout-caution collapse="true" icon=false title="Statistical detail: the Cramér–Rao bound"}
No unbiased estimator has a variance smaller than the inverse of the Fisher
information.
:::
```

The title of a collapsed box starts with "Statistical detail: " (formal results) or
"Technical detail: " (computational detail, such as how automatic differentiation works),
followed by a noun phrase. The main text must be complete without the box: it states each
result in plain words and never relies on a symbol or result that appears only inside
one. Inside the box the full rigour stays (statement, "where" clause, "In plain English"
sentence).

Chapter 4 opens with a roadmap table after the learning goals (step, question, R tool,
example) and closes with a "recipe" callout before the summary. Later theory chapters may
copy both when the chapter is a sequence of steps that students carry out.

## Exercises and solution patterns

Give a concrete setting, the necessary data or assumptions and numbered tasks that
progress from calculation to interpretation. Hints may refer to a tool taught earlier
without giving the answer away. Worked solutions contain the reasoning, executable code
and an answer in the terms of the question.

The Chapter 1 wrappers keep the metadata chunk that calls
`quarto::write_yaml_metadata_block(show_solution = TRUE)` (`FALSE` in `no_solution.qmd`),
followed by `{{< include material.qmd >}}`. Nested exercises and solutions follow this
pattern:

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

Keep fence lengths matched and the nesting intact. Collapsing a solution does not hide it
from the student version; the conditional div does. In the separate files of later
chapters use `# Exercise N: Topic` and `## Solution`. A `no_solution.qmd` may contain
worked exercises (`AGENTS.md` lists them).

## R coding patterns

- **Always `=` for assignment**, including function definitions, in existing and new
  code. Spaces around binary operators and after commas, two spaces of indentation,
  double-quoted strings, `TRUE` and `FALSE`.
- Ordinary literals in teaching examples: `NA` and `2`, not `NA_real_` or `2L`, unless
  the distinction is the lesson.
- Short, meaningful `snake_case` names; mathematical names (`x`, `mu`, `k`) when their
  meaning has just been defined.
- Name distribution arguments: `dbinom(x = 15, size = 25, prob = 0.65)`. Break long calls
  over several lines.
- Use `package::function()` or load the package explicitly. Explain a new dependency and
  do not introduce a framework for a small example.
- **No pipes** (`|>`, `%>%`). Call `dplyr` functions directly and assign intermediate
  results to named objects in preference to long nested expressions.
- Set a seed before each reproducible simulation or batch of repetitions, not inside
  every repetition. Explicitly varied seeds are appropriate where variation across
  samples is the lesson (Chapter 3, Exercise 2).
- Define objects in teaching order and pass data explicitly to functions; examples must
  work in a clean workspace. Document-relative data paths, no absolute paths, no
  `setwd()`. Explain any `na.rm = TRUE`.
- **Comment the chunks:** short comments that identify inputs, the purpose of a group of
  lines and new operations, without commenting every obvious line. The statistical
  lesson goes in the prose. No console prompts; label literal output with a `text` fence.

### Maximum likelihood with RTMB

Show the model and its assumptions before the implementation. Sum log probabilities with
`log = TRUE`. From Chapter 4 onward every NLL has the form that RTMB needs: two named
lists, parameters first and data second, unpacked with `getAll()`:

```r
poisson_nll = function(parms, data) {
  # Make the elements of both lists available by name.
  getAll(parms, data)
  # Transform the parameter to the original scale.
  lambda = exp(log_lambda)
  -sum(dpois(x = counts, lambda = lambda, log = TRUE))
}

# Connect a likelihood to a data set.
cmb = function(f, d) function(p) f(p, d)

# Process the NLL, then minimise it with BFGS.
fir_obj = MakeADFun(
  cmb(poisson_nll, list(counts = fir_counts)),
  list(log_lambda = log(2)),
  silent = TRUE
)
fir_fit = optim(par = fir_obj$par, fn = fir_obj$fn, gr = fir_obj$gr, method = "BFGS")
```

- **Every fit goes through `MakeADFun()`**, including the first; no example passes a
  plain NLL to `optim()`. The text says only that `MakeADFun()` processes the NLL so that
  the tools of the course can work with it and that details come progressively; that
  `cmb()` connects a likelihood to data, so that it can be used on another data set with
  the same variable names; and that `obj$gr` is the slope that RTMB supplies for BFGS
  (Chapter 6 says how). Do not explain automatic differentiation, tapes or lexical
  scoping before Chapter 6, do not present `cmb()` as an awkward part of TMB, and do not
  answer questions that students may not have.
- **Optimiser:** `optim()` with `method = "BFGS"` and `gr = obj$gr` everywhere, including
  one-parameter fits and the inner fits of a profile; say once that Chapter 8 explains
  the method. Never set `reltol`. `silent = TRUE` in every `MakeADFun()` call.
- **Constraints by transformation only:** the logarithm for positive parameters,
  `qlogis()` and `plogis()` for probabilities. Say why and report estimates on the
  ecological scale.
- **Object names:** `<model>_obj` (`MakeADFun()`), `<model>_fit` (`optim()`),
  `<model>_sd` (`sdreport()`), `<model>_profile_<par>` (`tmbprofile()`).
- **Grids:** `for` loops (one for a curve, two nested for a surface) that call `obj$fn()`
  on the optimised scale, not `sapply()`, `vapply()`, `Vectorize()` or `outer()`. A grid
  draws curves, surfaces and slices and never estimates. Distinguish a slice from a
  profile, which refits the other parameters.
- **By hand once, then the TMB tool.** Each calculation that TMB does is shown once by
  hand on the simplest case: the Hessian as `fit$hessian[1, 1]` from
  `optim(..., hessian = TRUE)`; a profile with inner fits that start at the joint
  estimate; the endpoints of a profile interval with `uniroot()`, its search interval
  chosen from the plotted curve so that the function changes sign. Then: `sdreport()` for
  standard errors; `ADREPORT()` for a quantity calculated from the parameters (TMB
  applies the delta method, which Chapter 6 explains); `TMB::tmbprofile()` with
  `confint()` (with the prefix, because RTMB does not export it); `OBS()` with
  `obj$simulate()` for hypothetical experiments; `checkConsistency()`. Introduce each
  tool where the text needs it, not in the first NLL.
- **Profiles** are drawn with `ggplot2` from the data frame that `tmbprofile()` returns,
  on the relative log-likelihood scale; in an exercise, `plot()` of the profile object is
  allowed.
- When teaching a complete fit, discuss starting values, convergence, constraints and
  uncertainty. A converged optimiser does not establish that the model is adequate.

### Distribution functions

From Chapter 2 onward they come from RTMB and RTMBdist. Load `library(RTMB)` first and
`library(RTMBdist)` second, in a chunk with `#| message: false`: both define `dnbinom2()`
with different arguments, and the course uses the RTMBdist version,
`dnbinom2(x, mu, size)` (it is the one found whichever the order; the order keeps the
code predictable). `dnbinom()` with `size` and `prob` also works in an NLL. A density or
mass function in an NLL always comes from RTMB or RTMBdist, because some base R versions
fail inside `MakeADFun()` (`dnbinom()` with `mu`, `dunif()`). Where a cumulative,
quantile or random function is missing, base R, MASS or a short hand-written line fills
in and the text says so. `RTMBdist::pt()` has no `lower.tail`; write `stats::pt()`.

## Figures and numerical interpretation

Give axes descriptive labels with units and distinguish probability, frequency, relative
frequency and density. Use bars or vertical lines for discrete mass, steps for cumulative
probabilities and density-scaled histograms under a continuous density. Label empirical
and model quantities. Choose simple figures that answer the question in the text, with
captions on theory figures and legends for several series. Restore graphics settings
after `par()`.

**The author's figures** (theory pages and supplements, including every figure of a
supplement entry) use `ggplot2` with `theme_classic()`; their code is usually hidden.

- Raw observations: Okabe–Ito blue (`#0072B2`), normally `alpha = 0.7` and `size = 2`;
  jitter only when overlap would hide data.
- Empirical bars, histograms and boxplots: `grey90` fill, `grey40` outline; suppress
  boxplot outliers when the raw observations are drawn.
- Fitted distributions and curves: Okabe–Ito vermillion (`#D55E00`), usually
  `linewidth = 0.8`; the same colour with `alpha = 0.2` for a confidence band. Keep
  different point, line and fill geometries so that figures work in greyscale.
- A figure that reports a fitted response shows raw data, fitted curve and uncertainty
  together where legible, and states the model and the meaning of the uncertainty in the
  caption or text. A model-reporting example adds a compact inset or table with the
  formula, estimates and confidence intervals.
- Transform an axis only when it helps interpretation; state it and keep the units.

**Plots inside exercises** (practicals from Chapter 2 onward, student page and solutions,
including worked exercises, and the `Practice` callouts of theory pages and supplements)
use simple base R graphics, so that students do not spend their time on visualisation.

- Only the functions of the Chapter 1 practical: `plot()`, `hist()`, `barplot()`,
  `curve()`, `lines()`, `points()`, `abline()`, `legend()`, `contour()`. Do not load
  `ggplot2` or `patchwork` in a practical.
- A few lines per plot, with axis labels and units; no themes, palettes, annotations or
  multi-panel layouts unless the question asks for them.
- Distinguish series by `lty` or `pch` with a short `legend()`. Colour is optional; the
  fitted model may use `"#D55E00"`.
- The code is shown, because it is part of the solution.

The Chapter 1 practical teaches both systems and keeps both. A theory page may show a
short base R call when it teaches a tool that students use in the exercises (`curve()`,
`contour()`, candidate curves over the data); the figure that the text refers to is then
drawn with `ggplot2`. Students may use either system in their own work.

Keep unrounded values for later calculations and round for presentation. Check every
number quoted in prose against the code and the seed. Say what the result means for the
ecological question, and separate what the calculation shows from what the model cannot
establish.
