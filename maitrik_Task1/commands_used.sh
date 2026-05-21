#!/bin/bash
# ============================================================
# Task 1: Basic Network Scanning with Nmap
# CyBrief Pvt. Ltd. — Security Analyst Internship
# ============================================================
# LEGAL: Run ONLY on machines you own or have written permission
# to scan. Unauthorized scanning is illegal.
# ============================================================

TARGET="${1:-127.0.0.1}"
OUTPUT_DIR="./nmap_results"

echo "[*] Creating output directory..."
mkdir -p "$OUTPUT_DIR"

echo "[*] Target: $TARGET"
echo "[*] Starting Nmap scans..."

# ── Scan 1: Basic scan (top 1000 ports) ─────────────────────
echo ""
echo "[1/4] Running basic scan..."
nmap "$TARGET" -oN "$OUTPUT_DIR/nmap_basic.txt"
echo "[+] Basic scan saved to $OUTPUT_DIR/nmap_basic.txt"

# ── Scan 2: Service and version detection ───────────────────
echo ""
echo "[2/4] Running service + version detection scan..."
nmap -sV "$TARGET" -oN "$OUTPUT_DIR/nmap_services.txt"
echo "[+] Service scan saved to $OUTPUT_DIR/nmap_services.txt"

# ── Scan 3: OS detection (requires root) ────────────────────
echo ""
echo "[3/4] Running OS detection scan (requires sudo)..."
sudo nmap -O "$TARGET" -oN "$OUTPUT_DIR/nmap_os.txt"
echo "[+] OS detection scan saved to $OUTPUT_DIR/nmap_os.txt"

# ── Scan 4: Aggressive all-in-one scan ──────────────────────
echo ""
echo "[4/4] Running aggressive scan (-A -T4)..."
sudo nmap -A -T4 "$TARGET" -oN "$OUTPUT_DIR/nmap_aggressive.txt"
echo "[+] Aggressive scan saved to $OUTPUT_DIR/nmap_aggressive.txt"

# ── Combine all results into one file ───────────────────────
echo ""
echo "[*] Combining all results..."
{
  echo "============================================================"
  echo " NMAP SCAN RESULTS — Task 1 | CyBrief Internship"
  echo " Target: $TARGET | Date: $(date)"
  echo "============================================================"
  echo ""
  echo "=== SCAN 1: BASIC SCAN ==="
  cat "$OUTPUT_DIR/nmap_basic.txt"
  echo ""
  echo "=== SCAN 2: SERVICE & VERSION DETECTION ==="
  cat "$OUTPUT_DIR/nmap_services.txt"
  echo ""
  echo "=== SCAN 3: OS DETECTION ==="
  cat "$OUTPUT_DIR/nmap_os.txt"
  echo ""
  echo "=== SCAN 4: AGGRESSIVE SCAN ==="
  cat "$OUTPUT_DIR/nmap_aggressive.txt"
} > nmap_scan_results.txt

echo ""
echo "============================================================"
echo "[✓] All scans complete!"
echo "[✓] Combined output: nmap_scan_results.txt"
echo "[✓] Individual files in: $OUTPUT_DIR/"
echo "============================================================"
echo ""
echo "Usage: bash commands_used.sh [TARGET_IP]"
echo "Example: bash commands_used.sh 192.168.1.10"
