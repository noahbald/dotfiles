# install scoop in powershell
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install winget

# Install essentials
scoop install nu
scoop install starship
scoop install git
scoop install neovim

# Install JavaScript runtimes
scoop install fnm
npm i -g yarn

scoop install bun

# Install Rust compilers (NOTE: requires Microsoft C++ Build Tools - https://visualstudio.microsoft.com/visual-cpp-build-tools/)
scoop install rustup

# Install CLang compilers
scoop install zig

# Install utilities
scoop install eza                                    # Better ls (when not in nushell)
scoop install zoxide                                 # Automated cd shortcuts
scoop install dust                                   # Readable file stats
scoop install bat                                    # Better cat
scoop install fzf                                    # Fuzzy finder
scoop install lazygit                                # Git TUI
scoop install ripgrep                                # Better grep
scoop install fd                                     # Better find
scoop install yazi ffmpegthumbnailer unar jq poppler # Visual interactive cd (+ previewers and processors)
curl -fsSL https://docs.grit.io/install | bash      # AST query language

# Admin installations
scoop install extras/vcredist2022 # Neovim dependency
winget install --id Microsoft.Powershell --source winget # Powershell 7

# Initialisation
# NOTE: Need to rename HOME to HOMEPATH and PATH to Path in nushell env
# NOTE: Initialise fnm in powershell
# fnm env --use-on-cd | Out-String | Invoke-Expression
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell | save -f ~/.zoxide.nu
