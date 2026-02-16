## 📘 Passive Reconnaissance For Web-Application
#### Bug Bounty Recon - Class 1: Foundation Layer

## Module 1: Introduction to Passive Recon
### 1.1 What is Passive Reconnaissance?

```bash
┌─────────────────────────────────────────────────────────────────┐
│                    RECONNAISSANCE TYPES                         │
├─────────────────────────────┬───────────────────────────────────┤
│      PASSIVE RECON          │         ACTIVE RECON              │
├─────────────────────────────┼───────────────────────────────────┤
│ • No direct contact         │ • Direct interaction              │
│ • Uses third-party sources  │ • Scanning target systems         │
│ • Undetectable              │ • Can be detected/logged          │
│ • Legal (mostly)            │ • Needs authorization             │
│ • OSINT-based               │ • Technical probing               │
└─────────────────────────────┴───────────────────────────────────┘
```

📊 Visual Diagram: Passive vs Active
```bash

                    ┌──────────────┐
                    │   ATTACKER   │
                    └──────┬───────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               │               ▼
    ┌─────────────┐        │        ┌─────────────┐
    │   PASSIVE   │        │        │   ACTIVE    │
    │             │        │        │             │
    │ Third-party │        │        │   Direct    │
    │  databases  │        │        │  scanning   │
    └──────┬──────┘        │        └──────┬──────┘
           │               │               │
           ▼               │               ▼
    ┌─────────────┐        │        ┌─────────────┐
    │  • crt.sh   │        │        │  • nmap     │
    │  • Shodan   │        │        │  • ffuf     │
    │  • Wayback  │        │        │  • nikto    │
    │  • GitHub   │        │        │  • burp     │
    └─────────────┘        │        └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │   TARGET    │
                    │  (No logs)  │◄── Passive = Invisible
                    └─────────────┘

```
## 1.2 Why Passive Recon First?
### 🎯 The Bug Bounty Recon Funnel
```bash

    ┌─────────────────────────────────────────────┐
    │         PASSIVE RECONNAISSANCE              │  ← YOU ARE HERE
    │   (Collect everything, touch nothing)       │
    │         ~5000 subdomains found              │
    └────────────────────┬────────────────────────┘
                         │
                         ▼
    ┌─────────────────────────────────────────────┐
    │         ACTIVE RECONNAISSANCE               │
    │   (Verify, expand, crawl)                   │
    │         ~500 live hosts confirmed           │
    └────────────────────┬────────────────────────┘
                         │
                         ▼
    ┌─────────────────────────────────────────────┐
    │         DEEP DIVE ANALYSIS                  │
    │   (Find vulnerabilities)                    │
    │         ~50 high-value targets              │
    └────────────────────┬────────────────────────┘
                         │
                         ▼
                    💰 BOUNTY 💰
```
## 1.3 Passive Recon Mindset
### Key Principles:
Principle -> Description\
Patience  -> Quality recon takes time\
Documentation -> Record EVERYTHING you find\
Correlation	-> Connect dots between findings\
Creativity	-> Think like the target's developer\
Persistence	-> Check multiple sources

## Module 2: Subdomain Enumeration (Passive)
### 2.1 Why Subdomains Matter
```bash

                          example.com
                               │
        ┌──────────┬──────────┬┴──────────┬──────────┐
        │          │          │           │          │
        ▼          ▼          ▼           ▼          ▼
    ┌───────┐ ┌────────┐ ┌────────┐ ┌─────────┐ ┌────────┐
    │  www  │ │  api   │ │ admin  │ │ staging │ │  dev   │
    │       │ │        │ │        │ │         │ │        │
    │Secure │ │ Maybe  │ │ GOLD!  │ │ Weak    │ │ GOLD!  │
    │       │ │ bugs   │ │        │ │ security│ │        │
    └───────┘ └────────┘ └────────┘ └─────────┘ └────────┘
        │          │          │           │          │
        ▼          ▼          ▼           ▼          ▼
      Low        Med        HIGH        HIGH       HIGH
     Value      Value      VALUE       VALUE      VALUE
```
## 🎯 High-Value Subdomain Patterns:

```bash
GOLD MINE SUBDOMAINS:
├── dev.target.com          → Development (weak security)
├── staging.target.com      → Staging (test data)
├── admin.target.com        → Admin panels
├── api.target.com          → API endpoints
├── internal.target.com     → Internal tools
├── jenkins.target.com      → CI/CD (often exposed)
├── jira.target.com         → Project management
├── git.target.com          → Source code
├── vpn.target.com          → VPN portals
├── test.target.com         → Test environments
├── uat.target.com          → User acceptance testing
├── beta.target.com         → Beta features
└── old.target.com          → Legacy systems
```
## 2.2 Certificate Transparency (CT) Logs
### What is Certificate Transparency?
```bash
┌─────────────────────────────────────────────────────────────────┐
│                  CERTIFICATE TRANSPARENCY                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   When a company gets an SSL certificate, it gets logged        │
│   in PUBLIC CT logs. We can search these logs!                  │
│                                                                 │
│   Company requests SSL     CT Log stores it      We search it   │
│   for dev.target.com  ───► publicly          ───► and find it!  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 📸 Tool #1: crt.sh
`Website: https://crt.sh`

```bash

┌─────────────────────────────────────────────────────────────────┐
│  🔍 crt.sh - Certificate Search                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Search: %.example.com                                          │
│  [Search Button]                                                │
│                                                                 │
│  Results:                                                       │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │ Logged At    │ Issuer      │ Common Name                   │ │
│  ├──────────────┼─────────────┼───────────────────────────────┤ │
│  │ 2024-01-15   │ Let's Enc   │ api.example.com               │ │
│  │ 2024-01-14   │ DigiCert    │ admin.example.com             │ │
│  │ 2024-01-10   │ Let's Enc   │ staging.example.com           │ │
│  │ 2024-01-08   │ Comodo      │ dev.example.com               │ │
│  │ 2023-12-20   │ Let's Enc   │ internal.example.com          │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 💻 Command Line Method:
```Bash

# Basic crt.sh query
curl -s "https://crt.sh/?q=%.example.com&output=json" | \
  jq -r '.[].name_value' | \
  sort -u > subdomains_crt.txt

# View results
cat subdomains_crt.txt
```
## 📝 Lab Exercise 1: crt.sh Practice
```bash

┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 1                                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: tesla.com (they have a bug bounty program)             │
│                                                                 │
│  Task 1: Go to crt.sh and search for %.tesla.com                │
│  Task 2: Count how many unique subdomains you find              │
│  Task 3: Identify any "interesting" subdomains                  │
│  Task 4: Export results using the curl command                  │
│                                                                 │
│  Time: 10 minutes                                               │
│                                                                 |
│  Expected Output: 100+ subdomains                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 2.3 DNS Aggregators
### 📸 Tool #2: Subfinder
`Installation:`

```Bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
```
**Architecture:**

