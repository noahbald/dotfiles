# install homebew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install essentials
brew install nushell
brew install starship
brew install git
brew install neovim
brew install zellij

# Install JavaScript runtimes
brew install fnm
npm i -g yarn
npm i -g gulp-cli
npm i -g grunt-cli

brew tap oven-sh/bun
brew install bun

# Install Ruby runtimes
brew install rbenv
gem install bundler

# Install Rust compilers
brew install cargo

# Install CLang compilers
brew install zig

# Install utilities
brew install eza
brew install zoxide
brew install dust
brew install bat
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install jesseduffield/lazynpm/lazynpm
