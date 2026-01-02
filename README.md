# 💎 Obsidian-OS

[![Build and Push Obsidian-OS](https://github.com/just-a-dev20/Obsidian-OS/actions/workflows/build.yml/badge.svg)](https://github.com/just-a-dev20/Obsidian-OS/actions/workflows/build.yml)

**Obsidian-OS** is a custom, immutable OCI desktop image based on [Bazzite](https://bazzite.gg/). It combines the gaming performance and hardware support of Bazzite with the productivity-focused **Cinnamon Desktop Environment** and a hardened, developer-centric configuration.

> **Note:** This is a personal configuration designed for a specific workflow. It is fully open for use or forking, but comes with no warranties.

---

## ✨ Key Features

### 🖥️ Desktop Experience
- **Cinnamon Desktop:** A traditional, stable, and highly customizable desktop environment, replacing the default KDE/GNOME.
- **Ptyxis:** A modern, container-aware terminal emulator tailored for Fedora Atomic workflows.
- **Theming:** Pre-configured Mint-Y themes and icons for a cohesive look.

### 🎮 Gaming Ready (Inherited from Bazzite)
- **Drivers & Tools:** Pre-installed Steam, Lutris, and drivers for Xbox controllers (`xpadneo`, `xone`).
- **Performance:** `system76-scheduler`, `gamemode`, `vkBasalt`, and `MangoHud` are configured out of the box.

### 🛠️ Developer Ecosystem
- **Tooling:** `git`, `neovim`, and `distrobox` are baked in.
- **Containers:** Ready-to-use recipes for Fedora and Ubuntu toolboxes via `just`.
- **Networking:** `tailscale` enabled for secure remote access.

### 🛡️ Security & Hardening
- **Network:** Optimized `firewalld` configuration.
- **Kernel:** Hardened `sysctl` parameters (see `config/sysctl/99-security.conf`).
- **Clean Base:** Firefox RPM removed in favor of sandboxed Flatpaks.
- **Signed Images:** All builds are signed with Cosign for integrity verification.

---

## 🚀 Installation

Obsidian-OS is designed to be layered on top of an existing Fedora Atomic installation (like Silverblue, Kinoite, or Bazzite).

### 1. Rebase System
Open a terminal on your current atomic setup and rebase to this image.

```bash
# Replace 'just-a-dev20' with your GitHub username if you forked the repo
rpm-ostree rebase ostree-unverified-registry:ghcr.io/just-a-dev20/obsidian-os:latest
```

### 2. Reboot
Apply the changes by rebooting your system.

```bash
systemctl reboot
```

### 3. Verification (Optional)
You can verify the integrity of the image using the included public key (`cosign.pub`).

---

## ⚙️ Post-Installation

This image includes a `justfile` to simplify common management tasks. After rebooting into Obsidian-OS, open a terminal and run the following:

### Initial Setup
```bash
# Update the system and flatpaks
just update

# Set up developer containers (Homebrew, Fedora/Ubuntu toolboxes)
just setup-dev

# Apply gaming optimizations (System76 scheduler, Steam permissions)
just setup-gaming
```



---

## 🏗️ Development & Building

### Directory Structure
- **`Containerfile`**: The blueprint for the OS image.
- **`config/`**: System configuration overlays (`dconf`, `firewalld`, `sysctl`).
- **`justfile`**: Client-side command runner.
- **`.github/`**: CI/CD workflows for building and signing.

### Local Build
To build the image locally for testing:

```bash
podman build -t obsidian-os .
```

### Automated Build (CI)
The project utilizes GitHub Actions to:
1.  Build the image on a weekly schedule or `main` branch push.
2.  Sign the image with Cosign.
3.  Push the artifact to GitHub Container Registry (GHCR).

---

## 🤝 Contributing

Issues and pull requests are welcome! If you have ideas for improvements or new features, feel free to open a discussion.

## 📄 License

This project is effectively open source. Please refer to the upstream [Bazzite](https://github.com/ublue-os/bazzite) and [Fedora](https://fedoraproject.org/) projects for their respective licensing.
