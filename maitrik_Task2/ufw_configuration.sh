#!/bin/bash
# ============================================================
# ufw_configuration.sh
# UFW Firewall Setup Script — CyBrief Internship Task 2
# Author: Maitrik
# Description: Installs and configures UFW on Kali/Ubuntu Linux
#              - Allows SSH (port 22)
#              - Denies HTTP (port 80)
# ============================================================

set -e  # Exit immediately on error

echo "[*] Checking for root privileges..."
if [ "$EUID" -ne 0 ]; then
  echo "[!] Please run this script as root (sudo ./ufw_configuration.sh)"
  exit 1
fi

echo "[*] Updating package list..."
apt update -y

echo "[*] Installing UFW..."
apt install ufw -y

echo "[*] Setting default policies..."
ufw default deny incoming
ufw default allow outgoing

echo "[*] Allowing SSH (port 22/tcp)..."
ufw allow 22/tcp

echo "[*] Denying HTTP (port 80/tcp)..."
ufw deny 80/tcp

echo "[*] Enabling UFW firewall..."
echo "y" | ufw enable

echo ""
echo "=========================================="
echo "  UFW Configuration Complete"
echo "=========================================="
ufw status verbose
echo ""
echo "[✓] Firewall is active with the following rules:"
echo "    - SSH  (22/tcp)  : ALLOWED"
echo "    - HTTP (80/tcp)  : DENIED"
