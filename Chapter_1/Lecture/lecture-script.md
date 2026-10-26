# Chapter 1 lecture script: Ecological models and data

Draft for the course author's review. **Target: 60 minutes**: 57 minutes on 19 slides,
including the questions, figure discussions and short activities below, and 3 minutes of
slack for discussion. Course logistics sit outside this hour. The remaining hour of a
two-hour session is available for your logistics, a break and further questions; no
particular allocation of that remaining time is assumed.

This script follows [Chapter 1 theory](../Theory.qmd), with a short introduction to the
[R practical](../Practicals/material.qmd). It has the same slide text and speaker notes
as [`lecture.qmd`](lecture.qmd). The slides carry keywords only; the narrative is in the notes. The notes are a speaking guide: the time allocations
include pointing to figures, taking answers and discussing them.

Your two existing figures are used on slides 7 (`ModelCycle.png`) and 14
(`Estimation.png`). Slides 9, 10 and 12 use PNG copies of figures of the chapter, kept in
`lecture-assets/`, and slides 5 and 6 use the schematics `feeding-response.svg` and `model-components.svg`.
No fitting code is needed for this lecture.

## Timing and slide sequence

Times are measured from the start of the Chapter 1 presentation, independently of
where you place the logistics in the session.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological models and data | 1 | 0–1 |
| 2 | Overview of the lecture | 1 | 1–2 |
| 3 | The problem and the purpose of the course | 2 | 2–4 |
| 4 | Ecological questions | 3 | 4–7 |
| 5 | A predator's feeding response | 4 | 7–11 |
| 6 | The components of a statistical model | 3 | 11–14 |
| 7 | The modelling cycle | 4 | 14–18 |
| 8 | Observation error and process variation | 4 | 18–22 |
| 9 | Probability models for ecological observations | 3 | 22–25 |
| 10 | Explaining some of the variation | 4 | 25–29 |
| 11 | Parameters and estimates | 3 | 29–32 |
| 12 | Parameter uncertainty | 4 | 32–36 |
| 13 | Discussion: which source of variation? | 3 | 36–39 |
| 14 | Reality, model and data | 4 | 39–43 |
| 15 | What we want from a statistical analysis | 4 | 43–47 |
| 16 | Course roadmap: distributions to estimation | 2 | 47–49 |
| 17 | Course roadmap: response curves to optimisation | 2 | 49–51 |
| 18 | The Chapter 1 R practical | 3 | 51–54 |
| 19 | Summary and closing questions | 3 | 54–57 |
| | Slack for discussion | 3 | 57–60 |
| | **Total** | **60** | |

## Slide 1 — Ecological models and data

The lecture has five parts.

First, the kind of question that the course wants to answer and what a model is
(slides 3 to 6). We use one example throughout, the feeding rate of a predator.

Second, the modeling cycle, how do we organize our work (slide 7 & 15).

Third, why observations vary and why we describe that variation with probability
(slides 8 to 10).

Fourth, what the parameters of a model are and why the values that we calculate from
data are uncertain (slides 11 to 14).

Fifth, the chapters of the course and the R practical of this week (slides 16 to 19).

Today is an overview. You do not need to know how to fit any of the models that
appear in the examples.

## Slide 3 — The problem and the purpose of the course

The purpose of this course is to learn how to use ecological models and statistics
to answer ecological questions with data.

We learn models in ecology courses: functional responses, growth curves, responses
to the environment. They often stay theoretical. In experimental research statistics
dominates, and the statistics that we learn first was developed for factorial
experiments, linear responses and Normal distributions. Ecological variables do not
respond linearly to their drivers, they do not follow Normal distributions, and a lot
of our data do not come from a balanced factorial experiment, because things go wrong
in the field or the design is not logistically possible.

The proposal of the course is to combine both disciplines. We take the response
functions of ecological modelling and the distributions that describe how ecological
variables behave, and we combine them with the same statistical machinery that is
behind the linear and generalised linear models.

The course has two objectives. The first is to teach likelihood-based inference, in
theory and in implementation, so that you understand better what tools like `glmmTMB`
do with your data. The second is to teach how to build non-linear (mixed) models and
how to apply to them the same type of analysis.

**Delivery**

Optional personal introduction: the chapter contains your account of reading
Bolker's *Ecological Models and Data in R*. If you want to include it, substitute
that account for part of these notes and keep the slide within two minutes.

## Slide 4 — Ecological questions

