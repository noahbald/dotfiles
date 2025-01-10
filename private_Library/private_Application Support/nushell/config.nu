# Nushell Config File
#
# version = "0.86.0"

# Theme
use ~/.config/nu_scripts/themes/nu-themes/catppuccin-mocha.nu
if ($env.config | is-empty) {
  $env.config = {}
}
$env.config = ($env.config | merge {color_config: (catppuccin-mocha)})

## FZF theme
$env.FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--multi"

# Aliases
use ~/.config/nu_scripts/aliases/bat/bat-aliases.nu *
use ~/.config/nu_scripts/aliases/git/git-aliases.nu *
alias nx = pnpm exec nx

# Completions
source ~/.config/nu_scripts/custom-completions/bat/bat-completions.nu
source ~/.config/nu_scripts/custom-completions/cargo/cargo-completions.nu
source ~/.config/nu_scripts/custom-completions/git/git-completions.nu
source ~/.config/nu_scripts/custom-completions/npm/npm-completions.nu
source ~/.config/nu_scripts/custom-completions/pnpm/pnpm-completions.nu
source ~/.config/nu_scripts/custom-completions/rg/rg-completions.nu
source ~/.config/nu_scripts/custom-completions/zellij/zellij-completions.nu

# Modules
use ~/.config/nu_scripts/modules/git/git.nu

# Hooks
$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD | append (
    {|before, _|
      if $before != null {
        return;
      }
      echo $"Startup Time: ($nu.startup-time)"
    }
  )
)

# Setup

$env.config.edit_mode = "vi"
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = { || $"(if $env.LAST_EXIT_CODE > 0 { ansi red } else { ansi grey })→ (ansi reset)" }
$env.PROMPT_MULTILINE_INDICATOR = $"(ansi grey) ∙ (ansi reset)"
use ~/.cache/starship/init.nu

if $nu.is-interactive {
    fastfetch
    $"Startup Time: ($nu.startup-time)"
}
$env.config.show_banner = false
