echo "✨ Setting up install"

def tap [name: string] {
    if $nu.os-info.name == "macos" {
        brew tap $name
    }
}
def install [
    ...names: string
    --cask: string
    --extras: string
    --su
] {
    if $nu.os-info.name == "macos" {
        if $cask != null {
            brew install $cask --cask
        } else {
            brew install ...$names
        }
    } else if $nu.os-info.family == "windows" {
        alias scoop = scoop
        if $su {
            alias scoop = winget
        }
        if $extras != null {
            scoop install $"extras/($extras)"
        } else {
            scoop install ...$names
        }
    } else {
        error make "OS not supported"
    }
}
def link [
    link: path
    target: path
    --file
] {
    if (which ln | is-empty | not $in) {
        if file {
            ln $link $target
        } else {
            ln -s $link $target
        }
    } else if (which mklink | is-empty | not $in) {
        if file {
            mklink /h $link $target
        } else {
            mklink /d $link $target
        }
    }
}

tap oven-sh/bun

echo "✨ Installing configs"

# Install configs
install git
let dotfiles = "~/.dotfiles/"
git clone https://github.com/noahbald/dotfiles $dotfiles

if $nu.os-info.name == "macos" {
    link ($dotfiles | path join `private_Library/private_Application Support/lazygit/`) `~/Library/Application Support/lazygit/`
    link ($dotfiles | path join `private_Library/private_Application Support/nushell/`) `~/Library/Application Support/nushell/`
    link ($dotfiles | path join `private_Library/private_Application Support/com.mitchellh.ghostty/`) `~/Library/Application Support/com.mitchellh.ghostty/`
} else {
    make error $"TODO: Support ($nu.os-info.name) application configs"
}

if (which zsh | is-empty | not $in) {
    link ($dotfiles | path join "dot_zshrc") ~/.zshrc --file
    link ($dotfiles | path join "zshrc.nu") ~/zshrc.nu --file
}
if (which bash | is-empty | not $in) {
    link ($dotfiles | path join "dot_bashrc") ~/.bashrc --file
    link ($dotfiles | path join "zshrc.nu") ~/zshrc.nu --file
}

link ($dotfiles | path join "dot_gitconfig") ~/.gitconfig --file
link ($dotfiles | path join "dot_config") ~/.config/
git clone https://github.com/nushell/nu_scripts ~/.config/nu_scripts/

echo "✨ Installing applications"

# Install essentials
install nushell # Shell
install starship # Prompt
install helix # Editor
install zellij # Multiplexer

# Install browsers
install chrome --cask ungoogled-chromium # Chromium
install zen --cask zen # Firefox

# Install JavaScript runtimes
install fnm # NodeJS
install vscode-langservers-extracted
install prettierd
install superhtml
npm i -g @typescript/native-preview
npm i -g yarn
npm i -g gulp-cli
npm i -g grunt-cli

install bun # BunJS

# Install Go runtimes
install go
install gopls

# Install Python Utils
install uv

# Install Rust compilers
install rustup # Rust Lang

# Install CLang compilers
install zig # Zig Lang
install zls

# Other language servers
install harper
install yaml-language-server
install marksman
install markdown-oxide

# Install utilities
install bat                                    # Better cat
install dust                                   # Readable file stats
install fastfetch                              # System info
install fd                                     # Better find
install ripgrep                                # Better grep
install uutils-coreutils                       # Experimental Rust coreutils
install zoxide                                 # Automated cd shortcuts

# Install TUIs
install bottom                                 # Process monitoring
install fzf                                    # Fuzzy finder
install lazygit                                # Git TUI
install scooter                                # Search/replace
install yazi ffmpeg jq poppler resvg           # Visual interactive cd (+ previewers and processors)

# Install agents
brew install claude
brew install opencode
brew install ollama

# Install applications
install spotify --extras spotify --cask spotify
install obsidian --extras spotify
install ghostty 

if $nu.os-info.name == "macos" {
    install raycast
    install ice --cask jordanbarid-ice
}
if $nu.os-info.family == "windows" {
    # Install MS C++ Build Tools (https://visualstudio.microsoft.com/visual-cpp-build-tools/)
    install-su Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000"
} else if $nu.os-info.family == "unix" {
    # Install utilities
    ^$"(brew --prefix)/opt/fzf/install" # Fuzzy finder
}

echo "✨ Setting up environment"

# Init applications
zoxide init nushell | save -f ~/.zoxide.nu
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

echo "✨ All done"

mut dont_forget = ""
if $nu.os-info.family == "windows" {
    $dont_forget = "- Install Visual Studio C++
"
}
echo $"Don't forget to
- Set up ssh keys \(https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent\)
- Update `~/.gitignore` email
($dont_forget)- To smile :\)"
