# ARP Spoofing Attack & Defense

## 🔹 What is ARP Spoofing?
ARP (Address Resolution Protocol) Spoofing is a Man-in-the-Middle (MITM) attack where an attacker sends fake ARP replies to associate their MAC address with the IP address of another host (like the default gateway). This allows the attacker to intercept, modify, or block traffic.

---

## 🔹 How the Attack Works
1. Victim asks "Who has 192.168.1.1 (Gateway)?"
2. Attacker replies "I do!" with their MAC address.
3. Victim updates its ARP table with the wrong MAC.
4. All traffic meant for the gateway goes to the attacker.

---

## 🔹 Defense Methods
- Enable **Dynamic ARP Inspection (DAI)** on switches (enterprise networks).
- Use **static ARP entries** on critical servers.
- Detect spoofing with monitoring scripts.
- Use tools like `arpwatch`.

---

## 🔹 Mitigation Script (Python)

See [`scripts/arp_defense.py`](../scripts/arp_defense.py) for a detection script that alerts if ARP spoofing is detected.

---

## ✅ Summary
- **Attack:** Attacker poisons ARP cache with fake MAC.  
- **Impact:** Traffic redirection, sniffing, MITM.  
- **Defense:** Dynamic ARP inspection, static ARP, monitoring with scripts.  
