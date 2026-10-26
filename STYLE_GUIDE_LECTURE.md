# Style guide for lecture slides

This guide records the conventions of the Chapter 1 lecture
(`Chapter_1/Lecture/`) so that the lectures of later chapters look and work the same.
It covers structure, slide content, speaker notes, incremental building, styling and
files. Prose, notation, British English, units and R conventions come from
`STYLE_GUIDE.md` and apply to slides and notes alike; they are not repeated here. The
Chapter 1 lecture is a generated draft awaiting the author's review (`AGENTS.md`), so
use it as a model of format and never of voice.

## Files of a lecture

Each lecture lives in `Chapter_N/Lecture/`:

- `lecture.qmd`: the slides (Reveal.js), with speaker notes in each slide.
- `lecture-script.md`: the same slide text and notes as a readable script, with a
  timing table. Slides and script carry the same text and are changed together.
- `lecture-README.md`: how to render, which assets are copies of what, and what the
  figures show.
- `lecture.scss`: presentation styling. Copy the Chapter 1 file and keep the class names
  below; do not restyle per lecture.
- `lecture-assets/`: figures made for the slides (schematics as SVG, copies of chapter
  figures as PNG). Copies of figures from the chapter are unchanged; their code and
  data provenance stay in the chapter's `Theory.qmd`. Refresh copies when the original
  changes and say so in the README.
- `lecture.html` is generated (`quarto render Chapter_N/Lecture/lecture.qmd --to
  revealjs`, from the repository root); never edit it.

## Size and timing

- Every slide has `data-timing="<seconds>"` (for the speaker view's timer) and, in its
  notes, a first line **Timing: N minutes · A–B minutes from the start.** The script
  has the same table (slide, topic, minutes, elapsed time) and ends with the slack row
  and the total.
- Time goes to what students must understand: 1 to 2 minutes for title, overview and
  roadmap slides, 3 to 4 for slides with a figure, an activity or a discussion.
- The notes of the last slide include "Adjustments during delivery": which slides to
  shorten first when discussion overruns, which explanations to keep, and where a break
  fits.

## Front matter

Use the Chapter 1 settings: `revealjs` with `theme: [simple, lecture.scss]`,
`embed-resources: true`, `slide-level: 2`, 1440 × 900, `margin: 0.06`, `center: false`,
`transition: fade`, `slide-number: c/t`, `navigation-mode: linear`, `hash: true`,
`history: false`, `incremental: false` (build lists with the classes below, not
globally), `default-timing: 180`, `show-notes: false`, a footer
"Ecological modelling and data analysis · Chapter N", `toc: false` and
`number-sections: false`. `pagetitle` names the chapter.

## Slide sequence

1. **Title slide:** class `.lecture-title`; a `.subtitle` ("Chapter N · Lecture") and an
   `.eyebrow` (the course name).
2. **Overview of the lecture:** a numbered list of the parts, each a bold keyword and a
   question ("**Variation:** why do we need probability?").
3. The content slides, in the order of the chapter, built on one running example that
   returns across slides (Chapter 1: the feeding response of a predator).
4. Roadmap slides when the chapter points forward (tables, at most four or five rows per
   slide).
5. **Summary and closing questions** (class `.closing`): a list of the take-home points,
   a `.takeaway` that strings the key terms, and an `.activity` with the closing
   questions.

## Content of a slide

Slides carry keywords and very short sentences, for students who do not know the course
yet. The narrative lives in the speaker notes.

- `##` is the slide title, in sentence case, as a noun phrase or a short question
  ("Parameter uncertainty", "Discussion: which source of variation?"). `###` heads a
  block inside a slide (columns). No deeper levels.
- At most one idea per slide and roughly four short bullets. A bullet is a bold keyword
  followed by a few words ("**Band:** uncertainty of the curve, not of the species."),
  or a fragment of a sentence. No paragraphs on slides.
- Slides do not name things that mean nothing to students yet (for example a package);
  the notes name them when the moment comes.
- Figures, not text, carry the content of a figure slide; the text beside it says how
  to read it. Every image has `fig-alt` that describes what it shows, not just what it
  is.
- Use the same terms as the chapter (observation error, process variation, parameter
  uncertainty; "model", not "theory"). Keep the provenance and caveats of data in the
  notes, once.

### Boxes

Four kinds of box, all fenced divs, each with a fixed role:

| Class | Use |
|---|---|
| `.definition` | A bold term and its definition: "**Parameter:** a quantity that sets a feature of the model." |
| `.example` | A short numerical or concrete case, inside a column or under a definition. |
| `.takeaway` | The one sentence or string of keywords that the slide should leave behind. At most one per slide. |
| `.activity` | A question for the students or a timed task ("**45 seconds:** discuss with a neighbour."). It states the time when the activity is timed. At most one per slide. |

Place the `.takeaway` and `.activity` last on the slide. Other helpers: `.caption`
(figure caption in small type, with the meaning of colours, bands and axes), `.columns`
and `.column width="NN%"` for two columns (text and figure 60/40 or 62/38; two figures
50/50), `.roadmap` on a slide with a table.

### Slide classes for figures

Add the class to the slide title line, for example `## Title {.figure-slide
data-timing="240"}`, and the class to the image:

- `.schematic` (image class): a schematic in a 56 to 60% column.
- `.two-plots`: two figures side by side, each with a heading and a one-line caption.
- `.figure-slide`: a large figure in a 62 to 65% column with a short list beside it.
- `.diagram-slide`: the author's own diagrams (`.cycle-diagram`, `.estimation-diagram`
  on the image).
