# Chapter 7 lecture script: Grouped ecological response curves

Draft for the course author's review. **Target: 150 minutes in total, with 116 minutes of
slides on 31 slides (including the discussion, the three practice questions and one live demo
of 18 minutes), 14 minutes of slack and two breaks of 10 minutes.** The breaks separate the
three blocks of the lecture. The only code that is run live is the demo of slide 21, from the
script `demo-pooling.R`.

This script follows the [Chapter 7 theory](../Theory.qmd) from the introduction to the recipe,
with a short introduction to the [R practical](../Practicals/no_solution.qmd). One data set runs
through the lecture, the CO₂ uptake curves of 12 grass plants: observations in groups and the
conditional and marginal distributions that describe them, the three ways of sharing information
among groups, the marginal likelihood and its Laplace approximation, the variance components,
group-level predictors and shrinkage, the uncertainty of a variance among groups and REML, the
curves of observed and new groups, and the checking and comparison of grouped models. The slides
carry keywords only; the narrative is here.

Slide 3 uses your diagram `ModelCycle.png` from the Chapter 1 lecture folder. Slides 5
(`co2-data.png`), 14 (`laplace.png`), 19 (`shrinkage.png`), 23 (`new-plants.png`) and 25
(`residuals-grouped.png`) use figures in `lecture-assets/`. All five are unchanged copies of
Chapter 7 figures: `fig-co2_data`, `fig-laplace`, `fig-shrinkage`, `fig-new_plants` and
`fig-residuals_grouped`. Their code is in `lecture-assets/figures.R`, which runs the chapter's
chunks in the chapter's order with the chapter's seed (701), so the residual plot is the one on
the chapter page. If the chapter figures change, run that script again (it takes about 13
seconds).

## Timing and slide sequence

Times are measured from the start of the session and include the breaks.

| Slide | Topic | Minutes | Elapsed time |
|---|---|---:|---|
| 1 | Ecological Models and Data Analysis | 1 | 0–1 |
| 2 | Overview of the lecture | 2 | 1–3 |
| 3 | Where we are: the modelling cycle | 1 | 3–4 |
| 4 | Observations in groups | 3 | 4–7 |
| 5 | Response curves measured on the same groups | 3 | 7–10 |
| 6 | Conditional distributions | 4 | 10–14 |
| 7 | Marginal distributions | 4 | 14–18 |
| 8 | A model with a random asymptote | 4 | 18–22 |
| 9 | Fixed effects and random effects | 3 | 22–25 |
| 10 | Practice 1: two seedlings in one quadrat | 3 | 25–28 |
| 11 | Three ways to share information | 4 | 28–32 |
| 12 | Discussion: which pooling answers which question? | 3 | 32–35 |
| | Break | 10 | 35–45 |
| 13 | The marginal likelihood | 4 | 45–49 |
| 14 | The Laplace approximation | 4 | 49–53 |
| 15 | Random effects in RTMB | 4 | 53–57 |
| 16 | Variance components and predicted effects | 4 | 57–61 |
| 17 | Group-level predictors | 4 | 61–65 |
| 18 | Two ways to encode groups | 3 | 65–68 |
| 19 | Shrinkage | 4 | 68–72 |
| 20 | Practice 2: wing length of chicks in nests | 3 | 72–75 |
| | Break | 10 | 75–85 |
| 21 | Live demo: from pooling to partial pooling | 2 + 16 | 85–103 |
| 22 | Uncertainty of variance components and REML | 4 | 103–107 |
| 23 | Curves for observed and new groups | 4 | 107–111 |
| 24 | Practice 3: sapling growth in forest stands | 3 | 111–114 |
| 25 | Checking a grouped model | 4 | 114–118 |
| 26 | AIC for grouped models | 4 | 118–122 |
| 27 | Leave-one-group-out cross-validation | 4 | 122–126 |
| 28 | Comparing the candidates | 3 | 126–129 |
| 29 | A recipe for a grouped response curve | 2 | 129–131 |
| 30 | The Chapter 7 R practical | 2 | 131–133 |
| 31 | Summary and closing questions | 3 | 133–136 |
| | Slack for discussion | 14 | 136–150 |
| | **Total** | **150** | |

Slides 116 minutes (blocks of 35, 30 and 51, the demo included), slack 14, breaks 20: 150
minutes. The break before the demo lets you open R and run section 0 of `demo-pooling.R`.

## Slides 1 and 2 — Ecological Models and Data Analysis; Overview of the lecture

In this lecture, we learn how to fit response curves to observations that come in groups.
Repeated measurements on the same plants, animals, nests or sites share the conditions of their
group, so they are not independent of each other. A grouped model describes three things
together: a curve that is common to all the groups, how that curve varies among groups, and how
the observations vary around the curve of their own group. The variation among groups is
described by a probability distribution, and the model is fitted by maximum likelihood once the
deviations of the groups have been integrated out of the likelihood.

The session has three blocks, separated by two breaks. The first block explains why grouped
observations are not independent, introduces conditional and marginal distributions, writes the
model with a random effect and compares three ways of sharing information among groups. The
second is about the fit: the marginal likelihood, the Laplace approximation, random effects in
RTMB, the variance components, group-level predictors and shrinkage. The third starts with a
live demo that goes from pooling to partial pooling, then turns to the uncertainty of a variance
among groups and REML, the curves of observed and new groups, and the checking and comparison of
grouped models. It ends with the recipe, the practical and the summary.

**Delivery**

Read the overview at the pace of the list, one keyword and its question at a time, and do not
explain any term yet.

## Slide 3 — Where we are: the modelling cycle

This lecture adds one entry to two boxes of the cycle. In the model box it is "groups (7)": the
model now has two levels, a distribution for the groups and a distribution for the observations
of each group. In the estimation box it is "marginalise (7)": the effects of the groups are not
observed, so they are integrated out of the likelihood before it is maximised. The comparison box
keeps the information criteria and cross-validation of Chapters 4 and 6, with two changes that
slides 26 and 27 explain.

**Delivery**

One minute. Point to "groups (7)" and "marginalise (7)", and to the comparison box.

## Slide 4 — Observations in groups

The **observational unit** is the entity on which one observation is made, such as a quadrat, a
visit to a nest or a measurement on a plant. In Chapters 4 and 6 the observations were
independent. Often, however, observations come in **groups**: several observations are made on the
same individual, at the same site, in the same nest or in the same tank. The observations of one
group share conditions that other groups do not share (the genotype and condition of an
individual, the microhabitat of a site, the parents of a brood, the observer of a survey), so they
tend to resemble each other more than observations of different groups do. The variation among
groups is part of the process variation of Chapter 1: it would remain with perfect measurements.

Treating grouped observations as independent overstates the information in the data. Another
observation of a group that we have already observed tells us less than an observation of a new
group, because part of what it shows is the condition of its group, which we already know
something about. A model that treats every observation as independent therefore calculates
standard errors that are too small and intervals that are too narrow, and the evidence for an
effect looks stronger than it is.

We have met this twice. Exercise 1 of the Chapter 4 practical found that the numbers of tadpoles
surviving in the reed frog tanks varied among tanks much more than a Binomial model allows: the
tadpoles of a tank share its conditions. And Chapter 6 used the number of tanks, 16, and not the
number of tadpoles as the number of observations in AICc and BIC, for the same reason. A grouped
model describes the dependence explicitly: each group has a curve of its own, and a distribution
describes how the curves vary among groups. That is the takeaway.

**Delivery**

Ask students for one example of grouped observations from their own field before the example box
appears (repeated counts at the same transect, several leaves of one tree, chicks of one nest).

## Slide 5 — Response curves measured on the same groups

A common design for response curves measures every group at the same values of the predictor, so
that each group gives a whole curve. The chapter describes the curves with the saturating
exponential shifted along $x$, $\mu(x)=a\left(1-e^{-b(x-c)}\right)$, where $\mu(x)$ is the
expected response at $x$, $a$ the asymptote, $b$ the rate at which the curve approaches it (it
reaches 63% of the asymptote at $x=c+1/b$), and $c$ the value of $x$ at which the expected response
is zero. A grouped model lets one or more parameters of the curve vary among groups; we choose the
one in which the groups differ most.

