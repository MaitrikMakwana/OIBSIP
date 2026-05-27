# Screenshots Guide — Task 3: SQL Injection on DVWA

This folder contains screenshots from the SQL Injection demonstration on DVWA (Low Security).

## Screenshot List

| File | Stage | What to Capture |
|---|---|---|
| `01_dvwa_login.png` | Setup | DVWA login page at http://localhost:8080 |
| `02_security_low.png` | Setup | DVWA Security page with level set to **Low** |
| `03_sqli_page.png` | Recon | SQL Injection vulnerability input page |
| `04_syntax_error.png` | Stage 1 | SQL error after submitting `1'` — confirms injection point |
| `05_always_true.png` | Stage 2 | All 5 users returned with `1' OR '1'='1` |
| `06_union_version.png` | Stage 5 | DB version + name via `1' UNION SELECT @@version,database()-- -` |
| `07_table_enum.png` | Stage 6 | Tables listed: `guestbook`, `users` |
| `08_credential_dump.png` | Stage 8 | Usernames + MD5 hashes from `users` table |
| `09_script_output.png` | Script | Terminal showing `sql_injection_exploit.sh` full output |

## How to Take Screenshots on Kali

```bash
# Full screen
scrot screenshots/01_dvwa_login.png

# Select a window interactively
scrot -s screenshots/01_dvwa_login.png

# After a 5 second delay (useful for capturing dropdowns)
scrot -d 5 screenshots/02_security_low.png
```

## Notes

- All screenshots taken on DVWA running at `http://localhost:8080`
- Security level confirmed as **Low** for all stages
- Browser used: Firefox / Chromium on Kali Linux
