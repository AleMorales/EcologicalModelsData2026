-- PDF (Typst) book only. It runs before Quarto's own filters (at: pre-quarto in
-- _quarto-pdf.yml), when the files of the book are already combined in one
-- document, and adapts the pages of the website to a book without changing them.
--
-- 1. Heading levels. A page of the website has its title in the YAML and its
--    sections under #, so in the combined document the sections would sit at the
--    level of the chapter titles. Every header except the title of a page moves
--    down one level (# becomes ##).
-- 2. Unique labels. A Typst document allows each label once, but the solution
--    pages repeat the figures, sections and callouts of the practicals under the
--    same IDs. In the chapters whose title contains "solution", "solN-" is inserted
--    after the type prefix of each cross-reference ID (fig-titre_fit becomes
--    fig-sol6-titre_fit, N counting the solution chapters), and the references
--    inside the same chapter are updated.
-- 3. Preface and case studies. The preface (index.qmd) and the chapters whose
--    title starts with "Case study" are not numbered, so that the theory chapters
--    keep the numbers of the course. The case studies'
--    figures, equations and callouts are labelled C1.1, C1.2, ... (C2 for the
--    second), and their running header has no chapter number. A reference to one
--    of their sections becomes a link that names the section, because Typst
--    cannot number a reference to an unnumbered heading.
--
-- Each file of the book starts with a quarto-file-metadata comment followed by a
-- level-1 header with the title of the page; that is how chapters are found.

local crossref_types = {
  fig = true, tbl = true, eq = true, sec = true, lst = true, imp = true,
  thm = true, lem = true, cor = true, prp = true, cnj = true, def = true,
  exm = true, exr = true, nte = true, wrn = true, tip = true, cau = true,
}

-- renamed[N][old_id] = new_id for solution chapter N.
local renamed = {}
-- case_sections[N][id] = inlines of the title, for the sections of case study N.
local case_sections = {}

local function is_marker(el)
  return el.t == "RawBlock" and el.text:find("quarto-file-metadata", 1, true) ~= nil
end

local function title_kind(header)
  local title = pandoc.utils.stringify(header):lower()
  if title:find("solution", 1, true) then return "solution" end
  if title:find("^case study") then return "case" end
end

-- Follows a walk in document order and knows the kind and number of the
-- current chapter.
local function chapter_tracker()
  local state = { expect_title = false, solution = nil, case = nil,
                  n_solution = 0, n_case = 0 }
  function state.raw(el)
    if is_marker(el) then
      state.expect_title = true
      state.solution = nil
      state.case = nil
    end
  end
  -- Returns true when the header is the title of a page.
  function state.header(el)
    if not (state.expect_title and el.level == 1) then return false end
    state.expect_title = false
    local kind = title_kind(el)
    if kind == "solution" then
      state.n_solution = state.n_solution + 1
      state.solution = state.n_solution
    elseif kind == "case" then
      state.n_case = state.n_case + 1
      state.case = state.n_case
    end
    return true
  end
  return state
end

-- First pass: shift headers, rename IDs in solution chapters, and record the
-- sections of the case studies.
local first = chapter_tracker()

local function rename(el)
  if not first.solution then return nil end
  local old = el.identifier or ""
  local prefix, rest = old:match("^(%a+)%-(.+)$")
  if prefix and crossref_types[prefix] then
    renamed[first.solution] = renamed[first.solution] or {}
    local new = prefix .. "-sol" .. first.solution .. "-" .. rest
    renamed[first.solution][old] = new
    el.identifier = new
    return el
  end
end

local first_pass = {
  traverse = "topdown",
  RawBlock = first.raw,
  Header = function(el)
    if first.header(el) then return nil end
    el.level = el.level + 1
    if first.case and el.identifier ~= "" then
      case_sections[first.case] = case_sections[first.case] or {}
      case_sections[first.case][el.identifier] = el.content
    end
    return rename(el) or el
  end,
  Div = rename, Span = rename, Image = rename, Figure = rename, Table = rename,
  CodeBlock = rename, FloatRefTarget = rename, Callout = rename, Theorem = rename,
}

-- Second pass: update the references inside solution chapters and case studies.
local second = chapter_tracker()

local second_pass = {
  traverse = "topdown",
  RawBlock = second.raw,
  Header = function(el) second.header(el) end,
  Cite = function(el)
    local map = second.solution and renamed[second.solution]
    if map then
      for _, c in ipairs(el.citations) do
        if map[c.id] then c.id = map[c.id] end
      end
      return el
    end
    local sections = second.case and case_sections[second.case]
    if sections and #el.citations == 1 and sections[el.citations[1].id] then
      local id = el.citations[1].id
      return pandoc.Link(
        { pandoc.Str("section"), pandoc.Space(),
          pandoc.Quoted("DoubleQuote", sections[id]) },
        "#" .. id)
    end
  end,
  Link = function(el)
    local map = second.solution and renamed[second.solution]
    local target = el.target:match("^#(.+)$")
    if map and target and map[target] then
      el.target = "#" .. map[target]
      return el
    end
  end,
}

-- Typst code that opens the scope of case study n. Set and let rules inside #[ ]
-- end with the scope, so the chapters after it are numbered as before.
local function open_case_study(n)
  local label = "C" .. n
  local code = ([==[
#[
#set heading(numbering: none)
#set figure(numbering: n => "LABEL." + str(n))
#set math.equation(numbering: n => "(LABEL." + str(n) + ")")
#let callout-numbering = n => "LABEL." + str(n)
#let subfloat-numbering(n-super, subfloat-idx) = "LABEL." + str(n-super) + numbering("a", subfloat-idx)
#set page(header: context {
  let physical = here().page()
  if query(heading.where(level: 1)).any(it => it.location().page() == physical) { return }
  let page-number = counter(page).at(here()).first()
  let chapter = query(heading.where(level: 1).before(here())).last()
  set text(size: 11pt)
  if calc.odd(page-number) {
    let sections = query(heading.where(level: 2).before(here()))
    let title = if sections.len() > 0 and sections.last().location().page() >= chapter.location().page() {
      sections.last().body
    } else {
      chapter.body
    }
    box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[#title #h(1fr) #page-number]
  } else {
    box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[#page-number #h(1fr) #text(weight: "bold")[#chapter.body]]
  }
})
]==]):gsub("LABEL", label)
  return pandoc.RawBlock("typst", code)
end

-- Third pass: wrap the preface (the first page, index.qmd) and each case study in
-- their own Typst scope. The preface is not numbered either, so that the theory
-- chapters keep the numbers of the course; it has no figures or running header.
local function wrap_case_studies(doc)
  local out = pandoc.List()
  local expect_title = false
  local inside = false
  local n_case = 0
  local n_title = 0
  for _, block in ipairs(doc.blocks) do
    if is_marker(block) then
      if inside then out:insert(pandoc.RawBlock("typst", "]")) end
      inside = false
      expect_title = true
    elseif expect_title and block.t == "Header" and block.level == 1 then
      expect_title = false
      n_title = n_title + 1
      if n_title == 1 then
        out:insert(pandoc.RawBlock("typst", "#[\n#set heading(numbering: none)"))
        inside = true
      elseif title_kind(block) == "case" then
        n_case = n_case + 1
        out:insert(open_case_study(n_case))
        inside = true
      end
    end
    out:insert(block)
  end
  if inside then out:insert(pandoc.RawBlock("typst", "]")) end
  doc.blocks = out
  return doc
end

return {
  first_pass,
  second_pass,
  { Pandoc = wrap_case_studies },
}