```bash

                         ┌─────────────┐
                         │  SUBFINDER  │
                         └──────┬──────┘
                                │
        ┌───────────┬───────────┼───────────┬───────────┐
        │           │           │           │           │
        ▼           ▼           ▼           ▼           ▼
   ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
   │ Censys  │ │ Shodan  │ │VirusT.  │ │ Chaos   │ │ GitHub  │
   └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘
        │           │           │           │           │
        └───────────┴───────────┴───────────┴───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │   MERGED RESULTS      │
                    │   (deduplicated)      │
                    └───────────────────────┘
```
**💻 Commands:**
```Bash

# Basic usage
subfinder -d example.com -o subdomains.txt

# With all sources (requires API keys)
subfinder -d example.com -all -o subdomains.txt

# Silent mode (clean output)
subfinder -d example.com -silent

# Multiple domains
subfinder -dL domains.txt -o all_subdomains.txt

# Show source of each subdomain
subfinder -d example.com -sources
```

## 📝 Subfinder Configuration (API Keys)

```bash
# ~/.config/subfinder/provider-config.yaml

securitytrails:[]

shodan:[]

censys:[]

virustotal:[]

chaos:[]

github:[]
```
## 🔑 Where to Get API Keys:
```bash
Source	              URL	                               Free Tier
SecurityTrails	https://securitytrails.com/app/signup	 50 queries/month
Shodan       	https://shodan.io/register	             Limited
Censys	        https://censys.io/register	             250 queries/month
VirusTotal	    https://virustotal.com/gui/join-us	     500 requests/day
Chaos	        https://chaos.projectdiscovery.io	     Free (ProjectDiscovery)
GitHub	        Personal Access Token	                 Unlimited
```
### 2.4 Tool #3: Assetfinder
```Bash

# Installation
go install github.com/tomnomnom/assetfinder@latest

# Usage
assetfinder --subs-only example.com > assetfinder_subs.txt
```
## 📊 Comparison: Subfinder vs Assetfinder
```bash

┌─────────────────────────────────────────────────────────────────┐
│              SUBFINDER vs ASSETFINDER                           │
├──────────────────────────┬──────────────────────────────────────┤
│        SUBFINDER         │           ASSETFINDER                │
├──────────────────────────┼──────────────────────────────────────┤
│ • More data sources      │ • Faster                             │
│ • API key support        │ • No configuration needed            │
│ • More accurate          │ • Lightweight                        │
│ • Actively maintained    │ • Good for quick scans               │
│ • Slower (more sources)  │ • Less comprehensive                 │
├──────────────────────────┴──────────────────────────────────────┤
│                                                                 │
│  💡 RECOMMENDATION: Use BOTH and merge results!                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 2.5 Tool #4: Amass (Passive Mode)
```Bash

# Installation
go install -v github.com/owasp-amass/amass/v5/cmd/amass@main

# Passive enumeration only
amass enum -passive -d example.com -o amass_subs.txt

# With config file
amass enum -passive -d example.com -config config.ini
```
## Amass Data Sources Visualization:
```bash

                              AMASS
                                │
    ┌───────────────────────────┼───────────────────────────┐
    │                           │                           │
    ▼                           ▼                           ▼
┌────────────┐           ┌────────────┐           ┌────────────┐
│    APIs    │           │   Scraping │           │   Archives │
├────────────┤           ├────────────┤           ├────────────┤
│ • Shodan   │           │ • Ask      │           │ • Wayback  │
│ • Censys   │           │ • Baidu    │           │ • CommonC  │
│ • VirusT   │           │ • Bing     │           │ • UKWebArc │
│ • SecTrail │           │ • Yahoo    │           │            │
│ • PassiveT │           │ • DNSDump  │           │            │
└────────────┘           └────────────┘           └────────────┘
```
## 2.6 Combining All Tools (Best Practice)
🔧 The Ultimate Passive Subdomain Script:
```Bash

#!/bin/bash
# passive_subdomains.sh

DOMAIN=$1
OUTPUT_DIR="./recon/$DOMAIN/passive"

# Create directory structure
mkdir -p $OUTPUT_DIR

echo "[*] Starting passive subdomain enumeration for $DOMAIN"

# 1. crt.sh
echo "[+] Querying crt.sh..."
curl -s "https://crt.sh/?q=%.$DOMAIN&output=json" | \
  jq -r '.[].name_value' 2>/dev/null | \
  sed 's/\*\.//g' | \
  sort -u > $OUTPUT_DIR/crt_sh.txt
echo "    Found: $(wc -l < $OUTPUT_DIR/crt_sh.txt) subdomains"

# 2. Subfinder
echo "[+] Running Subfinder..."
subfinder -d $DOMAIN -silent -o $OUTPUT_DIR/subfinder.txt 2>/dev/null
echo "    Found: $(wc -l < $OUTPUT_DIR/subfinder.txt) subdomains"

# 3. Assetfinder
echo "[+] Running Assetfinder..."
assetfinder --subs-only $DOMAIN > $OUTPUT_DIR/assetfinder.txt 2>/dev/null
echo "    Found: $(wc -l < $OUTPUT_DIR/assetfinder.txt) subdomains"

# 4. Amass Passive
echo "[+] Running Amass (passive)..."
amass enum -passive -d $DOMAIN -o $OUTPUT_DIR/amass.txt 2>/dev/null
echo "    Found: $(wc -l < $OUTPUT_DIR/amass.txt) subdomains"

