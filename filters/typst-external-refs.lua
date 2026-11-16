-- PDF (Typst) books only. The course is split into three PDFs (textbook,
-- practicals, solutions), so a link of a page to a section of a page that is in
-- another PDF has no destination, and Typst stops with an error for a link to a
-- label that does not exist. This filter replaces such a link (a link to "#id"
-- where no element of the document has that ID) by its text. It runs after
-- Quarto's own filters (post-quarto), when internal links are already "#id".

local ids = {}

local function collect(el)
  if el.identifier and el.identifier ~= "" then ids[el.identifier] = true end
end

local collect_pass = {
  Header = collect, Div = collect, Span = collect, Image = collect,
  Figure = collect, Table = collect, CodeBlock = collect,
}

local function unlink(el)
  local target = el.target:match("^#(.+)$")
  if target and not ids[target] then
    return el.content
  end
end

function Pandoc(doc)
  doc:walk(collect_pass)
  return doc:walk({ Link = unlink })
end