The way we ask a question decides what we need from an analysis. “Does temperature
affect development?” has a yes or no answer. “How does development change across the
observed temperature range?” names the relationship that we have to describe, and
asking for an optimum gives a reason to consider a curve that rises and then falls.

In the same way, a treatment could change seedling survival by a small or a large
amount, with different consequences for recruitment. We need the size of the change
and its uncertainty.

So in this course we give up null hypothesis testing as the main goal of an analysis,
because the questions that we care about are quantitative. This does not mean
abandoning linear models; slide 15 comes back to it.

A useful habit is to finish this sentence: “To answer my ecological question, I need
to estimate…” That might be a probability of survival, a maximum feeding rate or a
difference between groups.

**Short activity — included in the three minutes**

Give students 30 seconds to suggest a more specific version of “Does food
availability affect growth?” Take one or two answers. Possible answers: the increase
in growth at low food availability, the maximum growth rate, or the food availability
needed to reach a given growth rate. Accept answers that identify a quantity and a
range or comparison.

**Transition**

Let us use a feeding response to see how such a question guides a model.

## Slide 5 — A predator's feeding response

Imagine that we measure the feeding rate of a predator across a range of prey
densities. We could ask whether prey density has a statistically significant effect.
More useful questions are: how quickly does feeding increase when prey are scarce?
Does it reach a maximum? What is that maximum, and how uncertain is the estimate?

A straight line might describe part of the observed range, but it cannot keep
increasing forever. A predator has limited time to search for, capture and handle
prey. A saturating response curve represents that constraint directly, and its
parameters describe features of the system that we can discuss and compare among
studies. Those comparisons only make sense when the model definitions, units,
organisms and study conditions are similar enough.

We often know something about these shapes from theory, earlier experiments or from
thinking about how organisms work. Convenience used to be a good reason to fit a
straight line anyway, because more complicated models were difficult to fit. Modern
computers remove that limit. The challenge now is whether the model represents the
ecological relationship reasonably well and whether the data can inform its
parameters.

Comparing the values of parameteres across sites, species, treatments or other factors
is one way to answer ecological questions. Sometimes we will also compare different
models that are derived from alternative hypothesis. This is how we do statistics when
we do not have yes/no questions.

## Slide 6 — The components of a statistical model

A statistical model is a mathematical approximation to the process that produces our
data. That process includes what happens ecologically and how we observe it.

In the feeding example, one part of the model describes how expected feeding changes
with prey density. This is a deterministic function, and we use deterministic
functions to approximate the ecological process that we are most interested in. The
other part describes the possible observations at each prey density: different
predators eat different numbers of prey under the same conditions.

A statistical model needs at least one stochastic component, that is, a distribution.
The response function is the part that we add when the question asks for it. Some
questions need only distributions, for example the counts under one set of
conditions, and a model can even be made of nested distributions. The course starts
with those models and adds response functions and groups later.

**Delivery**

The figure is the curve of slide 5 with hypothetical observations added: several
predators at each of seven prey densities. Ask students which component describes
the curve and which describes the scatter. Point to one prey density and note that
the predators differ although the conditions are the same. Keep this conceptual;
distribution names and equations come later.

## Slide 7 — The modelling cycle

This figure is the map of the course. Ecological modelling begins with a research
question, but it does not move in a straight line from question to answer. Each
result may send us back to the question, the data or the model.

The three boxes on the right are the three parts of the work, with the chapters
where we learn each tool.

Model: we express an ecological idea as a model that can generate the kind of data
that we observe. We choose a probability distribution (Chapter 2), describe how its
parameters change with continuous predictors (Chapters 5 and 6) and how they vary
across groups such as location, species or treatment (Chapter 7).

Estimation: given a model and data, we estimate the parameter values that make the
model most compatible with the observations. Chapter 3 introduces estimates, their
sampling variation and confidence intervals. Chapter 4 develops maximum likelihood,
Chapter 8 deals with the technical difficulties of finding the optimum, and Chapter 7
covers the marginal likelihood that hierarchical models need.

Model comparison and answer: more than one model may be plausible. Chapter 4
introduces the Akaike information criterion, AIC, to compare fitted candidate
models. Chapter 6 adds other information criteria and cross-validation, checks how
well the models describe the data and interprets the parameters in terms of the question.
We compare fitted candidates; we do not assign probabilities to models.

Estimation has not been explained yet. Every box gets its own slide in the next half
hour, and the figure returns in the summary.

**Figure walkthrough — included in the four minutes**

