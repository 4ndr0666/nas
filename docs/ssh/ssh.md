# SSH Reference & Workflow

**Scope:**
Covers end-to-end secure SSH configuration for:
- Local Client ↔ Remote Host (dietpi)
- Client ↔ GitHub (for key distribution)
- Client ↔ AUR (Arch User Repository)

---

## ⚙️ Client → Host (dietpi)

**Client:** `andro@theworkpc` (`192.168.1.219`)
**Host:** `dietpi@dietpi` (`192.168.2.3`)
Goal: passwordless SSH using Ed25519 + GitHub key distribution.

---

### 🚀 Quickstart (new Pi)

```bash
# On the Pi console
mkdir -p ~/.ssh && chmod 700 ~/.ssh
curl -s https://github.com/4ndr0666.keys >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
````

### 🧩 Client configuration

`~/.ssh/config`:

```sshconfig
Host dietpi
    HostName 192.168.1.219
    User dietpi
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    StrictHostKeyChecking yes
    HashKnownHosts yes
    HostKeyAlgorithms ssh-ed25519
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 600
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

Then:

```bash
mkdir -p ~/.ssh/sockets && chmod 700 ~/.ssh/sockets
ssh dietpi
```

---

### ✅ Verify connection once

```bash
ssh -vvv -o ControlMaster=no -o ControlPath=none dietpi \
| grep -E 'Server host key|Authenticated|using "publickey"'
```

Expect:

```
Server host key: ssh-ed25519 SHA256:euCxRZVZ...
Authenticated ... using "publickey"
```

---

### 🧱 Harden the Pi (Server-side)

```bash
sudo sed -i \
  -e 's/^[# ]*PasswordAuthentication.*/PasswordAuthentication no/' \
  -e 's/^[# ]*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication no/' \
  -e 's/^[# ]*PubkeyAuthentication.*/PubkeyAuthentication yes/' \
  -e 's/^[# ]*PermitRootLogin.*/PermitRootLogin no/' \
  /etc/ssh/sshd_config
sudo systemctl restart ssh
```

---

### ⚡ Multiplexing notes

* Reuses one authenticated TCP session for instant new shells or scp/sftp.
* Requires `~/.ssh/sockets` (chmod 700).
* Not a sandbox — it’s performance and reliability.

Control commands:

```bash
ssh -O check dietpi   # Is master running?
ssh -O exit  dietpi   # Close master session
```

---

### 🩺 Mini-audit (repeat anytime)

#### On the Pi

```bash
whoami
sudo journalctl -u ssh -n 50 --no-pager | grep -i 'Accepted publickey' || echo 'NO publickey events seen'
ls -ld ~/.ssh; ls -l ~/.ssh/authorized_keys; head -n 2 ~/.ssh/authorized_keys
sudo sshd -T | grep -E '^(passwordauthentication|kbdinteractiveauthentication|pubkeyauthentication)'
sudo ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
systemctl is-active ssh; systemctl is-enabled ssh
ss -tnlp | grep ':22'
```

#### On the Client

```bash
ls -ld ~/.ssh/sockets || (mkdir -p ~/.ssh/sockets && chmod 700 ~/.ssh/sockets)
ssh -G dietpi | grep -E 'control(master|path|persist)|serveralive(interval|countmax)'
ssh-keygen -F 192.168.1.219
ssh -o PubkeyAuthentication=no -o PasswordAuthentication=yes dietpi || echo 'OK: passwords disabled'
```

---

### 🔑 Key management

