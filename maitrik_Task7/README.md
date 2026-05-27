# Task 7: Vulnerability Scanning with Nikto


**Author:** Maitrik  
**Tool:** Nikto v2.1.6  
**Target:** DVWA running at http://localhost:8080  

---

## Objective

Use Nikto to perform a vulnerability scan on a web server (DVWA) and analyze the results to identify potential security issues.

---

## What is Nikto?

**Nikto** is an open-source web server scanner that performs comprehensive tests against web servers for multiple vulnerabilities including:

- Outdated server software and dangerous files
- Misconfigurations (directory indexing, exposed config files)
- Missing security headers
- Insecure cookie flags
- Default/test files left on the server (phpinfo.php, etc.)
- Over 6700 potentially dangerous files/CGIs

Nikto is **not** stealthy — it generates a lot of traffic and will appear in web server logs. It is designed for authorized security assessments only.

---

## Installation

```bash
# Kali Linux (pre-installed)
nikto -Version

# If not installed
sudo apt update && sudo apt install -y nikto

# Verify
nikto -Version
```

---

## Running the Scan

### Basic scan against DVWA
```bash
nikto -h http://127.0.0.1:8080
```

### Save output to file
```bash
nikto -h http://127.0.0.1:8080 -o nikto_scan_results.txt
```

### Full scan with all CGI directories checked
```bash
nikto -h http://127.0.0.1:8080 -C all -o nikto_scan_results.txt
```

### Scan with SSL (if DVWA is on HTTPS)
```bash
nikto -h https://127.0.0.1:443 -ssl -o nikto_scan_results.txt
```

### Scan with specific port
```bash
nikto -h 127.0.0.1 -p 8080 -o nikto_scan_results.txt
```

---

## Scan Results Analysis

Full results are in `nikto_scan_results.txt`. Below is a categorized breakdown of findings.

---

### 🔴 High Severity Findings

#### 1. PHP Info Page Exposed — `/phpinfo.php`
- **Finding:** `phpinfo()` output accessible at `/phpinfo.php`
- **Risk:** Exposes PHP version, server configuration, loaded modules, environment variables, file paths, and compilation options — a goldmine for attackers during reconnaissance.
- **CWE:** CWE-552 — Files or Directories Accessible to External Parties
- **Fix:** Delete or restrict access to `phpinfo.php` on any non-development server. Add to `.htaccess`:
  ```apache
  <Files "phpinfo.php">
    Require all denied
  </Files>
  ```

#### 2. Directory Indexing Enabled — `/config/`, `/docs/`, `/vulnerabilities/`
- **Finding:** Apache directory listing is enabled, allowing anyone to browse folder contents.
- **Risk:** Exposes source files, configuration files, database credentials, and application structure.
- **Fix:** Disable directory indexing in Apache config:
  ```apache
  Options -Indexes
  ```

#### 3. Configuration Directory Accessible — `/config/`
- **Finding:** `/config/` directory is browsable and may contain `config.inc.php` with database credentials.
- **Risk:** Direct exposure of `DB_HOST`, `DB_USER`, `DB_PASSWORD` to unauthenticated users.
- **Fix:** Move config files outside web root, or restrict access via `.htaccess`.

---

### 🟠 Medium Severity Findings

#### 4. Outdated Apache Version — `Apache/2.4.57`
- **Finding:** Server banner reveals Apache 2.4.57; current stable is 2.4.58+.
- **Risk:** Older versions may have known CVEs. Banner disclosure also aids attacker reconnaissance.
- **Fix:** Update Apache: `sudo apt upgrade apache2`. Suppress version in banner:
  ```apache
  ServerTokens Prod
  ServerSignature Off
  ```

#### 5. Cookies Missing `HttpOnly` Flag — `PHPSESSID`, `security`
- **Finding:** Session and security cookies set without `HttpOnly` flag.
- **Risk:** Cookies accessible via JavaScript — enables session theft via XSS attacks.
- **Fix:** In `php.ini`:
  ```ini
  session.cookie_httponly = 1
  ```
  Or in PHP code:
  ```php
  session_set_cookie_params(['httponly' => true, 'secure' => true, 'samesite' => 'Strict']);
  ```

