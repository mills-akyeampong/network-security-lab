#!/bin/bash
# Basic TLS/HTTPS hardening checklist for a Linux web server (nginx example)
# Run as root or with sudo. This script provides recommended changes; review before applying.

echo "[*] Installing recommended packages..."
apt update -y
apt install -y nginx certbot

echo "[*] Sample nginx server block: ensure redirect HTTP->HTTPS and HSTS"
cat <<'NGINX' > /etc/nginx/sites-available/ssl_hardened.conf
server {
    listen 80;
    server_name example.com www.example.com;
    # Redirect all HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name example.com www.example.com;

    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

    # Strong TLS settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256';

    # HSTS
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;

    # Security headers
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";

    root /var/www/html;
    index index.html;
}
NGINX

echo "[*] Enabling nginx site and restarting..."
ln -s /etc/nginx/sites-available/ssl_hardened.conf /etc/nginx/sites-enabled/ssl_hardened.conf
nginx -t && systemctl reload nginx

echo "[*] Reminder: obtain certificates with certbot:"
echo "sudo certbot --nginx -d example.com -d www.example.com"

echo "[*] Hardening script completed. Review nginx config and replace example.com with your domain."
