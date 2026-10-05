#!/bin/bash
# ==============================================================================
# Script: harden-fortress.sh
# Purpose: Automates UFW perimeter defense and Fail2Ban deployment for Ubuntu.
#          Designed for Purple Team defense operations.
# ==============================================================================

echo "[*] Initiating Fortress Lockdown..."

# 1. Enforce strict UFW Perimeter 
echo "[*] Configuring UFW default-deny policy..."
ufw default deny incoming
ufw default allow outgoing

# 2. Allow only authorized remote access
echo "[*] Opening authorized ports (SSH/HTTP)..."
ufw allow 22/tcp
ufw allow 80/tcp

# 3. Enable Firewall (Forced to prevent prompt disruption)
echo "[*] Activating UFW..."
ufw --force enable
ufw status verbose

# 4. Restart Fail2Ban to ingest new jail.local configs
echo "[*] Restarting active defenses (Fail2Ban)..."
systemctl restart fail2ban
fail2ban-client status sshd

echo "[+] Lockdown Complete. Fortress is active."
