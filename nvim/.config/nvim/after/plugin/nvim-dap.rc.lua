local installed, dap = pcall(require, "dap")

if not installed or not dap then
  return
end

dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = 9213,
    executable = {
      command = "bundle",
      args = {
        "exec", "rdbg",
        "--nonstop",
        "--open",
        "--port", 9213,
        "--command", "--", "bundle", "exec", config.command, config.script,
      },
    },
  }
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
}
