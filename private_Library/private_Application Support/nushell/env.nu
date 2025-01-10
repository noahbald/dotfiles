#!/opt/homebrew/bin/nu
# Nushell Environment Config File
#
# version = "0.86.0"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# Add package managers to path
use std 'path add'
path add /opt/homebrew/sbin/
path add /opt/homebrew/bin/
path add /nix/var/nix/profiles/default/bin/
path add /usr/local/bin/
path add ~/.cargo/bin/
path add ~/Library/pnpm/

# Setup useful env vars
$env.config.buffer_editor = 'nvim'
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Setup programs
$env.GRIT_INSTALL = '~/.grit'
path add ($env.GRIT_INSTALL | path join 'bin')
$env.PNPM_HOME = $"($env.HOME)/Library/pnpm"
path add $env.PNPM_HOME

zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

def --env ya [args?] {
	let tmp = $"(mktemp -t "yazi-cwd.XXXXX")"
    if ($args == null) {
        yazi --cwd-file $tmp
    } else {
        yazi $args --cwd-file $tmp
    }
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		z $cwd
	}
	rm -f $tmp
}
use ~/.config/nu_scripts/modules/fnm/fnm.nu
fnm use default | ignore

use ~/zshrc.nu

# Setup user specific/sensitive stuffs
const extra_config = if ($nu.home-path | str ends-with "baldwinn") {
  "./anz.nu"
} else {
  "./home.nu"
}
source $extra_config
