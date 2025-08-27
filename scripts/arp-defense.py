from scapy.all import ARP, sniff

# Predefined ARP table (replace MACs with your real ones in lab)
arp_table = {
    "192.168.1.1": "00:11:22:33:44:55",  # Gateway MAC
    "192.168.1.10": "66:77:88:99:AA:BB"  # Victim MAC
}

def detect_arp_spoof(packet):
    if packet.haslayer(ARP) and packet[ARP].op == 2:  # ARP reply
        try:
            real_mac = arp_table.get(packet[ARP].psrc)
            if real_mac and real_mac != packet[ARP].hwsrc:
                print(f"[ALERT] Possible ARP Spoofing Detected!")
                print(f"IP: {packet[ARP].psrc} is being spoofed by {packet[ARP].hwsrc}")
        except Exception as e:
            pass

print("[*] Starting ARP spoof detection...")
sniff(store=False, prn=detect_arp_spoof)
