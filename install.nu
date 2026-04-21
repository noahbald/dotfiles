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
    --pacman: string
    --su
    --yay
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
    } else if $nu.os-info.name == "linux" {
        alias pacman = sudo pacman
        if $yay {
            alias pacman = yay
        }
        if $pacman != null {
            pacman -S --noconfirm --needed $pacman
        } else {
            pacman -S --noconfirm --needed ...$names
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
        if $file {
            ln -f $link $target
        } else {
            ln -f -s $link $target
        }
    } else if (which mklink | is-empty | not $in) {
        if $file {
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
let dotfiles = $"($nu.home-dir)/.dotfiles/"
try {
    git clone https://github.com/noahbald/dotfiles $dotfiles
} catch {
    try {
        git -C $dotfiles pull origin main --ff-only
    } catch {
        git -C $dotfiles merge --no-ff
    }
}

if $nu.os-info.name == "macos" {
    link ($dotfiles | path join "private_Library/private_Application Support/lazygit/") $"($nu.home-dir)/Library/Application Support/lazygit/"
    link ($dotfiles | path join "private_Library/private_Application Support/nushell/") $"($nu.home-dir)/Library/Application Support/nushell/"
    link ($dotfiles | path join "private_Library/private_Application Support/com.mitchellh.ghostty/") $"($nu.home-dir)/Library/Application Support/com.mitchellh.ghostty/"
} else {
    echo $"TODO: Support ($nu.os-info.name) application configs"
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
do -i { mkdir ~/.config }
link ($dotfiles | path join "dot_config") ~/.config/
git clone https://github.com/nushell/nu_scripts ~/.config/nu_scripts/

echo "✨ Installing applications"

let is_desktop = $nu.os-info.name == "macos" or $nu.os-info.family == "windows" or (which gnome-shell | is-empty | not $in)

# Install essentials
install nushell # Shell
install starship # Prompt
install helix # Editor
install zellij # Multiplexer

# Install browsers
if (is_desktop) {
    install chrome --cask ungoogled-chromium --pacman chromium # Chromium
    install zen --cask zen --yay --pacman zen-browser-bin # Firefox
}

# Install JavaScript runtimes
install fnm # NodeJS
install vscode-langservers-extracted --yay
install prettierd --yay
install superhtml --yay --pacman superhtml-bin
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
install scooter --yay --pacman scooter-bin     # Search/replace
install yazi ffmpeg jq poppler resvg           # Visual interactive cd (+ previewers and processors)

# Install agents
install claude --yay --pacman claude-code
install opencode
install ollama

# Install applications
if (is_desktop) {
    install spotify --extras spotify --cask spotify --pacman spotify-launcher
    install obsidian --cask obsidian
    install ghostty 
}

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
if $nu.os-info.name == "linux" {
    install networkmanager
    install iwctl # connect to wifi devices

    systemctl enable --now NetworkManager.service

    if (is-desktop) {
        install vulkan-icd-loader
    }
}

if (which gnome-shell | is-empty | not $in) {
    # Install subset of [gnome](https://archlinux.org/groups/x86_64/gnome/) group
    install gdm gnome-backgrounds gnome-color-manager gnome-control-center gnome-disk-utility gnome-logs gnome-menus gnome-session gnome-settings-daemon loupe nautilus papers showtime snapshot sushi xdg-desktop-portal-gnome xdg-user-dirs-gtk
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
if $nu.os-info.name == "linux" {
    $dont_forget = "- Install GPU drivers for your hardware (for desktop)
"
}
nu -e $"\"Don't forget to
- Set up ssh keys \(https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent\)
- Update `~/.gitignore` email
($dont_forget)- To smile :\)\""
