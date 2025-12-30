# Stage 1: Preparation
FROM ghcr.io/ublue-os/base-main:latest AS prep
# We can use this stage to download keys or prepare scripts if needed.
# For now, we prepare the repo files.
RUN curl -o /tmp/system76-scheduler.repo \
    https://copr.fedorainfracloud.org/coprs/kylegospo/system76-scheduler/repo/fedora-$(rpm -E %fedora)/kylegospo-system76-scheduler-fedora-$(rpm -E %fedora).repo

# Stage 2: Final Image
FROM ghcr.io/ublue-os/base-main:latest

# Copy prepared repos
COPY --from=prep /tmp/system76-scheduler.repo /etc/yum.repos.d/

# Install RPMFusion, Desktop, Dev Tools, Gaming Stack, and remove Firefox in one layer
RUN rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    @cinnamon-desktop \
    cinnamon-themes \
    mint-y-icons \
    ptyxis \
    distrobox \
    tailscale \
    git \
    neovim \
    steam-devices \
    xpadneo \
    xone \
    mangohud \
    gamemode \
    vkBasalt \
    system76-scheduler \
    && rpm-ostree override remove firefox || true \
    && rpm-ostree cleanup -m

# 4. Security & Hardening
COPY config/sysctl/99-security.conf /etc/sysctl.d/99-security.conf
COPY config/firewalld/firewalld.conf /etc/firewalld/firewalld.conf
COPY config/dconf/01-cinnamon-custom /etc/dconf/db/local.d/01-cinnamon-custom

# Update dconf and enable services
RUN dconf update \
    && systemctl enable tailscaled \
    && systemctl enable com.system76.Scheduler.service \
    && systemctl enable firewalld

# Metadata
LABEL org.opencontainers.image.title="Obsidian-OS" \
      org.opencontainers.image.description="Cinnamon-based Fedora Atomic with Bazzite/Aurora features"