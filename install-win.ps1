echo "✨ Running pre-install (unix)"

# Install scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop install nu
nu -c 'nu -c `$"(http get https://raw.githubusercontent.com/noahbald/dotfiles/main/install.nu)"'