Trace question, model, data, estimation and answer with a pointer, then the loop
through model comparison. Ask: “Suppose our fitted curve still rises at the highest
prey density that we measured. What might we revisit?” Accept extending the
measurements, reconsidering the candidate functions, or restricting the claim to the
observed range.

## Slide 8 — Observation error and process variation

We use probability as a tool to describe unexplained variation and the uncertainty
that follows from it. There are three sources to keep apart: observation error,
process variation and parameter uncertainty. This slide defines the first two;
slides 11 and 12 take up the third.

Observation error is the difference between what happens and what we record. We may
miss an individual or count it twice, instruments never give perfect readings, and
protocols are not followed perfectly. In the hypothetical case, twenty insects are on
the plant and we record sixteen. Observation error changes the data that we analyse
and leaves the ecological reality as it was. How the observations are collected
matters for the probability model, and repeated observations under the same
conditions help to characterise the error.

Process variation, also called process error or stochasticity, is variation in the
ecological reality that the deterministic part of the model does not explain. It is
still there with perfect measurements. “Error” does not mean that somebody made a
mistake. The slide lists four reasons: the environment and drivers that we did not
measure, differences among individuals, chance in births and deaths, and nearby or
repeated observations that resemble each other. The chapter adds the non-linear
effects and interactions that a model simplifies away.

Unexplained is not the same as random. Persi Diaconis of Stanford University built a
model that predicts coin flips, provided that the initial conditions are measured
accurately enough. Process variation is therefore relative to the model and to the
information that we have.

A recorded value often reflects both sources. Simple models describe their combined
variation with one distribution. When the data have groups, hierarchical models (also
called mixed or multilevel models) can separate them, or at least estimate a good
part of the process variation. That is Chapter 7.

**Discussion**

Ask the question on the slide and take one reason for the answer. Relate it to one
of the four items on the right.

## Slide 9 — Probability models for ecological observations

A probability distribution describes the possible values of an observation and how
probability is allocated to them.

The two panels show why we need several distributions. Insect counts are whole
numbers that start at zero. Body mass is a positive continuous quantity, and here it
is strongly skewed: many small values and a few much larger ones. The grey bars
summarise the observations and the orange marks or curve show a fitted model, a
Negative Binomial distribution on the left and a LogNormal on the right. We will
seldom use the Normal distribution in this course.

The vertical axes differ. For counts we assign a probability to each possible count.
For a continuous measurement, probability is an area under a density curve over an
interval. Chapter 2 develops that distinction.

**Figure discussion — included in the three minutes**

Ask students to identify the observations and the model in each panel. Then ask:
“Could an insect count be negative? Could it be 3.5?” A model should respect the
possible values of the quantity that it describes. Do not start a detailed comparison
of distributions.

## Slide 10 — Explaining some of the variation

These are the insect counts of the previous slide. The plot now shows what the
pooled plot hid: the plants were sprayed with different products.

There is variation among the sprays and within each spray. The variation among
sprays is process variation, because we do not expect our counts to have errors that
depend on the spray: the sprays changed how many insects were on the plants.

“Explained” and “unexplained” always refer to a model. For the pooled model of the
previous slide, the differences among sprays are unexplained process variation. For
a model that includes spray, they are explained. The variation within each spray
remains, and it contains process variation among plants and observation error. The
figure cannot tell us how much there is of each.

This is how the models of the course grow: we describe how a response changes with
a predictor (Chapter 6) or how parameters vary among groups (Chapter 7), and we keep
a probability distribution for the variation that remains.

**Figure discussion — allow about two minutes**

Ask the question on the slide. If there is time, ask: “What variation remains after
we account for spray?” Point to the differences among groups and to the spread
within each group. Describe what is visible without making a significance claim.

**Transition**

Once we propose a model, we still have to determine its parameter values.

## Slide 11 — Parameters and estimates

A parameter is a quantity that determines a feature of the model. A model for
survival has a parameter for the probability of survival. A feeding response has a
parameter for its maximum rate. A distribution also has parameters that describe how
much the observations vary.

The parameter belongs to the model. The estimate is the value that we obtain when we
apply an estimation procedure to the observations, and a different procedure can
give a different value. To estimate, we treat the data as if they were a random
sample from the model; slide 14 looks at that assumption.

Another sample from the same study design would give a different estimate. This is
the third source, parameter uncertainty, and it is the reason why we report more
than a fitted value.

Chapter 3 introduces this reasoning with samples and repeated hypothetical
experiments. Chapter 4 develops maximum likelihood, the estimation method of the
rest of the course.

