### 📂 `scripts/dns-defense.sh`
```bash
#!/bin/bash
# Basic defense against DNS spoofing

echo "[*] Applying DNS security measures..."

# Use only trusted DNS servers
sudo nmcli dev show | grep DNS
echo "Consider switching to secure DNS like 1.1.1.1 or 8.8.8.8"

# Block spoofed replies (drop DNS responses not from your DNS server)
DNS_SERVER="8.8.8.8"
sudo iptables -A INPUT -p udp --sport 53 ! -s $DNS_SERVER -j DROP

# Enable DNSSEC if supported
echo "Enable DNSSEC on your DNS resolver for added protection."

echo "[*] DNS defense rules applied."
