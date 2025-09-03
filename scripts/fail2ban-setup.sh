## 📄 `scripts/fail2ban_setup.sh`

```bash
#!/bin/bash

# Fail2Ban setup script for Ubuntu/Debian
# Run as root: sudo bash fail2ban_setup.sh

echo "[*] Updating system..."
apt update -y && apt upgrade -y

echo "[*] Installing Fail2Ban..."
apt install fail2ban -y

echo "[*] Configuring Fail2Ban for SSH..."
cat <<EOL > /etc/fail2ban/jail.local
[sshd]
enabled = true
port    = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 600
EOL

echo "[*] Restarting Fail2Ban..."
systemctl restart fail2ban
systemctl enable fail2ban

echo "[*] Fail2Ban setup completed!"
fail2ban-client status sshd
