local exists, fidget = pcall(require, "fidget")

if not exists then
  return
end

fidget.setup()
