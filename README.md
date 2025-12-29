# Obsidian-OS: Custom Fedora Atomic (Cinnamon + Gaming + Dev)

Obsidian-OS is a custom OCI image based on Fedora Atomic (Silverblue base), merging the gaming optimizations of **Bazzite** with the developer-centric workflow of **Aurora**, all while using **Cinnamon** as the primary desktop environment.

## 🚀 Features

### 🎮 Gaming (Bazzite-inspired)
- **Steam & Lutris Pre-configured:** Steam devices and drivers included.
- **Performance:** Includes `system76-scheduler`, `gamemode`, and `MangoHud`.
- **Controllers:** `xpadneo` (Xbox) and `xone` drivers included.

### 🛠️ Developer Workflow (Aurora-inspired)
- **Ptyxis:** The container-aware terminal.
- **Homebrew & Distrobox:** Managed via `just` commands.
- **Tailscale:** Integrated for easy networking.
- **CLI Tools:** `neovim`, `git`, and `distrobox` pre-installed.

### 🛡️ Security & Hardening
- **Network:** `firewalld` set to `drop` by default.
- **Kernel:** Hardened sysctl tweaks (`kptr_restrict`, `ptrace_scope`).
- **Sandboxing:** Firefox RPM removed in favor of Flatpak (installed by user post-rebase).

---

## 🛠️ Installation & Rebase

To rebase an existing Fedora Silverblue/Kinoite installation to Obsidian-OS, follow these steps:

### 1. Preparation
Ensure your system is up to date and you have backed up important data.

### 2. Unpin old deployments (Optional)
```bash
# See your current deployments
rpm-ostree status
```

### 3. Rebase to Obsidian-OS
Replace `<username>` with your GitHub username once the CI has published your image.

```bash
# Rebase to the new image
rpm-ostree rebase ostree-unverified-registry:ghcr.io/<username>/obsidian-os:latest
```

### 4. Reboot
```bash
systemctl reboot
```

### 5. Post-Installation Setup
After logging into Cinnamon, run the following to finish the setup:

```bash
# Enable gaming optimizations
just setup-gaming

# Setup dev environment (Homebrew + Distrobox)
just setup-dev
```

---

## 🏗️ Building Locally

If you want to build this image locally using Podman:

```bash
podman build -t obsidian-os .
```

To sign the image (required for verified boots), refer to the [ublue-os signing guide](https://universal-blue.org/creating-your-own-image/#signing).
