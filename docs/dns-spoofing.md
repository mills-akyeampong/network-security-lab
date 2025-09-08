# DNS Spoofing / DNS Poisoning

## Overview
DNS spoofing occurs when a malicious actor alters DNS records, redirecting users to fraudulent websites.  
Example: typing `www.bank.com` but being redirected to a fake site controlled by the attacker.

## Attack Flow
1. Attacker intercepts DNS queries.
2. Instead of the real IP, attacker sends a fake IP.
3. Victim unknowingly connects to the attacker's server.

## Tools Commonly Used
- `ettercap`
- `dsniff`
- Custom DNS servers

⚠️ **Note**: This is strictly for controlled lab environments.
