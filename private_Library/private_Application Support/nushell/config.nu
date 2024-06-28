# Nushell Config File
#
# version = "0.86.0"

# Theme
use ~/.config/nu_scripts/themes/nu-themes/catppuccin-mocha.nu
$env.config = ($env.config | merge {color_config: (catppuccin-mocha)})

# Aliases
use ~/.config/nu_scripts/aliases/bat/bat-aliases.nu *
use ~/.config/nu_scripts/aliases/git/git-aliases.nu *
alias nx = bun nx

# Completions
source ~/.config/nu_scripts/custom-completions/bat/bat-completions.nu
source ~/.config/nu_scripts/custom-completions/git/git-completions.nu
source ~/.config/nu_scripts/custom-completions/npm/npm-completions.nu
source ~/.config/nu_scripts/custom-completions/pnpm/pnpm-completions.nu
source ~/.config/nu_scripts/custom-completions/rg/rg-completions.nu
source ~/.config/nu_scripts/custom-completions/zellij/zellij-completions.nu

# Modules
use ~/.config/nu_scripts/modules/fnm/fnm.nu
source ~/.config/nu_scripts/modules/git/git.nu

use ~/.cache/starship/init.nu

if $nu.is-interactive {
    fastfetch
    $"Startup Time: ($nu.startup-time)"
}
$env.config.show_banner = false