**Check for understanding**

Point back to the feeding curve: “Which feature could be controlled by a parameter?”
Take one answer, then ask what data would help to estimate it.

## Slide 12 — Parameter uncertainty

The same model is compatible with different samples of data, because of the
variation that the model does not explain. Turn this around: with the data fixed,
several models are compatible with that sample, and each corresponds to different
values of the parameters. That we do not know exactly which values to use is what we
call uncertainty.

The points are the body mass and brain mass of 28 species of land animals, on
logarithmic axes because the sizes cover a wide range. The line is a fitted
saturating response and the band is an approximate 95% confidence interval around
the fitted mean response. The band is not where we expect individual species to lie.
It shows that several similar curves are compatible with these data.

Three of the 28 species are dinosaurs (*Diplodocus*, *Triceratops* and
*Brachiosaurus*) with very large bodies and small brains. The levelling-off of the
curve at large body masses comes from them.

There are two formal definitions of parameter uncertainty, the frequentist and the
Bayesian. For large samples and simple models they differ little. For small data
sets the Bayesian way can be superior, but it is sensitive to the prior assumptions
that complement the data. We keep to the frequentist interpretation, with two things
to remember: our statements of uncertainty are approximate when we have little data,
and Bayesian methods are rising in popularity. The book is meant as a bridge to them.

**Figure discussion — allow about two minutes**

Ask: “What does a point represent? What does the line represent? What does the band
represent?” Give students time to separate the three. Keep to interpretation; the
calculation of confidence intervals comes in Chapters 3 and 4.

## Slide 13 — Discussion: which source of variation?


Case 1: the animals are the same and the records differ. This is observation error.

Case 2: say aloud that the model has only spray as a predictor; the slide leaves it
out. The counts are the true ones, so nothing was recorded wrongly. Relative to that model the difference is process
variation. It would become explained variation if we measured, say, plant size and
added it to the model.

Case 3: what changes is the estimate from a study. This is parameter uncertainty.
Each study may contain many observations; the variation here is among the estimates
of repeated studies.

All three occur in one analysis. We separate them to be clear about what a
distribution or a statement of uncertainty describes.

## Slide 14 — Reality, model and data

This figure zooms into the estimation box of the cycle. With the cycle on slide 7,
it is one of the two figures of the chapter.

The data generating process is everything in a study that can affect the data that
we collect: the ecological processes, the experimental protocols and the measurement
procedures. For the feeding experiment it includes encounters with prey, capture,
handling, differences among predators and how feeding is recorded. The model is a
mathematical approximation to that process, and its parameters give it the
flexibility to match different possible processes.

For the purpose of estimation we treat the data as if they were a random sample from
the model. In reality they come from the data generating process and not from the
model. We need the assumption to develop the statistical procedures: it links the
parameter values to the data sets that we could have observed.

A parameter can be estimated with many procedures. Frequentist statistics studies
how a procedure behaves across repeated hypothetical samples: whether the estimates
are too high or too low on average (bias), how much they vary, and how often their
intervals cover the parameter. Chapters 3 and 4 develop this.

We use maximum likelihood, the most general procedure. Informally, it selects the
parameter values that make the model most compatible with the observed data.
Chapter 4 defines it.

**Figure walkthrough**

Follow the solid arrows, then the dashed arrows, with the labels of the figure. Ask
where a missed insect or an imperfect instrument belongs in the diagram: in the data
generating process, which includes how we observe.

## Slide 15 — What we want from a statistical analysis

Most of us first learn statistics through linear models and ANOVA, and later perhaps
generalised linear and mixed models. They are useful tools and you should not throw
them away. But they are often taught as if the challenge were to choose the right
formula, check a few assumptions and see whether a coefficient differs from zero.
That is not always the question that we care about.

A small p-value is rarely the end of an ecological analysis, or its main goal. A
test against a zero effect does not tell us whether the effect is large enough to
matter, what shape the response has or how precisely we know it. “Nothing happens”
is often not even a plausible ecological model: we usually choose among several ways
in which something might happen. And a large p-value often says more about the size
of the experiment or survey than about the effect. For the debate, the chapter
recommends Wasserstein, Schirm and Lazar (2019), “Moving to a world beyond
‘p < 0.05’”, *The American Statistician* 73(sup1), 1–19.

The approach of the course is to make the choices explicit: a response function, a
probability model for the observations, estimates with uncertainty, a comparison of
plausible candidates and a check of the fit. The aim is the simplest model that
answers the question. If that is a linear model with Normal errors, we use it,
because we choose to and not because we have to.

