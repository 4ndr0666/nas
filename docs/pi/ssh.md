# SSH into Host from Client

## Scenario

* **Client**: `andro@theworkpc` (`192.168.1.226`)
* **Host**: `kali@4ndr0kali` (`192.168.1.91`)

Goal: seamless, passwordless SSH login from client → Kali Pi using modern, secure practices.

---

## Steps

### 1. Generate SSH keypair (client-side)

On the client (`andro@theworkpc`):

```bash
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/id_ed25519 -C "andro@theworkpc"
```

* Uses **Ed25519** (modern, strong, lightweight).
* Saves to `~/.ssh/id_ed25519` (private) + `.pub` (public).

---

### 2. Fetch key from GitHub (server-side)

Since the public key is already linked to GitHub under [github.com/4ndr0666](https://github.com/4ndr0666), the Pi can pull it directly:

```bash
# On the Kali Pi console
mkdir -p ~/.ssh
chmod 700 ~/.ssh
curl -s https://github.com/4ndr0666.keys >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

That’s it — no USB sticks, no password fights, no `ssh-copy-id`.
GitHub serves all your public keys at `/username.keys`.

---

### 3. Configure SSH client (optional, for convenience)

On the client, edit `~/.ssh/config`:

```sshconfig
Host kali
    HostName 192.168.1.91
    User kali
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    StrictHostKeyChecking yes
    HashKnownHosts yes
    HostKeyAlgorithms ssh-ed25519
```

Now `ssh kali` just works.

---

### 4. Verify the connection

From the client:

```bash
ssh -vvv -o ControlMaster=no -o ControlPath=none kali
```

Expected log highlights:

* `Server host key: ssh-ed25519 SHA256:euCxRZVZ...`
* `Authenticated ... using "publickey"`
* **No password prompt**

---

## Extras

* Confirm server identity (`known_hosts` should contain a single hashed ED25519 entry for `192.168.1.91`).
* Disable password logins on the Pi for extra security:

  ```bash
  sudoedit /etc/ssh/sshd_config
  ```

  ```
  PasswordAuthentication no
  KbdInteractiveAuthentication no
  ```

  Then:

  ```bash
  sudo systemctl restart ssh
  ```

---

✅ Done. You now have secure, passwordless SSH between your workstation and Kali Pi, using GitHub as your key distribution source.
