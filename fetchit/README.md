# fetchit

![fetchit screenshot](./assets/fetchit-screenshot)

A minimal system info fetcher written in C and configurable in lua

## build

```bash
git clone https://codeberg.org/nzuum/fetchit && cd fetchit
sudo make install
make install-config
```

## configure it

fetchit will copy the `init.lua` and `logos/logo.txt` into your
`~/.config/fetchit` folder on install

```lua
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
```

the default config only uses a few of the modules that fetchit exposes to the
lua state. for a full list, look below

## learn

### host

```lua
host.name
```

### user

```lua
user.name
```

### os

```lua
os.name
```

### kernel

```lua
kernel.sysname
kernel.release
```

### cpu

```lua
cpu.name
```

### gpu

```lua
gpu.name
```

### memory

```lua
-- it is recommended to format x_gb. i.e: string.format(%.1fgb, memory.total_gb)
memory.total_gb
memory.used_gb
memory.available_gb
memory.percent
```

### disk

```lua
-- it is recommended to format x_gb. i.e: string.format(%.1fgb, disk.total_gb)
disk.total_gb
disk.used_gb
```

### vendor

```lua
vendor.name
vendor.model
```

### uptime

```lua
uptime.pretty -- 12h 6m
uptime.seconds -- 43560
```

### shell

```lua
shell.name
```

### terminal

```lua
terminal.name
```

### art

art source is to be specified in the config file. the path is relative to the
config's location

```lua
art = {
    source = "path/to/file"
}
```

### color

```lua
color.black()
color.red()
color.green()
color.yellow()
color.blue()
color.magenta()
color.cyan()
color.white()
color.bright_black()
color.bright_red()
color.bright_green()
color.bright_yellow()
color.bright_blue()
color.bright_magenta()
color.bright_cyan()
color.bright_white()
color.bold()
color.reset()
```
