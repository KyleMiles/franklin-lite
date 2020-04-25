#!/bin/bash

# Initialize, update, and install dependencies
pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu
pacman -Syy pkgfile fakeroot binutils git sudo apache lsb-release arduino-cli
arduino-cli core update-index
git clone https://github.com/wijnen/mighty-1284p/ .arduino15/packages/mighty-1284p
# Old: # pacman -Syy git python python-pip wget fakeroot sudo make base-devel arduino-cli

# We can't install debtap as root:
echo 'alarm ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
su alarm && cd

# Install the installer
git clone https://aur.archlinux.org/debtap.git && cd debtap && makepkg -si

exit

# Update debtap:
debtap -u

# Make folders for everything
mkdir python3-fhs python3-fhs-doc python3-network python3-network-doc python3-websocketd python3-websocketd-doc franklin-dbgsym franklin
mv python3-fhs_*.deb python3-fhs
mv python3-fhs-doc_*.deb python3-fhs-doc
mv python3-network_*.deb python3-network
mv python3-network-doc_*.deb python3-network-doc
mv python3-websocketd_*.deb python3-websocketd
mv python3-websocketd-doc_*.deb python3-websocketd-doc
mv franklin_*_armhf.deb franklin
mv franklin-dbgsym_*_armhf.deb franklin-dbgsym

# Unpack and install them (in the right order)
cd python3-fhs && debtap -q *.deb && pacman -U *.zst && cd ..
cd python3-fhs-doc && debtap -q *.deb && pacman -U *.zst && cd ..
cd python3-network && debtap -q *.deb && pacman -U *.zst && cd ..
cd python3-network-doc && debtap -q *.deb && pacman -U *.zst && cd ..
cd python3-websocketd && debtap -q *.deb && pacman -U *.zst && cd ..
cd python3-websocketd-doc && debtap -q *.deb && pacman -U *.zst && cd ..
# Remove the line with the dependencies
cd franklin-dbgsym && debtap -q *.deb && pacman -U *.zst && cd ..
# Remove the bad dependencies
cd franklin && debtap -q *.deb && pacman -U *.zst && cd ..
