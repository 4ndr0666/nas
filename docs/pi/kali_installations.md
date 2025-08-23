# Kali Linux Pi Caveats & Setup Guide

This covers the **nuances of running Kali on the Raspberry Pi 4**—including GPG keys, Docker, package errors, and “best practices” for a modern install.

---

## Table of Contents

1. [GPG & Repository Key Issues](#gpg--repository-key-issues)
2. [Recommended `/etc/apt/sources.list`](#recommended-etcaptsourceslist)
3. [Fixing Broken or Outdated Packages](#fixing-broken-or-outdated-packages)
4. [Docker on Kali ARM64](#docker-on-kali-arm64)
5. [Pi-specific Kernel (Re4son)](#pi-specific-kernel-re4son)
6. [Essential System Maintenance](#essential-system-maintenance)
7. [Quick Debugging Checklist](#quick-debugging-checklist)

---

## GPG & Repository Key Issues

**You should only need two keyrings:**

* **Kali Linux official**: `/usr/share/keyrings/kali-archive-keyring.gpg`
* **Docker (optional)**: `/etc/apt/keyrings/docker.asc`

**Add/update the Kali key:**

```bash
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | sudo gpg --dearmor -o /usr/share/keyrings/kali-archive-keyring.gpg
```

**Recommended `/etc/apt/sources.list` entry:**

```
deb [signed-by=/usr/share/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free
```

**Remove/comment any “re4son” lines unless you specifically need a custom Pi kernel!**

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
   # Unhold example:
   sudo apt-mark unhold <package>
   ```

---

## Docker on Kali ARM64

1. **Install GPG Key and Repo:**

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

3. **Recommended:**

   * Install Python, pip, git, and Docker Compose:

     ```bash
     sudo apt install -y python3 python3-pip python3-venv git
     pip3 install --upgrade pip
     sudo pip3 install docker-compose
     ```

---

## Pi-specific Kernel (Re4son)

**Only add the Re4son repo if you need:**

* Experimental kernel modules
* Special drivers
* Pi 2/3 legacy support

**If you ever need it, add:**

```bash
# Not needed for most users!
# deb [signed-by=/usr/share/keyrings/re4son-archive-keyring.gpg] http://http.re4son-kernel.com/re4son kali-pi main
```

**…and fetch the GPG key as shown in prior sections (if it ever becomes available).**

---

## Essential System Maintenance

* Always update fully after install:

  ```bash
  sudo apt update && sudo apt full-upgrade -y
  sudo reboot
  ```
* **Comment out broken or obsolete repos** to avoid key/signature errors.
* Clean your package cache regularly:

  ```bash
  sudo apt clean
  ```

---

## Quick Debugging Checklist

*For troubleshooting sources and keys:*

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

## Best Practices for Kali on Pi 4

* Use only official ARM64 repos unless you have a specific, documented need.
* Don’t add “re4son” or other 3rd-party sources unless a tool or driver absolutely requires it.
* Always verify keyring files are not empty.
* If package problems persist after a fresh install, **comment out 3rd-party repos and try again.**

---

### **You are now set for a smooth, secure Kali Pi 4 experience with Docker, Adaptix, Mythic, and more.**

---
