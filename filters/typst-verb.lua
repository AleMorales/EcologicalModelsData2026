-- Typst output only: pandoc cannot convert \verb|...| inside mathematics (the
-- course uses it for R code with ^ or _, which MathJax refuses in \texttt{}).
-- Replace it with \text{...}, which Typst renders as plain upright text.
function Math(el)
  local text = el.text:gsub("\\verb(%p)(.-)%1", function(_, code)
    return "\\text{" .. code .. "}"
  end)
  if text ~= el.text then
    el.text = text
    return el
  end
end