The data come from Potvin, Lechowicz and Tardif (1990), "The statistical analysis of
ecophysiological response curves obtained from experiments involving repeated measures", *Ecology*
71: 1389–1400, and are built into R as `CO2`. They come from an experiment on the cold tolerance of
the grass *Echinochloa crus-galli*. Six plants came from Quebec and six from Mississippi, and
three plants of each origin were chilled overnight before the measurements. The CO₂ uptake of
every plant (µmol/m²/s) was measured at the same seven ambient concentrations of CO₂, from 95 to
1000 µL/L, so the design has 2 origins × 2 treatments × 3 plants × 7 concentrations, 84 measurements
in total. The observational unit is one measurement and the group is the plant. The help page of
`CO2` gives the concentration in mL/L, but the units stored with the data set are µL/L, which is the
same as parts per million; 1000 mL/L would be pure CO₂. Mention this only if a student reads the
help page.

The asymptote is the uptake of a plant at high concentrations of CO₂, a measure of its capacity
for photosynthesis. In the figure it is the property in which the plants differ most visibly, so it
is the parameter that we let vary among plants. In the curve, $a$ is in µmol/m²/s, $b$ in L/µL and
$c$ in µL/L.

**Figure walkthrough**

The four panels are the combinations of origin (columns) and treatment (rows); in each panel the
three plants of that combination are blue lines with points, distinguished by line type and
symbol. Every curve rises steeply up to about 250 µL/L and then levels off. The plants differ
mainly in the level that they reach: the non-chilled plants from Quebec near 40 µmol/m²/s, the
chilled plants from Mississippi lowest, near 15 to 22. Within a panel the three plants still
differ. Ask students what they would want to know from these data (does chilling lower the
uptake, and does it do so for both origins?), and point out that the 84 points are not 84
independent observations: the seven points of a line belong to one plant.

## Slide 6 — Conditional distributions

Chapter 2 introduced the joint distribution of two random variables, the marginal distribution of
each and independence. The **conditional distribution** of $X_1$ for a given value $x_2$ of $X_2$
gives the probabilities of the values of $X_1$ among the outcomes in which $X_2=x_2$. It is the
joint probability divided by the marginal probability of the given value, which must be larger
than zero. The bar reads "for a given value of", as in the likelihood notation of Chapter 4; what is
given now is the value of another random variable.

Two variables are independent when the conditional distribution of $X_1$ is the same for every
value of $X_2$, and equal to the marginal distribution: knowing $X_2$ does not change the
probabilities of $X_1$. When they are not independent, the conditional distribution changes with
the given value, which Practice 1 (slide 10) shows.

In the table of the two seeds of Chapter 2, with $P(X_1=1)=0.6$ and $P(X_2=1)=0.3$, the joint
probability that neither seed germinates is 0.28 and the probability that the second fails is
0.70. So the probability that the first seed does not germinate, for a given failure of the
second, is $0.28/0.70=0.4$, which equals the marginal probability $P(X_1=0)=0.4$. These seeds are
independent.

**Delivery**

Write the two-seed table on the board if students do not remember it, or show the Chapter 2 page.
The only new idea is the division by the marginal probability of the given value.

## Slide 7 — Marginal distributions

Multiplying both sides of the definition of slide 6 by $P(X_2=x_2)$ writes the joint distribution
as a conditional distribution times a marginal one. Adding these joint probabilities over all the
values of $X_2$ gives the marginal distribution of $X_1$, as in the tables of Chapter 2. For
continuous random variables the same relations hold with densities in place of probabilities and an
integral in place of the sum: the second equation on the slide, where $f_{X\mid Y}(x\mid y)$ is the
conditional density of $X$ for a given value $y$ of $Y$ and $f_Y(y)$ the marginal density of $Y$.
In plain English, the marginal density of $X$ is the average of its conditional densities over all
the values of $Y$, each weighted by the density of that value.

This is the form in which a grouped model is written: first the distribution of the value of a
group, then the distribution of the observations for a given value. The marginal distribution of
the observations follows by integration.

We have met a marginal distribution of this kind before. The Beta-Binomial distribution of Chapter
6 is the marginal distribution of a count that is Binomial for a given probability, when the
probability varies among sampling units according to a Beta distribution: each reed frog tank had
its own probability that a tadpole was killed, and the Beta-Binomial distribution describes the
counts with those probabilities integrated out. For this combination of distributions the integral
has a closed form, which is why we could write its probability mass directly. A **random effect**
is the same idea with a Normal distribution for the value of each group, usually on a transformed
scale (the logarithm of a positive parameter or the logit of a probability). For most such models
the integral has no closed form, and slide 14 shows how it is approximated.

**Transition**

The next slide writes the CO₂ model in this form.

## Slide 8 — A model with a random asymptote

Let $Y_{ij}$ be the $i$-th observation of group $j$ and $u_j$ the deviation of group $j$ from the
common curve, on the log scale of the asymptote. The deviations follow a Normal distribution with
mean zero and variance $\sigma^2_{\mathrm{group}}$, and for a given deviation the observations
follow a Normal distribution around the curve of their group, $\mu_j(x)$, with variance
$\sigma^2_{\mathrm{obs}}$. The asymptote of group $j$ is $a_j=a\,e^{u_j}$, that is,
$\log(a_j)=\log(a)+u_j$, so every asymptote is positive and the deviations act by multiplication:
a group with $u_j=0.1$ has an asymptote about 10% above $a$, because $e^{0.1}\approx1.105$.

The model has two levels. For a given value of $u_j$, the observations of group $j$ are
independent: each varies around the curve of its group with variance $\sigma^2_{\mathrm{obs}}$.
Marginally, that is, without knowing $u_j$, they are not independent, because they share $u_j$: an
observation above the common curve makes it more probable that the group has a high asymptote, and
so that its other observations are also above the common curve. This is the dependence of slide 4,
now written as a model. Observations of different groups are independent, because the deviations
of different groups are independent. That is the takeaway.

For the CO₂ data, $j=1,\ldots,12$ are the plants and $i=1,\ldots,7$ the measurements of a plant,
$x_{ij}$ is the concentration of measurement $i$ of plant $j$, and the variance among groups is
written $\sigma^2_{\mathrm{plant}}$. The rate $b$ and the location $c$ are shared by all the plants.
Any parameter of a curve can vary among groups in the same way; the chapter lets only the
asymptote vary.

**Delivery**

Point at the bar in $Y_{ij}\mid u_j$ and connect it to slide 6: the observations are described for
a given value of the group effect.

## Slide 9 — Fixed effects and random effects

The parameters that are shared by all the groups are called **fixed effects**: here $a$, $b$ and
$c$, and the effects of the group-level predictors that slide 17 adds. The deviations $u_j$, which
are described by a distribution, are the **random effects**, and a model with both is a
**mixed-effects model** (or mixed model). Because it describes the data in levels, it is also
called a **hierarchical** or **multilevel model**. The three names are used for the same kind of
model in different fields.

"Random" says that the deviations are described by a distribution. It does not mean that the plants
were allocated at random, nor that their differences have no cause: the plants differ for reasons
(genotype, condition), and slide 17 explains part of the differences with predictors. The
variances of the model, here $\sigma^2_{\mathrm{plant}}$ and $\sigma^2_{\mathrm{obs}}$, are
estimated together with the fixed effects; the random effects themselves are not estimated, as
slides 13 and 16 explain.

## Slide 10 — Practice 1: two seedlings in one quadrat

**Short activity — allow about two minutes of work and one to discuss**

Students work on paper. Expected answers, from the chapter's solution:

1. For a given quality the seedlings are independent, so their joint probability is the product of
   their probabilities. The quality was not recorded, so the products are added over the two
   qualities, each weighted by its probability; this is the discrete version of the integral of
   slide 7. $P(X_1=1,X_2=1)=0.5\times0.8\times0.8+0.5\times0.2\times0.2=0.32+0.02=0.34$; in the same
   way $P(X_1=1,X_2=0)=P(X_1=0,X_2=1)=0.08+0.08=0.16$ and $P(X_1=0,X_2=0)=0.02+0.32=0.34$, which add
   up to one. Then $P(X_1=1)=0.34+0.16=0.5$.