- `.dense`, `.with-footline`: available for slides with more text or a footline.

## Incremental building

Build with Reveal.js fragments, so that students read what the speaker is explaining.
The more text or topics on a slide, the more steps.

- **Lists:** wrap a list in `::: {.incremental}` so that its items appear one by one.
  Applies to bullet and numbered lists of three or more items (overview, summary,
  keyword lists). Inside a column, the wrapper goes inside the column div.
- **Columns:** each column of a two-column text slide is one fragment (wrap the
  heading and the text in `::: {.fragment}` inside the column, or put `.fragment` on
  the column). A figure that is the subject of the slide is visible from the start.
- **Takeaways and activities:** `::: {.takeaway .fragment}` and `::: {.activity
  .fragment}`, so that students think about the question before the answer or the
  prompt appears. Exception: a timed discussion slide shows its `.activity` from the
  start, because the task is what the slide is for.
- **Paired boxes:** a `.definition` that follows a list or another definition is a
  fragment.
- **Not built:** the title slide, a diagram that is walked through live with a pointer
  (the cycle, the estimation figure), tables (a table cannot be built by row, and
  roadmap tables are read as a whole), and slides with one short line.
- Fragments change what is visible and never the text: slides and script stay
  identical, and the script does not mention fragments.

## Speaker notes

Every slide ends with `::: {.notes}` holding, in this order (omit headings that do not
apply):

1. **Timing:** as above.
2. **Speaker notes:** the narrative, in full sentences, written for the lecturer to
   speak. It follows the chapter, connects the slide to the neighbouring slides by
   number ("slide 14 looks at that assumption") and to later chapters, states
   caveats once and gives sources in full when the lecturer may cite them. The slide
   leaves out what the notes explain.
3. One delivery block, named for what it is: **Delivery**, **Figure discussion**,
   **Figure walkthrough**, **Discussion**, **Short activity**, **Check for
   understanding** or **Transition**. It tells the lecturer which question to ask,
   what to point at, which answers to accept and how much time it takes ("included in
   the three minutes").
4. **Transition:** a sentence that leads to the next slide, where the link is not
   obvious.

An activity slide gives its expected answers in the notes. A figure slide says what
each element is, what the figure cannot show, and where the calculation is taught. Notes
that mention slide numbers are updated when slides are added or removed, in the script
and in the README.

## The script file

`lecture-script.md` follows the slides one to one: a heading `## Slide N — Title`, then
**On the slide** (the slide text), **Speaker notes** and the delivery block, with the
timing table at the top. It states that it is a draft for the author's review, links the
chapter theory and practical, and lists which figures come from where.

## Styling

`lecture.scss` holds all of it. Colours are the course palette: dark green `#164c43`
(headings, bold, table headers), mid green `#52836a` (takeaway rule), light green
`#f0f6f2` and `#dcece5` (box backgrounds, title rule), Okabe–Ito blue `#0072b2`
(example rule, links) and vermillion `#d55e00` (activity rule), with `#263530` for body
text and `#52605a` for captions and footer. Use `Segoe UI` at 36 px root size and left-aligned text; no
animation beyond the fade transition and fragments. Figures on
slides follow the figure rules of `STYLE_GUIDE.md` (raw observations blue, fitted
models vermillion); schematics have no numerical scales and no fitted values.

## Checklist for a new lecture

1. Title, overview, content, roadmap (if needed), summary with closing questions.
2. Slides hold keywords and short bullets, one idea each; the narrative is in the notes.
3. Boxes use the four classes; takeaway and activity come last, one of each at most.
4. Lists and columns build with `.incremental` and `.fragment`; diagrams and tables do
   not.
5. Every image has descriptive `fig-alt`; copies of chapter figures are unchanged and
   listed in the README.
6. Slide numbers in notes, script and README agree with the slide order.
7. `lecture.qmd` and `lecture-script.md` carry the same text.
8. Rendered with `quarto render`, and the claim of a render is made only if it ran.
