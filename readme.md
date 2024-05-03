# My .files

## Installations

1. Run the Unix/Windows install from the default shell. This will open Nu once done
2. If anything goes wrong, update the install scripts

### Mac\Linux

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install-unix.sh)"
```

### Windows

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://raw.githubusercontent.com/noahbald/dotfiles/main/install-win.ps1 | Invoke-Expression
```

## External Sources

- [NeoVim](https://github.com/noahbald/LazyNvOAH)
- [NuScript](https://github.com/nushell/nu_scripts): Cloned into ~/.config/nu_scripts/
