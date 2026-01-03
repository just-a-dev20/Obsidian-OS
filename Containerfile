FROM ghcr.io/ublue-os/bazzite:stable

RUN rpm-ostree install \
        ptyxis \
        git \
        neovim \
    && rpm-ostree override remove firefox || true \
    && rpm-ostree cleanup -m

# Security & Hardening
COPY config/sysctl/99-security.conf /etc/sysctl.d/99-security.conf
COPY config/firewalld/firewalld.conf /etc/firewalld/firewalld.conf
COPY config/dconf/01-cinnamon-custom /etc/dconf/db/local.d/01-cinnamon-custom
COPY config/brave/brave_policies.json /etc/brave/policies/managed

# Update dconf and enable services
RUN dconf update \
    && systemctl enable tailscaled \
    && systemctl enable firewalld

# ---- Install Homebrew (preinstall) ----
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Use Homebrew to install opencode
RUN brew install opencode

# Metadata
LABEL org.opencontainers.image.title="Obsidian-OS" \
      org.opencontainers.image.description="Bazzite with some extra shit" \
      org.opencontainers.image.source="https://github.com/just-a-dev20/Obsidian-OS"