2. $P(X_2=1)=0.5$ as well, so $P(X_1=1\mid X_2=1)=0.34/0.5=0.68$.
3. The seedlings are not independent: the survival of one makes it more probable that the quadrat
   is favourable, and so that the other survives too (0.68 against 0.5). For a given quality they
   are independent, by construction.

The third answer is the structure of a grouped model: independence for a given value of the group
effect, and dependence when the group effect is integrated out. Students who calculate
$P(X_1=1)P(X_2=1)=0.25$ for the joint probability have assumed the independence that the question
asks about.

## Slide 11 — Three ways to share information

When a parameter of a curve may differ among groups, a model can treat it in three ways. With
**complete pooling**, all the groups share one value of the parameter: the groups are ignored and
the observations are treated as independent, as in Chapter 6. With **no pooling**, each group has
its own value, an ordinary parameter estimated from the observations of that group, and nothing
connects the values of different groups. With **partial pooling**, the values of the groups are
drawn from a distribution whose variance is estimated, as in the model of slide 8: each group has
its own value, the values of all the groups inform the distribution, and the distribution in turn
informs the value of each group. That is the takeaway.

The three ways differ in what they assume and in the question that they answer. Complete pooling
assumes that the groups do not differ. When they do, the observation variance absorbs the
variation among groups, and the standard errors are too small because every observation is treated
as independent. No pooling describes the measured groups, and only them: it says how each of these
groups responds, but nothing about a group that was not measured, because it does not describe how
groups vary. Partial pooling describes the measured groups and, through the distribution of the
group values, groups in general, which is usually the question of an ecological study (plants of
this species, nests of this bird, sites of this habitat). Its costs are an assumption about the
shape of that distribution, which is Normal in this chapter, and an integral in the likelihood
(slides 13 and 14).

For the CO₂ data, complete pooling fits one curve to all 84 measurements, and the measurements vary
around it with a standard deviation of 8.2 µmol/m²/s. Without pooling, each plant has its own
asymptote, and the measurements vary around the curves of their own plants with a standard
deviation of 1.9 µmol/m²/s. So most of the scatter around the common curve is variation among
plants, which complete pooling counts as variation of the measurements. The asymptotes without
pooling range from 14.2 µmol/m²/s (plant Mc2) to 45.0 µmol/m²/s (Qn3), and the three chilled plants
from Mississippi have the lowest ones. No pooling describes these 12 plants, but it cannot say how
much plants of this grass vary in their capacity for uptake, or which curve to expect for a plant
that was not measured.

**Delivery**

The two NLLs are in the chapter ("Three ways to share information") and are run in sections 1 and
2 of the demo; do not show code here. If a student asks: the no-pooling NLL makes `log_asym` a vector
with one value per plant and selects the asymptote of each measurement with `a[plant]`.

## Slide 12 — Discussion: which pooling answers which question?

This discussion applies the three ways of slide 11 to questions about a survey. The ponds are a
hypothetical example for the discussion.

**Discussion and expected answers — included in the three minutes**

Give students two minutes to match the questions with a neighbour, then take one answer per item.

1. **Which of these 20 ponds has the most newts?** A question about the surveyed ponds, so **no
   pooling** answers it, and so does **partial pooling**, whose predicted pond values are shrunk
   towards the typical pond (slide 19) and are less sensitive to chance variation in ponds with
   few or noisy counts. Complete pooling cannot answer it, because it gives every pond the same
   density.
2. **How much does the density vary among the ponds of the region?** **Partial pooling**: the
   variance among ponds is a parameter of the model. No pooling describes only these 20 ponds and no
   distribution of ponds; complete pooling assumes that ponds do not differ.
3. **How many newts in a pond that was not surveyed?** **Partial pooling**: the typical pond and
   the range of new ponds (slide 23). No pooling has no value for a pond that was not surveyed.
4. **Does the density increase with pond area, and how precisely do we know it?** Area is
   measured on the ponds, a group-level predictor (slide 17), so **partial pooling with area as a
   fixed effect**. Complete pooling with area would treat the 100 counts as independent and
   overstate the precision of the effect (slide 4). No pooling cannot estimate it at all, because
   the value of each pond absorbs everything that differs among ponds, including their area.

Accept "both no and partial pooling" for the first question if students say why. The fourth answer
is the one that students usually miss.

Break (10 minutes).

## Slide 13 — The marginal likelihood

In a mixed model the random effects are not observed. The likelihood of the parameters
$\boldsymbol\theta$, which are the fixed effects and the variances of the model, is therefore the
probability of the observations with the random effects integrated out, that is, their marginal
distribution (slide 7). For group $j$, with its observations collected in the vector
$\mathbf y_j$, this is the integral on the slide. In it, $f(\mathbf y_j\mid u,\boldsymbol\theta)$ is
the joint density of the observations of group $j$ for a given value $u$ of its random effect (the
product of the densities of its observations, which are independent for a given $u$), and
$f(u\mid\sigma_{\mathrm{group}})$ is the Normal density of the random effect, with mean zero and
standard deviation $\sigma_{\mathrm{group}}$. The groups are independent, so the likelihood is the
product of the $L_j$ over the groups, and the log-likelihood is the sum of their logarithms. This is
the **marginal likelihood**, and its maximisation is called **maximum marginal likelihood**. In plain
English, the marginal likelihood of a group averages the likelihood of its observations over all
the values that its random effect could take, each weighted by its density under the distribution
of group effects.

Why not estimate the deviations as parameters? That is no pooling: the $u_j$ would be ordinary
parameters, and no distribution would connect them. In the marginal likelihood the deviations are
replaced by one parameter, the standard deviation among groups, which describes how groups vary.
The number of parameters then stays the same however many groups are observed, which is one of the
conditions under which the large-sample properties of maximum likelihood of Chapter 4 hold.

For the CO₂ data, $\boldsymbol\theta$ holds $a$, $b$, $c$, $\sigma_{\mathrm{plant}}$ and
$\sigma_{\mathrm{obs}}$, and there are 12 integrals, one for each plant, each over the deviation of
that plant.

## Slide 14 — The Laplace approximation

The integral of the marginal likelihood has a closed form only in special cases, such as the
Beta-Binomial distribution and the Normal linear mixed model, so in general it must be
approximated. The **Laplace approximation** uses the shape of the integrand. As a function of $u$,
the integrand is the likelihood of the observations of the group multiplied by the density of $u$.
It has a peak at the value of $u$ that is most probable for these observations, and near the peak
its logarithm is close to a parabola, so the integrand itself is close to a Normal-shaped curve. The
area under a Normal-shaped curve is known: it depends only on the height of the peak and on the
curvature of the logarithm at the peak. So the approximation finds the peak, measures its height and
its curvature, and replaces the integral by the area under the Normal-shaped curve with the same
peak and curvature. This is the quadratic approximation of the log-likelihood that gave the standard
errors of Chapter 4, applied to the integrand.

The approximation is accurate when the integrand is close to a Normal-shaped curve: when each group
has many observations, so that the likelihood of the group dominates the integrand, and when the
observations are Normal, or close to Normal, for a given value of the random effect. For Normal
linear mixed models it is exact, because there the logarithm of the integrand is a parabola. It is
less accurate when the groups have few observations, and when the observations are counts near zero
or binary outcomes, for which the integrand can be skewed. The practical fits models of both kinds
(one Binomial count per tank of tadpoles, Poisson counts of salamanders with four visits per site).

**Figure walkthrough**

The figure shows the integrand for plant Mc2, the plant with the lowest uptake, with the parameters
at the estimates of the model that slide 15 fits. The horizontal axis is the deviation of Mc2 on the
log scale of the asymptote, and both curves are scaled so that their peak is one. The solid line is
the integrand; the dashed line is the Normal-shaped curve with the same peak and the same curvature
of the logarithm at the peak. The two curves almost coincide; the integrand has a slightly longer
tail towards low values of $u$, which the symmetric approximation cannot follow. As a result the area
under the approximation is 0.3% smaller than the area under the integrand, which changes the
log-likelihood of this plant by 0.003. The figure is an illustration: the chapter draws it in a
hidden chunk, and in practice no one calculates the integral, because RTMB does it (the takeaway).

