FROM ghcr.io/ublue-os/bazzite:latest

# Install Cinnamon Desktop and tools not included in Bazzite
# Bazzite already includes:
# - RPMFusion repositories
# - Gaming stack (steam-devices, xpadneo, xone, mangohud, gamemode, vkBasalt)
# - system76-scheduler
# - distrobox, tailscale
RUN rpm-ostree install \
    cinnamon \
    cinnamon-desktop \
    cinnamon-session \
    cinnamon-themes \
    mint-y-icons \
    ptyxis \
    git \
    neovim \
    && rpm-ostree override remove firefox || true \
    && rpm-ostree cleanup -m

# Security & Hardening
COPY config/sysctl/99-security.conf /etc/sysctl.d/99-security.conf
COPY config/firewalld/firewalld.conf /etc/firewalld/firewalld.conf
COPY config/dconf/01-cinnamon-custom /etc/dconf/db/local.d/01-cinnamon-custom

# Update dconf and enable services
RUN dconf update \
    && systemctl enable tailscaled \
    && systemctl enable firewalld

# Metadata
LABEL org.opencontainers.image.title="Obsidian-OS" \
      org.opencontainers.image.description="Cinnamon-based Fedora Atomic with Bazzite features"
      org.opencontainers.image.source="https://github.com/just-a-dev20/Obsidian-OS"
