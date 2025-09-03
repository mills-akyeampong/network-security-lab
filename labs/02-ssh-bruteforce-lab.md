## 📄 `labs/02_ssh_bruteforce_lab.md`

```markdown
# 🔬 Lab 2: SSH Brute Force Simulation

This lab demonstrates how an SSH brute force attack works and how to defend against it using Fail2Ban.

---

## ⚙️ Requirements
- Attacker VM: Kali Linux / Parrot OS (with Hydra installed).
- Victim VM: Ubuntu Server (with SSH enabled).
- Both machines on the same network.

---

## 🔹 Step 1: Enable SSH on Victim
On victim server:
    $bash
    sudo apt update && sudo apt install openssh-server -y
    sudo systemctl enable ssh
    sudo systemctl start ssh

Verify SSH is running:
    $bash
    sudo systemctl status ssh

---

## 🔹 Step 2: Launch SSH Brute Force Attack

On attacker (Kali):
    $bash
    hydra -l testuser -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.20

testuser → a user on the victim machine.

rockyou.txt → common password list.

192.168.1.20 → victim IP.

Observe repeated login attempts.

---

## 🔹 Step 3: Defense with Fail2Ban

On victim (Ubuntu):
    $bash
    sudo apt install fail2ban -y

Default config is in /etc/fail2ban/jail.conf. To customize, copy it:
    $bash
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

Enable SSH jail in /etc/fail2ban/jail.local:
    [sshd]
    enabled = true
    port    = ssh
    logpath = /var/log/auth.log
    maxretry = 3
    bantime = 600

Restart Fail2Ban:
    sudo systemctl restart fail2ban

---

## 🔹 Step 4: Test Defense

Run Hydra attack again.
After 3 failed attempts, attacker’s IP should be banned.

Check status:
    $bash
    sudo fail2ban-client status sshd

✅ Lab Summary

Simulated brute force with Hydra.

Observed repeated login attempts.

Deployed Fail2Ban to auto-block attacker IPs.
