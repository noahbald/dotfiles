# install homebrew
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
brew install eza # Better ls (when not in nushell)
brew install zoxide # Automated cd shortcuts
brew install dust # Readable file stats
brew install bat # Better cat
brew install fzf # Fuzzy finder
$(brew --prefix)/opt/fzf/install
brew install jesseduffield/lazynpm/lazynpm # NPM TUI
brew install lazygit # Git TUI
brew install ripgrep # Better grep
brew install fd # Better find
brew install yazi ffmpegthumbnailer unar jq poppler # Visual interactive cd (+ previewers and processors)
