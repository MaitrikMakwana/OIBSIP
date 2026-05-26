# Network Security Threats: A Comprehensive Research Report

**Author:** Maitrik   
**Task:** Task 4 — Research Report on Common Network Security Threats  
**Date:** May 2026

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Denial of Service (DoS) and Distributed DoS (DDoS) Attacks](#2-denial-of-service-dos-and-distributed-dos-ddos-attacks)
3. [Man-in-the-Middle (MITM) Attacks](#3-man-in-the-middle-mitm-attacks)
4. [Spoofing Attacks](#4-spoofing-attacks)
5. [Packet Sniffing / Eavesdropping](#5-packet-sniffing--eavesdropping)
6. [DNS Hijacking and Cache Poisoning](#6-dns-hijacking-and-cache-poisoning)
7. [Comparative Summary](#7-comparative-summary)
8. [Conclusion](#8-conclusion)
9. [References](#9-references)

---

## 1. Introduction

Network security threats are malicious activities that target the confidentiality, integrity, and availability (CIA triad) of networked systems. As organizations become increasingly dependent on digital infrastructure, the frequency and sophistication of network attacks have grown significantly.

This report examines five major categories of network security threats:
- **DoS/DDoS attacks** — targeting availability
- **Man-in-the-Middle (MITM) attacks** — targeting confidentiality and integrity
- **Spoofing attacks** — targeting identity and trust
- **Packet sniffing / eavesdropping** — targeting confidentiality
- **DNS hijacking** — targeting integrity and availability

For each threat, this report covers: how it works, its impact, real-world examples, and mitigation strategies.

---

## 2. Denial of Service (DoS) and Distributed DoS (DDoS) Attacks

### 2.1 Overview

A **Denial of Service (DoS)** attack floods a target system — server, network, or application — with excessive traffic or malformed requests, rendering it unavailable to legitimate users. A **Distributed DoS (DDoS)** attack scales this by using a botnet (a network of compromised machines) to launch the attack from thousands of sources simultaneously.

### 2.2 How It Works

**Volumetric Attacks:**
- Attacker sends massive amounts of UDP/ICMP packets to exhaust bandwidth.
- Example: UDP flood, ICMP flood (Ping of Death).

**Protocol Attacks:**
- Exploit weaknesses in TCP/IP to consume server-side resources.
- Example: SYN flood — attacker sends TCP SYN packets but never completes the handshake, filling the server's connection table.

**Application Layer Attacks (Layer 7):**
- Mimic legitimate HTTP requests to exhaust web server resources.
- Example: HTTP GET/POST flood, Slowloris attack.

**Amplification Attacks:**
- Attacker spoofs the victim's IP, sends small requests to open servers (DNS, NTP), which respond with large replies — directing massive traffic at the victim.
- Example: DNS amplification (amplification factor up to 70x), NTP amplification.

### 2.3 Impact

| Impact Area | Description |
|---|---|
| Service Unavailability | Legitimate users cannot access the service |
| Financial Loss | Downtime costs businesses thousands to millions per hour |
| Reputational Damage | Trust erodes if SLAs are breached |
| Resource Exhaustion | CPU, memory, and bandwidth consumed entirely |
| Cover for Other Attacks | DDoS can distract security teams during data breaches |

### 2.4 Real-World Examples

- **GitHub DDoS (2018):** GitHub suffered the largest DDoS ever recorded at the time — a 1.35 Tbps memcached amplification attack. It was mitigated within 10 minutes via Akamai's DDoS protection.
- **Dyn DNS Attack (2016):** A Mirai botnet (compromised IoT devices) attacked Dyn's DNS infrastructure, taking down Twitter, Netflix, Reddit, and Spotify for hours.
- **AWS Shield (2020):** Amazon mitigated a 2.3 Tbps DDoS attack — the largest ever recorded — targeting an AWS customer.

### 2.5 Mitigation Strategies

1. **Rate Limiting:** Restrict the number of requests per IP per second at the network edge.
2. **Traffic Scrubbing / DDoS Protection Services:** Use services like Cloudflare, Akamai, or AWS Shield that absorb and filter attack traffic.
3. **Anycast Network Diffusion:** Spread incoming traffic across multiple data centers.
4. **SYN Cookies:** Prevent SYN flood by not allocating resources until the TCP handshake is complete.
5. **Ingress Filtering (BCP38):** Network providers should block packets with spoofed source IPs.
6. **Web Application Firewall (WAF):** Detect and block Layer 7 attacks based on request patterns.
7. **Capacity Planning & CDN:** Over-provision bandwidth and use CDNs to absorb volumetric floods.

---

## 3. Man-in-the-Middle (MITM) Attacks

### 3.1 Overview

A **Man-in-the-Middle (MITM)** attack occurs when an attacker secretly intercepts and potentially alters communications between two parties who believe they are communicating directly with each other. The attacker acts as a relay — reading, modifying, or injecting data undetected.

### 3.2 How It Works

**ARP Spoofing (LAN-based):**
1. Attacker broadcasts fake ARP (Address Resolution Protocol) replies on the local network.
2. Victims' ARP tables map the gateway's IP to the attacker's MAC address.
3. All traffic intended for the gateway now flows through the attacker.

**SSL Stripping:**
1. Victim initiates an HTTPS request.
2. Attacker downgrades the connection to HTTP between themselves and the victim, while maintaining HTTPS with the actual server.
3. Sensitive data (passwords, tokens) flows unencrypted through the attacker.

**DNS Spoofing:**
1. Attacker poisons a DNS cache or intercepts DNS queries.
2. Redirects the victim to a fraudulent IP address (attacker-controlled server) for a legitimate domain.

**Wi-Fi Eavesdropping (Evil Twin Attack):**
1. Attacker creates a rogue Wi-Fi access point mimicking a legitimate one (same SSID).
2. Victims connect to it, and all their traffic passes through the attacker.

**BGP Hijacking:**
1. Attacker announces illegitimate BGP routes to redirect internet traffic at scale.
2. Typically executed by nation-state actors or rogue ISPs.

### 3.3 Impact

- **Credential Theft:** Usernames, passwords, session tokens intercepted.
- **Data Manipulation:** Financial transaction details or messages altered mid-transit.
- **Session Hijacking:** Attacker reuses stolen session cookies to impersonate users.
- **Malware Injection:** Attacker injects malicious code into unencrypted HTTP pages.

### 3.4 Real-World Examples

- **Superfish Adware (2015):** Lenovo pre-installed Superfish on laptops — it used a self-signed CA to intercept all HTTPS traffic, performing MITM on its own users to inject ads.
- **Belgian Cryptanalysis (2013):** Belgian telecom Belgacom was compromised by GCHQ in a MITM attack involving BGP hijacking and SSL interception — linked to the Snowden documents.
- **Iranian DigiNotar Compromise (2011):** Attackers obtained fraudulent SSL certificates from DigiNotar CA, enabling MITM against ~300,000 Iranian Gmail users.

### 3.5 Mitigation Strategies

1. **TLS/HTTPS Everywhere:** Enforce HTTPS; use HSTS (HTTP Strict Transport Security) to prevent SSL stripping.
2. **Certificate Pinning:** Applications pin known certificates/public keys, rejecting any substituted certificate.
3. **DNSSEC:** Digitally signs DNS records to prevent cache poisoning.
4. **Multi-Factor Authentication (MFA):** Even if credentials are intercepted, MFA adds a second layer.
5. **VPN:** Encrypts all traffic end-to-end, especially on public Wi-Fi.
6. **Public Key Infrastructure (PKI):** Properly managed CA certificates prevent rogue certificate acceptance.
7. **ARP Inspection / Dynamic ARP Inspection (DAI):** Validates ARP packets on managed switches to block ARP spoofing.
8. **Network Monitoring:** Detect anomalies like ARP table inconsistencies or unexpected certificate changes.

---

## 4. Spoofing Attacks

### 4.1 Overview

**Spoofing** is the act of disguising communication from an unknown source as being from a known, trusted source. Attackers forge headers, addresses, or identities to bypass security controls, gain unauthorized access, or deceive users.

### 4.2 Types of Spoofing

#### 4.2.1 IP Spoofing
- Attacker forges the source IP address in packet headers.
- Used to bypass IP-based access controls, conduct DDoS amplification, or hide identity.
- Stateless protocols (UDP, ICMP) are particularly vulnerable.

#### 4.2.2 ARP Spoofing
- Attacker sends fake ARP messages on a LAN to link their MAC address with a legitimate IP.
- Enables MITM attacks, traffic interception, and session hijacking on local networks.

#### 4.2.3 DNS Spoofing
- Attacker provides falsified DNS responses to redirect domain lookups to malicious IPs.
- Can be achieved via cache poisoning (Kaminsky Attack) or by compromising DNS resolvers.

#### 4.2.4 Email Spoofing
- Forging the `From` header in emails to impersonate trusted entities (executives, banks, vendors).
- Underpins phishing and Business Email Compromise (BEC) attacks.

#### 4.2.5 MAC Address Spoofing
- Attacker changes their NIC's MAC address to impersonate an authorized device.
- Used to bypass MAC filtering on Wi-Fi networks.

#### 4.2.6 Caller ID Spoofing
- Attacker forges the calling number displayed to the recipient (VoIP exploitation).
- Used in vishing (voice phishing) attacks impersonating banks or government agencies.

### 4.3 Impact

| Spoofing Type | Primary Impact |
|---|---|
| IP Spoofing | Enables DDoS amplification, bypasses ACLs |
| ARP Spoofing | Enables MITM on LAN, credential theft |
| DNS Spoofing | Redirects users to phishing/malware sites |
| Email Spoofing | Phishing, BEC, malware delivery |
| MAC Spoofing | Bypasses NAC controls on Wi-Fi |
| Caller ID Spoofing | Vishing, social engineering |

### 4.4 Real-World Examples

- **Twitter Bitcoin Scam (2020):** Attackers used social engineering + email spoofing to compromise Twitter employee accounts, then posted from verified accounts of Obama, Biden, and Elon Musk — netting $100,000+ in Bitcoin.
- **FACC AG BEC Attack (2016):** Austrian aerospace company lost €50 million to email spoofing — an attacker impersonated the CEO via a spoofed email instructing a finance employee to wire funds.
- **Kaminsky DNS Attack (2008):** Dan Kaminsky discovered a fundamental DNS cache poisoning flaw affecting virtually all DNS resolvers, allowing attackers to redirect any domain to a malicious IP.

### 4.5 Mitigation Strategies

1. **SPF, DKIM, DMARC:** Email authentication protocols that validate sender identity and prevent domain spoofing.
2. **Ingress/Egress Filtering (RFC 2827/BCP38):** ISPs and enterprises block packets with spoofed source IPs.
3. **DNSSEC:** Cryptographic signatures on DNS records prevent tampering.
4. **Dynamic ARP Inspection (DAI):** Validates ARP packets against a DHCP snooping binding table.
5. **802.1X Port Authentication:** Authenticate devices on the network; reject unauthorized MACs.
6. **Reverse Path Forwarding (RPF):** Routers discard packets whose source IP doesn't match the expected interface.
7. **User Awareness Training:** Educate users to verify email senders, especially for financial requests.

---

## 5. Packet Sniffing / Eavesdropping

### 5.1 Overview

**Packet sniffing** involves capturing network traffic as it passes through a network interface. While legitimate administrators use sniffers (like Wireshark) for diagnostics, attackers use them to harvest credentials, session tokens, and sensitive data from unencrypted communications.

### 5.2 How It Works

- **Promiscuous Mode:** A NIC is set to capture all packets on the segment, not just those addressed to it.
- **Hub-based Networks:** All devices receive all frames; sniffing is trivial.
- **Switch-based Networks:** Attackers use ARP spoofing to redirect traffic, or exploit switch features like port mirroring.
- **Wi-Fi Sniffing:** On open or WEP-encrypted Wi-Fi, all traffic can be captured passively.

**Tools commonly used:** Wireshark, tcpdump, ettercap, Scapy.

### 5.3 Impact

- **Credential Harvesting:** HTTP, FTP, Telnet, and SMTP transmit credentials in plaintext.
- **Session Token Theft:** Stolen cookies allow session hijacking without knowing passwords.
- **Data Leakage:** Confidential business data, PII, or IP captured in transit.
- **Reconnaissance:** Attackers map network topology, services, and protocols.

### 5.4 Real-World Examples

- **Heartbleed (2014):** While primarily a memory leak bug, the vulnerability allowed attackers to steal session keys from TLS — effectively enabling passive MITM/eavesdropping on encrypted connections.
- **NSA PRISM Program (2013):** Snowden documents revealed mass packet-level interception of internet traffic at major IXPs and backbone infrastructure by the NSA.

### 5.5 Mitigation Strategies

1. **Encryption in Transit:** TLS for web, SSH instead of Telnet, SFTP/SCP instead of FTP.
2. **Switched Network Infrastructure:** Replace hubs with managed switches; disable unused ports.
3. **VPN:** Encrypt all communications, especially on untrusted networks.
4. **Network Segmentation / VLANs:** Limit broadcast domains to reduce sniffing scope.
5. **IDS/IPS:** Detect promiscuous mode NICs and unusual packet capture behavior.
6. **WPA3 Enterprise for Wi-Fi:** Provides per-session encryption, preventing passive sniffing.

---

## 6. DNS Hijacking and Cache Poisoning

### 6.1 Overview

**DNS Hijacking** redirects DNS queries to malicious DNS servers, routing users to fraudulent websites without their knowledge. **DNS Cache Poisoning** corrupts the DNS resolver's cache with falsified records, causing all users of that resolver to be misdirected.

### 6.2 How It Works

**DNS Cache Poisoning (Kaminsky Attack):**
1. Attacker floods a DNS resolver with forged responses for a domain before the legitimate response arrives.
2. Resolver caches the malicious record; all subsequent queries are redirected.

**Router DNS Hijacking:**
1. Attacker compromises home/office routers (default credentials, firmware exploits).
2. Changes the DNS server setting to an attacker-controlled resolver.

**ISP/Rogue DNS Server:**
1. Attacker or rogue ISP runs a malicious DNS server.
2. Users configured (or redirected) to use it receive falsified resolutions.

**BGP-level Hijacking:**
1. Nation-state actors announce false BGP routes to intercept DNS query traffic.

### 6.3 Impact

- **Phishing at Scale:** Users redirected to fake banking/login sites lose credentials.
- **Malware Distribution:** Legitimate software update domains resolve to malicious servers.
- **Revenue Theft:** Ad networks or e-commerce redirected to competitor or fraud sites.
- **Surveillance:** ISP-level hijacking used to monitor browsing behavior.

### 6.4 Real-World Examples

- **Sea Turtle Campaign (2019):** APT group (likely nation-state) hijacked DNS records of government agencies, telecoms, and ISPs across 13 countries by compromising domain registrars and DNS providers.
- **DNSChanger Malware (2011):** FBI Operation Ghost Click — malware infected 4 million machines globally, changing DNS settings to attacker-controlled servers to serve fraudulent ads.
- **MyEtherWallet DNS Hijack (2018):** Attackers briefly hijacked MyEtherWallet's DNS via BGP hijacking of AWS Route 53 infrastructure, stealing ~$160,000 in cryptocurrency.

### 6.5 Mitigation Strategies

1. **DNSSEC:** Cryptographically signs DNS records; resolvers verify signatures, preventing injection.
2. **DNS over HTTPS (DoH) / DNS over TLS (DoT):** Encrypts DNS queries, preventing interception and tampering.
3. **RPKI (Resource Public Key Infrastructure):** Cryptographically validates BGP route announcements.
4. **Multi-Factor Authentication on Registrar Accounts:** Prevents unauthorized DNS record modifications.
5. **Registry Lock:** Domain registrars offer server-side locks requiring out-of-band verification for any DNS changes.
6. **Monitoring DNS Records:** Continuously monitor authoritative DNS records for unauthorized changes.
7. **Zero Trust Architecture:** Do not trust DNS resolution alone; validate endpoints via certificate and IP.

---

## 7. Comparative Summary

| Threat | CIA Triad Target | Attack Vector | Key Mitigation |
|---|---|---|---|
| DoS/DDoS | Availability | Network / Application layer | Rate limiting, DDoS scrubbing, CDN |
| MITM | Confidentiality, Integrity | Network interception | TLS/HTTPS, HSTS, VPN, Certificate Pinning |
| Spoofing | Integrity, Authenticity | Protocol abuse (IP/ARP/DNS/Email) | SPF/DKIM/DMARC, BCP38, DNSSEC |
| Packet Sniffing | Confidentiality | Passive interception | Encryption, VPN, Switched networks |
| DNS Hijacking | Integrity, Availability | DNS infrastructure | DNSSEC, DoH/DoT, Registry Lock |

---

## 8. Conclusion

Network security threats are diverse, evolving, and increasingly sophisticated. Understanding their mechanics — from the protocol-level exploitation of ARP and DNS to volumetric flooding and passive eavesdropping — is foundational for any cybersecurity professional.

Key takeaways:
- **Defence in depth** is essential; no single control is sufficient.
- **Encryption** (TLS, VPN, DNSSEC, WPA3) addresses confidentiality and integrity at multiple layers.
- **Authentication and validation** (SPF/DKIM/DMARC, RPKI, 802.1X, MFA) prevent identity-based attacks.
- **Monitoring and detection** (IDS/IPS, DNS monitoring, anomaly detection) enable rapid incident response.
- **User awareness** remains a critical last line of defence against social engineering and phishing-adjacent network attacks.

Organizations that layer these defences — applying the principle of least privilege, segmenting networks, encrypting data in transit, and continuously monitoring their environment — significantly reduce their attack surface against all threats discussed in this report.

---

## 9. References

1. CISA — Understanding Denial-of-Service Attacks: https://www.cisa.gov/uscert/ncas/tips/ST04-015
2. OWASP — Man-in-the-Middle Attack: https://owasp.org/www-community/attacks/Manipulator-in-the-middle_attack
3. RFC 2827 — Network Ingress Filtering (BCP38): https://tools.ietf.org/html/rfc2827
4. NIST SP 800-81-2 — Secure Domain Name System (DNS) Deployment Guide
5. Cloudflare Learning — DDoS Attack Types: https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/
6. SANS Institute — DNS Security: https://www.sans.org/reading-room/
7. Cisco Talos — Sea Turtle DNS Hijacking Campaign (2019)
8. FBI — Operation Ghost Click (DNSChanger): https://www.fbi.gov/news/stories/operation-ghost-click
9. GitHub Engineering Blog — February DDoS Incident Report (2018)
10. Kaminsky, D. (2008) — DNS Vulnerability Disclosure, Black Hat USA 2008

---