# 5. Merge and deduplicate
echo "[+] Merging results..."
cat $OUTPUT_DIR/*.txt | sort -u > $OUTPUT_DIR/all_subdomains.txt

TOTAL=$(wc -l < $OUTPUT_DIR/all_subdomains.txt)
echo ""
echo "======================================"
echo "[✓] TOTAL UNIQUE SUBDOMAINS: $TOTAL"
echo "======================================"
echo "[*] Results saved to: $OUTPUT_DIR/all_subdomains.txt"
```
## 💻 Usage:
```Bash

chmod +x passive_subdomains.sh
./passive_subdomains.sh tesla.com
```

## 📝 Lab Exercise 2: Subdomain Enumeration
```bash

┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 2: Complete Subdomain Enumeration              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: Choose a bug bounty program from:                      │
│          • hackerone.com/programs                               │
│          • bugcrowd.com/programs                                │
│                                                                 │
│  Tasks:                                                         │
│  1. Run crt.sh query manually                                   │
│  2. Run subfinder                                               │
│  3. Run assetfinder                                             │
│  4. Merge all results                                           │
│  5. Count unique subdomains                                     │
│  6. Identify 5 "interesting" subdomains and explain why         │
│                                                                 │
│  Time: 20 minutes                                               │
│                                                                 │
│  Deliverable: subdomains.txt + analysis report                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
# Module 3: Search Engine Dorking
## 3.1 Google Dorking Fundamentals
### 🔍 Basic Google Operators:
```bash
┌─────────────────────────────────────────────────────────────────┐
│                   GOOGLE DORK OPERATORS                         │
├─────────────────┬───────────────────────────────────────────────┤
│    Operator     │                 Description                   │
├─────────────────┼───────────────────────────────────────────────┤
│ site:           │ Restrict results to specific domain           │
│ inurl:          │ Search for keyword in URL                     │
│ intitle:        │ Search for keyword in page title              │
│ intext:         │ Search for keyword in page content            │
│ filetype:       │ Search for specific file types                │
│ ext:            │ Same as filetype                              │
│ cache:          │ View Google's cached version                  │
│ -keyword        │ Exclude keyword from results                  │
│ "exact phrase"  │ Search for exact phrase                       │
│ *               │ Wildcard                                      │
│ OR              │ Boolean OR                                    │
│ |               │ Same as OR                                    │
└─────────────────┴───────────────────────────────────────────────┘
```

## 3.2 Bug Bounty Google Dorks
### 🎯 Subdomain Discovery Dorks:

```bash
# Find subdomains indexed by Google
site:*.example.com -www

# Find specific subdomain patterns
site:*.dev.example.com
site:*.staging.example.com
site:*.api.example.com
site:*.admin.example.com
# Sensitive Information Dorks:


# Database files
site:example.com ext:sql | ext:db | ext:mdb | ext:sqlite

# Log files
site:example.com ext:log

# Backup files
site:example.com ext:bak | ext:backup | ext:old | ext:temp

# Password file
site:example.com inurl:password | inurl:passwd | inurl:pass

# Exposed documents
site:example.com ext:pdf | ext:doc | ext:docx | ext:xls | ext:xlsx

# PHP errors exposing info
site:example.com "php error" | "warning" | "fatal error"

# Login & Admin Panel Dorks

# Admin panel
site:example.com inurl:admin
site:example.com inurl:login
site:example.com inurl:portal
site:example.com intitle:"admin" | intitle:"login" | intitle:"dashboard"


# Specific technologies
site:example.com inurl:wp-admin          # WordPress
site:example.com inurl:administrator     # Joomla
site:example.com inurl:admin/login.php   # Custom PHP
site:example.com inurl:phpmyadmin        # Database admin
```
# 📊 Visual: Google Dorking Process
```bash

┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE DORKING WORKFLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Step 1: Basic Site Search                                     │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │ site:example.com                                        │   │
│   └─────────────────────────────────────────────────────────┘   │
│                           │                                     │
│                           ▼                                     │
│   Step 2: Find Subdomains                                       │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │ site:*.example.com -www                                 │   │
│   └─────────────────────────────────────────────────────────┘   │
│                           │                                     │
│                           ▼                                     │
│   Step 3: Find Sensitive Files                                  │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │ site:example.com ext:pdf | ext:doc | ext:xls            │   │
│   └─────────────────────────────────────────────────────────┘   │
│                           │                                     │
│                           ▼                                     │
│   Step 4: Find Login Panels                                     │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │ site:example.com inurl:admin | inurl:login              │   │
│   └─────────────────────────────────────────────────────────┘   │
│                           │                                     │
│                           ▼                                     │
│   Step 5: Find Exposed Errors                                   │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │ site:example.com "error" | "warning" | "exception"      │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 3.3 Google Dork Cheat Sheet for Bug Bounty
```bash

┌─────────────────────────────────────────────────────────────────┐
│              🎯 BUG BOUNTY GOOGLE DORK CHEATSHEET               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ SUBDOMAINS:                                                     │
│ site:*.target.com                                               │
│ site:*.*.target.com                                             │
│                                                                 │
│ SENSITIVE DIRECTORIES:                                          │
│ site:target.com inurl:backup                                    │
│ site:target.com inurl:admin                                     │
│ site:target.com inurl:config                                    │
│ site:target.com inurl:staging                                   │
│ site:target.com inurl:dev                                       │
│ site:target.com inurl:test                                      │
│ site:target.com inurl:old                                       │
│                                                                 │
│ FILE TYPES:                                                     │
│ site:target.com ext:log                                         │
│ site:target.com ext:sql                                         │
│ site:target.com ext:env                                         │
│ site:target.com ext:bak                                         │
│ site:target.com ext:conf                                        │
│ site:target.com ext:yaml | ext:yml                              │
│ site:target.com ext:json                                        │
│                                                                 │
│ EXPOSED DATA:                                                   │
│ site:target.com "api_key" | "apikey"                            │
│ site:target.com "password" | "passwd" | "pwd"                   │
│ site:target.com "secret" | "token"                              │
│ site:target.com "BEGIN RSA PRIVATE KEY"                         │
│                                                                 │
│ ERRORS & DEBUG:                                                 │
│ site:target.com "error" | "exception" | "warning"               │
│ site:target.com "stack trace"                                   │
│ site:target.com "debug" | "debugging"                           │
│                                                                 │
│ TECHNOLOGY SPECIFIC:                                            │
│ site:target.com inurl:wp-content (WordPress)                    │
│ site:target.com inurl:Servlet (Java)                            │
│ site:target.com inurl:.php?id= (SQL injection candidates)       │
│ site:target.com inurl:api/v1 | inurl:api/v2                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 3.4 GitHub Dorking
Why GitHub Dorking?
```bash

┌─────────────────────────────────────────────────────────────────┐
│                WHY DEVELOPERS LEAK SECRETS                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│    Developer writes code                                        │
│            │                                                    │
│            ▼                                                    │
│    Hardcodes API key for "testing"                              │
│            │                                                    │
│            ▼                                                    │
│    Forgets to remove before commit                              │
│            │                                                    │
│            ▼                                                    │
│    Pushes to GitHub                                             │
│            │                                                    │
│            ▼                                                    │
│    ┌─────────────────────────────────────────┐                  │
│    │  🎉 API KEY IS NOW PUBLIC FOREVER  🎉   │                  │
│    │  (Even if deleted, it's in history)     │                  │
│    └─────────────────────────────────────────┘                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 🔍 GitHub Search Operators:
```Bash

# Search in specific organization
org:target-company password

# Search in user's repositories  
user:username api_key

# Search in specific repository
repo:owner/repo secret

# Search in specific file
filename:config.php password

# Search in specific path
path:config/ password

# Search by extension
extension:py api_key

# Search in specific language
language:python api_key
```
## 🎯 GitHub Dork Examples:
```Bash

# API Keys
org:company "api_key" OR "apikey" OR "api-key"
org:company "AWS_ACCESS_KEY"
org:company "AKIA"                    # AWS Access Key pattern

# Passwords
org:company "password" filename:config
org:company "passwd" extension:py
org:company "DB_PASSWORD"

# Private Keys
org:company "BEGIN RSA PRIVATE KEY"
org:company "BEGIN OPENSSH PRIVATE KEY"

# Tokens
org:company "access_token"
org:company "auth_token"
org:company "bearer"

# Database Credentials
org:company "mongodb://" password
org:company "mysql://" password
org:company "postgresql://"

# Internal URLs
org:company "internal." OR "staging." OR "dev."

# Configuration Files
org:company filename:.env
org:company filename:config.json
org:company filename:secrets.yml
org:company filename:credentials
```
## 📊 Visual: GitHub Dorking Workflow
```bash

┌─────────────────────────────────────────────────────────────────┐
│                    GITHUB DORKING WORKFLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   1. Find Organization                                          │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │ • Search company name on GitHub                          │  │
│   │ • Check company website for GitHub links                 │  │
│   │ • LinkedIn → Employee profiles → GitHub links            │  │
│   └──────────────────────────────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│   2. Search for Secrets                                         │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │ org:company password                                     │  │
│   │ org:company api_key                                      │  │
│   │ org:company secret                                       │  │
│   │ org:company token                                        │  │
│   └──────────────────────────────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│   3. Search for Config Files                                    │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │ org:company filename:.env                                │  │
│   │ org:company filename:config                              │  │
│   │ org:company filename:settings                            │  │
│   └──────────────────────────────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│   4. Search in Code                                             │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │ Check commit history for removed secrets                 │  │
│   │ Look at all branches, not just main                      │  │
│   │ Check .git/config for internal URLs                      │  │
│   └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 3.5 Automated GitHub Secret Scanning
**Tool: truffleHog**
```Bash

# Installation
pip install trufflehog

# Scan entire organization
trufflehog github --org=target-company

# Scan specific repository
trufflehog github --repo=https://github.com/company/repo

# Scan with JSON output
trufflehog github --org=target-company --json > secrets.json
Tool: GitDorker
Bash

# Installation
git clone https://github.com/obheda12/GitDorker.git
cd GitDorker
pip install -r requirements.txt

# Usage
python3 GitDorker.py -tf GITHUB_TOKEN -q "target.com" -d dorks/alldorksv3

# With organization
python3 GitDorker.py -tf GITHUB_TOKEN -q "org:target-company" -d dorks/alldorksv3
```
## 📝 Lab Exercise 3: Google & GitHub Dorking
```bash

┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 3: Search Engine Dorking                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: A bug bounty program of your choice                    │
│                                                                 │
│  Part A: Google Dorking (15 minutes)                            │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │ 1. Find all subdomains using site:*.target.com             │ │
│  │ 2. Search for exposed configuration files                  │ │
│  │ 3. Search for login/admin panels                           │ │
│  │ 4. Search for PDF/DOC files (might contain info)           │ │
│  │ 5. Document all interesting findings                       │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                 │
│  Part B: GitHub Dorking (15 minutes)                            │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │ 1. Find the company's GitHub organization                  │ │
│  │ 2. Search for hardcoded passwords/keys                     │ │
│  │ 3. Search for .env files                                   │ │
│  │ 4. Look for internal URLs/staging environments             │ │
│  │ 5. Document all interesting findings                       │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                 │
│  Deliverable: dorking_results.txt with categorized findings     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## Module 4: ASN & IP Range Discovery
**4.1 What is ASN?**
```bash

┌─────────────────────────────────────────────────────────────────┐
│              AUTONOMOUS SYSTEM NUMBER (ASN)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ASN = A unique identifier assigned to a collection of IP      │
│         ranges owned by an organization                         │
│                                                                 │
│   Example:                                                      │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  Tesla, Inc.                                            │   │
│   │  ASN: AS394161                                          │   │
│   │                                                         │   │
│   │  IP Ranges:                                             │   │
│   │  • 8.45.124.0/24                                        │   │
│   │  • 12.201.32.0/24                                       │   │
│   │  • 199.66.8.0/22                                        │   │
│   │  • ...more ranges                                       │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│   Why this matters: These IPs might host subdomains we          │
│   haven't discovered through DNS enumeration!                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 📊 ASN Discovery Workflow:
```bash

    ┌─────────────────┐
    │   Company Name  │
    │   (e.g., Tesla) │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Find ASN(s)    │
    │   AS394161      │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Find IP Ranges │
    │  8.45.124.0/24  │
    │  12.201.32.0/24 │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │ Reverse DNS     │
    │ IP → Hostname   │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │ More Subdomains!│
    └─────────────────┘
```
## 4.2 ASN Enumeration Tools
### 🌐 Website: bgp.he.net
```bash

┌─────────────────────────────────────────────────────────────────┐
│  🔍 bgp.he.net - Hurricane Electric BGP Toolkit                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  URL: https://bgp.he.net                                        │
│                                                                 │
│  How to use:                                                    │
│  1. Search for company name (e.g., "Tesla")                     │
│  2. Click on the ASN result                                     │
│  3. View "Prefixes v4" tab for IP ranges                        │
│  4. Copy all IP ranges for further enumeration                  │
│                                                                 │
│  Example Search Results:                                        │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │ AS394161  |  TESLA  |  Tesla, Inc.  |  United States       │ │
│  │           |         |               |                      │ │
│  │ Prefixes: 8.45.124.0/24, 12.201.32.0/24, ...               │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 💻 Command Line Tools:
```Bash

# Using whois
whois -h whois.radb.net -- '-i origin AS394161'

# Using ASNmap (Project Discovery)
asnmap -a AS394161 -o ip_ranges.txt

# Using Amass
amass intel -asn 394161

# Using nmap script
nmap --script targets-asn --script-args targets-asn.asn=394161
```
### Tool: ASNLookup
```Bash
# Installation
pip install asnlookup

# Usage - by organization name
asnlookup -o "Tesla"

# Usage - by domain
asnlookup -d tesla.com
```
## 4.3 Finding IP Ranges from ASN
### Script: ASN to IP Ranges
```Bash

#!/bin/bash
# asn_to_ips.sh

ASN=$1

echo "[*] Finding IP ranges for ASN: $ASN"

# Method 1: RADB

echo "[+] Querying RADB..."
whois -h whois.radb.net -- "-i origin $ASN" | grep -Eo "([0-9.]+){4}/[0-9]+" | sort -u

# Method 2: BGP.he.net (parsing HTML)
echo "[+] Querying bgp.he.net..."
curl -s "https://bgp.he.net/$ASN#_prefixes" | \
  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}" | \
  sort -u
```

## 📝 Lab Exercise 4: ASN Discovery
```bash

┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 4: ASN & IP Range Discovery                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: A large company with its own ASN                       │
│          (e.g., Tesla, Uber, Netflix)                           │
│                                                                 │
│  Tasks:                                                         │
│  1. Go to bgp.he.net and find the company's ASN                 │
│  2. List all IPv4 prefixes owned by the company                 │
│  3. Calculate total number of IP addresses                      │
│  4. Pick 2-3 IP ranges and do reverse DNS lookup                │
│  5. Document any new subdomains found                           │
│                                                                 │
│  Bonus: Find if the company has multiple ASNs                   │
│         (acquisitions often have separate ASNs)                 │
│                                                                 │
│  Time: 15 minutes                                               │
│                                                                 │
│  Deliverable: asn_results.txt                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## Module 5: Historical Data Mining
### 5.1 Wayback Machine
What is Wayback Machine?
```bash

┌─────────────────────────────────────────────────────────────────┐
│                     WAYBACK MACHINE                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Internet Archive that stores snapshots of websites            │
│   over time (since 1996!)                                       │
│                                                                 │
│   Why useful for bug bounty:                                    │
│   • Find old endpoints that still work                          │
│   • Discover removed sensitive files                            │
│   • Find old parameters (might still be vulnerable)             │
│   • See how the website changed over time                       │
│   • Find old subdomains that were removed from DNS              │
│                                                                 │
│   ┌───────────────────────────────────────────────────────────┐ │
│   │   2015        2018        2020        2023        NOW     │ │
│   │     │           │           │           │           │     │ │
│   │     ▼           ▼           ▼           ▼           ▼     │ │
│   │   [📸]        [📸]        [📸]        [📸]        [🌐]    │ │
│   │                                                           │ │
│   │   All these snapshots are stored and searchable!          │ │
│   └───────────────────────────────────────────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 💻 Tools for Wayback Mining:
```Bash
#Web Based Url:

http://web.archive.org/cdx/search/cdx?url=DOMAIN/*&output=text&fl=original&collapse=urlkey

# Tool 1: waybackurls (by tomnomnom)
go install github.com/tomnomnom/waybackurls@latest

# Basic usage
echo "target.com" | waybackurls > wayback_urls.txt

# Multiple domains
cat subdomains.txt | waybackurls > all_wayback_urls.txt

# Tool 2: gau (GetAllUrls)
go install github.com/lc/gau/v2/cmd/gau@latest

# Basic usage (combines Wayback + CommonCrawl + more)
gau target.com > gau_urls.txt

# With specific providers
gau --providers wayback,commoncrawl target.com

# With output filtering
gau target.com | grep "\.js$" > js_files.txt
gau target.com | grep "\.php\?" > php_endpoints.txt

# Tool 3: waymore
pip install waymore

# Usage
waymore -i target.com -mode U -oU wayback_urls.txt
```
## 📊 What to Look for in Historical URLs:
```bash

┌─────────────────────────────────────────────────────────────────┐
│              VALUABLE PATTERNS IN WAYBACK DATA                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. OLD API ENDPOINTS                                           │
│     • /api/v1/users                                             │
│     • /api/internal/                                            │
│     • /rest/admin/                                              │
│                                                                 │
│  2. BACKUP/CONFIG FILES                                         │
│     • /config.php.bak                                           │
│     • /web.config.old                                           │
│     • /.env                                                     │
│     • /backup.sql                                               │
│                                                                 │
│  3. ADMIN/DEBUG PAGES                                           │
│     • /admin/                                                   │
│     • /debug/                                                   │
│     • /phpinfo.php                                              │
│     • /server-status                                            │
│                                                                 │
│  4. JUICY PARAMETERS                                            │
│     • ?file=                                                    │
│     • ?path=                                                    │
│     • ?url=                                                     │
│     • ?redirect=                                                │
│     • ?id=                                                      │
│     • ?user=                                                    │
│                                                                 │
│  5. JAVASCRIPT FILES                                            │
│     • May contain API keys                                      │
│     • May contain internal endpoints                            │
│     • May have debug code                                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 🔧 Automated Filtering Script:
```Bash

#!/bin/bash
# filter_wayback.sh

DOMAIN=$1
OUTPUT_DIR="./recon/$DOMAIN/wayback"
mkdir -p $OUTPUT_DIR

echo "[*] Fetching Wayback URLs for $DOMAIN..."
echo $DOMAIN | waybackurls > $OUTPUT_DIR/all_urls.txt

echo "[+] Total URLs found: $(wc -l < $OUTPUT_DIR/all_urls.txt)"

echo "[*] Filtering interesting endpoints..."

# JavaScript files
grep -E "\.js(\?|$)" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/js_files.txt
echo "    JS files: $(wc -l < $OUTPUT_DIR/js_files.txt)"

# PHP with parameters (potential SQLi/LFI)
grep -E "\.php\?" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/php_params.txt
echo "    PHP with params: $(wc -l < $OUTPUT_DIR/php_params.txt)"

# Potential LFI endpoints
grep -E "(file|path|folder|dir|document|root|include)=" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/potential_lfi.txt
echo "    Potential LFI: $(wc -l < $OUTPUT_DIR/potential_lfi.txt)"

# Potential SSRF endpoints
grep -E "(url|uri|redirect|return|next|dest|src|source|link|fetch)=" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/potential_ssrf.txt
echo "    Potential SSRF: $(wc -l < $OUTPUT_DIR/potential_ssrf.txt)"

# Potential IDOR endpoints
grep -E "(id|user|account|order|no|doc|key)=[0-9]+" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/potential_idor.txt
echo "    Potential IDOR: $(wc -l < $OUTPUT_DIR/potential_idor.txt)"

# API endpoints
grep -E "/api/" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/api_endpoints.txt
echo "    API endpoints: $(wc -l < $OUTPUT_DIR/api_endpoints.txt)"

# Config/backup files
grep -E "\.(bak|backup|old|orig|temp|swp|sql|log|config|conf|cfg|env)(\?|$)" $OUTPUT_DIR/all_urls.txt | sort -u > $OUTPUT_DIR/sensitive_files.txt
echo "    Sensitive files: $(wc -l < $OUTPUT_DIR/sensitive_files.txt)"

echo ""
echo "[✓] Filtering complete! Results saved to $OUTPUT_DIR/"
```
## 5.2 GitHub Historical Analysis
#### Finding Deleted Secrets in Commit History:
```Bash

# Clone repository
git clone https://github.com/target/repo.git
cd repo

# Search through all commit history for passwords
git log -p -S "password" --all

# Search for API keys
git log -p -S "api_key" --all

# Search for AWS keys
git log -p -S "AKIA" --all

# View changes in specific file over time
git log -p -- config.py
```
#### Tool: git-secrets
```Bash

# Installation
git clone https://github.com/awslabs/git-secrets.git
cd git-secrets
make install

# Scan repository
git secrets --scan-history
```
## 📝 Lab Exercise 5: Historical Data Mining
```bash
┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 5: Wayback Machine Mining                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: A bug bounty target of your choice                     │
│                                                                 │
│  Tasks:                                                         │
│  1. Run waybackurls on the main domain                          │
│  2. Run gau for comprehensive coverage                          │
│  3. Filter results by:                                          │
│     • JavaScript files                                          │
│     • PHP/ASP endpoints with parameters                         │
│     • Potential LFI patterns                                    │
│     • API endpoints                                             │
│  4. Check if any old endpoints still work (just open in browser)│
│  5. Document interesting findings                               │
│                                                                 │
│  Time: 20 minutes                                               │
│                                                                 │
│  Deliverable: wayback_analysis.txt                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## Module 6: Technology Fingerprinting (Passive)
### 6.1 Why Fingerprint Technologies?
```bash
┌─────────────────────────────────────────────────────────────────┐
│              TECHNOLOGY FINGERPRINTING VALUE                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Know the tech stack → Know the vulnerabilities                │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  Found: WordPress 5.2.3                                 │   │
│   │                    │                                    │   │
│   │                    ▼                                    │   │
│   │  Search: CVE-2019-XXXX for WordPress 5.2.3              │   │
│   │                    │                                    │   │
│   │                    ▼                                    │   │
│   │  Exploit: Known vulnerabilities for this version        │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│   Common CVE-prone technologies:                                │
│   • WordPress plugins                                           │
│   • Drupal                                                      │
│   • Jenkins                                                     │
│   • Apache Struts                                               │
│   • Tomcat                                                      │
│   • Jira                                                        │
│   • Confluence                                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 6.2 Passive Fingerprinting Methods
### 🌐 Browser Extension: Wappalyzer
```bash
┌─────────────────────────────────────────────────────────────────┐
│                     WAPPALYZER                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Install: Chrome/Firefox extension                              │
│  URL: https://www.wappalyzer.com/                               │
│                                                                 │
│  What it detects:                                               │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Category          │  Examples                            │  │
│  ├────────────────────┼──────────────────────────────────────┤  │
│  │  CMS               │  WordPress, Drupal, Joomla           │  │
│  │  Frameworks        │  React, Angular, Vue, Django         │  │
│  │  Web Servers       │  Apache, Nginx, IIS                  │  │
│  │  Programming Lang  │  PHP, Python, Ruby, Java             │  │
│  │  CDN               │  Cloudflare, Akamai, AWS CloudFront  │  │
│  │  Analytics         │  Google Analytics, Hotjar            │  │
│  │  Security          │  WAF, reCAPTCHA                      │  │
│  │  Databases         │  MySQL, MongoDB (if headers leak)    │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                 │
│  How to use passively:                                          │
│  • Just visit the website with the extension installed          │
│  • Click the Wappalyzer icon to see all detected technologies   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
### 🌐 Website: BuiltWith
```bash
┌─────────────────────────────────────────────────────────────────┐
│                     BUILTWITH                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  URL: https://builtwith.com/                                    │
│                                                                 │
│  Enter target domain → Get detailed technology profile          │
│                                                                 │
│  Information provided:                                          │
│  • Web server                                                   │
│  • SSL certificate details                                      │
│  • Hosting provider                                             │
│  • CMS/Framework                                                │
│  • JavaScript libraries                                         │
│  • Analytics tools                                              │
│  • Email services                                               │
│  • CDN                                                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
### 🌐 Shodan Queries:
```Bash

# Basic search for target
ssl.cert.subject.cn:"example.com"

# Find all servers with specific technology
ssl.cert.subject.cn:"example.com" product:"nginx"

# Find specific ports
ssl.cert.subject.cn:"example.com" port:8080

# Find WordPress
http.html:"wp-content" hostname:"example.com"

# Find Apache Struts
http.html:"Struts Problem Report" hostname:"example.com"

# Find Jenkins
product:"Jenkins" hostname:"example.com"
```
### 💻 Using Shodan CLI:
```Bash

# Install
pip install shodan

# Initialize with API key
shodan init YOUR_API_KEY

# Search
shodan search "ssl:example.com" --fields ip_str,port,org

# Get info for specific IP
shodan host 8.8.8.8
```
## 6.3 Job Posting Analysis
### Creative OSINT Technique:
```bash
┌─────────────────────────────────────────────────────────────────┐
│              JOB POSTING ANALYSIS FOR TECH STACK                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Companies reveal their tech stack in job postings!            │
│                                                                 │
│   Example Job Posting:                                          │
│   ┌───────────────────────────────────────────────────────────┐ │
│   │                                                           │ │
│   │  "Senior Backend Developer at Target Corp                 │ │
│   │                                                           │ │
│   │   Requirements:                                           │ │
│   │   • 5+ years experience with Python/Django                │ │
│   │   • Experience with PostgreSQL and Redis                  │ │
│   │   • Familiarity with AWS (EC2, S3, Lambda)                │ │
│   │   • Experience with Kubernetes and Docker                 │ │
│   │   • Knowledge of Elasticsearch                            │ │
│   │   • CI/CD experience (Jenkins preferred)                  │ │
│   │                                                           │ │
│   └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│   What we learned:                                              │
│   ✓ Backend: Python/Django                                      │
│   ✓ Database: PostgreSQL, Redis                                 │
│   ✓ Cloud: AWS                                                  │
│   ✓ Infrastructure: Kubernetes, Docker                          │
│   ✓ Search: Elasticsearch                                       │
│   ✓ CI/CD: Jenkins                                              │
│                                                                 │
│   Where to find job postings:                                   │
│   • LinkedIn Jobs                                               │
│   • Indeed                                                      │
│   • Glassdoor                                                   │
│   • Company careers page                                        │
│   • AngelList (for startups)                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
### 📝 Lab Exercise 6: Technology Fingerprinting
```bash
┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 6: Passive Technology Fingerprinting           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: A bug bounty program of your choice                    │
│                                                                 │
│  Tasks:                                                         │
│  1. Install Wappalyzer and visit the target                     │
│  2. Use BuiltWith to get detailed tech profile                  │
│  3. Search Shodan for the target                                │
│  4. Find 2-3 job postings from the company                      │
│  5. Create a complete tech stack document                       │
│                                                                 │
│  Deliverable: tech_stack.txt with:                              │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Web Server: _______                                       │ │
│  │  Framework: _______                                        │ │
│  │  CMS: _______                                              │ │
│  │  CDN: _______                                              │ │
│  │  WAF: _______                                              │ │
│  │  Database (if found): _______                              │ │
│  │  Cloud Provider: _______                                   │ │
│  │  Other: _______                                            │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                 │
│  Time: 15 minutes                                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## Module 7: Acquisitions & Related Assets
### 7.1 Why Research Acquisitions?
```bash
┌─────────────────────────────────────────────────────────────────┐
│              ACQUISITIONS = EXPANDED ATTACK SURFACE             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   When Company A acquires Company B:                            │
│                                                                 │
│   ┌─────────────────┐        ┌─────────────────┐                │
│   │   Company A     │        │   Company B     │                │
│   │   (Main target) │───────▶│   (Acquired)    │                │
│   │                 │        │                 │                │
│   │   Well secured  │        │  Forgotten!     │                │
│   │   Bug bounty    │        │  Older security │                │
│   │   focus         │        │  Less attention │                │
│   └─────────────────┘        └─────────────────┘                │
│                                                                 │
│   The acquired company often:                                   │
│   • Still runs old infrastructure                               │
│   • Has weaker security practices                               │
│   • Connects to parent company systems                          │
│   • Becomes IN SCOPE for parent company bug bounty!             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
#### Where to Research Acquisitions:
```bash
┌─────────────────────────────────────────────────────────────────┐
│              ACQUISITION RESEARCH SOURCES                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Crunchbase (https://crunchbase.com)                         │
│     • Most comprehensive M&A database                           │
│     • Shows funding rounds, acquisitions, key people            │
│                                                                 │
│  2. Wikipedia                                                   │
│     • Company pages often list acquisitions                     │
│     • Search: "Company Name acquisitions"                       │
│                                                                 │
│  3. Company Press Releases                                      │
│     • Search: "Company Name acquired"                           │
│     • Often announce acquisitions officially                    │
│                                                                 │
│  4. TechCrunch / VentureBeat                                    │
│     • Tech acquisition news                                     │
│                                                                 │
│  5. LinkedIn                                                    │
│     • Check company page for subsidiaries                       │
│     • Employee profiles showing both companies                  │
│                                                                 │
│  6. SEC Filings (for US public companies)                       │
│     • 10-K annual reports list subsidiaries                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
#### Example: Google Acquisitions
```bash
┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE ACQUISITIONS                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Google has acquired 200+ companies. Some examples:            │
│                                                                 │
│   • YouTube (2006)                                              │
│   • Waze (2013)                                                 │
│   • Nest (2014)                                                 │
│   • Fitbit (2021)                                               │
│   • Mandiant (2022)                                             │
│                                                                 │
│   Each of these might have:                                     │
│   • Old subdomains: *.waze.com, *.nest.com                      │
│   • Legacy infrastructure                                       │
│   • Separate ASNs and IP ranges                                 │
│   • Old employee accounts/access                                │
│                                                                 │
│   Bug bounty impact:                                            │
│   If *.google.com is in scope AND they own Waze,                │
│   then waze.com infrastructure might be testable!               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 7.2 Reverse WHOIS Lookup
### Finding Related Domains:
```Bash

# If you find the registrant email/name from WHOIS
# You can find ALL domains registered by them

# Example WHOIS output:
# Registrant Email: domains@company.com

# Use reverse WHOIS to find all domains
# registered with domains@company.com
```
### Tools for Reverse WHOIS:
```bash
┌─────────────────────────────────────────────────────────────────┐
│              REVERSE WHOIS TOOLS                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. ViewDNS Reverse WHOIS                                       │
│     URL: https://viewdns.info/reversewhois/                     │
│     Search by email or name                                     │
│                                                                 │
│  2. DomainEye                                                   │
│     URL: https://domaineye.com/reverse-whois                    │
│                                                                 │
│  3. WHOXY                                                       │
│     URL: https://www.whoxy.com/reverse-whois/                   │
│                                                                 │
│  4. SecurityTrails                                              │
│     URL: https://securitytrails.com                             │
│     (Requires account)                                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 📝 Lab Exercise 7: Acquisition Research
```bash
┌─────────────────────────────────────────────────────────────────┐
│  🧪 LAB EXERCISE 7: Acquisition & Related Asset Discovery       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: A large tech company (e.g., Microsoft, Meta, Uber)     │
│                                                                 │
│  Tasks:                                                         │
│  1. Go to Crunchbase and find recent acquisitions (last 5 yrs)  │
│  2. Identify at least 3 acquired companies                      │
│  3. For each acquisition:                                       │
│     • Find their main domain                                    │
│     • Run subdomain enumeration on them                         │
│     • Check if they share infrastructure with parent            │
│  4. Use reverse WHOIS to find related domains                   │
│                                                                 │
│  Time: 20 minutes                                               │
│                                                                 │
│  Deliverable: acquisitions.txt listing all related domains      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## Module 8: The Complete Passive Recon Methodology
### 8.1 Putting It All Together
#### 📋 Master Passive Recon Checklist
```bash
┌─────────────────────────────────────────────────────────────────┐
│            PASSIVE RECON MASTER CHECKLIST                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  SUBDOMAIN ENUMERATION                                          │
│  [ ] crt.sh certificate transparency                            │
│  [ ] Subfinder (with API keys configured)                       │
│  [ ] Assetfinder                                                │
│  [ ] Amass (passive mode)                                       │
│  [ ] Merge and deduplicate results                              │
│                                                                 │
│  SEARCH ENGINE DORKING                                          │
│  [ ] Google dorking (subdomains)                                │
│  [ ] Google dorking (sensitive files)                           │
│  [ ] Google dorking (admin panels)                              │
│  [ ] GitHub dorking (organization)                              │
│  [ ] GitHub dorking (secrets/keys)                              │
│  [ ] GitLab dorking (if applicable)                             │
│                                                                 │
│  ASN & IP RANGES                                                │
│  [ ] Identify company ASN(s)                                    │
│  [ ] Extract all IP ranges                                      │
│  [ ] Reverse DNS lookup on key ranges                           │
│                                                                 │
│  HISTORICAL DATA                                                │
│  [ ] Wayback Machine (waybackurls)                              │
│  [ ] GAU (all sources)                                          │
│  [ ] Filter for interesting patterns                            │
│  [ ] GitHub commit history analysis                             │
│                                                                 │
│  TECHNOLOGY FINGERPRINTING                                      │
│  [ ] Wappalyzer                                                 │
│  [ ] BuiltWith                                                  │
│  [ ] Shodan queries                                             │
│  [ ] Job posting analysis                                       │
│                                                                 │
│  ACQUISITIONS & RELATED ASSETS                                  │
│  [ ] Crunchbase research                                        │
│  [ ] Wikipedia acquisitions                                     │
│  [ ] Reverse WHOIS                                              │
│  [ ] Subdomain enum on acquired companies                       │
│                                                                 │
│  DOCUMENTATION                                                  │
│  [ ] All subdomains in one file                                 │
│  [ ] IP ranges documented                                       │
│  [ ] Tech stack documented                                      │
│  [ ] Interesting findings highlighted                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 8.2 Automated Passive Recon Script
```Bash

#!/bin/bash
#============================================================
# PASSIVE RECON AUTOMATION SCRIPT
# For Bug Bounty Hunters
#============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
    echo -e "${RED}Usage: $0 <domain>${NC}"
    exit 1
fi

# Setup directories
BASE_DIR="./recon/$DOMAIN"
PASSIVE_DIR="$BASE_DIR/passive"
SUBDOMAINS_DIR="$PASSIVE_DIR/subdomains"
URLS_DIR="$PASSIVE_DIR/urls"
DORKING_DIR="$PASSIVE_DIR/dorking"

mkdir -p $SUBDOMAINS_DIR $URLS_DIR $DORKING_DIR

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║          PASSIVE RECONNAISSANCE AUTOMATION                 ║"
echo "║                    Target: $DOMAIN"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

#------------------------------------------------------------
# PHASE 1: SUBDOMAIN ENUMERATION
#------------------------------------------------------------
echo -e "${YELLOW}[PHASE 1] Subdomain Enumeration${NC}"

# 1.1 crt.sh
echo -e "${GREEN}[+] Querying crt.sh...${NC}"
curl -s "https://crt.sh/?q=%.$DOMAIN&output=json" | \
    jq -r '.[].name_value' 2>/dev/null | \
    sed 's/\*\.//g' | \
    sort -u > $SUBDOMAINS_DIR/crt_sh.txt
echo "    Found: $(wc -l < $SUBDOMAINS_DIR/crt_sh.txt) subdomains"

# 1.2 Subfinder
echo -e "${GREEN}[+] Running Subfinder...${NC}"
subfinder -d $DOMAIN -silent -o $SUBDOMAINS_DIR/subfinder.txt 2>/dev/null
echo "    Found: $(wc -l < $SUBDOMAINS_DIR/subfinder.txt) subdomains"

# 1.3 Assetfinder
echo -e "${GREEN}[+] Running Assetfinder...${NC}"
assetfinder --subs-only $DOMAIN > $SUBDOMAINS_DIR/assetfinder.txt 2>/dev/null
echo "    Found: $(wc -l < $SUBDOMAINS_DIR/assetfinder.txt) subdomains"

# 1.4 Amass Passive
echo -e "${GREEN}[+] Running Amass (passive mode)...${NC}"
timeout 300 amass enum -passive -d $DOMAIN -o $SUBDOMAINS_DIR/amass.txt 2>/dev/null
echo "    Found: $(wc -l < $SUBDOMAINS_DIR/amass.txt 2>/dev/null || echo 0) subdomains"

# Merge all subdomains
echo -e "${GREEN}[+] Merging subdomain results...${NC}"
cat $SUBDOMAINS_DIR/*.txt | sort -u > $PASSIVE_DIR/all_subdomains.txt
echo -e "${BLUE}    TOTAL UNIQUE SUBDOMAINS: $(wc -l < $PASSIVE_DIR/all_subdomains.txt)${NC}"

#------------------------------------------------------------
# PHASE 2: HISTORICAL URL DATA
#------------------------------------------------------------
echo ""
echo -e "${YELLOW}[PHASE 2] Historical URL Mining${NC}"

# 2.1 Waybackurls
echo -e "${GREEN}[+] Fetching Wayback URLs...${NC}"
echo $DOMAIN | waybackurls > $URLS_DIR/wayback_urls.txt 2>/dev/null
echo "    Found: $(wc -l < $URLS_DIR/wayback_urls.txt) URLs"

# 2.2 GAU
echo -e "${GREEN}[+] Running GAU...${NC}"
gau $DOMAIN > $URLS_DIR/gau_urls.txt 2>/dev/null
echo "    Found: $(wc -l < $URLS_DIR/gau_urls.txt) URLs"

# Merge URLs
cat $URLS_DIR/*.txt | sort -u > $PASSIVE_DIR/all_urls.txt
echo -e "${BLUE}    TOTAL UNIQUE URLs: $(wc -l < $PASSIVE_DIR/all_urls.txt)${NC}"

# Filter interesting endpoints
echo -e "${GREEN}[+] Filtering interesting endpoints...${NC}"

# JS Files
grep -E "\.js(\?|$)" $PASSIVE_DIR/all_urls.txt | sort -u > $URLS_DIR/js_files.txt
echo "    JS files: $(wc -l < $URLS_DIR/js_files.txt)"

# Potential LFI
grep -E "(file|path|folder|doc|root|include)=" $PASSIVE_DIR/all_urls.txt | sort -u > $URLS_DIR/potential_lfi.txt
echo "    Potential LFI: $(wc -l < $URLS_DIR/potential_lfi.txt)"

# Potential SSRF
grep -E "(url|redirect|return|next|dest|src|link)=" $PASSIVE_DIR/all_urls.txt | sort -u > $URLS_DIR/potential_ssrf.txt
echo "    Potential SSRF: $(wc -l < $URLS_DIR/potential_ssrf.txt)"

# API endpoints
grep -E "/api/" $PASSIVE_DIR/all_urls.txt | sort -u > $URLS_DIR/api_endpoints.txt
echo "    API endpoints: $(wc -l < $URLS_DIR/api_endpoints.txt)"

#------------------------------------------------------------
# PHASE 3: SUMMARY
#------------------------------------------------------------
echo ""
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    RECON SUMMARY                           ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║  Subdomains Found: $(wc -l < $PASSIVE_DIR/all_subdomains.txt)"
echo "║  URLs Found: $(wc -l < $PASSIVE_DIR/all_urls.txt)"
echo "║  JS Files: $(wc -l < $URLS_DIR/js_files.txt)"
echo "║  Potential LFI: $(wc -l < $URLS_DIR/potential_lfi.txt)"
echo "║  Potential SSRF: $(wc -l < $URLS_DIR/potential_ssrf.txt)"
echo "║  API Endpoints: $(wc -l < $URLS_DIR/api_endpoints.txt)"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║  Results saved to: $BASE_DIR                               "
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
```
## 8.3 Expected Deliverables
#### Folder Structure After Passive Recon:

```bash
target.com/
└── passive/
    ├── all_subdomains.txt          # All unique subdomains
    ├── all_urls.txt                # All historical URLs
    │
    ├── subdomains/
    │   ├── crt_sh.txt
    │   ├── subfinder.txt
    │   ├── assetfinder.txt
    │   └── amass.txt
    │
    ├── urls/
    │   ├── wayback_urls.txt
    │   ├── gau_urls.txt
    │   ├── js_files.txt
    │   ├── potential_lfi.txt
    │   ├── potential_ssrf.txt
    │   └── api_endpoints.txt
    │
    ├── dorking/
    │   ├── google_results.txt
    │   └── github_secrets.txt
    │
    ├── ip_ranges.txt               # ASN enumeration results
    ├── tech_stack.txt              # Technology fingerprint
    └── acquisitions.txt            # Related companies/domains
```
## 📝 Final Lab: Complete Passive Recon
```bash
┌─────────────────────────────────────────────────────────────────┐
│  🧪 FINAL LAB: Complete Passive Reconnaissance                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Target: Choose a bug bounty program from HackerOne             │
│                                                                 │
│  Complete the ENTIRE passive recon checklist:                   │
│                                                                 │
│  [ ] Subdomain enumeration (all tools)                          │
│  [ ] Google dorking                                             │
│  [ ] GitHub dorking                                             │
│  [ ] ASN enumeration                                            │
│  [ ] Wayback URL mining                                         │
│  [ ] Technology fingerprinting                                  │
│  [ ] Acquisition research                                       │
│                                                                 │
│  Deliverables:                                                  │
│  1. Complete folder structure as shown above                    │
│  2. Summary report with key findings                            │
│  3. Top 10 interesting assets to investigate next               │
│                                                                 │
│  Time: 45-60 minutes                                            │
│                                                                 │
│  Grading:                                                       │
│  • Completeness of data collection: 40%                         │
│  • Quality of filtering/analysis: 30%                           │
│  • Interesting findings identified: 30%                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
## 📚 Additional Resources
#### Recommended Tools Summary
#### Tool	Purpose	Installation
```bash
subfinder	Subdomain enum	go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
assetfinder	Subdomain enum	go install github.com/tomnomnom/assetfinder@latest
amass	Subdomain enum	go install -v github.com/owasp-amass/amass/v5/cmd/amass@main
waybackurls	URL mining	go install github.com/tomnomnom/waybackurls@latest
gau	URL mining	go install github.com/lc/gau/v2/cmd/gau@latest
httpx	HTTP probing	go install github.com/projectdiscovery/httpx/cmd/httpx@latest
shodan	Passive scanning	pip install shodan
```
#### Recommended Learning
```bash
┌─────────────────────────────────────────────────────────────────┐
│              CONTINUE YOUR LEARNING                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  YouTube Channels:                                              │
│  • NahamSec                                                     │
│  • STÖK                                                         │
│  • InsiderPhD                                                   │
│  • Jason Haddix                                                 │
│                                                                 │
│  Practice Platforms:                                            │
│  • HackerOne (hackerone.com)                                    │
│  • Bugcrowd (bugcrowd.com)                                      │
│  • Intigriti (intigriti.com)                                    │
│                                                                 │
│  Next Class:                                                    │
│  • Active Reconnaissance (Class 2)                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
