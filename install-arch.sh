#!/bin/bash

# announce
echo "✨ Running pre-install (Arch Linux)"

# install yay
sudo pacman -S --needed --noconfirm git base-devel
if ! command -v "yay" &> /dev/null
then
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
fi

# enable multilib
if ! cat /etc/pacman.conf | grep "^\[multilib]" &> /dev/null
then
echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syu
fi

# install nu
echo "✨ Installing nushell"
sudo pacman -S --noconfirm --needed nushell
nu -c "$(curl -fsSL https://raw.githubusercontent.com/noahbald/dotfiles/main/install.nu)"
