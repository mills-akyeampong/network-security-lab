# SSH Brute Force Attack & Defense

## 🔹 What is SSH Brute Force?
SSH Brute Force is an attack where an attacker repeatedly tries different username/password combinations on an SSH server until they find the correct credentials. Automated tools like Hydra or Medusa can launch thousands of login attempts in seconds.

---

## 🔹 How the Attack Works
1. Attacker scans for open SSH port (default: 22).
2. Uses a dictionary or brute force tool to guess credentials.
3. If successful, attacker gains unauthorized access to the server.

---

## 🔹 Example Attack Command (Hydra)
```bash
hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.20
-l root → username (root)

-P → password wordlist

192.168.1.20 → target IP


🔹 Defense Methods

Disable root login over SSH.

Use strong passwords or, better, SSH keys.

Change the default SSH port from 22.

Deploy Fail2Ban to automatically block IPs after failed attempts.


🔹 Mitigation Script (Fail2Ban Setup)

See scripts/fail2ban_setup.sh



✅ Summary

Attack: Automated login attempts on SSH.

Impact: Unauthorized access if weak passwords exist.

Defense: SSH key authentication, disable root login, Fail2Ban.