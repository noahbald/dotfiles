#!/bin/bash

# announce
echo "✨ Running pre-install (Arch Linux)"

# install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..

# enable multilib
echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syu

# install nu
echo "✨ Installing nushell"
sudo pacman -S nu
nu -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install.nu)"
