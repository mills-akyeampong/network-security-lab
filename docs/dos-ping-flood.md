# Denial of Service (DoS) - ICMP Ping Flood

## Overview
A Ping Flood is a basic DoS attack where the attacker overwhelms a target with ICMP Echo Requests (pings).  
The goal is to exhaust bandwidth, CPU, or memory, making the system unresponsive.

## Attack Flow
1. Attacker sends a large volume of ICMP Echo Requests.
2. Target responds with ICMP Echo Replies.
3. Excessive packets slow down or crash the target system.

## Tools Commonly Used
- `ping` command with high frequency
- `hping3` (customizable packet crafting tool)

⚠️ **Note**: This is for educational/lab purposes only.
