ARG BASE_IMAGE_NAME="bazzite"
ARG FEDORA_MAJOR_VERSION="43"
ARG SOURCE_IMAGE="${BASE_IMAGE_NAME}-main"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
ARG COMMON_IMAGE="ghcr.io/get-aurora-dev/common:latest"
ARG BREW_IMAGE="ghcr.io/ublue-os/brew:latest"

FROM ${COMMON_IMAGE} AS common
FROM ${BREW_IMAGE} AS brew

# https://github.com/get-aurora-dev/common
COPY --from=common /flatpaks /flatpaks
COPY --from=common /logos /logos
COPY --from=common /system_files /system_files
COPY --from=common /wallpapers /system_files/shared

# https://github.com/ublue-os/brew
COPY --from=brew /system_files /system_files/shared

## aurora image section
FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS base

ARG AKMODS_FLAVOR="coreos-stable"
ARG BASE_IMAGE_NAME="bazzite"
ARG FEDORA_MAJOR_VERSION="43"
ARG IMAGE_NAME="aurora"
ARG IMAGE_VENDOR="ublue-os"
ARG KERNEL="6.16.0-200.fc43.x86_64"
ARG SHA_HEAD_SHORT="dedbeef"
ARG UBLUE_IMAGE_TAG="stable"
ARG VERSION=""
ARG IMAGE_FLAVOR=""

RUN rpm-ostree install \
    ptyxis \
    git \
    neovim \
    brave-browser \
    && rpm-ostree override remove firefox || true \
    && rpm-ostree cleanup -m

# Security & Hardening
COPY config/sysctl/99-security.conf /etc/sysctl.d/99-security.conf
COPY config/firewalld/firewalld.conf /etc/firewalld/firewalld.conf
COPY config/brave/brave_policies.json /etc/brave/policies/managed

# Update dconf and enable services
RUN dconf update \
    && systemctl enable tailscaled \
    && systemctl enable firewalld

# Makes `/opt` writeable by default
# Needs to be here to make the main image build strict (no /opt there)
# This is for downstream images/stuff like k0s
RUN rm -rf /opt && ln -s /var/opt /opt

# Metadata
LABEL org.opencontainers.image.title="Obsidian-OS" \
      org.opencontainers.image.description="Bazzite image with some extra shit" \
      org.opencontainers.image.source="https://github.com/just-a-dev20/Obsidian-OS"
