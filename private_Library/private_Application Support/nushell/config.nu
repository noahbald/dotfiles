# Nushell Config File
#
# version = "0.86.0"

# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes
const color_palette = {
    rosewater: "#f5e0dc"
    flamingo: "#f2cdcd"
    pink: "#f5c2e7"
    mauve: "#cba6f7"
    red: "#f38ba8"
    maroon: "#eba0ac"
    peach: "#fab387"
    yellow: "#f9e2af"
    green: "#a6e3a1"
    teal: "#94e2d5"
    sky: "#89dceb"
    sapphire: "#74c7ec"
    blue: "#89b4fa"
    lavender: "#b4befe"
    text: "#cdd6f4"
    subtext1: "#bac2de"
    subtext0: "#a6adc8"
    overlay2: "#9399b2"
    overlay1: "#7f849c"
    overlay0: "#6c7086"
    surface2: "#585b70"
    surface1: "#45475a"
    surface0: "#313244"
    base: "#1e1e2e"
    mantle: "#181825"
    crust: "#11111b"
}

let dark_theme = {
    separator: $color_palette.overlay0
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: $color_palette.blue attr: "b" }
    empty: $color_palette.lavender
    bool: $color_palette.lavender
    int: $color_palette.peach
    duration: $color_palette.text
    filesize: {|e|
          if $e < 1mb {
            $color_palette.green
        } else if $e < 100mb {
            $color_palette.yellow
        } else if $e < 500mb {
            $color_palette.peach
        } else if $e < 800mb {
            $color_palette.maroon
        } else if $e > 800mb {
            $color_palette.red
        }
    }
    date: {|| (date now) - $in |
        if $in < 1hr {
            $color_palette.green
        } else if $in < 1day {
            $color_palette.yellow
        } else if $in < 3day {
            $color_palette.peach
        } else if $in < 1wk {
            $color_palette.maroon
        } else if $in > 1wk {
            $color_palette.red
        }
    }
    range: $color_palette.text
    float: $color_palette.text
    string: $color_palette.text
    nothing: $color_palette.text
    binary: $color_palette.text
    cellpath: $color_palette.text
    row_index: { fg: $color_palette.mauve attr: "b" }
    record: $color_palette.text
    list: $color_palette.text
    block: $color_palette.text
    hints: $color_palette.overlay1
    search_result: { fg: $color_palette.red bg: $color_palette.text }

    shape_and: { fg: $color_palette.pink attr: "b" }
    shape_binary: { fg: $color_palette.pink attr: "b" }
    shape_block: { fg: $color_palette.blue attr: "b" }
    shape_bool: $color_palette.teal
    shape_custom: $color_palette.green
    shape_datetime: { fg: $color_palette.teal attr: "b" }
    shape_directory: $color_palette.teal
    shape_external: $color_palette.teal
    shape_externalarg: { fg: $color_palette.green attr: "b" }
    shape_filepath: $color_palette.teal
    shape_flag: { fg: $color_palette.blue attr: "b" }
    shape_float: { fg: $color_palette.pink attr: "b" }
    shape_garbage: { fg: $color_palette.text bg: $color_palette.red attr: "b" }
    shape_globpattern: { fg: $color_palette.teal attr: "b" }
    shape_int: { fg: $color_palette.pink attr: "b" }
    shape_internalcall: { fg: $color_palette.teal attr: "b" }
    shape_list: { fg: $color_palette.teal attr: "b" }
    shape_literal: $color_palette.blue
    shape_match_pattern: $color_palette.green
    shape_matching_brackets: { attr: "u" }
    shape_nothing: $color_palette.teal
    shape_operator: $color_palette.peach
    shape_or: { fg: $color_palette.pink attr: "b" }
    shape_pipe: { fg: $color_palette.pink attr: "b" }
    shape_range: { fg: $color_palette.peach attr: "b" }
    shape_record: { fg: $color_palette.teal attr: "b" }
    shape_redirection: { fg: $color_palette.pink attr: "b" }
    shape_signature: { fg: $color_palette.green attr: "b" }
    shape_string: $color_palette.green
    shape_string_interpolation: { fg: $color_palette.teal attr: "b" }
    shape_table: { fg: $color_palette.blue attr: "b" }
    shape_variable: $color_palette.pink

    background: $color_palette.base
    foreground: $color_palette.text
    cursor: $color_palette.blue
}

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }

use ~/.cache/starship/init.nu

# fnm on cd
$env.config = {
  show_banner: false # true or false to enable or disable the welcome banner at startup
  hooks: {
    env_change: {
      PWD: [{ |before, after|
        let is_node_dir = [.nvmrc .node-version] | path exists | any { |it| $it }
        if ('FNM_DIR' in $env) and $is_node_dir {
          fnm use # Personally I prefer to use fnm --log-level=quiet use 
        }
      }]
    }
  }
}

if not (which fnm | is-empty) {
  ^fnm env --json | from json | load-env
  # Checking `Path` for Windows
  let path = if 'Path' in $env { $env.Path } else { $env.PATH }
  let node_path = if (sys).host.name == 'Windows' {
    $"($env.FNM_MULTISHELL_PATH)"
  } else {
    $"($env.FNM_MULTISHELL_PATH)/bin"
  }
  $env.PATH = ($path | prepend [ $node_path ])
}

fastfetch
