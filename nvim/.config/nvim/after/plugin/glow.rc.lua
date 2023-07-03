local exists, glow = pcall(require, "glow")

if not exists then
  return
end

glow.setup({
  width = 250,
})
