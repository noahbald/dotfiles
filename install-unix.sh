echo "✨ Running pre-install (unix)"

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install nu
brew install nu
nu -c "$(nu -c \$"(http get https://raw.githubusercontent.com/noahbald/dotfiles/main/install.nu)")"