**Optional remark (the box of the chapter)**

The statistical detail box gives the formula: with $h(u)$ the logarithm of the integrand and $\hat u$
its maximum, the integral is replaced by $e^{h(\hat u)}\sqrt{2\pi/(-h''(\hat u))}$, the height of the
peak times its width. With several random effects per group the curvature becomes a Hessian matrix
and the square root a determinant. Mention it only if asked.

## Slide 15 — Random effects in RTMB

In RTMB we do not write the marginal likelihood ourselves. We write the **joint NLL** of the
observations and the random effects, minus the logarithm of their joint density: minus the log
density of the observations for given random effects plus minus the log density of the random
effects (the joint density is the conditional density times the marginal one, slide 7).
`MakeADFun()` then integrates the random effects out. Three things change compared with the NLLs of
Chapters 4 and 6. The random effects are an element of the list of parameters, a vector with one
starting value for each group, usually zero. The NLL adds minus the log density of the random
effects to minus the log density of the observations, and the line with the density of the random
effects comes before the line that uses them; we need this order to simulate from the model (slide
25). And the argument `random` of `MakeADFun()` names the elements of the list of parameters that
are random effects. RTMB then integrates them out with the Laplace approximation: the elements `fn`
and `gr` of the object are the marginal NLL and its gradient, as functions of the other parameters
only, and `par` holds only those other parameters. So the fit with `optim()` works as before.

For the CO₂ data, the NLL is the no-pooling NLL with the vector of log asymptotes replaced by one
parameter `log_asym` plus the deviations `u`, and with the density of `u`, whose standard deviation
$\sigma_{\mathrm{plant}}$ is optimised as `log_sd_plant`. The deviations start at zero, and
$\sigma_{\mathrm{plant}}$ at 0.1 (plants that differ by about 10%). The chunk on the slide writes
the standard deviations inline to fit the slide; the chapter names them first. The fit converges,
and `par` holds five estimates; the deviations of the plants are not among them.

**Delivery**

Show the chunk without running it; section 3 of the demo runs it. Point at the first line of the
body (the density of `u`), at `a[plant]` and at `random = "u"`.

**Optional remark (the box of the chapter)**

The technical detail box says what RTMB does with `random`. Each time the optimiser calls `fn`, RTMB
first carries out an **inner optimisation**: it minimises the joint NLL over the random effects for
the current values of $\boldsymbol\theta$, which gives the peak of the integrand, with Newton's
method (an optimiser that uses second derivatives; Chapter 8). Automatic differentiation, which
Chapter 6 introduced, supplies the first and second derivatives, and the Hessian with respect to
the random effects at the peak gives the curvature of the Laplace approximation. So every evaluation
of the marginal NLL contains a complete optimisation over the random effects, which is why a mixed
model takes longer to fit. The method is described by Kristensen, Nielsen, Berg, Skaug and Bell
(2016), "TMB: automatic differentiation and Laplace approximation", *Journal of Statistical
Software* 70(5): 1–21.

## Slide 16 — Variance components and predicted effects

The variances $\sigma^2_{\mathrm{group}}$ and $\sigma^2_{\mathrm{obs}}$ are the **variance
components** of the model: the first describes the variation among groups, the second the variation
of the observations around the curve of their group. Each has the scale and the units of the
quantity that it describes, and the NLL takes their square roots, the standard deviations.
`sdreport()` works on the marginal NLL as on any other NLL, and two values of the argument `select`
of `summary()` give the two kinds of output: `"fixed"` gives the estimates and standard errors of
the parameters $\boldsymbol\theta$ on the optimised scales, and `"random"` gives the **predicted
group effects**, one row for each group, with their standard errors.

The predicted effect of a group is the peak of its integrand (slide 14), the most probable value of
its random effect for the observations of the group and the estimates of $\boldsymbol\theta$; it is
also called the conditional mode. The random effects are not parameters, so the predicted effects
are not estimated by maximum likelihood: they are predictions of unobserved quantities. Their
standard errors combine the uncertainty about the effect of a group for given parameter values with
the uncertainty of the estimates of the parameters.

