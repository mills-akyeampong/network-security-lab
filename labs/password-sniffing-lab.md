# Password Sniffing Lab

## Objective
Demonstrate how insecure protocols expose credentials and how encryption mitigates the risk.

## Requirements
- Attacker machine: Kali Linux
- Victim machine: Ubuntu/Debian
- Tools: tcpdump / Wireshark, FTP server

## Steps
1. On attacker machine, start packet capture:
   ```bash
   sudo tcpdump -i eth0 -w sniffed.pcap

2. On victim machine, connect to FTP server:
   ```bash
   ftp <attacker-ip>
    Username: testuser
    Password: password123

3. Stop capture and open file in Wireshark:
   ```bash
   wireshark sniffed.pcap

4. Search for USER and PASS fields — credentials are visible in   cleartext.

5. Repeat test using sftp or ftps (encrypted).
   Observe that credentials are no longer visible.