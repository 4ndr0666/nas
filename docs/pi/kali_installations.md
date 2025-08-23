# Kali Linux Pi Caveats

The following covers the **nuances of running Kali on the pi**:

1. **GPG/Repo Key Errors** (missing or expired keys)
2. **Broken/Unmet Package Dependencies** (missing packages, held/broken)

---

## Kali Rolling NO\_PUBKEY**

Add the missing Kali repo key:

```bash
# Add the Kali Linux public key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED65462EC8D5E4C5

# Or (for newer APT, recommended)
curl -fsSL https://archive.kali.org/archive-key.asc | sudo gpg --dearmor -o /usr/share/keyrings/kali-archive-keyring.gpg
```

**Then, ensure your `/etc/apt/sources.list` uses this keyring:**

```
deb [signed-by=/usr/share/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free
```

---

## **Fix Broken/Outdated Packages**

#### **a. Update and Fix the Package Database**

```bash
sudo apt clean
sudo apt update --allow-insecure-repositories --allow-unauthenticated
sudo apt --fix-broken install
sudo dpkg --configure -a
```

#### **b. Check and Remove Held Packages**

```bash
sudo apt-mark showhold
# Unhold any held packages (example)
sudo apt-mark unhold <package>
```

---

## Docker Deps

```bash
sudo apt update
sudo apt install gnupg dirmngr gnupg-l10n gnupg-utils
sudo apt install software-properties-common || true
```

---

*Fetch the following for debugging*:
```bash
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/
apt-key list
lsb_release -a
```
