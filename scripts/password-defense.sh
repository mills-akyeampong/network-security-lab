#!/bin/bash
# Mitigation: Disable cleartext protocols and enforce encrypted ones

echo "[*] Hardening system against password sniffing..."

# Disable insecure services
sudo systemctl stop telnet.socket
sudo systemctl disable telnet.socket
sudo systemctl stop vsftpd
sudo systemctl disable vsftpd

# Suggest alternatives
echo "Use SSH instead of Telnet."
echo "Use SFTP/FTPS instead of FTP."
echo "Use HTTPS instead of HTTP."

# Enforce SSH
sudo apt-get install -y openssh-server

echo "[*] Defense applied: Insecure protocols disabled, SSH enabled."