```bash
ssh-keygen -t ed25519 -a 100 -C "andro@theworkpc"
cat ~/.ssh/id_ed25519.pub

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

---

### 🧰 Troubleshooting

```bash
ssh -vvv dietpi
ssh-keygen -R 192.168.2.3
ssh-keyscan -t ed25519 192.168.1.219 >> ~/.ssh/known_hosts
ssh-keygen -H -f ~/.ssh/known_hosts && rm -f ~/.ssh/known_hosts.old
eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519
```

---

## 🏗️ AUR (Arch User Repository) Workflow

**Purpose:** Access, clone, and manage AUR packages via SSH with your Ed25519 key.

---

### 🔐 Setup once

1. Upload your public key (`~/.ssh/id_ed25519.pub`) to your AUR profile:
   [https://aur.archlinux.org/account/USERNAME/edit](https://aur.archlinux.org/account/USERNAME/edit)

2. Add to `~/.ssh/config`:

   ```sshconfig
   Host aur.archlinux.org
       User aur
       IdentityFile ~/.ssh/id_ed25519
       IdentitiesOnly yes
       HostKeyAlgorithms ssh-ed25519
       StrictHostKeyChecking yes
       HashKnownHosts yes
   ```

3. Pin host key:

   ```bash
   ssh-keyscan aur.archlinux.org >> ~/.ssh/known_hosts
   ssh-keygen -H -f ~/.ssh/known_hosts
   ```

---

### 🧪 Verify AUR access

```bash
ssh -T aur@aur.archlinux.org help
```

Expected:

```
Commands:
  adopt <name> ...
  git-upload-pack
  git-receive-pack
  ...
```

If you see that, you’re fully authenticated.

---

### 🧭 Common AUR commands

| Purpose         | Command                                               | Notes                          |
| --------------- | ----------------------------------------------------- | ------------------------------ |
| List your repos | `ssh aur@aur.archlinux.org list-repos`                | View all packages you maintain |
| Clone package   | `git clone ssh://aur@aur.archlinux.org/<pkgname>.git` | Pulls AUR repo locally         |
| Push update     | `git push aur master`                                 | Publishes new PKGBUILD         |
| Flag outdated   | `ssh aur@aur.archlinux.org flag <pkg> "reason"`       | Marks package as out-of-date   |
| Vote            | `ssh aur@aur.archlinux.org vote <pkg>`                | Adds your vote                 |
| Disown/adopt    | `ssh aur@aur.archlinux.org disown <pkg>`              | Manage maintainership          |

All use the same Ed25519 key.

---

### 🧾 Test automation

```bash
ssh -T aur@aur.archlinux.org help >/dev/null 2>&1 && echo "✅ AUR SSH OK" || echo "❌ AUR SSH FAIL"
```

---

## 🪄 Hardened `ssh_setup.sh` (idempotent, safe, reproducible)

```bash
#!/usr/bin/env bash
# Author: 4ndr0666
# Purpose: Install GitHub-hosted SSH keys into ~/.ssh/authorized_keys on the local host.
# Usage:   curl -fsSL https://raw.githubusercontent.com/4ndr0666/nas/refs/heads/main/docs/ssh/ssh_setup.sh | bash
set -euo pipefail

USER_KEYS_URL="${1:-https://github.com/4ndr0666.keys}"

umask 077
mkdir -p "${HOME}/.ssh"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "$USER_KEYS_URL" > "$tmp"

touch "${HOME}/.ssh/authorized_keys"
awk 'NF' "${HOME}/.ssh/authorized_keys" "$tmp" | sort -u > "${HOME}/.ssh/authorized_keys.new"
mv "${HOME}/.ssh/authorized_keys.new" "${HOME}/.ssh/authorized_keys"

chmod 700 "${HOME}/.ssh"
chmod 600 "${HOME}/.ssh/authorized_keys"

echo "✅ Installed keys from: $USER_KEYS_URL"
```

* **Idempotent** – safe to rerun anytime
* **Portable** – works on any Linux/Unix host
* **Reproducible** – deterministic permissions & key order

Example alt-source:

```bash
curl -fsSL https://…/ssh_setup.sh | bash -s -- https://gist.githubusercontent.com/<id>/raw/key.pub
```

---

### 🧠 Mental model summary

| Concept                 | Analogy           | Key takeaway                 |
| ----------------------- | ----------------- | ---------------------------- |
| `authorized_keys`       | Lock whitelist    | Determines who can enter     |
| `known_hosts`           | Handshake logbook | Proves who you’re talking to |
| `ControlMaster`         | Connection pool   | Performance optimization     |
| `id_ed25519`            | Private identity  | Never leave your machine     |
| GitHub `.keys` endpoint | Cloud keyring     | Canonical public source      |
| AUR SSH                 | Command gate      | No shell, just RPC commands  |

---

**✅ You are now production-aligned.**

* Secure keypair (Ed25519)
* Deterministic permissions
* Verified host identity
* GitHub/AUR integration
* Audit reproducibility
