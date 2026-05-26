# Social Engineering Attacks: A Comprehensive Research Report

**Author:** Maitrik  
**Task:** Task 5 — Research Report on Social Engineering Attacks  
**Date:** May 2026

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Phishing and Its Variants](#2-phishing-and-its-variants)
3. [Pretexting](#3-pretexting)
4. [Baiting](#4-baiting)
5. [Vishing (Voice Phishing)](#5-vishing-voice-phishing)
6. [Quid Pro Quo](#6-quid-pro-quo)
7. [Tailgating / Piggybacking](#7-tailgating--piggybacking)
8. [Case Studies](#8-case-studies)
9. [Psychological Principles Exploited](#9-psychological-principles-exploited)
10. [Comparative Summary](#10-comparative-summary)
11. [Prevention and Recommendations](#11-prevention-and-recommendations)
12. [Conclusion](#12-conclusion)
13. [References](#13-references)

---

## 1. Introduction

**Social engineering** is the art of manipulating people into divulging confidential information or performing actions that compromise security — without ever exploiting a technical vulnerability. It targets the weakest link in any security chain: the human.

Unlike hacking that requires technical skill, social engineering exploits fundamental human psychology — trust, fear, urgency, curiosity, and authority. According to the Verizon 2023 Data Breach Investigations Report, over **74% of all breaches involve a human element**, with social engineering being a primary vector.

This report examines six major categories of social engineering attacks, supported by real-world case studies, and concludes with comprehensive prevention recommendations.

---

## 2. Phishing and Its Variants

### 2.1 Overview

**Phishing** is a fraudulent attempt to obtain sensitive information (credentials, credit card numbers, personal data) by disguising as a trustworthy entity in electronic communication — typically email.

### 2.2 How It Works

1. Attacker crafts an email impersonating a trusted entity (bank, employer, cloud provider).
2. Email contains a malicious link leading to a spoofed website or a weaponized attachment.
3. Victim enters credentials on the fake site, or malware is installed via the attachment.
4. Attacker harvests credentials or gains remote access.

### 2.3 Variants

#### Spear Phishing
- Highly targeted phishing directed at a specific individual or organization.
- Attacker researches the target (LinkedIn, social media, company website) to craft a convincing, personalized message.
- Example: An email to a CFO appearing to come from their CEO asking to review an "urgent invoice."

#### Whaling
- Spear phishing specifically targeting high-value individuals — C-level executives (CEO, CFO, CTO).
- The stakes are higher because executives have elevated system access and authority to authorize financial transfers.

#### Smishing (SMS Phishing)
- Phishing conducted via SMS text messages.
- Example: Fake delivery notification with a link to "reschedule" — leading to a credential harvesting page.

#### Vishing (Voice Phishing)
- Covered separately in Section 5.

#### Clone Phishing
- Attacker duplicates a legitimate, previously delivered email but replaces attachments or links with malicious versions.
- The spoofed re-send appears as a "corrected" version of the original.

#### Pharming
- Attacker compromises DNS to redirect users from legitimate URLs to fraudulent sites — phishing at scale without requiring the victim to click a link.

### 2.4 Impact

- Credential theft leading to account takeover (ATO)
- Financial fraud via unauthorized wire transfers
- Corporate espionage via email account access
- Ransomware deployment via malicious attachments

### 2.5 Real-World Example

**Google and Facebook Spear Phishing (2013–2015):** Lithuanian fraudster Evaldas Rimasauskas impersonated Quanta Computer (a Taiwanese vendor used by both companies) via spear phishing emails with fraudulent invoices. Both Google and Facebook transferred a combined **$121 million** before the fraud was detected. Rimasauskas was extradited and sentenced in 2019.

---

## 3. Pretexting

### 3.1 Overview

**Pretexting** involves fabricating a convincing scenario (the "pretext") to manipulate a target into providing information or performing an action. Unlike phishing, pretexting often involves direct human interaction — phone calls, in-person visits, or chat messages — and requires the attacker to maintain a believable persona.

### 3.2 How It Works

1. Attacker researches the target and organization to build a credible backstory.
2. Attacker assumes a false identity — IT support technician, auditor, bank official, vendor, new employee.
3. Attacker engages the target, using the pretext to extract information or access.
4. Common information extracted: passwords, internal system names, employee data, building access codes.

### 3.3 Common Pretext Scenarios

| Pretext | Attacker Persona | Information Targeted |
|---|---|---|
| "IT Help Desk" | IT support staff | Password reset, VPN credentials |
| "HR Audit" | Human Resources | Employee PII, salary data |
| "Vendor/Supplier" | Trusted partner | Purchase order details, banking info |
| "New Employee" | Colleague | System access, internal procedures |
| "Bank Security" | Bank fraud officer | OTP codes, account details |

### 3.4 Impact

- Unauthorized access to internal systems
- Extraction of personally identifiable information (PII)
- Business Email Compromise (BEC) facilitation
- Physical security breaches (when combined with tailgating)

### 3.5 Real-World Example

**Hewlett-Packard Pretexting Scandal (2006):** HP's board of directors hired private investigators who used pretexting — impersonating journalists and board members — to obtain phone records from AT&T and Verizon to identify a boardroom leak. The scandal resulted in the resignation of HP's chairwoman Patricia Dunn, congressional hearings, and California enacting stricter anti-pretexting laws.

---

## 4. Baiting

### 4.1 Overview

**Baiting** exploits human curiosity or greed by leaving a physical or digital lure for the victim to discover. When the victim interacts with the bait, their system is compromised or their credentials are harvested.

### 4.2 How It Works

**Physical Baiting (USB Drop Attack):**
1. Attacker leaves infected USB drives in locations frequented by targets — parking lots, lobbies, conference rooms.
2. Label on drive may read "Salary Information Q3" or "Confidential."
3. Curious employee plugs in the drive; malware executes automatically (via AutoRun) or the employee opens a malicious file.

**Digital Baiting:**
1. Attacker offers free software, music, movies, or games via torrents or shady websites.
2. Downloads contain bundled malware — ransomware, keyloggers, remote access trojans (RATs).
3. Attacker gains persistent access to victim's machine.

### 4.3 Impact

- Malware infection (ransomware, spyware, keyloggers)
- Remote access trojan (RAT) installation giving attacker persistent foothold
- Data exfiltration from connected enterprise networks
- Lateral movement within organizational infrastructure

### 4.4 Real-World Example

**US Department of Defense USB Baiting Experiment (2016):** Researchers scattered 297 USB drives around the University of Illinois campus. **98% of dropped drives were picked up**, and **45% of those were plugged into computers** — with users clicking on files within minutes of insertion. This confirmed that USB baiting remains a highly effective attack vector even among technically aware populations.

**Stuxnet (2010):** While nation-state-attributed, Stuxnet was delivered into an air-gapped Iranian nuclear facility via infected USB drives — a real-world, high-stakes baiting attack that caused physical damage to centrifuges.

---

## 5. Vishing (Voice Phishing)

### 5.1 Overview

**Vishing** uses phone calls — increasingly aided by VoIP spoofing and AI-generated voice cloning — to impersonate trusted entities and extract sensitive information or authorize fraudulent actions.

### 5.2 How It Works

1. Attacker spoofs caller ID to display as a bank, government agency, or employer.
2. Uses urgency and authority: "Your account has been compromised — we need to verify your identity immediately."
3. Tricks victim into providing OTPs, PINs, account numbers, or authorization for fund transfers.
4. In corporate contexts, may impersonate IT support to extract VPN credentials or reset passwords.

### 5.3 AI-Powered Vishing (Voice Cloning)

Emerging threat: attackers use AI voice synthesis tools to clone a target's trusted contact (CEO, family member) from publicly available audio (social media, YouTube) and call employees or relatives requesting urgent action.

### 5.4 Real-World Example

**UK Energy Firm CEO Voice Clone (2019):** The CEO of a UK energy company received a call from what he believed was his German parent company's CEO — the voice was cloned using AI. He was instructed to wire €220,000 to a Hungarian supplier "urgently." The funds were transferred and subsequently moved to Mexico. This is the first publicly confirmed AI voice cloning fraud case.

**Twitter 2020 Hack (Vishing Component):** Attackers used vishing to call Twitter employees, impersonating Twitter's own IT department. They convinced employees to provide VPN credentials, enabling access to internal admin tools used to hijack verified accounts of Biden, Obama, Musk, and others.

---

## 6. Quid Pro Quo

### 6.1 Overview

A **quid pro quo** attack involves an attacker offering a service or benefit in exchange for information. Unlike baiting (passive lure), this is an active exchange — the attacker provides something the victim wants.

### 6.2 How It Works

1. Attacker calls or contacts random employees claiming to be IT support.
2. Offers to fix a "problem" the victim didn't know they had — or resolves a real nuisance.
3. In exchange, asks the victim to install software (RAT), provide their password temporarily, or disable antivirus.
4. Victim perceives this as a fair, helpful trade.

### 6.3 Real-World Example

**IT Support Survey (Carnegie Mellon, 2003):** In an early study, security researchers found that **90% of office workers gave away their computer password** in exchange for a cheap pen — when the interviewer framed it as a prize for a "security survey." While dated, this principle remains relevant in modern quid pro quo attacks.

---

## 7. Tailgating / Piggybacking

### 7.1 Overview

**Tailgating** (also called piggybacking) is a physical social engineering attack where an unauthorized person gains access to a restricted area by following an authorized person through a secured entry point.

### 7.2 How It Works

1. Attacker waits near a secured door carrying boxes, coffee trays, or looking distracted.
2. Authorized employee badges in; attacker follows closely before the door closes.
3. Social norms (politeness, holding doors) make it difficult for employees to challenge or deny entry.
4. Once inside, attacker may plant keyloggers, steal equipment, access unlocked workstations, or deploy network implants.

### 7.3 Impact

- Unauthorized physical access to server rooms, data centers, or executive offices
- Hardware-based attacks (USB implants, keyloggers on physical machines)
- Theft of physical assets — laptops, hard drives, badge readers
- Bypasses all logical/network security controls

### 7.4 Real-World Example

**Coalfire Physical Penetration Test (2019):** Two professional penetration testers hired by the state of Iowa were arrested after successfully tailgating into a courthouse. While a legitimate engagement, it demonstrated how easily tailgating bypasses even security-conscious environments, and highlighted the importance of written authorizations for physical pen testers.

---

## 8. Case Studies

### 8.1 RSA SecurID Breach (2011)

**Attack Type:** Spear phishing + targeted exploitation  
**Target:** RSA Security (EMC subsidiary)  
**What Happened:** Employees received a spear phishing email with the subject line "2011 Recruitment Plan." The attached Excel file exploited an Adobe Flash zero-day. The resulting access allowed attackers to exfiltrate data related to RSA's SecurID two-factor authentication tokens — compromising the security of millions of SecurID users globally, including US defence contractors.  
**Impact:** RSA spent over $66 million on remediation; Lockheed Martin (a SecurID customer) was subsequently targeted.  
**Lesson:** Even security companies are vulnerable; spear phishing + zero-day is a potent combination.

---

### 8.2 The Sony Pictures Hack (2014)

**Attack Type:** Spear phishing + credential harvesting  
**Target:** Sony Pictures Entertainment  
**What Happened:** Attackers (attributed to North Korea's Lazarus Group) sent highly targeted spear phishing emails to Sony employees. Once credentials were harvested, attackers spent months inside the network, exfiltrating 100 terabytes of data including unreleased films, executive emails, employee SSNs, and salary information.  
**Impact:** Estimated $100 million+ in damages; five unreleased films leaked; significant reputational damage and employee PII exposure.  
**Lesson:** Extended dwell time (months undetected) amplifies damage; network segmentation and anomaly detection are critical.

---

### 8.3 Ubiquiti Networks BEC Attack (2015)

**Attack Type:** Business Email Compromise (BEC) via impersonation  
**Target:** Ubiquiti Networks (networking hardware company)  
**What Happened:** Attackers impersonated Ubiquiti executives and outside legal counsel via spoofed email addresses. Finance employees were convinced to execute a series of wire transfers totalling **$46.7 million** to attacker-controlled accounts.  
**Impact:** $46.7 million lost; $8.1 million partially recovered. Ubiquiti disclosed the incident to the SEC.  
**Lesson:** Financial transfer requests via email must require out-of-band verbal verification, regardless of apparent seniority of requester.

---

### 8.4 MGM Resorts Ransomware (2023)

**Attack Type:** Vishing + Social Engineering → Ransomware  
**Target:** MGM Resorts International  
**What Happened:** The ALPHV/BlackCat ransomware group (via their affiliate Scattered Spider) used vishing to impersonate an MGM employee to the IT help desk — information sourced from a 10-minute LinkedIn search. The IT help desk reset credentials, giving attackers access. This led to a full Okta SSO compromise and ransomware deployment across MGM's infrastructure.  
**Impact:** Estimated $100 million+ in losses; hotel operations, slot machines, and digital key systems went offline across Las Vegas properties for days.  
**Lesson:** Help desk identity verification procedures are critical; social engineering can bypass even enterprise SSO.

---

## 9. Psychological Principles Exploited

Social engineering attacks succeed because they exploit universal, well-documented cognitive biases and social norms identified by Robert Cialdini in *Influence: The Psychology of Persuasion*:

| Principle | How Attackers Exploit It | Example |
|---|---|---|
| **Authority** | Impersonating executives, IT, law enforcement, regulators | "This is your CEO — wire the funds immediately" |
| **Urgency / Scarcity** | Creating artificial time pressure to prevent rational thinking | "Your account will be locked in 30 minutes" |
| **Social Proof** | Implying others have complied | "All other departments have already submitted their credentials" |
| **Liking / Rapport** | Building a friendly connection before making the request | Attacker chats warmly before asking for password |
| **Reciprocity** | Offering help first to create obligation | "I fixed your VPN issue — can you just give me your old password?" |
| **Commitment** | Getting small commitments that escalate | Start with confirming name/employee ID, then request sensitive data |
| **Fear** | Threatening negative consequences for inaction | "Failure to verify will result in account suspension" |

Understanding these triggers helps security teams craft more effective awareness training.

---

## 10. Comparative Summary

| Attack Type | Medium | Primary Exploit | Key Indicator | Detection Difficulty |
|---|---|---|---|---|
| Phishing | Email | Fake links/attachments | Suspicious sender domain, urgency | Medium |
| Spear Phishing | Email | Personalized targeting | Unexpected request, unusual sender | High |
| Pretexting | Phone/In-person | False identity | Unsolicited contact, unusual requests | High |
| Baiting | Physical/Digital | Curiosity/Greed | Unattended USB, free software | Low–Medium |
| Vishing | Phone/VoIP | Authority, urgency | Caller ID spoofing, OTP requests | Medium |
| Quid Pro Quo | Phone | Reciprocity | Unsolicited IT "help" | Medium |
| Tailgating | Physical | Politeness norms | Unauthorized badge swipes | Low |

---

## 11. Prevention and Recommendations

### 11.1 Technical Controls

1. **Email Security Gateway:** Deploy SPF, DKIM, DMARC to block spoofed emails; use anti-phishing filters (Proofpoint, Mimecast, Microsoft Defender for Office 365).
2. **Multi-Factor Authentication (MFA):** Enforce MFA on all systems — even compromised credentials become useless without the second factor.
3. **Zero Trust Architecture:** Never trust, always verify — authenticate every access request regardless of source.
4. **DNS Filtering:** Block known phishing/malware domains at the DNS layer (Cisco Umbrella, Cloudflare Gateway).
5. **Endpoint Detection & Response (EDR):** Detect and respond to malware installed via baiting or phishing attachments.
6. **USB Port Control:** Disable AutoRun; use endpoint management to block unauthorized USB devices.
7. **Privileged Access Management (PAM):** Limit who can authorize wire transfers or reset credentials; require multi-party approval.

### 11.2 Procedural Controls

1. **Out-of-Band Verification:** Any financial transfer or credential reset requested via email must be verbally confirmed via a known, pre-established phone number — not a number provided in the email.
2. **Help Desk Identity Verification:** Require employees to provide verifiable information (employee ID, manager name, HR-registered callback number) before any account action.
3. **Visitor Management:** Issue visitor badges, require escorts, and log all physical access to sensitive areas.
4. **Clean Desk Policy:** Sensitive documents, passwords, and access tokens should never be visible on desks.
5. **Incident Reporting Culture:** Encourage employees to report suspicious contacts without fear of reprisal for "falling for it."

### 11.3 Human Controls (Security Awareness)

1. **Regular Security Awareness Training:** Conduct at minimum annual training on recognizing phishing, pretexting, and social engineering tactics.
2. **Simulated Phishing Campaigns:** Use platforms like KnowBe4, Proofpoint Security Awareness, or GoPhish to run realistic phishing simulations and measure click rates over time.
3. **Role-Based Training:** Finance staff need BEC training; IT help desk needs identity verification procedures; executives need whaling awareness.
4. **Visual Cues Education:** Train users to hover over links before clicking, verify sender domains carefully (e.g., `paypa1.com` vs `paypal.com`), and recognize urgency as a red flag.
5. **Social Media Hygiene:** Advise employees to limit the personal/professional information they share publicly — attackers mine LinkedIn, Twitter, and Facebook for pretexting research.

### 11.4 Organizational Controls

1. **Security Culture from the Top:** Leadership must champion security — if executives bypass controls, employees will too.
2. **Segregation of Duties:** No single person should be able to authorize and execute large financial transactions.
3. **Regular Penetration Testing:** Include social engineering (phishing simulations, physical pen tests) in annual security assessments.
4. **Incident Response Plan:** Have a documented, tested plan for suspected social engineering incidents, including who to call and how to contain damage.

---

## 12. Conclusion

Social engineering remains one of the most effective and underestimated attack vectors in cybersecurity. Technical defences — firewalls, IDS, encryption — offer little protection when an attacker can simply call an employee and ask for their password.

The attacks covered in this report — phishing, pretexting, baiting, vishing, quid pro quo, and tailgating — share a common thread: they exploit human psychology rather than software vulnerabilities. The MGM breach (2023), Google/Facebook fraud ($121M), and Sony Pictures hack all demonstrate that even large, security-conscious organizations fall victim when humans are targeted.

Effective defence requires a layered approach combining:
- **Technical controls** to reduce the attack surface
- **Procedural controls** to enforce verification and authorization
- **Human controls** — ongoing training, simulation, and a culture of security awareness

An organization's security posture is ultimately only as strong as its least-informed employee's response to a social engineering attempt.

---

## 13. References

1. Verizon — 2023 Data Breach Investigations Report (DBIR): https://www.verizon.com/business/resources/reports/dbir/
2. Cialdini, R. (1984). *Influence: The Psychology of Persuasion.* Harper Business.
3. CISA — Phishing Guidance: https://www.cisa.gov/phishing
4. FBI IC3 — Business Email Compromise: https://www.ic3.gov/Media/Y2023/PSA230609
5. KrebsOnSecurity — MGM Resorts Vishing Hack (2023): https://krebsonsecurity.com
6. DOJ — Evaldas Rimasauskas Conviction (Google/Facebook Phishing): https://www.justice.gov
7. RSA Security — RSA SecurID Breach Disclosure Letter (2011)
8. SANS Institute — Social Engineering Fundamentals: https://www.sans.org/reading-room/
9. Hadnagy, C. (2010). *Social Engineering: The Art of Human Hacking.* Wiley.
10. NIST SP 800-50 — Building an Information Technology Security Awareness and Training Program

---


