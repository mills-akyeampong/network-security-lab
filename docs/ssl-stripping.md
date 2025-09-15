# SSL Stripping (HTTPS Downgrade) — Attack & Defense

## Overview
SSL stripping is a Man-in-the-Middle (MITM) technique where an attacker intercepts a victim's HTTP requests and transparently proxies connections to an HTTPS site while presenting the victim with HTTP responses — effectively removing TLS from the victim’s session. This exposes sensitive data and allows session hijacking.

## How the Attack Works (high level)
1. Victim requests `http://example.com` (or follows a non-HTTPS link).
2. Attacker intercepts and forwards the request to the real site over HTTPS.
3. Attacker returns responses to the victim over HTTP, removing TLS.
4. Victim submits credentials or cookies over plaintext — attacker captures them.

## Tools Commonly Used
- `sslstrip` (historical tool; lab use only)
- `mitmproxy` can be configured to show downgrade scenarios
- `ettercap` or ARP spoofing used for network positioning

## Impact
- Theft of session cookies, credentials, and sensitive data.
- Invisible to victims if site lacks HTTPS enforcement (HSTS) or secure cookies.

## Mitigations / Best Practices
- Enforce HTTPS site-wide (redirect HTTP → HTTPS).
- Implement HSTS (Strict-Transport-Security) with `preload` and a long max-age.
- Use `Secure` and `HttpOnly` flags on cookies.
- Enable TLS 1.2+ only and disable weak ciphers.
- Use HSTS preload (submit domain to browser preload lists).
- Use tools like `Observatory`/`SSL Labs` to test configuration.

⚠️ **Disclaimer:** For educational, lab-only use. Do not perform attacks on networks or services without explicit permission.