Two limits of scope. Probability also describes uncertainty about initial
conditions, inputs such as future rainfall, scenarios and numerical error. These
matter for dynamical and forecasting models, which the course does not cover. And we
compare candidate models without assigning probabilities to them.

Stating the model, estimating with uncertainty and checking the fit are also useful
habits when models inform decisions, although this course is about analysing data
and not about forecasting.

**Discussion**

Ask: “If I tell you that prey density has a statistically significant effect, which
of our questions about the feeding curve are still unanswered?” Refer to slide 5 and
take two answers.

## Slide 16 — Course roadmap: distributions to estimation

One sentence per row.

Chapter 2: what values an observation can take and with what probabilities, with a
Binomial model for seed survival and a Normal model for penguin flipper lengths.

Chapter 3 changes the direction of the question: we have a sample and want to learn
about unknown parameters, so we study how samples and estimates vary.

Chapter 4: maximum likelihood, with the uncertainty of the estimates and a first
comparison of models with AIC.

The R tools arrive when we need them: the distribution functions of the packages
RTMB and RTMBdist from Chapter 2, and fitting with RTMB and `optim()` from Chapter 4.

**Delivery**

Stress the change from Chapter 2 (known parameters, possible observations) to
Chapters 3 and 4 (observed data, unknown parameters). Do not list every distribution
or method.

## Slide 17 — Course roadmap: response curves to optimisation

One sentence per row.

Chapter 5: the response functions themselves, their shapes and the meaning and units
of their parameters, without fitting.

Chapter 6: functions, distributions and maximum likelihood together, in a complete
analysis that fits, compares, checks and interprets.

Chapter 7: groups and repeated observations, with hierarchical models.

Chapter 8: how the numerical searches work and what to do when a fit is difficult.

The supplement on formula-based methods describes `glmmTMB`, which uses the same
techniques as the course, with a formula that writes the likelihood for you. This
closes the loop with the first objective of slide 3.

The detailed roadmap in the chapter is a reference to return to while you work
through the course.

## Slide 18 — The Chapter 1 R practical

The Chapter 1 practical teaches the R skills that the rest of the course uses. R is
the language for the calculations and RStudio helps us to write and organise the
work.

We store commands in scripts so that an analysis can be run again. We learn how to
store observations, select and summarise data and make plots. Functions let us write
a model or a calculation once and use it for different inputs. Loops repeat
operations, which we need when we simulate studies later in the course.

Work through the tutorial in order and run the examples yourself. When you change a
line, predict what will happen before you run it.

The practical also covers the installation of packages, finding help and the use of
AI. You may use AI as a tutor: to translate the material, explain concepts, provide
examples and fix bugs in your code. If it writes the solutions before you have
tried, you will not learn the material. AI tools make mistakes and you are
responsible for your work, so you must be able to explain what your code does and
what its result means ecologically.

**Delivery**

Open the practical briefly, or show a screenshot of its contents, and point out the
sections on scripts, functions and exercises. Keep installation, schedules and
assessment for the logistics segment. A live demonstration is optional and replaces
part of the three minutes of this slide.

## Slide 19 — Summary and closing questions


Go back to slide 7 and show the cycle again; no new slide is needed. We started from
a question, expressed an ecological idea as a response function with a probability
distribution, and saw what estimation assumes and why estimates are uncertain.
Comparison and checking send us back around the cycle until the answer is useful for
the question.

An estimate is useful when we know what it measures, its units and its uncertainty.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: the curve describes the expected response, and observations at the same
prey density differ. A probability model represents that variation, and estimation
and uncertainty are built on it.

Question 2: variation among observations is in the data and contains process
variation and observation error. Parameter uncertainty is about how precisely a
sample determines a quantity of the model; repeated hypothetical studies give
different estimates.

**Final transition**

The next steps are the R tools of the practical and the probability language of
Chapter 2.

## Adjustments during delivery

The slides take 57 minutes and leave 3 minutes of slack for discussion. If
discussion runs longer, use the slack first and then shorten slides 16 and 17 to one
spoken sentence each, which recovers about three minutes. Keep the distinction
between variation and parameter uncertainty and the explanation of the two figures
(slides 7 and 14).

If you prefer a break within the Chapter 1 content, place it after slide 13
(39 minutes of content). The break is additional to the hour.

If time remains in the wider session, return to the feeding example and ask students
to propose an experiment: what they would measure, which prey densities they would
include and which observation problems they expect.
