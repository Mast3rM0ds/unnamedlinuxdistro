column_padding = 2

art = {
  source = "./logos/logo.txt"
}

function fetch()
  return {
    columns = {
      art.out,
      {
        color.red(user.name .. "@" .. host.name),
        color.yellow("os:"),
        color.green("kernel:"),
        color.cyan("cpu:"),
        color.blue("gpu:"),
        color.magenta("ram:"),
      },
      {
        "",
        string.lower(os.name),
        string.lower(kernel.sysname).." "..kernel.release,
        string.lower(cpu.name),
        string.lower(gpu.name),
        string.format("%.1fGB/%.1fGB (%.1f%%)", memory.used_gb, memory.total_gb, memory.percent)
      }
    }
  }
end
