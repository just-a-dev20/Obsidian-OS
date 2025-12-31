# Obsidian-OS: My Custom Fedora Atomic Setup

Obsidian-OS is my personal OCI image based on **Bazzite**. It leverages Bazzite's gaming optimizations and adds a developer-centric workflow with **Cinnamon** as the primary desktop environment.

> [!NOTE]
> This is a personal configuration tailored to my specific workflow. Feel free to use it or fork it, but it is provided "as is".

## 🚀 Features

### 🎮 Gaming
- **Steam & Lutris:** Pre-configured with drivers.
- **Performance:** Includes `system76-scheduler`, `gamemode`, and `MangoHud`.
- **Controllers:** Drivers for Xbox (`xpadneo`, `xone`) included.

### 🛠️ Developer Workflow
- **Ptyxis:** The container-aware terminal.
- **Tools:** `git`, `neovim`, `distrobox` and `tailscale` pre-installed.

### 🛡️ Security & Hardening
- **Network:** `firewalld` optimized.
- **Kernel:** Hardened sysctl tweaks.
- **Sandboxing:** Firefox RPM removed in favor of Flatpak.

---

## 🛠️ Installation & Rebase

To rebase an existing Fedora Silverblue/Kinoite installation to Obsidian-OS:

### 1. Preparation
Ensure your system is up to date and back up important data.

### 2. Rebase to Obsidian-OS
Replace `<username>` with the GitHub username hosting this image.

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/<username>/obsidian-os:latest
```

### 3. Reboot
```bash
systemctl reboot
```

### 4. Post-Installation Setup
After logging into Cinnamon, open a terminal and run the following to finish the setup:

```bash
# Update the system
just update

# Enable gaming optimizations
just setup-gaming

# Setup dev environment (Homebrew + Distrobox)
just setup-dev

# Fix Cinnamon theme quirks (optional)
just fix-cinnamon

# Enroll Secure Boot key (if needed for custom drivers)
just enroll-key
```

---

## 🏗️ Building Locally (Advanced)

If you want to build this image locally using Podman:

```bash
podman build -t obsidian-os .
```