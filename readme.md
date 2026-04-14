# My .files

## Installations

1. Run the appropriate install from the default shell. This will open Nu once done
2. If anything goes wrong, update the install scripts

### Mac

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install-mac.sh)"
```

### Windows

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://raw.githubusercontent.com/noahbald/dotfiles/main/install-win.ps1 | Invoke-Expression
```

### Arch/Linux

I recommend using `archinstall` and then going to a root tty or rebooting to open desktop terminal.

This script will install different profiles based on whether the following was installed via `archinstall`

- `gnome-shell`: Assumes a minimalist install; only installs a subset of the `gnome` group
- `hyprland`: Assumes a maximalist install; TODO: install riced desktop
- None of the above: Assumes a server install; won't install any DE or graphical applications

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install-unix.sh)"
```

## External Sources

- [NeoVim](https://github.com/noahbald/LazyNvOAH): No longer in use
- [NuScript](https://github.com/nushell/nu_scripts): Cloned into ~/.config/nu_scripts/
