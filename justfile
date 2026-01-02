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



