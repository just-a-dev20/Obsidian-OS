# Justfile for Obsidian-OS Custom Image

# Update the system
update:
    rpm-ostree update

# Initial setup for developers (Homebrew + Distrobox)
setup-dev:
    echo "Setting up Homebrew..."
    /usr/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Setting up Distrobox..."
    distrobox create --name fedora-toolbox --image fedora:latest
    distrobox create --name ubuntu-toolbox --image ubuntu:latest

# Optimize for gaming (Ensure services are running)
setup-gaming:
    echo "Enabling System76 Scheduler..."
    sudo systemctl enable --now com.system76.Scheduler.service
    echo "Setting up Steam permissions..."
    flatpak override --user --filesystem=/mnt/games com.valvesoftware.Steam || true

# Enroll Secure Boot key (if using custom kmods)
enroll-key:
    echo "Enrolling MOK key for custom drivers..."
    sudo mokutil --import /etc/pki/akmods/certs/public_key.der

# Fix specific Cinnamon quirks
fix-cinnamon:
    gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Teal"
    gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Teal"
