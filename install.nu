echo "✨ Setting up install"

alias install = brew install
alias install-extras = brew install --cask
alias install-su = brew install
if $nu.os-info.family == "windows" {
    alias install = scoop install
    def --env install-extras [name: string] {
        exec "scoop" "install" $"extras/($name)"
    }
    install winget

    alias install-su = winget install

    scoop bucket add extras
} else if $nu.os-info.family == "unix" {
    brew tap oven-sh/bun
    brew tab spotify
}

echo "✨ Installing applications"

# Install essentials
install nushell
install starship
install git
install neovim

# Install JavaScript runtimes
install fnm
npm i -g yarn
npm i -g gulp-cli
npm i -g grunt-cli

install bun

# Install Rust compilers
install rustup

# Install CLang compilers
brew install zig

# Install utilities
install chezmoi                                # Dotfile manager
install zoxide                                 # Automated cd shortcuts
install dust                                   # Readable file stats
install bat                                    # Better cat
install fzf                                    # Fuzzy finder
install lazygit                                # Git TUI
install ripgrep                                # Better grep
install fd                                     # Better find
install yazi ffmpegthumbnailer unar jq poppler # Visual interactive cd (+ previewers and processors)
install fastfetch                              # System info

# Install applications
install-extras spotify
install-extras obsidian
install-extras wezterm
install-extras bitwarden

if $nu.os-info.name == "macos" {
    install raycast
}
if $nu.os-info.family == "windows" {
    # Install essentials
    install-extras vcredist2022 # Neovim dependency
    install-su --id Microsoft.Powershell --source winget # Powershell 7
    install brave
    # Install MS C++ Build Tools (https://visualstudio.microsoft.com/visual-cpp-build-tools/)
    install-su Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000"

    # Install applications
} else if $nu.os-info.family == "unix" {
    # Install essentials
    install zellij

    # Install utilities
    ^$"(brew --prefix)/opt/fzf/install" # Fuzzy finder
    curl -fsSL https://docs.grit.io/install | bash # AST query language

    # Install applications
    install arc
}

echo "✨ Setting up environment"

mut $nvim_config = "~/.config/nvim/"
if $nu.os-info.family == "windows" {
    $nvim_config = "~/AppData/Local/nvim/"
}

# Install configs
git clone https://github.com/noahbald/LazyNvOAH.git $nvim_config
git clone https://github.com/nushell/nu_scripts ~/.config/nu_scripts/
chezmoi init --apply https://github.com/noahbald/dotfiles.git

# Init applications
zoxide init nushell | save -f ~/.zoxide.nu
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

echo "✨ All done"

mut $dont_forget = ""
if $nu.os-info.family == "windows" {
    $dont_forget = `- Install Visual Studio C++
`
}
echo $`Don't forget to
- Update your chezmoi.toml email
- Set up ssh keys \(https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent\)
($dont_forget)- To smile :\)`
