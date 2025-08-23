# Kali Linux on Raspberry Pi 4 – Setup & Lab Operations

> **Maintainer:** 4ndr0666  
> **Purpose:** Reliable, reproducible, and *lab-safe* Kali Pi 4 installation for red team, C2, and expendable attackboxes.

---

## Table of Contents

1. [GPG & Repository Key Issues](#gpg--repository-key-issues)
2. [Recommended `/etc/apt/sources.list`](#recommended-etcaptsourceslist)
3. [Fixing Broken or Outdated Packages](#fixing-broken-or-outdated-packages)
4. [Docker on Kali ARM64](#docker-on-kali-arm64)
5. [Re4son Kernel Note (Pi-Specific)](#re4son-kernel-note-pi-specific)
6. [Safe Upgrades & Full-Upgrade Warnings](#safe-upgrades--full-upgrade-warnings)
7. [Red Team Lab/Expendable Install Policy](#red-team-labexpendable-install-policy)
8. [Essential System Maintenance](#essential-system-maintenance)
9. [Quick Debugging Checklist](#quick-debugging-checklist)

---

## GPG & Repository Key Issues

- You should only need two keyrings:
    - `/usr/share/keyrings/kali-archive-keyring.gpg` (Kali official)
    - `/etc/apt/keyrings/docker.asc` (optional, for Docker)

**Add/update the Kali key:**
```bash
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | sudo gpg --dearmor -o /usr/share/keyrings/kali-archive-keyring.gpg
````

---

## Recommended `/etc/apt/sources.list`

```plaintext
deb [signed-by=/usr/share/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free
# deb-src http://http.kali.org/kali kali-rolling main contrib non-free

# Optional: Docker for ARM64/Pi4
deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable
```

* **No re4son line needed for standard Kali Pi 4 installs.**

---

## Fixing Broken or Outdated Packages

1. **Update and Fix:**

   ```bash
   sudo apt clean
   sudo apt update
   sudo apt --fix-broken install
   sudo dpkg --configure -a
   sudo apt full-upgrade
   ```
2. **Check for Held Packages:**

   ```bash
   sudo apt-mark showhold
   sudo apt-mark unhold <package>
   ```

---

## Docker on Kali ARM64

1. **Add Docker repo and GPG key:**

   ```bash
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   echo "deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
   | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```
2. **Install Docker:**

   ```bash
   sudo apt update
   sudo apt install -y docker-ce docker-ce-cli containerd.io
   sudo systemctl enable --now docker
   sudo usermod -aG docker $USER
   newgrp docker
   docker run --rm hello-world
   ```
3. **Install Python, pip, git, Docker Compose:**

   ```bash
   sudo apt install -y python3 python3-pip python3-venv git
   pip3 install --upgrade pip
   sudo pip3 install docker-compose
   ```

---

## Re4son Kernel Note (Pi-Specific)

* **Do NOT add the re4son repo** unless you need experimental kernels/modules for special hardware.
* Official Kali ARM64 Pi images **do NOT require re4son**.
* If you ever do need it, add:

  ```plaintext
  # deb [signed-by=/usr/share/keyrings/re4son-archive-keyring.gpg] http://http.re4son-kernel.com/re4son kali-pi main
  ```
* ...and fetch the GPG key only if/when the repo is actually needed.

---

## ⚠️ Safe Upgrades & Full-Upgrade Warnings

> **CAUTION:**
> After major system library upgrades (`libc6`, `libglib2`, etc.), if `apt full-upgrade` warns:
>
> ```
> The following essential packages will be removed.
> This should NOT be done unless you know exactly what you are doing!
> ```
>
> **DO NOT PROCEED** unless you *intend* to convert your system to CLI-only!
>
> * **Cancel the upgrade** (`q` or `n` at prompt).
> * **Pin/hold the offending library** (e.g., `sudo apt-mark hold libc6`) and wait a few days for repos to catch up.
> * Retry upgrade after verifying no core desktop packages are scheduled for removal.
> * *On Pi/ARM/rolling distros, this is common after big base library transitions.*

---

## 🧪 Red Team Lab/Expendable Install Policy

> **If this Kali install is a disposable lab/attackbox and you do NOT care about losing the desktop or breaking the system:**
>
> * You may proceed with `apt full-upgrade` even if it removes the desktop/XFCE/meta-packages.
> * System may become CLI-only or require a re-image—acceptable for red team, ephemeral, or automation boxes.
> * *If/when the system is trashed, simply restore a snapshot or re-flash the SD card.*

---

## Essential System Maintenance

* Always run:

  ```bash
  sudo apt update && sudo apt full-upgrade -y
  sudo reboot
  ```
* **Remove/comment out broken or obsolete repos** to avoid persistent GPG/signature errors.
* Clean package cache:

  ```bash
  sudo apt clean
  ```

---

## Quick Debugging Checklist

```bash
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/
lsb_release -a
ls -lh /usr/share/keyrings/
sudo apt-key list
sudo apt update
```

*Paste errors here or to ChatGPT for rapid diagnosis.*

---

## Recap & Best Practices

* Use only official ARM64 repos unless you have a specific, documented need.
* Do not add “re4son” or third-party sources unless a tool or driver requires it.
* Always verify keyring files are valid (not empty).
* Avoid mass desktop removals after libc6 upgrades unless you’re running an expendable attackbox.

---

> **Ready for destructive testing, Adaptix/Mythic deployments, or re-imaging at will!**

