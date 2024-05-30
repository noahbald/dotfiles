#!/bin/bash

# announce
echo "✨ Running pre-install (unix)"

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install nu
echo "✨ Installing nushell"
brew install nu
nu -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install.nu)"
