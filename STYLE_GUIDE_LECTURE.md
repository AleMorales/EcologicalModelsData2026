# Style guide for lecture slides

This guide records the conventions of the Chapter 1 lecture
(`Chapter_1/Lecture/`) so that the lectures of later chapters look and work the same.
It covers files, structure, slide content, the script, incremental building and styling.
Prose, notation, British English, units and R conventions come from `STYLE_GUIDE.md` and
apply to slides and script alike; they are not repeated here. The author revised the
Chapter 1 slides on 26 October 2026 (shorter text, notes moved out of the slides), so the
slides are the reference for format and amount of text. The script is generated text that
the author edited and is never a model of voice (`AGENTS.md`).

## Files of a lecture

Each lecture lives in `Chapter_N/Lecture/`:

- `lecture.qmd`: the slides (Reveal.js). They carry no speaker notes: the lecturer
  speaks from the script.
- `lecture-script.md`: what to say, slide by slide, with the timing table and the
  provenance of the figures (see "The script").
- `lecture-script.pdf`: a printout of the script for the lecturer. Generated (Typst);
  regenerate it after changing the script and never edit it.
- `lecture.scss`: presentation styling. Copy the Chapter 2 file (the Chapter 1 file plus
  the rules for live demos) and keep the class names below; do not restyle per lecture.
- `lecture-assets/`: figures made for the slides (schematics as SVG, copies of chapter
  figures as PNG). Copies of figures from the chapter are unchanged; their code and
  data provenance stay in the chapter's `Theory.qmd`. Refresh copies when the original
  changes and say so in the script. The author's own diagrams (`ModelCycle.png`,
  `Estimation.png` in Chapter 1) sit next to `lecture.qmd` and are never edited; a later
  lecture references them from `Chapter_1/Lecture/` and does not copy them. The code of
  every PNG made for the slides (new figures and copies) is in
  `lecture-assets/figures.R`, which runs in a clean R session from the repository root
  and writes into `lecture-assets/`.
- `lecture.html` and `.quarto/` are generated (`quarto render
  Chapter_N/Lecture/lecture.qmd --to revealjs`, from the repository root); never edit
  them.

There is no separate README: how to render is stated above, and the script says which
slides use which figure.

## Size and timing

- Every slide has `data-timing="<seconds>"` (for the speaker view's timer). The slides
  show no times and have no notes; the script has the table with minutes and elapsed
  time.
- **The author sets the length of each lecture** when asking for it (Chapter 1: 60
  minutes). Never assume a length from an earlier lecture: if the request does not give
  one, ask before planning slides.
- Plan the slides to fill the length minus a few minutes of slack for discussion (Chapter
  1: about 57 minutes of slides and 3 of slack), which appears as its own row of the
  table. The number of slides follows from the time and not the other way round.
- **Live demos and breaks** are outside the length that the author sets for the slides.
  A demo slide's `data-timing` includes its demo (one minute of introduction plus the
  demo), so that the speaker view tracks the whole session; the script's table shows the
  two parts ("1 + 12"). A break is a row of the table without a slide number, and the
  line under the table totals slides, slack, demos and breaks.
- Time goes to what students must understand; the Chapter 1 allocation is a guide for
  proportions: 1 minute for the title and overview
  slides, 2 for the roadmap slides and the slide that opens the argument, 3 to 4 for
  slides with a figure, an activity or a discussion.

## Front matter

Use the Chapter 1 settings: `revealjs` with `theme: [simple, lecture.scss]`,
`embed-resources: true`, `slide-level: 2`, 1440 × 900, `margin: 0.06`, `center: false`,
`transition: fade`, `slide-number: c/t`, `navigation-mode: linear`, `hash: true`,
`history: false`, `incremental: false` (build lists with the classes below, not
globally), `default-timing: 180`, `show-notes: false`, `toc: false` and
`number-sections: false`. The course name is written in title case, as a title, in
`pagetitle` ("Chapter N — Ecological Models and Data Analysis"), on the title slide and in
the footer ("Ecological Models and Data Analysis · Chapter N"). Every other slide title
is in sentence case.

## Slide sequence

1. **Title slide:** class `.lecture-title`; the `##` title is the course name, then a
   `.subtitle` ("Chapter N · Lecture") and an `.eyebrow` with the subject of the chapter
   ("Introduction and Course Overview").
2. **Overview of the lecture:** a numbered list of the parts, each a bold keyword and a
   question ("**Estimates and uncertainty:** what can we learn from data?"), in the order
   of delivery.
3. The content slides, in the order of the chapter, built on one running example that
   returns across slides (Chapter 1: the feeding response of a predator). A lecture may
   open with a slide that states the problem of the chapter and what it offers, and may
   show an organising figure early as a map (Chapter 1: the modelling cycle). The summary
   returns to that figure by speaking about it again, without a new slide.
