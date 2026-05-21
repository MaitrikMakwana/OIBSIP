# Task 2: Basic Firewall Configuration with UFW


**Tool:** UFW (Uncomplicated Firewall)  
**Platform:** Kali Linux (VirtualBox)

---

## Objective

Set up a basic firewall using UFW on a Linux system that:
- Allows SSH traffic (port 22)
- Denies HTTP traffic (port 80)

---

## Files in This Submission

| File | Description |
|------|-------------|
| `ufw_configuration.sh` | Automated shell script to configure UFW |
| `ufw_status_screenshot.png` | Screenshot of active UFW rules |
| `README.md` | This file |

---

## Configuration Steps

### 1. Install UFW
```bash
sudo apt update
sudo apt install ufw -y
```

### 2. Set Default Policies
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```
All incoming traffic is blocked by default. Only explicitly allowed ports pass through.

### 3. Allow SSH (Port 22)
```bash
sudo ufw allow 22/tcp
```
SSH is allowed so remote access to the system is maintained after the firewall is enabled.

### 4. Deny HTTP (Port 80)
```bash
sudo ufw deny 80/tcp
```
HTTP traffic on port 80 is explicitly denied.

### 5. Enable the Firewall
```bash
sudo ufw enable
```

### 6. Verify Rules
```bash
sudo ufw status verbose
```

---

## Expected Output

```
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
80/tcp                     DENY IN     Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
80/tcp (v6)                DENY IN     Anywhere (v6)
```

---

## Why These Rules?

| Port | Protocol | Action | Reason |
|------|----------|--------|--------|
| 22 | TCP | ALLOW | Required for SSH remote management |
| 80 | TCP | DENY | HTTP traffic not needed; reduces attack surface |

---

## How to Run the Script

```bash
chmod +x ufw_configuration.sh
sudo ./ufw_configuration.sh
```

---

## Reverting (Disable Firewall)

```bash
sudo ufw disable
# or reset all rules:
sudo ufw reset
```



