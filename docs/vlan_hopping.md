# VLAN Hopping — Attack & Defense

## Overview
VLAN Hopping is a Layer 2 attack allowing an attacker on one VLAN to send or receive traffic on another VLAN without legitimate routing. Two common VLAN-hopping techniques are:

- **Switch (DTP) Spoofing / Trunking Attack** — attacker negotiates a trunk with the switch (using DTP) and gains access to multiple VLANs.
- **Double-Tagging Attack** — attacker crafts 802.1Q frames with two VLAN tags; the outer tag is stripped by the first switch, leaving the inner tag to be forwarded into a target VLAN.

## How the Attacks Work (high level)
- **DTP / Trunking**: If an access port is left in a mode that allows DTP or is misconfigured as a trunk, an attacker can spoof DTP frames and cause the switch to form a trunk, exposing multiple VLANs.
- **Double-tagging**: Frames are sent with 2 VLAN tags (outer: attacker VLAN, inner: target VLAN). The first switch removes outer tag and forwards the frame into the inner VLAN; the switch on the target VLAN accepts it.

## Impact
- Unauthorized access to traffic on other VLANs.
- Bypass of network segmentation and access controls.
- Data leakage, broadcast storms or lateral movement.

## Tools Commonly Used (lab)
- `Yersinia` (for DTP / 802.1X / CDP / etc. protocol attacks)
- `Scapy` (craft double-tagged 802.1Q frames)
- `tcpdump` / `wireshark` (capture & analyze traffic)

## Defenses / Mitigations (recommended)
**Switch configuration (Cisco examples shown):**
1. **Disable DTP / auto-trunking on access ports**

interface FastEthernet0/10
  switchport mode access
  switchport nonegotiate    ! disables DTP
  switchport access vlan 10
  spanning-tree portfast
  switchport port-security

2. **Use an unused native VLAN (not VLAN 1) and set native VLAN consistently**
interface GigabitEthernet0/1
  switchport trunk native vlan 999  ! use an unused VLAN

3. **Do not use VLAN 1 for user access; restrict management VLANs.**

4. **Enable port-security**
    interface FastEthernet0/10
  switchport port-security
  switchport port-security maximum 2
  switchport port-security mac-address sticky
  switchport port-security violation restrict

5. **Enable BPDU Guard, Root Guard, and UDLD where applicable**
   spanning-tree portfast bpduguard default
interface GigabitEthernet0/2
  spanning-tree guard root

6. **Enable dynamic ARP inspection, DHCP snooping, and control plane policing (where supported).**

**Other recommendations**

Use private, unused VLAN as native/trunk native (e.g., 999).

Do not auto-enable trunking on switch ports.

Use management VLANs and ACLs to restrict inter-VLAN traffic.

Monitor switch logs for DTP/Trunk negotiation attempts.

**Summary**

VLAN hopping exploits weak L2 configurations.

Proper switch hardening (disable DTP, port-security, non-default native VLAN, BPDU/Root guard) prevents most attacks.