#### 6. INode Leakage via ETag — CVE-2003-1418
- **Finding:** Apache ETag header leaks inode numbers of files.
- **Risk:** Can expose internal server file structure; useful for attackers in certain exploitation scenarios.
- **Fix:** Disable inode-based ETags in Apache config:
  ```apache
  FileETag MTime Size
  ```

---

### 🟡 Low Severity / Informational Findings

#### 7. Missing `X-Frame-Options` Header
- **Finding:** No `X-Frame-Options` header present.
- **Risk:** Application can be embedded in an `<iframe>` on an attacker's site — enables clickjacking attacks.
- **Fix:** Add to Apache config or `.htaccess`:
  ```apache
  Header always set X-Frame-Options "SAMEORIGIN"
  ```

#### 8. Missing `X-Content-Type-Options` Header
- **Finding:** `X-Content-Type-Options: nosniff` header absent.
- **Risk:** Browsers may MIME-sniff responses, potentially executing uploaded files as scripts.
- **Fix:**
  ```apache
  Header always set X-Content-Type-Options "nosniff"
  ```

#### 9. Sensitive Files Exposed
| File | Risk |
|---|---|
| `/.gitignore` | Reveals directory structure and ignored file paths |
| `/CHANGELOG.md` | Reveals application version history |
| `/README.md` | Reveals application details |
| `/setup.php` | Database setup page should be removed post-install |

**Fix:** Remove or restrict access to all such files in production:
```bash
rm /var/www/html/dvwa/.gitignore
rm /var/www/html/dvwa/CHANGELOG.md
rm /var/www/html/dvwa/setup.php
```

#### 10. Vulnerability Pages Publicly Accessible
- **Finding:** All DVWA vulnerability pages (`/vulnerabilities/sqli/`, `/vulnerabilities/xss_r/`, etc.) are indexed and accessible.
- **Note:** This is intentional for DVWA as a training platform. On a real application, these would represent critical vulnerabilities.

---

## Summary Table

| # | Finding | Severity | CVSS (approx) | Fix |
|---|---|---|---|---|
| 1 | phpinfo.php exposed | 🔴 High | 7.5 | Delete file |
| 2 | Directory indexing | 🔴 High | 7.5 | `Options -Indexes` |
| 3 | Config dir accessible | 🔴 High | 8.1 | Restrict or move outside webroot |
| 4 | Outdated Apache | 🟠 Medium | 5.3 | Update + suppress banner |
| 5 | Missing HttpOnly on cookies | 🟠 Medium | 6.1 | `session.cookie_httponly=1` |
| 6 | ETag inode leakage | 🟠 Medium | 5.0 | `FileETag MTime Size` |
| 7 | Missing X-Frame-Options | 🟡 Low | 4.3 | Set header in Apache |
| 8 | Missing X-Content-Type-Options | 🟡 Low | 4.3 | Set nosniff header |
| 9 | Sensitive files (.gitignore etc.) | 🟡 Low | 3.7 | Remove files |
| 10 | Login page exposed | ℹ️ Info | — | Rate limiting, lockout |

---

## How to Run Nikto (Reproduce This Scan)

```bash
# Step 1: Start DVWA
docker run -d -p 8080:80 docker.io/vulnerables/web-dvwa

# Step 2: Run Nikto
nikto -h http://l127.0.0.1:8080 -o nikto_scan_results.txt

# Step 3: View results
cat nikto_scan_results.txt
```

---

## Screenshots

| File | Description |
|---|---|
| `screenshots/01_nikto_running.png` | Nikto scan in progress in terminal |
| `screenshots/02_nikto_results.png` | Full scan output showing all findings |
| `screenshots/03_phpinfo_exposed.png` | Browser showing exposed phpinfo.php |
| `screenshots/04_directory_indexing.png` | Browser showing /config/ directory listing |

---

## Disclaimer

> Nikto was run against DVWA — a deliberately vulnerable application in a local lab environment. Scanning web servers without explicit written authorization is illegal. This demonstration is for educational purposes only as part of the CyBrief Pvt. Ltd. cybersecurity internship.

---


