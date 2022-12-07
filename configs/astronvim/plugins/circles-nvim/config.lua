local circles_ok, circles = pcall(require, "circles")
if not circles_ok then
  return
end

circles.setup({})
