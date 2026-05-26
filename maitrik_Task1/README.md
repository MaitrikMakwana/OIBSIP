# Task 1: Basic Network Scanning with Nmap


**Task Level:** Beginner  
**Status:** ✅ Completed  

---

## Objective

Perform a network scan on a local machine/VM using Nmap to identify open ports, running services, and gather OS information. Document the findings and explain the security significance of each open port.

---

## Environment

| Component | Details |
|-----------|---------|
| OS | Kali Linux / Ubuntu 22.04 |
| Tool | Nmap 7.94 |
| Target | 127.0.0.1 (localhost) / Local VM |
| Network | Internal / Lab environment |

> ⚠️ **Legal Notice:** All scans were performed on machines I own or have explicit permission to scan. Unauthorized network scanning is illegal under the IT Act, 2000 (India) and similar laws worldwide.

---

## Tools Used

- **Nmap** (Network Mapper) — Free, open-source network discovery and security auditing tool.

### Installation

```bash
sudo apt update
sudo apt install nmap -y
nmap --version
```

---

## Scans Performed

### 1. Basic Scan

```bash
nmap 127.0.0.1 -oN nmap_basic.txt
```

Performs a default TCP SYN scan on the 1,000 most common ports.

### 2. Service & Version Detection Scan

```bash
nmap -sV 127.0.0.1 -oN nmap_services.txt
```

Probes open ports to detect service names and version numbers.

### 3. OS Detection Scan

```bash
sudo nmap -O 127.0.0.1 -oN nmap_os.txt
```

Attempts to fingerprint the target operating system using TCP/IP stack behavior.

### 4. Aggressive Scan (All-in-One)

```bash
sudo nmap -A -T4 127.0.0.1 -oN nmap_aggressive.txt
```

Enables OS detection, version detection, script scanning, and traceroute simultaneously. `-T4` uses a faster timing template.

---

## Findings: Open Ports

Below are the open ports identified during scanning.

| Port | Protocol | State | Service | Version |
|------|----------|-------|---------|---------|
| 22 | TCP | Open | SSH | OpenSSH 8.9 |
| 80 | TCP | Open | HTTP | Apache httpd 2.4.52 |
| 3306 | TCP | Open | MySQL | MySQL 8.0.32 |
| 8080 | TCP | Open | HTTP-alt | — |

---

## Security Significance of Each Open Port

### Port 22 — SSH (Secure Shell)

**What it is:** SSH allows encrypted remote login and command execution on the machine.

**Security Risks:**
- Susceptible to brute-force and dictionary attacks if weak passwords are used.
- Default port (22) is well-known and frequently targeted by automated scanners.
- SSH key mismanagement can lead to unauthorized access.

**Recommendations:**
- Disable password-based authentication; use SSH key pairs only.
- Change the default port to a non-standard port (e.g., 2222) using `/etc/ssh/sshd_config`.
- Use `fail2ban` to auto-ban IPs with repeated failed login attempts.
- Restrict access to specific IPs using UFW: `sudo ufw allow from 192.168.1.0/24 to any port 22`

---

### Port 80 — HTTP (HyperText Transfer Protocol)

**What it is:** Port 80 hosts an HTTP web server (Apache). Traffic on this port is unencrypted.

**Security Risks:**
- All data transmitted is in plaintext — susceptible to Man-in-the-Middle (MITM) attacks.
- Outdated Apache versions contain known CVEs (Common Vulnerabilities and Exposures).
- Common attack surface for web vulnerabilities: SQL Injection, XSS, Directory Traversal.

**Recommendations:**
- Force HTTPS by redirecting all port 80 traffic to port 443 (SSL/TLS).
- Keep Apache updated to the latest stable version.
- Disable directory listing in Apache config: `Options -Indexes`
- Use a WAF (Web Application Firewall) such as ModSecurity.

---

### Port 3306 — MySQL (Database)

**What it is:** MySQL database server listening on its default port.

**Security Risks:**
- Exposing the database port externally is a critical misconfiguration.
- Attackers can attempt direct database login with brute-force or stolen credentials.
- Default MySQL root accounts with no password are a known vulnerability.

**Recommendations:**
- Block port 3306 from external access immediately: `sudo ufw deny 3306`
- Bind MySQL to localhost only in `/etc/mysql/mysql.conf.d/mysqld.cnf`: `bind-address = 127.0.0.1`
- Create separate database users with minimal required privileges.
- Enable MySQL audit logging.

---

### Port 8080 — HTTP-alt (Alternative HTTP)

**What it is:** An alternative HTTP port often used for development servers, proxies, or admin panels.

**Security Risks:**
- Developer/test services running on 8080 often lack production-level security controls.
- May expose admin interfaces without authentication.
- Proxy services on 8080 can be exploited for SSRF (Server-Side Request Forgery).

**Recommendations:**
- Investigate what service is running: `sudo ss -tlnp | grep 8080`
- If not needed, block it: `sudo ufw deny 8080`
- If it's a development server, ensure it is not exposed beyond localhost.

---

## Summary of Security Recommendations

| Priority | Action |
|----------|--------|
| 🔴 Critical | Block port 3306 from external access; bind MySQL to localhost |
| 🔴 Critical | Force HTTPS on port 80; disable HTTP |
| 🟠 High | Disable SSH password auth; use key-based authentication only |
| 🟠 High | Investigate and restrict port 8080 |
| 🟡 Medium | Change SSH default port from 22 |
| 🟡 Medium | Install and configure fail2ban |
| 🟢 Low | Regularly update Apache and MySQL to latest stable versions |

---

## Repository Structure

```
task1-nmap-scan/
├── README.md                  ← This file
├── nmap_scan_results.txt      ← Combined output of all 4 scans
├── commands_used.sh           ← All Nmap commands in one script
└── screenshots/
    ├── 01_basic_scan.png
    ├── 02_service_scan.png
    ├── 03_os_detection.png
    └── 04_aggressive_scan.png
```

---

## Demo Video

The demo video covers:
1. Installing Nmap and verifying the version
2. Running all 4 scan types on the target machine
3. Reading and interpreting the output
4. Explaining the significance of each open port

---

## References

- [Nmap Official Documentation](https://nmap.org/docs.html)
- [Nmap Cheat Sheet — StationX](https://www.stationx.net/nmap-cheat-sheet/)
- [OWASP Testing Guide — Network Scanning](https://owasp.org/www-project-web-security-testing-guide/)
- [CVE Database](https://cve.mitre.org/)

---

*Report prepared by: Maitrik | CyBrief Pvt. Ltd. Security Analyst Internship*
