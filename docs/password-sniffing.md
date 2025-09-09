# Password Sniffing (Cleartext Capture)

## Overview
Password sniffing is the practice of intercepting and capturing credentials sent in cleartext across a network.  
Attackers use packet capture tools to read usernames and passwords from insecure protocols like FTP, Telnet, POP3, and HTTP.

## Attack Flow
1. Attacker sets up packet capture on the same network.
2. Victim logs in using a cleartext protocol (e.g., FTP).
3. Attacker extracts credentials from captured packets.

## Tools Commonly Used
- Wireshark
- tcpdump
- Ettercap

⚠️ **Note**: This attack works only on unencrypted traffic.