A standard deviation on the log scale has no units, and for small values it is approximately the
coefficient of variation of the quantity on the original scale (its standard deviation divided by
its mean). The curve with $u_j=0$ has the median asymptote of groups in general: $u_j$ is symmetric
around zero and the exponential is increasing, so half of the groups lie above it and half below.
It is not their mean, which is larger, because the exponential is not a straight line (the box on
Jensen's inequality in Chapter 4).

For the CO₂ data, the measurements vary around the curve of their plant with a standard deviation
of about 2.0 µmol/m²/s, close to the 1.9 of no pooling and far from the 8.2 of complete pooling: the
mixed model, like no pooling, separates the variation among plants from the variation of the
measurements. $\hat\sigma_{\mathrm{plant}}\approx0.34$ is not very small, and it means that the
asymptotes of plants vary around their median by roughly a third. The estimate
$\hat a\approx30.9$ µmol/m²/s is the median asymptote of plants in general. The Quebec plants have
positive predicted effects, and the chilled plants from Mississippi (Mc1, Mc2 and Mc3) the most
negative ones, $-0.370$, $-0.755$ and $-0.422$: their asymptotes are about 31%, 53% and 34% below
the median ($e^{-0.370}\approx0.69$, $e^{-0.755}\approx0.47$, $e^{-0.422}\approx0.66$). So much of the
variation among plants follows their origin and treatment, which the model does not know about yet.

**Delivery**

Show the chunk without running it; the numbers are in its comments, and section 3 of the demo prints
them. The point to stress is the second bullet: a predicted effect is a prediction, not an estimate.

**Transition**

The next slide gives the model what it does not know yet: the origin and treatment of each plant.

## Slide 17 — Group-level predictors

A **group-level predictor** is measured on the group and not on each observation: the origin of a
plant, the treatment that it received, the habitat of a site. All the observations of a group share
its value. In a mixed model it enters as a fixed effect on the parameter that varies among groups,
here on its log scale, where it explains part of the variation among groups. On the log scale the
effects add up, so on the original scale they multiply. The random effects then describe the
variation that remains among groups with the same values of the predictors, and the variance among
groups becomes smaller. That is the takeaway.

When there are two predictors, the effect of one may depend on the level of the other: that is an
**interaction**. The chapter writes the effects of origin and chilling as a baseline plus contrasts,
with an interaction. In the equation of the example, $M_j$ is 1 for a plant from Mississippi and 0
for a plant from Quebec, $C_j$ is 1 for a chilled plant and 0 otherwise, and $a$ is now the typical
asymptote (with $u_j=0$) of the baseline group, the non-chilled plants from Quebec, which are R's
reference levels of the factors. $\beta_{\mathrm{miss}}$ is the effect of the origin in non-chilled
plants, $\beta_{\mathrm{chill}}$ the effect of chilling in plants from Quebec, and
$\beta_{\mathrm{int}}$ the difference between the effect of chilling in plants from Mississippi and
in plants from Quebec. Chilling multiplies the typical asymptote of a Quebec plant by
$e^{\beta_{\mathrm{chill}}}$ and that of a Mississippi plant by
$e^{\beta_{\mathrm{chill}}+\beta_{\mathrm{int}}}$. The predictors are properties of the plants, so they
go into the list of data as two vectors with one value per plant, and the NLL reports the logarithms
of the two chilling factors with `ADREPORT()`.

With origin and chilling in the model, $\hat\sigma_{\mathrm{plant}}$ falls from 0.34 to 0.079, so the
variance among plants on the log scale falls by about 94%. Origin and chilling explain most of the
variation among plants, and the asymptotes of plants of the same origin and treatment differ by
roughly 8%. Chilling multiplies the typical asymptote of plants from Quebec by about 0.90, with a
Wald interval from the log scale of 0.79 to 1.03, and that of plants from Mississippi by about 0.59
(0.52 to 0.68). So the plants from the colder origin are hardly affected by a cold night, whereas
the plants from the warmer origin lose about two fifths of their capacity. Slide 22 returns to the
uncertainty of these effects.

**Delivery**

The code is on the chapter page ("Group-level predictors and shrinkage") and runs in section 4 of the
demo. Read the equation term by term, and ask which term would be zero if a cold night affected the
plants of both origins in the same way ($\beta_{\mathrm{int}}$).

## Slide 18 — Two ways to encode groups

The effects of groups defined by predictors, such as the four combinations of origin and treatment,
can be written in two ways. With one parameter for each group, each group has its own typical value
(here, four typical log asymptotes). With a baseline plus effects and interactions, one group is the
baseline and the other parameters are differences from it (here, $\log(a)$, $\beta_{\mathrm{miss}}$,
$\beta_{\mathrm{chill}}$ and $\beta_{\mathrm{int}}$). Both have the same number of parameters and
describe the same model: they have the same maximum likelihood and give the same fitted curves, and
each set of parameters can be calculated from the other. In the example, both forms reach a minimum
NLL of 192.086.

The second form makes the differences between treatments parameters, so their estimates, standard
errors and intervals come directly from the fit, and a simpler model is obtained by leaving a term
out (the interaction, for example; slide 28 does that). The first form makes the typical value of
each group a parameter. Which one to use depends on the question: for the CO₂ experiment, whose
question is how chilling affects the two origins, the differences are what we want to report.

**Delivery**

The two columns appear one at a time. This is the callout "Two ways to encode groups" of the
chapter.

## Slide 19 — Shrinkage

The predicted effect of a group is a compromise between the observations of that group and the
distribution of groups. Its observations alone would give the no-pooling estimate; the distribution
of group effects pulls the prediction towards the typical value of groups with the same predictors.
This pull is called **shrinkage**. It is stronger when the group has few observations, when its
observations are noisy compared with what they need to determine, and when the variance among
groups is small, because the distribution then says that groups are alike. A group with many precise
observations stays close to its own estimate. Shrinkage is a form of **regularisation**: the values
of many groups are pulled towards a common value, which makes each of them less sensitive to the
noise in the observations of its group. In a mixed model the shrinkage follows from the model itself,
through the distribution of the group effects; it is not a correction applied after the fit.

**Figure walkthrough**

For each plant, the open blue circle is its asymptote without pooling and the filled vermillion circle
its predicted asymptote under a mixed model; a grey line joins them where they differ visibly. Top
panel: the model with a random asymptote only, whose dashed line is the median asymptote of plants in
general, 30.9 µmol/m²/s. The two circles nearly coincide for every plant: every plant has seven
precise measurements and $\hat\sigma_{\mathrm{plant}}$ is large, so the measurements of each plant
dominate its prediction. The largest change is that of Mc2, from 14.2 to 14.5 µmol/m²/s. Bottom panel:
the model with origin and chilling, whose dashed lines are the typical asymptotes of the four
combinations (about 42, 38, 31 and 18.5 µmol/m²/s). Now the distribution of plant effects is narrow,
because plants of the same origin and treatment are similar, and the shrinkage is visible: Mc2 moves
from 14.2 to 15.6 µmol/m²/s, about a third of the way towards the typical 18.5 of chilled plants from
Mississippi. Mc2 moves most because it lies farthest below the typical asymptote of its group, and
because its uptake is the lowest of all: the same observation error of about 2 µmol/m²/s is a larger
fraction of its uptake, so its measurements determine its asymptote on the log scale less precisely.

**Optional remark (the box of the chapter)**

The statistical detail box gives the formula for the Normal linear model with a random intercept: the
predicted mean of a group is a weighted average of its own mean, with weight
$w_j=n_j\sigma^2_{\mathrm{group}}/(n_j\sigma^2_{\mathrm{group}}+\sigma^2_{\mathrm{obs}})$, and the common
mean, with weight $1-w_j$. Practice 2 uses it. For non-linear curves and other distributions there is
no such formula, but the same quantities determine the shrinkage.

## Slide 20 — Practice 2: wing length of chicks in nests

**Short activity — allow about two minutes of work and one to discuss**

Students use R as a calculator. Expected answers, from the chapter's solution:

1. Nest A is pulled more, because two chicks say less about their nest than eight do.
2. With $\sigma^2_{\mathrm{nest}}=4$ mm² the weights are $8/12\approx0.67$ (A) and $32/36\approx0.89$
   (B), so the predicted deviations are 2.0 mm and 2.7 mm. In R:
   `3 * c(2, 8) * 4 / (c(2, 8) * 4 + 4)`.
3. With $\sigma^2_{\mathrm{nest}}=1$ mm² the weights are $2/6\approx0.33$ and $8/12\approx0.67$, and the
   predicted deviations 1.0 mm and 2.0 mm.

When nests vary less, the model expects a deviation of 3 mm to come partly from the chance variation of
the few chicks measured, so both nests are pulled more strongly towards the common mean, and the nest
with fewer chicks most of all. These are the three conditions of slide 19 in numbers.

Break (10 minutes).

## Slide 21 — Live demo: from pooling to partial pooling

The demo runs the steps of slides 11 to 19 for the CO₂ data, from complete pooling to the model with
origin and chilling, and ends with the curves of observed and new plants, which slide 23 explains. It has no model
comparison: the comparison follows on slides 26 to 28. The script needs the packages RTMB and
RTMBdist; the data set `CO2` is built into R. Its code and object names are those of the chapter, so
the numbers agree with the chapter and the slides. The whole script runs in a few seconds (1.5
seconds in a check in R 4.6.1), so there is no waiting.

During the break, open R and run section 0, "Packages and data". It loads RTMB and RTMBdist (with
their messages about masked functions), prints the first rows of the data and the names of the 12
plants, builds the list of data `co2_data`, draws the 12 plants in base R and defines `cmb()`. Keep
the session and the plot open. Spend the two minutes at the slide reading the five steps, then switch
to R and run the sections one at a time.

**Walkthrough of the script — 16 minutes**

1. **Complete pooling (about 2 minutes).** Start from the plot of section 0: solid lines are
   non-chilled plants, dashed lines chilled ones, circles Quebec and triangles Mississippi; the dashed
   lines with triangles lie lowest. Define the NLL with one curve and fit it from the values read from
   the plot (asymptote 30, zero uptake at 50 µL/L, rate 0.01). Convergence code 0; the standard
   deviation of the measurements around the common curve is 8.23 µmol/m²/s.
2. **No pooling (about 3 minutes).** The same NLL with `log_asym` as a vector of 12 and `a[plant]`;
   every plant starts at the same asymptote. Convergence code 0; the standard deviation around the
   curves of the plants is 1.86. The 12 asymptotes run from 14.2 (Mc2) to 45.0 (Qn3), and the three
   chilled Mississippi plants have the lowest (21.3, 14.2 and 20.1). Ask the first question below.
3. **Partial pooling (about 4 minutes).** Define the joint NLL and point at the order: the density of
   `u` first, then `a = exp(log_asym + u)`. Process it with `random = "u"` and print `mixed_obj$par`:
   five starting values, and no `u`. Fit: convergence code 0; on the original scale $a$ is 30.9,
   $b$ 0.0096 L/µL, $c$ 48.4 µL/L, `sd_plant` 0.335 (log scale) and `sd_obs` 2.01 µmol/m²/s.
   `summary(mixed_sd, select = "fixed")` gives the standard errors on the optimised scales (0.21 for
   `log_sd_plant`). The predicted plant effects: 0.145 to 0.372 for the Quebec plants, close to zero
   for the non-chilled Mississippi plants ($-0.072$ to $0.054$), and $-0.370$, $-0.755$ and $-0.422$ for
   Mc1 to Mc3, each with a standard error of about 0.10 to 0.11. Ask the second question below.
4. **Origin and chilling, and shrinkage (about 4 minutes).** The two indicators go into the list of
   data with one value per plant, and the NLL gains the effects and `ADREPORT()` of the two log chilling
   factors. Convergence code 0. `summary(treatment_sd, select = "fixed")`: $\beta_{\mathrm{miss}}=-0.31$,
   $\beta_{\mathrm{chill}}=-0.10$ and $\beta_{\mathrm{int}}=-0.42$ (standard error 0.10); the rate, the
   location and `log_sd_obs` hardly change. The standard deviation among plants falls from 0.335 to
   0.079. The chilling factors: Quebec 0.90 (0.79 to 1.03), Mississippi 0.59 (0.52 to 0.68). The table
   of asymptotes shows the typical values of the four groups (42.2, 38.2, 31.1 and 18.5) and Mc2 at 14.2
   without pooling and 15.6 predicted. The plot shows the shrinkage in base R: open circles without
   pooling, filled vermillion circles predicted, dashed lines typical. Ask the third question below.
5. **Observed and new plants (about 3 minutes).** The typical asymptote of chilled Mississippi plants is
   18.46 µmol/m²/s, and 95% of new plants of this group have asymptotes between 15.81 and 21.55. The plot
   draws the measurements of Mc1 to Mc3, the curve of each from its predicted asymptote, the typical
   curve (thick, vermillion) and the range of new plants (dashed). Point out that the curve of Mc2 lies
   above its own measurements and just below the range of new plants. End by saying that the curves of
   the measured plants and the curves of new plants answer different questions (slide 23).

**Questions to ask during the demo (about 1 minute, within the sections above)**

1. In section 2, "Why is the standard deviation so much smaller without pooling?" Because complete
   pooling counts the differences among plants as variation of the measurements; most of the 8.2 is
   variation among plants (slide 11).
2. In section 3, "Why does `par` have five elements and not 17?" The 12 deviations are integrated out of
   the likelihood; they cost one parameter, $\sigma_{\mathrm{plant}}$ (slides 13 and 26).
3. In section 4, "Why does the standard deviation among plants fall, but not the one of the
   measurements?" The predictors act on the asymptote, a property of the plants, so they explain
   variation among plants and nothing within a plant (slide 17).

## Slide 22 — Uncertainty of variance components and REML

`sdreport()` and `TMB::tmbprofile()` work on the marginal NLL as on any other NLL; each evaluation of
the NLL during a profile contains a Laplace approximation, so a profile takes longer, but it needs no
new code. Variance components need care. A variance is bounded below by zero, so we optimise the
logarithm of the standard deviation. The observations inform the variance among groups only through
the deviations of the groups, and part of the information in these is used up by the fixed effects on
the parameter that varies, so a variance among groups is usually estimated much less precisely than the
fixed effects. And its log-likelihood is often asymmetric, the more so when the estimate is close to
zero. For variance components we therefore use the likelihood profile interval of the log standard
deviation, and transform its endpoints back: `exp()` gives the interval of the standard deviation and
squaring that gives the interval of the variance, because both functions are increasing.

Maximum likelihood estimates of variances also tend to be too small when the fixed effects are estimated
from the same data. Chapter 3 met the simplest case: for i.i.d. Normal observations the maximum likelihood
estimate of the variance divides by $n$ and is too small on average, because the deviations are taken from
the estimated mean, which lies closer to the observations than the mean of the model; dividing by $n-1$
removes the bias. In a grouped model the same happens at the level of the groups: the fixed effects of the
group-level predictors are fitted to the deviations of the groups, so these look smaller than they are,
and the bias grows with the number of fixed effects estimated from the groups and falls with the number of
groups. **Restricted maximum likelihood** (REML) estimates the variance components from a likelihood in which
the fixed effects have been integrated out as well, as if they were random effects with a flat distribution.
For i.i.d. Normal observations it gives the estimator that divides by $n-1$, and for Normal linear mixed
models it is the standard method. In RTMB, REML is one change to the call of `MakeADFun()`: the fixed effects
are added to `random`, and only the variance parameters are left for `optim()`. REML was introduced by
Patterson and Thompson (1971), "Recovery of inter-block information when block sizes are unequal",
*Biometrika* 58: 545–554.

Two cautions apply. For non-linear curves or observations that are not Normal, REML through the Laplace
approximation is itself an approximation, and the reduction of the bias is not guaranteed. And the REML
likelihood depends on which fixed effects were integrated out, so models with different fixed effects are
compared with their maximum likelihood fits. REML is worth its extra fit when the variance components are
the question.

For the CO₂ data, the standard deviation among plants of the same origin and treatment lies between 0.045
and 0.139 (likelihood profile interval), so the asymptotes of such plants differ by between about 5% and 14%.
The interval of the variance, from 0.0020 to 0.019, spans almost a factor of ten, although the model was
fitted to 84 measurements: the variance among plants is informed by 12 plants. The REML estimate of
$\sigma_{\mathrm{plant}}$, 0.105, is a third larger than the maximum likelihood estimate of 0.079: plants of
the same origin and treatment differ by roughly 10% instead of 8%. The estimate of $\sigma_{\mathrm{obs}}$
hardly changes (2.05 against 2.04 µmol/m²/s), because the measurements around the curve of each plant are
many compared with the parameters of the curve. The takeaway is the practical consequence: to estimate a
variance among groups more precisely, observe more groups.

**Delivery**

The code is on the chapter page ("Uncertainty in a grouped model"); it is not run live. If a student asks
about the interaction: its profile interval is $-0.64$ to $-0.21$, so the chilling factor of Mississippi
plants is between 0.53 and 0.81 times that of Quebec plants. Exercise 5 of the practical checks the bias of
both estimators by simulation.

## Slide 23 — Curves for observed and new groups

A fitted grouped model gives three kinds of curve, which answer different questions. The **curve of an
observed group** uses the predicted effect of that group, and describes the group that was measured, shrunk
towards its typical value (slide 19). The **typical curve** has $u_j=0$ and describes the median group with
given values of the predictors; it is not the mean group (slide 16). The curve of a **new group**, one that
was not measured, has an effect that is a new draw from the distribution of group effects, so we can only
give the range in which it is expected to lie. With a Normal distribution of deviations, 95% of new groups
have deviations within $\pm1.96\,\sigma_{\mathrm{group}}$, so their asymptotes lie between
$a_{\mathrm{typ}}e^{-1.96\,\sigma_{\mathrm{group}}}$ and $a_{\mathrm{typ}}e^{1.96\,\sigma_{\mathrm{group}}}$,
where $a_{\mathrm{typ}}$ is the typical asymptote for their predictors. The curve increases with $u$ at every
value of $x$, so these two curves are the 2.5% and 97.5% quantiles of the curves of new groups at every $x$.
The range is calculated at the estimates and leaves out the uncertainty of the estimates themselves, which
would widen it.

Questions about the measured groups ("how does this plant respond?") use their own curves; questions about
groups in general ("which curve should we expect for a plant from Mississippi after a cold night?") use the
typical curve and the range of new groups. That is the takeaway.

For the CO₂ data, a new chilled plant from Mississippi is expected to have an asymptote between 15.8 and 21.5
µmol/m²/s around a typical 18.5, and a new non-chilled plant from Quebec one between 36 and 49 around 42. The
ranges are narrow because plants of the same origin and treatment are similar. The mean asymptote of plants
is $a_{\mathrm{typ}}e^{\sigma^2_{\mathrm{plant}}/2}$ (the mean of a LogNormal distribution), only 0.3% above the
median for $\hat\sigma_{\mathrm{plant}}=0.079$; the difference grows quickly with the variance among groups,
as Practice 3 shows.

**Figure walkthrough**

The figure shows the three chilled plants from Mississippi: their measurements as blue points, with a
different symbol for each plant, and the curve of each plant from its predicted deviation as a blue line. The
thick vermillion line is the typical curve of this origin and treatment, and the light vermillion band the
range that contains the curves of 95% of new plants. The curves of Mc1 and Mc3 lie above the typical curve
(predicted asymptotes 20.6 and 19.7). The curve of Mc2 lies just below the band and above its own
measurements, because its predicted asymptote is shrunk towards the typical one. The band is not a confidence
band (Chapter 6): it describes how plants vary, not how precisely the typical curve is estimated.

## Slide 24 — Practice 3: sapling growth in forest stands

**Short activity — allow about two minutes of work and one to discuss**

Students use R as a calculator. Expected answers, from the chapter's solution:

1. $20\,e^{-1.96\times0.4}\approx9.1$ to $20\,e^{1.96\times0.4}\approx43.8$ cm/year, which is wide because
   $\sigma_{\mathrm{stand}}$ is large. In R: `20 * exp(qnorm(p = c(0.025, 0.975)) * 0.4)`.
2. $20\,e^{0.5}\approx33.0$ cm/year. That value describes this stand only. For a stand that was not
   surveyed we know only the distribution of stand effects, so we expect a typical growth rate of 20
   cm/year, anywhere between about 9 and 44 cm/year.
3. No: 20 cm/year is the median. The exponential stretches the stands above the median more than it
   compresses those below, so the mean is larger. Simulating one million stands with
   `mean(20 * exp(rnorm(n = 1e6, mean = 0, sd = 0.4)))` gives about 21.65 (with seed 702), and the mean of the
   LogNormal distribution, $20\,e^{0.4^2/2}$, is 21.67: about 21.7 cm/year, 8% above the median.

The second answer is the point of slide 23: the curve of an observed group answers a question about that
group, and the typical curve with its range a question about groups in general.

## Slide 25 — Checking a grouped model

A fitted grouped model is a data generating process with two levels: first the effects of the groups are drawn
from their distribution, and then the observations are drawn for these effects. Checking the model means
comparing data simulated in this way with the observations, with scaled quantile residuals as in Chapter 6.
The observations are marked with `OBS()` in the NLL, and `obj$simulate()` then draws both levels: new effects for
all the groups, and new observations for these effects. This is called **unconditional simulation**, because the
effects of the groups are not kept at their predicted values. RTMB simulates in the order of the lines of the NLL:
at the line with the density of the random effects it draws new values of them, and the lines below use these
values, which is why that line must come first (slide 15). Keeping the effects at their predicted values instead,
**conditional simulation**, simulates new observations of the same groups; it checks the curves of the observed
groups and not the distribution of group effects.

The residuals of the observations come from `DHARMa::createDHARMa()` as in Chapter 6, with the typical curve of
each observation as `fittedPredictedResponse`, because that is its expected value before the effect of its group
is known. They share the deviation of their group, so they are not independent values, and a pattern among them
can come from a few groups. The residuals of the groups come from `DHARMa::recalculateResiduals()`, whose argument
`group` gives the group of each observation: it adds up the observed values of each group, and the simulated values
of each group in each hypothetical sample, and calculates one residual per group from these sums.

The chapter's warning is the takeaway. A grouped model can disagree with the data at either level, and the
residuals of one level can hide a problem at the other. Residuals of the observations mix the deviation of their
group with their own variation, so a curve that misses some groups may look acceptable, and a pattern that looks
like a misfit of the curve may come from a few groups. Residuals of the groups summarise each group in one number,
so they cannot show a problem with the shape of the curve within groups. Check both. With few groups, a quiet plot
of the group residuals says little about whether the distribution of group effects is Normal.

For the CO₂ data, the measurements vary around their typical curves about 80% as much (as a variance) as in the
simulated samples: dispersion statistic 0.80. Most of this variation comes from the deviations of 12 plants, which
vary a lot from one hypothetical sample to the next, so this is not a clear disagreement. The residual of Mc2 as a
group is 0.010: its total uptake is lower than in 99% of the simulated plants of its origin and treatment. Among 12
plants one residual this extreme is not unusual, so this is a pattern to note, not a sign that the model fails. With
more plants in this group, several of them in the tails would suggest that the distribution of plant effects should
be wider or have a longer tail than the Normal distribution allows.

**Figure walkthrough**

The figure is DHARMa's own plot of the 84 measurements under the model with origin and chilling, from 1,000
hypothetical samples with new plant deviations (seed 701). On the left, the quantile–quantile plot follows the
diagonal. On the right, the residuals against the rank of the typical curve of each measurement, with dashed lines at
0.25, 0.5 and 0.75: the line of the upper quartile lies above 0.75, most of all at low typical values, and DHARMa
draws it in red. Many of the measurements with low typical values belong to the chilled plants from Mississippi, and
the residuals of Mc1 and Mc3 are mostly high, because both plants lie above the typical curve (slide 23) and their
seven measurements share that deviation. So this pattern comes from two plants, not from the shape of the curve. The
panels are small at slide size; read them aloud. The printed tests are on the figure because DHARMa draws them; as in
Chapter 6, we read the plots and the dispersion statistic as exploratory evidence and do not rest decisions on the
p-values.

## Slide 26 — AIC for grouped models

Grouped models are compared with AIC calculated from the maximum marginal log-likelihood. $K$ counts the parameters
that were estimated, the fixed effects and the variance parameters, but not the random effects, which were integrated
out. The vector `par` of a fit holds exactly these parameters, so $K$ is its length.

A model without random effects is the special case $\sigma_{\mathrm{group}}=0$, which lies at the boundary of the
range of the parameter, where the large-sample theory behind AIC does not hold. So a comparison between models with
and without random effects is only an approximate guide.

AICc and BIC need the number of independent observations $n$, and for grouped data it is ambiguous. The observations
of a group are not independent, because they share its deviation, but they are not one observation either, because
each adds information about the curve of its group. The effective number lies somewhere between the number of groups
and the number of observations, and depends on how large the variance among groups is compared with the variance
within groups. So we do not use AICc and BIC for grouped models, and compare them with AIC and with cross-validation.
This is the question that Chapter 6 deferred to this chapter when it chose 16 tanks and not 610
tadpoles as $n$.

For the CO₂ data, the model with a random asymptote has $K=5$, not 17: the 12 deviations cost one parameter,
$\sigma_{\mathrm{plant}}$. Ask the question of the example box (84 measurements or 12 plants?) before giving the
answer of the last bullet.

## Slide 27 — Leave-one-group-out cross-validation

**Leave-one-group-out cross-validation** holds out one whole group at a time. Every parameter is estimated again from
the other groups, and the held-out group is scored by its marginal log-likelihood under that fit: the log density of
all its observations together, with its effect integrated out, because the effect of a new group is not known. The
score of a model is the sum over the groups, and a larger score is better, as in Chapter 6.

Chapter 6 noted that each held-out part should be a block of related observations. If we held out single
observations, the other observations of the same group would stay in the fit, and their group deviation would make
the held-out observation look easier to predict than an observation of a new group. Holding out whole groups scores
the models by how well they predict a group that was not used to fit them, which is the question of partial pooling.

To score a held-out group we need its marginal log-likelihood at the estimates from the other groups. That is the
value of `fn` of an object for the data of that group, with every parameter except the random effects fixed at those
estimates. The argument `map` of `MakeADFun()` fixes parameters: it is a list with one element for each parameter to
fix, named as in the list of parameters, and each element is a factor with one value per element of the parameter;
`factor(NA)` fixes a parameter with one element at its value in the list of parameters. The fixed parameters are left
out of `par`, so when every parameter but the random effects is fixed, `par` is empty, and `fn(par)` returns the
marginal NLL of the data at the fixed values. Every fit starts from the same fixed starting values, and we count the
fits that did not converge.

For the CO₂ data we leave out one plant at a time: 12 fits per model, 60 for the five candidates of slide 28, and all
of them converged.

**Delivery**

The functions `subset_plants()` and `plant_loglik()` and the loop are on the chapter page ("Comparing grouped
models"); do not show them. If a student asks why the held-out plant is not scored by its predicted effect: it has
none, because it was not in the fit, and a new plant's effect is unknown.

## Slide 28 — Comparing the candidates

Only differences between models matter for each criterion, so the table gives the difference of each model from the
best one: the lowest AIC and the highest leave-one-plant-out score, whose differences are therefore zero or negative.
Recall that a difference of one unit in the log score corresponds to about two units of AIC.

The five candidates answer two questions: do the plants differ beyond their origin and treatment, and do origin and
chilling explain part of the differences? Both criteria prefer the random asymptote with origin, chilling and their
interaction, and both rank complete pooling without predictors last by far. They agree that the plants differ beyond
their origin and treatment: with the same fixed effects, the random asymptote is better than complete pooling by 19.2
units of AIC and 22.2 units of log score. They agree on the direction of the interaction but not on its strength: AIC
prefers the model with the interaction by 8.6 units, leave-one-plant-out by only 0.33 units of log score. And they
disagree on the order of two models. AIC prefers complete pooling with predictors to the random asymptote without
predictors (by 5.9 units), whereas leave-one-plant-out prefers the random asymptote, by 19.2 units of log score. The
likelihood of complete pooling treats the seven measurements of a plant as independent, so its AIC estimates how well
it predicts new measurements that are independent of each other; a new plant has seven measurements that share its
deviation, which this model cannot predict. Leave-one-plant-out scores exactly that, so it is the better guide when
models with and without random effects are compared.

No pooling is not in the table. Its AIC, 372.9, is lower than that of every mixed model, but it answers another
question. Its likelihood describes new measurements of the same 12 plants, with their 12 asymptotes as parameters,
whereas the marginal likelihood of a mixed model describes the measurements of a new plant, whose asymptote is
unknown. The two likelihoods are probabilities of different things, so their AICs cannot be compared. Nor can
leave-one-plant-out score no pooling, because it has no asymptote for a plant that was not used to fit it.

For the ecological question the chapter uses the model with the interaction. Chilling multiplies the typical uptake
capacity of plants from Quebec by about 0.90 (0.79 to 1.03) and that of plants from Mississippi by about 0.59 (0.52
to 0.68), and the ratio of the two factors lies between 0.53 and 0.81. So a cold night hardly affects the plants
from the colder origin, and lowers the capacity of the plants from the warmer origin by about two fifths. Plants of
the same origin and treatment differ by roughly 8% (5% to 14%), or 10% when the variance is estimated by REML. With
three plants per combination, these conclusions rest on 12 plants, which is why the intervals are wide.

**Delivery**

Read the table by rows in pairs: rows 1 and 3 (and 2 and 5) differ only in the plant deviations; rows 4 and 5 only in
the interaction; rows 2 and 3 are the pair on which the criteria disagree. The takeaway is the general point: the
criteria rank the candidates and can disagree, and what the ranking means for the question is a matter of ecological
interpretation. Do not present the choice of the model with the interaction as settled by the criteria alone.

## Slide 29 — A recipe for a grouped response curve

The steps of this chapter extend the recipe of Chapter 6 to observations that come in groups, and the chapter
collects them in a note callout before the summary. Read the nine steps with the tool of each: identify the
observational unit, the groups and the level at which each predictor is measured; choose the curve, the observation
model and the parameter that varies among groups, on a scale on which a Normal deviation is plausible (the logarithm
of a positive parameter, the logit of a probability); write the joint NLL with the density of the random effects
first; process it with `MakeADFun()` and `random`, fit it with `optim()` and check `convergence`; read the variance
components and predicted effects from `sdreport()`, with likelihood profile intervals from `TMB::tmbprofile()` and
REML when the variances are the question; draw the curves of observed groups, the typical curve and the range of new
groups, each for the question that it answers; mark the response with `OBS()`, simulate with `obj$simulate()` and
check the residuals of the observations and of the groups; compare the candidates, fitted by maximum likelihood to
the same observations, with AIC and leave-one-group-out cross-validation; and interpret the fixed effects and the
variance among groups in units, saying what the number of groups leaves uncertain.

**Delivery**

About two minutes. Steps 2, 4 and 8 extend steps of Chapter 6; point at the new ones (1, 3, 5 with REML, 6 and 7 with
the residuals of the groups). The practical follows the same sequence in its worked exercise.

## Slide 30 — The Chapter 7 R practical

The practical fits models with random effects to four data sets in which the observations come in groups; three of
them were used in earlier chapters, where the observations were treated as independent. Exercise 1, on the growth of
14 loblolly pines (`Loblolly`, built into R), is worked on the page: the saturating exponential as a growth curve with
a random asymptote for each tree, the variance components with a likelihood profile interval, the curves of the trees
and of new trees, residuals of measurements and trees, and AIC. Exercise 2 returns to the reed frog tanks of the
Chapter 4 practical (`ReedfrogPred`, `emdbook`): a Binomial model with a random effect for each tank on the logit
scale, against the Beta-Binomial model of Chapter 6. Exercise 3 uses all the visits to 27 barn owl nests (`Owls`,
`glmmTMB`) with a Negative Binomial model and a random effect for each nest, and compares no pooling with partial
pooling. Exercise 4 models the salamander counts of Chapter 2 at 23 stream sites (`Salamanders`, `glmmTMB`) with a
Poisson model and a random effect for each site, and fits the same model with a formula in `glmmTMB`. Exercise 5 is
extra practice: it compares maximum likelihood and REML estimates of a variance among groups by simulation.

Try each exercise before checking the solution.

## Slide 31 — Summary and closing questions

Observations that come in groups share the conditions of their group, so they are not independent. A grouped model
describes this with two levels: the effects of the groups follow a distribution, and the observations follow a
distribution for given values of these effects, so the observations of a group are independent for a given effect of
their group but dependent marginally. Complete pooling ignores the groups, no pooling gives each group parameters of
its own, and partial pooling, the mixed model, describes both the measured groups and groups in general. The
likelihood is the marginal likelihood, with the random effects integrated out, and RTMB approximates the integrals
with the Laplace approximation when we name the random effects in `random`. Group-level predictors explain part of the
variation among groups, the variance component describes the variation that remains, and the predicted effects of the
groups are shrunk towards the typical value. A variance among groups is informed by the number of groups, and REML
reduces the bias of its estimate. The curve of an observed group, the typical curve and the range of new groups answer
different questions. Grouped models are checked at both levels and compared with AIC and leave-one-group-out
cross-validation. On the diagram of slide 3, the lecture added groups to the model and marginalisation to the
estimation.

Return to this slide for the two closing questions.

**Discussion and expected answers — allow about two minutes**

Question 1: the variance among groups is informed by the deviations of the groups, and there is one deviation per
group. Measuring each group more often makes each deviation more precise, but the number of deviations stays the same,
so the precision of the variance is limited by the number of groups (slide 22). For the CO₂ data, 84 measurements but 12
plants. To estimate it more precisely, observe more groups.

Question 2: for a group that was not measured we do not know its effect, so we use the typical curve for its values of
the predictors, with the range of new groups; the curve of a measured group describes only that group (slide 23 and
Practice 3). Accept answers that add that the typical curve is the median group, not the mean.

**Final transition**

In the chapter every fit converged from simple starting values. Chapter 8 turns to the
difficulties of finding the maximum of a likelihood: bounds, scaling, starting values, local maxima and problems with
the Hessian. Exercise 5 of the practical meets one of them, fits that stop at a variance of practically zero, and
Chapter 8 returns to that example. The practical comes first.

## Adjustments during delivery

The slides take 116 minutes and leave 14 minutes of slack, which comes last. The demo is kept whole; if it overruns,
it takes the slack first. If discussion overruns, use the slack first, then shorten in this order:

- Slide 3 to one sentence: recovers about half a minute.
- Slide 5 to the figure and the example box, with the provenance in one sentence: about one minute.
- Slide 9 to the two definitions: about one minute.
- Slide 18 to the takeaway, with one sentence on the two columns: about one and a half minutes.
- Slide 12 to questions 2 and 4: about one and a half minutes.
- Slide 24 given as homework, with the answers in one sentence: about two and a half minutes.
- Slide 27 to the definition and the first bullet, without `map`: about one and a half minutes.
- Slides 29 and 30 to one sentence each: about two minutes together.

Keep the conditional and marginal distributions (slides 6 and 7), the model with a random asymptote (slide 8), the
three ways to share information (slide 11), the marginal likelihood (slide 13), random effects in RTMB (slide 15),
shrinkage (slide 19) and the curves for observed and new groups (slide 23).

The breaks are placed between the blocks, after slides 12 and 20 (minutes 35 and 75). If a block runs over, shorten the
block rather than the following break.

**If time is left: code to run**

No code is run live apart from the demo, which stops before the uncertainty of the variance components and the
comparison. Students can follow the chunks of the chapter page at home, by section: "Uncertainty in a grouped model"
(the likelihood profiles of `log_sd_plant` and `beta_int`, and the REML fit with the fixed effects in `random`),
"Checking a grouped model" (the NLL with `OBS()`, the loop over `treatment_obj$simulate()`,
`DHARMa::createDHARMa()` and `DHARMa::recalculateResiduals()`) and "Comparing grouped models" (the two extra NLLs,
`fit_model()`, the list `models`, AIC, `subset_plants()`, `plant_loglik()` with `map`, and the loop that leaves out one
plant at a time).
