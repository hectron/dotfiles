local exists, filetype = pcall(require, "filetype")

if not exists then
  return
end

filetype.setup({
  overrides = {
    extensions = {
      sh = "bash",
      pp = "puppet", -- by default, *.pp files are read as PASCAL filetypes :smdh:
      tf = "terraform",
    },
  },
})