4. **Live demo slides** when the author runs R during the lecture: one slide titled
   "Live demo: <topic>" at the end of the block that it practises (class `.demo-slide`),
   with an incremental list of 3 or 4 tasks, each a short phrase naming what is run,
   and a `.demo` box that names the chapter sections to open ("**Follow along:**
   Chapter 2, *The four faces of a distribution*"). A demo uses the code chunks and
   `Practice` callouts of the chapter, not new scripts, and its instructions are only in
   the script.
5. Roadmap slides when the chapter points forward: tables of at most four rows per
   slide, titled "Course roadmap: A to B".
6. **Practical slide** when a practical accompanies the lecture: what it covers, as
   bold keywords, and a `.takeaway` on how to work with it.
7. **Summary and closing questions** (class `.closing`): the take-home points, a
   `.takeaway` that strings the key terms, and an `.activity` with the closing
   questions as a numbered list.

## Content of a slide

Slides carry keywords and very short sentences, for students who do not know the course
yet. The narrative lives in the script.

- `##` is the slide title, in sentence case, as a noun phrase or a short question
  ("Parameter uncertainty"). A discussion slide begins "Discussion: ..." ("Discussion:
  which source of variation?"). `###` heads a block inside a slide (columns). No deeper
  levels.
- At most one idea per slide and roughly four short bullets. A bullet is a bold keyword
  followed by a few words ("**Straight line:** keeps increasing."), or a fragment of a
  sentence. No paragraphs on slides; a line of the lecture's overview or of a slide may
  be a question.
- Terms are written out. A short form ("Obs error", "Process var.") is acceptable only in
  a list that compares terms defined on the previous slides, and never on the slide that
  introduces them.
- Slides do not name things that mean nothing to students yet (for example a package);
  the script names them when the moment comes.
- Figures, not text, carry the content of a figure slide; the text beside it says how
  to read it (for a diagram, what the line styles mean). Every image has `fig-alt` that
  describes what it shows, not just what it is. A `.caption` gives the meaning of colours,
  bands and numbers in the figure in one short sentence.
- Use the same terms as the chapter (observation error, process variation, parameter
  uncertainty; "model", not "theory"). Keep the provenance and caveats of data in the
  script, once.
- A chain of ideas may be written as a takeaway with arrows ("Questions $\rightarrow$
  Models $\rightarrow$ Parameters $\rightarrow$ Answers"); a string of key terms is
  separated by ` · `.

### Boxes

Five kinds of box, all fenced divs, each with a fixed role:

| Class | Use |
|---|---|
| `.definition` | A bold term and its definition: "**Parameter:** a quantity that sets a feature of the model." |
| `.example` | A short numerical or concrete case, inside a column or under a definition. |
| `.takeaway` | The one sentence or string of keywords that the slide should leave behind. At most one per slide. |
| `.activity` | A question for the students or a timed task ("**30 seconds:** discuss with a neighbour."). It states the time when the activity is timed. At most one per slide. |
| `.demo` | On a live demo slide only: the chapter sections that students open to follow along. The stylesheet adds a small "Live demo" label. |

Place the `.takeaway` and `.activity` last on the slide. Other helpers: `.caption`
(figure caption in small type), `.columns` and `.column width="NN%"` for two columns
(two text columns 50/50; text and figure 56/44 to 65/35 with the figure in the larger
column; two figures 50/50), `.roadmap` on a slide with a table.

### Slide classes for figures

Add the class to the slide title line, for example `## Title {.figure-slide
data-timing="240"}`, and the class to the image:

- `.schematic` (image class): a schematic in a 56 to 60% column.
- `.two-plots`: two figures side by side, each with a heading and a one-line description
  of the model (the observations and the fitted model are explained once in the caption).
- `.figure-slide`: a large figure in a 62 to 65% column with a short list beside it.
- `.diagram-slide`: the author's own diagrams (`.cycle-diagram`, `.estimation-diagram`
  on the image). The modelling cycle may stand alone with a caption.
- `.dense`, `.with-footline`: for slides with more text or a footline; not used so far.
- `.demo-slide`: a live demo slide (see "Slide sequence").

### Code on slides

Short display chunks only, taken from the chapter: ```` ```{r} ```` with `#| echo: true`
and `#| eval: false`. The `echo` line is needed because Reveal.js output hides code by
default; `eval: false` keeps the render free of R packages. Results are quoted in short
comments in the chunk or in the script, not both.

## Incremental building

Build with Reveal.js fragments, so that students read what the speaker is explaining.
The more text or topics on a slide, the more steps.

- **Lists:** wrap a list in `::: {.incremental}` so that its items appear one by one.
  Applies to bullet and numbered lists (overview, summary, keyword lists, the list
  beside a figure). Inside a column, the wrapper goes inside the column div.
- **Columns:** each column of a two-column text slide is one fragment (wrap the
  heading and the text in `::: {.fragment}` inside the column, or put `.fragment` on
  the column div). On a `.two-plots` slide the first figure is visible from the start and
  the second column is the fragment. A figure that is the subject of a figure slide is
  visible from the start.
- **Explanation beside a diagram:** the lines that say how to read it (for example what
  solid and dashed arrows mean) are fragments.
- **Takeaways and activities:** `::: {.takeaway .fragment}` and `::: {.activity
  .fragment}`, so that students think about the question before the answer or the
  prompt appears. Exception: a timed discussion slide shows its `.takeaway` (the labels
  that students apply) and its `.activity` from the start, because the task is what the
  slide is for.
- **Paired boxes:** a `.definition` that follows a list or another definition is a
  fragment.
- **Not built:** the title slide, a diagram that is walked through live with a pointer
  (the cycle), tables (a table cannot be built by row, and roadmap tables are read as a
  whole), and slides with one short line.
- Fragments change what is visible and never the text; the script does not mention
  them.

## The script

`lecture-script.md` is written for the lecturer to speak from. It has, in this order:

1. A title (`# Chapter N lecture script: <title>`) and a short opening: that it is a draft
   for the author's review, the target time set by the author, links to the chapter theory and the
   practical, that the narrative is here and not on the slides, and which slides use which
   figure (the author's diagrams, the schematics and the copies of chapter figures, with
   their slide numbers).
2. `## Timing and slide sequence`: a table (slide, topic, minutes, elapsed time) with a
   row for the slack and a row for the total. The topics are the slide titles and the
   minutes agree with `data-timing`.
3. One section per slide, `## Slide N — Title`, in the order of the slides. A title and
   an overview slide that are spoken together may share one section headed "Slides 1 and
   2". Slide numbers in the script are the numbers of the rendered slides and are updated
   when slides are added or removed.
4. `## Adjustments during delivery`: which slides to shorten first when discussion
   overruns and how much time that recovers, which explanations to keep, and where a
   break fits.

The section of a live demo slide has the narrative of its one-minute introduction and
then a **Live demo** block: the steps in order with the chapter chunks to run, what to
point out in the output, the `Practice` callouts that students try first (1 to 2 minutes)
before they are solved live, time checkpoints ("by minute 6, start here"), code only
where the chapter has none, and what to drop when the demo runs late. A break is a
single line ("Break (10 minutes).") after the section of the slide that precedes it.

A section is the narrative in full sentences, which follows the chapter, connects the
slide to the neighbouring slides by number ("slide 14 looks at that assumption") and to
later chapters, states caveats once and gives sources in full when the lecturer may cite
them. The slide leaves out what the narrative explains. There are no "On the slide" or
"Speaker notes" headings and no timing line in a section: the table carries the times.

After the narrative, one bold block named for what it is, where the slide needs it:
**Delivery**, **Figure walkthrough**, **Figure discussion**, **Discussion**, **Short
activity**, **Check for understanding** or **Transition**. It tells the lecturer which
question to ask, what to point at, which answers to accept and how much time it takes
("included in the four minutes"; "allow about two minutes"). An activity slide gives its
expected answers ("Discussion and expected answers"). A figure slide says what each
element is, what the figure cannot show, and where the calculation is taught. A
**Transition** leads to the next slide where the link is not obvious; the last slide ends
with a **Final transition** to the next chapter or the practical.

Where the chapter has the author speaking in the first person, the script keeps the
chapter's wording or leaves an optional note for the author to fill in; it never writes
an anecdote or opinion on the author's behalf (`STYLE_GUIDE.md`).

## Styling

`lecture.scss` holds all of it. Colours are the course palette: dark green `#164c43`
(headings, bold, table headers), mid green `#52836a` (takeaway rule), light green
`#f0f6f2` and `#dcece5` (box backgrounds, title rule), Okabe–Ito blue `#0072b2`
(example rule, links) and vermillion `#d55e00` (activity rule; the `.demo` box has a dark
green rule), with `#263530` for body
text and `#52605a` for captions and footer. Use `Segoe UI` at 36 px root size and
left-aligned text; no animation beyond the fade transition and fragments. The title slide
has its own rules (`.lecture-title`, `.subtitle`, `.eyebrow`). Figures on slides follow
the figure rules of `STYLE_GUIDE.md` (raw observations blue, fitted models vermillion);
schematics have no numerical scales and no fitted values.

## Checklist for a new lecture

1. The author has given the length of the lecture (otherwise ask), and the timing table
   adds up to it.
2. Title, overview, content, roadmap (if needed), practical (if any), summary with
   closing questions.
3. Slides hold keywords and short bullets, one idea each; there are no notes in the
   slides and the narrative is in the script.
4. Boxes use the five classes; takeaway and activity come last, one of each at most.
5. Lists and columns build with `.incremental` and `.fragment`; diagrams and tables do
   not.
6. Every image has descriptive `fig-alt`; copies of chapter figures are unchanged and
   listed in the script.
7. Slide numbers, titles and times in the script agree with the slides and `data-timing`.
8. The script has the timing table (with slack and total), one section per slide, a
   delivery block where needed and the section on adjustments.
9. Rendered with `quarto render`, and the claim of a render is made only if it ran.
