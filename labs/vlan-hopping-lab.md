# Lab: VLAN Hopping — Switch Spoofing & Double-Tagging

## Objective
Demonstrate two VLAN-hopping techniques in a controlled lab:
1. Switch/DTP (trunk) spoofing
2. 802.1Q double-tagging

## Requirements
- 3 VMs (or more):
  - **Attacker**: Kali / Parrot OS (root privileges)
  - **Victim-A**: Host on VLAN 10 (target VLAN)
  - **Victim-B**: Host on VLAN 20 (attacker VLAN)
- A switch (physical lab switch or virtual switch in GNS3 / EVE-NG / VMware) that supports 802.1Q and DTP.
- Tools: `yersinia` (optional), `scapy` (Python), `tcpdump`/`wireshark`.

> Use an isolated lab network (VirtualBox internal net, VMware host-only, or GNS3). **Do not** run on production networks.

---

## Topology (example)
[Victim-A VLAN10] ---|
|---[Switch]--- Internet/Gateway
[Attacker VLAN20] ---|
[Victim-B VLAN20] ---|



Switch ports:
- Fa0/1: Victim-A (access VLAN 10)
- Fa0/2: Attacker (access VLAN 20) — attacker will try to hop to VLAN10
- Fa0/24: Uplink/trunk to router (trunked)

---

## Part A — Switch/DTP Trunk Spoofing (using Yersinia)
1. Install yersinia on attacker:

sudo apt update
sudo apt install yersinia -y


2. Launch yersinia GUI or CLI and attempt DTP attacks:
    sudo yersinia -G   # GUI (if available)
# or from CLI: yersinia -I dtp -a attack

3. If the switch port is misconfigured (e.g., allowed to negotiate trunk), the attacker may cause the switch to negotiate a trunk and see traffic from other VLANs. Observe with tcpdump on attacker interface.

Mitigation check: On a hardened switch, DTP will fail because switchport nonegotiate or access mode is enforced.


Part B — Double-Tagging Attack (using Scapy)

Double-tagging success depends on switch behavior (native VLAN handling). This is purely for lab illustration.

1. On attacker, create a Python script (double_tag_send.py) that crafts and sends a double-tagged frame (outer VLAN 20, inner VLAN 10):

    sudo python3 scripts/double_tag_send.py

2. Capture on Victim-A (VLAN 10):
    sudo tcpdump -i eth0 -n -vvv 'vlan' -w double_tag.pcap

3. If the first switch strips the outer tag (native VLAN behavior) and forwards inner tag to VLAN 10, Victim-A may receive the frame.

Note: Modern switches and using a non-default native VLAN reduces this attack's effectiveness.


Part C — Verification & Hardening

Apply switch-hardening measures (see docs/vlan_hopping.md).

Re-run attacks — they should fail:

DTP attempts should not create a trunk.

Double-tagged frames should not reach other VLANs if native VLANs and trunk/native configs are correct.


Cleanup

Stop any attack tools (Ctrl+C).

Remove extra captures (.pcap) and restore any switch changes.