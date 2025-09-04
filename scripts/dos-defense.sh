
---

### 📂 `scripts/dos-defense.sh`
```bash
#!/bin/bash
# Basic DoS Ping Flood defense using iptables

TARGET_IF="eth0"

echo "[*] Applying basic ICMP flood mitigation..."

# Limit ICMP requests to 1 per second
sudo iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Optional: log dropped packets
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j LOG --log-prefix "ICMP Flood: "

echo "[*] Defense rules applied."
