# Subdomain Permutation & Active DNS Enumeration

---

## DNS Resolution — Technical Explanation

### What DNS Actually Is

The Domain Name System is a **globally distributed, hierarchical, delegated database**. It translates human-readable names into IP addresses (and stores other record types).

```
You query: dev2.example.com

Resolution chain:
  Your machine
      ↓ (stub resolver)
  Local DNS resolver (your ISP or 8.8.8.8)
      ↓ (recursive resolver)
  Root nameserver (.)
      ↓ "I don't know, ask .com TLD"
  .com TLD nameserver
      ↓ "I don't know, ask example.com's NS"
  example.com authoritative nameserver
      ↓ "dev2.example.com = 10.20.30.40" OR "NXDOMAIN"
  Answer returns up the chain
  Your machine receives: 10.20.30.40 or NXDOMAIN
```
### Version:

`https://miro.com/welcomeonboard/b3lBOGthTzRYVitSZXJqbERnVXZDdmJMWG5acnFiR1JQeWgrRFV4RXpmV3RyTFFmRUdvMXcwNEF1dXlrZTdHRkNaNGIxSFB4SHYyZXNlYlJzRjVpb09FdjJXRlk1WDNsMjRZZUlpQWxWaUVzS1poeFM1MUVOL2ZzZXFaVTlpTDFzVXVvMm53MW9OWFg5bkJoVXZxdFhRPT0hdjE=?share_link_id=143750809510`

This full chain is called **iterative recursive resolution** and takes 4–8 network hops.

---

### DNS Record Types You Care About

**A Record** — IPv4 address mapping
```
dev2.example.com.  300  IN  A  10.20.30.40
```
If this resolves → the host exists. This is your primary target.

**AAAA Record** — IPv6 mapping
```
dev2.example.com.  300  IN  AAAA  2001:db8::1
```
Often overlooked. Some internal infrastructure is IPv6-only.

**CNAME Record** — Canonical Name (alias)
```
dev2.example.com.  300  IN  CNAME  dev2.us-east-1.elb.amazonaws.com.
```
This is **critical**. A CNAME pointing to a deprovisioned cloud resource = **subdomain takeover**. The subdomain exists in DNS but the backend is gone — an attacker can claim it.

**NS Record** — Nameserver delegation
```
internal.example.com.  IN  NS  ns1.internal.corp.
```
A different NS for a subdomain means a **separate DNS zone** — often less hardened.

**MX Record** — Mail exchanger
```
mail.example.com.  IN  MX  10 smtp.example.com.
```
Reveals mail infrastructure.

**TXT Record** — Arbitrary text
```
_dmarc.example.com.  IN  TXT  "v=DMARC1; p=none"
example.com.         IN  TXT  "google-site-verification=..."
```
Leaks third-party service usage (Google, Salesforce, Atlassian, etc.).

---

### Response Codes You Must Understand

| RCODE | Meaning | Action |
|---|---|---|
| `NOERROR` + answer | Host exists, resolved | **KEEP** |
| `NXDOMAIN` | Name doesn't exist at all | Discard |
| `SERVFAIL` | Nameserver error | Retry, may be intermittent |
| `REFUSED` | Resolver refused the query | Switch resolver |
| `NOERROR` + no answer | Name exists, no A record (but maybe CNAME) | Investigate |

The `NOERROR` + no answer case is subtle and important. It means the **label exists in DNS** (the zone has an entry) but not the record type you asked for. Always follow up with CNAME queries.

---

### How High-Speed Resolution Works (MassDNS Architecture)

Tools like `puredns` / `massdns` don't do full recursive resolution. They send **raw UDP DNS queries directly to authoritative-adjacent resolvers** and handle responses asynchronously.

```
Thread pool
  ↓
UDP socket → Query batch → Resolver 1 (8.8.8.8)
                         → Resolver 2 (1.1.1.1)
                         → Resolver 3 (9.9.9.9)
                         → Resolver N (...)
                         ↑
              Response handler (async)
                  ↓
            Parse RCODE → filter → output
```

This is why you can push **100,000+ queries per second** — no waiting for each response before sending the next. This is **asynchronous I/O at scale**.

**The risk:** At high rates, resolvers rate-limit or block you. A resolver that starts dropping packets looks identical to NXDOMAIN — you get **false negatives** (real subdomains missed). This is why resolver health and rotation matter enormously.

---

## DNS Resolvers — Deep Explanation

### What Is a Resolver?

A DNS resolver is a server that **accepts your query, performs the recursive lookup through the DNS hierarchy, and returns the answer.**

```
Your tool                   Resolver                  Authoritative NS
    │                          │                              │
    │── "What is dev.tgt.com?" →│                              │
    │                          │── iterates through root, TLD →│
    │                          │←── answer: 10.0.0.5 ─────────│
    │←── "10.0.0.5" ───────────│                              │
```

---

### Types of Resolvers

**Public Resolvers** — Operated by large companies, globally available:
```
8.8.8.8        Google
8.8.4.4        Google
1.1.1.1        Cloudflare
1.0.0.1        Cloudflare
9.9.9.9        Quad9
208.67.222.222 OpenDNS
```

**ISP Resolvers** — Your local Internet Service Provider's resolvers. Fast, but geographically limited. Never use for enumeration.

**Open Public Resolvers** — Thousands of smaller open resolvers worldwide. These are what you use for **high-volume enumeration**.

You get fresh lists from: `https://public-dns.info/nameservers.txt`

---

### Why You Cannot Use a Single Resolver

This is fundamental. Using only `8.8.8.8` for 5 million queries:

```
Rate limit:     Google imposes ~1,000 QPS per IP for 8.8.8.8
Your rate:      50,000 QPS
Result:         Queries get dropped silently
Consequence:    False negatives — real subdomains appear as NXDOMAIN
                Your enumeration is inaccurate and you don't know it
```

This is the **silent failure mode** — the most dangerous kind. You don't get an error. You just miss real subdomains.

---

### Resolver Quality Dimensions

**1. Accuracy** — Does it return the correct answer without lying?
Some resolvers **lie** — they intercept NXDOMAIN and return their own IP (for ad injection or "helpful" redirection). This creates false positives at scale.

```bash
# Test: query a guaranteed-nonexistent domain
dig @resolver_ip nonexistent-xyz-abc-123.com

# If it returns an IP instead of NXDOMAIN → resolver is lying → DISCARD
```

**2. Availability** — Is it reliably up?
Open resolvers go offline frequently. A resolver that's down drops your queries silently → false negatives.

**3. Rate Tolerance** — How many QPS before it rate-limits you?
Large resolvers (8.8.8.8) have hard limits. Small open resolvers often have none, but also less capacity.

**4. Geographic Distribution** — Does it see the same DNS as your target's users?
Some organizations use split-horizon DNS — different answers for different geographies. A resolver in US-East may see different records than one in EU-West.

**5. DNSSEC Validation** — Does it validate DNSSEC signatures?
For enumeration purposes, DNSSEC-validating resolvers may refuse to answer queries for domains with broken DNSSEC — a false negative from your perspective.

---

### Building a Quality Resolver List

```bash
# Download fresh list
wget https://public-dns.info/nameservers.txt -O all_resolvers.txt

# Validate them with dnsvalidator
go install github.com/vortexau/dnsvalidator@latest

dnsvalidator -tL all_resolvers.txt \
             -threads 200 \
             -o valid_resolvers.txt

# What dnsvalidator does:
# 1. Queries each resolver for known domains (google.com, cloudflare.com)
# 2. Checks answers match expected IPs
# 3. Queries for nonexistent domains
# 4. Discards any resolver that returns wrong answers or lies about NXDOMAIN
```

**Ideal resolver list size:** 50–150 high-quality, validated resolvers.
More isn't better — 20 accurate resolvers beats 500 unreliable ones.

---

### Resolver Rotation Strategy

`puredns` handles rotation automatically — it distributes queries across your resolver list using **round-robin with health checking.** Resolvers that start dropping packets or returning anomalous results get deprioritized.

```
Query 1 → Resolver 12
Query 2 → Resolver 47
Query 3 → Resolver 3
Query 4 → Resolver 91
...
```

No single resolver gets hammered. Your fingerprint is distributed.

---

## Wildcards — Complete Deep Dive

### What Is a DNS Wildcard?

A wildcard DNS record is a special entry in a DNS zone that matches **any label that doesn't have a more specific record.**

```dns
# Zone file for example.com:
*.example.com.  300  IN  A  203.0.113.5
```

This single record means:

```
anything.example.com        → 203.0.113.5  ✓
randomgarbage.example.com   → 203.0.113.5  ✓
dev.example.com             → 203.0.113.5  ✓ (unless overridden)
xyz123.example.com          → 203.0.113.5  ✓
```

**Technically:** RFC 1034 defines wildcards as matching any single label at the leftmost position. `*.example.com` does NOT match `a.b.example.com` — only one level deep.

---

### Is a Wildcard Good or Bad?

**From the organization's perspective:**
- Often used for **SaaS platforms** where customers get `customer.saas.com` — a wildcard handles all tenants pointing to the same application server
- Used in **CDN configurations** where the CDN serves all subdomains
- Legitimate and common

**From YOUR enumeration perspective:**
Wildcards are a **catastrophic source of false positives.**

Without wildcard detection:
```
You generate: 5,000,000 permutations
All resolve to: 203.0.113.5
Your results: "5,000,000 live subdomains found!"
Reality: 0 of them are individually meaningful
```

Every single permutation "resolves" — making your data completely useless.

---

### When to Be Concerned About Wildcards

**Concern Level 1 — Simple wildcard on apex:**
`*.example.com → single IP`
Easy to detect, easy to filter. All wildcard responses have the same IP.

**Concern Level 2 — Wildcard + real subdomains coexist:**
```
*.example.com          → 203.0.113.5   (wildcard)
admin.example.com      → 10.0.0.1      (real, different IP)
api.example.com        → 10.0.0.2      (real, different IP)
```
Here `admin` and `api` are real but everything else hits the wildcard. You must **distinguish wildcard responses from real responses** by comparing IPs.

**Concern Level 3 — Wildcard returns different IPs (load balanced wildcard):**
```
*.example.com → 203.0.113.5, 203.0.113.6, 203.0.113.7 (round-robin)
```
Now you can't filter by single IP. You must filter by **the set of IPs associated with the wildcard.**

**Concern Level 4 — Wildcard with valid-looking HTTP responses:**
The wildcard IP runs a web server that returns HTTP 200 for all requests. Now even HTTP probing won't distinguish real from wildcard without content-based fingerprinting.

---

### How Wildcard Detection Works (The Algorithm)

```
Step 1: Generate 5 completely random, guaranteed-nonexistent labels
  e.g., a3f9k2.example.com, zx7m1p.example.com, q8r4t6.example.com

Step 2: Resolve all 5
  If ANY resolves → wildcard likely exists

Step 3: Collect the wildcard fingerprint
  Record the IPs returned, the CNAME chains, TTL values, response sizes

Step 4: During bulk resolution, for each result:
  If result matches wildcard fingerprint → DISCARD
  If result differs from wildcard fingerprint → KEEP (potentially real)

Step 5: Edge case — re-query KEPT results from a different resolver
  Confirm they're real and not resolver-level caching artifacts
```

`puredns` does all of this automatically with `--wildcard-tests N` where N is how many random probes to send.

---

### Wildcard Summary

| Scenario | Impact on Enumeration | How to Handle |
|---|---|---|
| No wildcard | No issue | Normal resolution |
| Simple wildcard, static IP | All false positives | Filter by IP match |
| Wildcard + real hosts, different IPs | Mixed results | Filter wildcard IP, keep others |
| Load-balanced wildcard | Hard to filter by IP | Filter by IP set, use HTTP fingerprinting |
| Wildcard returning HTTP 200 | Even HTTP probing fails | Content-hash fingerprinting |

---

## The 6 Permutation Strategies Deep Dive

### Strategy 1: Prefix/Suffix Insertion

This is **morphological augmentation** — you're exploiting the human tendency to name new infrastructure by modifying existing names rather than inventing entirely new ones.

**The cognitive model behind it:**
When a DevOps engineer spins up a second API server, they don't brainstorm a new name. They type `api` and add `-v2`, `-new`, `-backup`. This is **naming inertia** and it's universal across organizations.

```
Seed: api.example.com

Prefix insertions:
  new-api.example.com
  old-api.example.com
  internal-api.example.com
  external-api.example.com
  private-api.example.com
  public-api.example.com

Suffix insertions:
  api-v2.example.com
  api-backup.example.com
  api-legacy.example.com
  api-gateway.example.com
  api-us.example.com
  api-prod.example.com
```

**Why it works:** You're not guessing randomly. You're modeling the engineer's decision tree. The hit rate on this strategy alone often exceeds 40% of all found subdomains.

---

### Strategy 2: Numeric Sequence Permutation

Organizations that scale horizontally (load balancers, shards, worker nodes) follow **sequential or zero-padded naming conventions.**

```
Seed: web01.example.com

Generated:
  web02, web03 ... web99        ← sequential
  web001, web002 ... web099     ← zero-padded
  web1, web2 ... web9           ← unpadded
  web-1, web-2                  ← dash-separated
```

**Deep insight:** The numeric space isn't just appended — it can be *embedded*. `prod1-api`, `api-prod2`, `us1-prod-api` are all valid real-world patterns. Tools like `gotator` with `-numbers 3` handle this but miss embedded positions. A truly thorough approach permutes numbers at every token boundary.

**The math:** If your seed has N subdomains and you test 0–99 for each, that's 100N candidates just from this strategy. For 500 seeds → 50,000 candidates. Manageable.

---

### Strategy 3: Word Substitution (Semantic Replacement)

This is the most **intellectually rich** strategy. You identify *semantic roles* within a subdomain label and replace them with synonyms or equivalents in that role.

```
Seed: prod-api.example.com
         ↑
    [environment token]

Substitutions of the environment token:
  dev-api.example.com
  staging-api.example.com
  qa-api.example.com
  uat-api.example.com
  test-api.example.com
  sandbox-api.example.com
  preprod-api.example.com
  dr-api.example.com          ← disaster recovery
  hotfix-api.example.com
```

**Why this is PhD-level thinking:** You're performing **semantic role labeling on infrastructure names**. The token `prod` isn't just a string  it belongs to the *environment* semantic class. Replacing it with other members of that class is principled, not random.

The same logic applies to:
- Region tokens: `us` → `eu`, `ap`, `us-east-1`, `lon`, `sin`, `syd`
- Version tokens: `v1` → `v2`, `v3`, `latest`, `stable`, `beta`
- Service tokens: `api` → `rest`, `graphql`, `grpc`, `ws`

---

### Strategy 4: Separator Mutation (Dot ↔ Dash Transposition)

DNS labels can use dashes but not dots *within* a single label. However, engineers often inconsistently decide whether to use a subdomain level (dot) or a hyphenated label (dash).

```
Seed: api.internal.example.com

Dot → Dash (collapse levels):
  api-internal.example.com

Dash → Dot (expand to levels):
  Seed: dev-api.example.com
  dev.api.example.com
  api.dev.example.com

Mixed:
  api.dev-internal.example.com
  dev.api-internal.example.com
```

**When this matters most:** Microservice architectures. A company running Kubernetes often has both `auth.service.example.com` *and* `auth-service.example.com` pointing to different things — one external, one internal proxy. This strategy catches exactly that split.

---

### Strategy 5: Word Insertion Between Labels

Instead of modifying existing tokens, you **inject new tokens** at every position in the label hierarchy.

```
Seed: admin.example.com

Insert environment words:
  admin.dev.example.com
  admin.staging.example.com
  dev.admin.example.com
  staging.admin.example.com

Insert infrastructure words:
  admin.internal.example.com
  internal.admin.example.com
  admin.corp.example.com
  corp.admin.example.com
```

**The structural insight:** DNS is a hierarchy. `admin.dev.example.com` and `dev.admin.example.com` are completely different namespaces and may both exist. Each insertion point doubles your candidate space but also doubles relevance.

**Practical limit:** Insert at depth 1 only. Inserting at depth 2+ creates exponential explosion with diminishing returns.

---

### Strategy 6: Combinatorial Label Merging

This is the most powerful and most dangerous strategy (in terms of output size). You take the **vocabulary of labels observed across all your seeds** and systematically combine them.

```
Observed labels from seeds:
  {dev, api, us, internal, admin, portal, v2}

Combinatorial 2-way merges:
  dev-api, api-dev
  dev-us, us-dev
  api-internal, internal-api
  admin-portal, portal-admin
  ... (C(7,2) × 2 = 42 combinations)

Combinatorial 3-way merges:
  dev-api-us, us-api-dev, api-us-dev
  ... (exponential)
```

**The discipline:** Never go beyond 3-way merges in practice. The combinatorial explosion at depth 4+ produces tens of millions of low-probability candidates that waste resolver capacity and produce noise.

---

## Is There One Tool That Does All 6 Strategies?

**Yes — and here's the honest comparison:**

### `gotator` — Closest to "All 6"

```bash
gotator -sub seeds.txt -perm words.txt -depth 2 -numbers 10 -md -prefixes -ro
```

| Flag | Strategy Covered |
|---|---|
| `-perm words.txt` | Prefix/Suffix Insertion (#1) |
| `-numbers 10` | Numeric Sequences (#2) |
| `-perm` with env/region words | Word Substitution (#3) |
| `-md` (middle dot mode) | Word Insertion Between Labels (#5) |
| `-prefixes` | Prefix insertion specifically |
| Combinatorial from `-depth 2` | Partial #6 |

**Gap:** Separator mutation (#4, dot↔dash) is NOT natively handled. You need to pre-process seeds or post-process output.

---

### `alterx` — Most Modern, Template-Driven

```bash
# Install
go install github.com/projectdiscovery/alterx/cmd/alterx@latest

# Run with default templates
alterx -list seeds.txt -enrich -o permutations.txt

# Custom pattern templates
alterx -list seeds.txt -p '{{sub}}-{{word}}' \
                        -p '{{word}}-{{sub}}' \
                        -p '{{sub}}{{number}}' \
                        -enrich -o permutations.txt
```

**Why `alterx` is superior for precision:**

It uses **Go template syntax** so you explicitly define every permutation strategy as a pattern. You're not hoping the tool does what you want — you *declare* exactly what patterns to generate.

```
Pattern: {{sub}}-{{word}}     → api-dev, admin-staging
Pattern: {{word}}-{{sub}}     → dev-api, staging-admin
Pattern: {{sub}}{{number}}    → api1, api2, admin01
Pattern: {{word}}.{{sub}}     → dev.api (dot insertion)
Pattern: {{sub}}.{{word}}     → api.dev
```

`-enrich` flag extracts the vocabulary *from your own seed list* — so permutations are domain-specific, not generic.

---

### Full Tool Comparison

| Tool | Strategy Coverage | Speed | Wildcard Safe | Language |
|---|---|---|---|---|
| `gotator` | 5/6 (missing sep mutation) | Fast | No (external) | Go |
| `alterx` | 6/6 via templates | Fast | No (external) | Go |
| `altdns` | 3/6 | Slow | No | Python |
| `dnsgen` | 4/6 | Medium | No | Python |
| `regulator` | 4/6 | Fast | No | Go |

**Recommendation:** Use `alterx` for generation + `puredns` for resolution. This is the current industry-standard pairing.

---

## From Passive Seeds → Complete Active Enumeration: Professional Workflow

You have your passive seeds. Here is the exact professional workflow.

---

### Step 1: Clean & Normalize Your Seed List

```bash
# Remove duplicates, normalize case, strip wildcards
cat passive_seeds.txt | tr '[:upper:]' '[:lower:]' \
                      | sed 's/^\*\.//' \
                      | sed 's/\.$//'\
                      | sort -u > seeds_clean.txt

# Verify scope — ensure all are in your target domain
grep '\.example\.com$' seeds_clean.txt > seeds_scoped.txt

echo "[+] Seed count: $(wc -l < seeds_scoped.txt)"
```

---

### Step 2: Validate Your Resolver List

```bash
# Download fresh resolvers
wget https://public-dns.info/nameservers.txt -O resolvers_raw.txt

# Validate
dnsvalidator -tL resolvers_raw.txt -threads 200 -o resolvers_valid.txt

echo "[+] Valid resolvers: $(wc -l < resolvers_valid.txt)"
# Aim for 50+
```

---

### Step 3: Verify Seeds Are Still Live

Before permuting, confirm your seeds are real. Permuting dead seeds wastes everything.

```bash
puredns resolve seeds_scoped.txt \
  --resolvers resolvers_valid.txt \
  --rate-limit 3000 \
  --wildcard-tests 10 \
  -w seeds_live.txt

echo "[+] Live seeds: $(wc -l < seeds_live.txt)"
echo "[+] Dead seeds: $(($(wc -l < seeds_scoped.txt) - $(wc -l < seeds_live.txt)))"
```

---

### Step 4: Generate Permutations with alterx

```bash
# Install alterx
go install github.com/projectdiscovery/alterx/cmd/alterx@latest

# Generate with enrichment from your own seed vocabulary
alterx -list seeds_live.txt \
       -enrich \
       -o permutations.txt

echo "[+] Permutation candidates: $(wc -l < permutations.txt)"

# Also run gotator for complementary coverage
gotator -sub seeds_live.txt \
        -perm /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \
        -depth 1 \
        -numbers 5 \
        -md \
        -prefixes >> permutations.txt

# Deduplicate
sort -u permutations.txt -o permutations_deduped.txt

# Remove any seeds you already know about
comm -23 permutations_deduped.txt seeds_live.txt > permutations_new.txt

echo "[+] Net new candidates: $(wc -l < permutations_new.txt)"
```

---

### Step 5: Resolve Permutations at Scale

```bash
puredns resolve permutations_new.txt \
  --resolvers resolvers_valid.txt \
  --rate-limit 5000 \
  --wildcard-tests 20 \
  --wildcard-batch 1000000 \
  -w resolved_permutations.txt \
  2>&1 | tee puredns_run.log

echo "[+] Resolved permutations: $(wc -l < resolved_permutations.txt)"
```

**Rate guidance:**
- Home connection: 2,000–5,000 QPS
- VPS (1Gbps): 20,000–50,000 QPS
- Dedicated server: 100,000+ QPS

---

### Step 6: Enrich with Full DNS Record Data

```bash
# Get A, CNAME, AAAA, TXT, MX records
cat resolved_permutations.txt | dnsx \
  -a -aaaa -cname -mx -txt \
  -resp \
  -threads 100 \
  -o dns_enriched.txt

# Extract just CNAMEs for takeover analysis
cat dns_enriched.txt | grep "CNAME" > cnames.txt
```

---

### Step 7: Subdomain Takeover Check

```bash
# Check CNAME targets for dangling records
cat cnames.txt | nuclei \
  -t ~/nuclei-templates/http/takeovers/ \
  -o takeovers_found.txt

# Cross-validate with subjack
subjack -w resolved_permutations.txt \
        -t 100 \
        -ssl \
        -o subjack_takeovers.txt
```

---

### Step 8: HTTP Probe & Fingerprint

```bash
cat resolved_permutations.txt | httpx \
  -title \
  -status-code \
  -tech-detect \
  -content-length \
  -follow-redirects \
  -threads 100 \
  -o http_live.txt

# Count by status code
cat http_live.txt | grep -oP '\[\d{3}\]' | sort | uniq -c | sort -rn
```

---

### Step 9: Combine All Results & Final Dedup

```bash
# Merge original seeds + newly found permutations
cat seeds_live.txt resolved_permutations.txt \
  | sort -u > all_subdomains_final.txt

echo "[+] TOTAL unique live subdomains: $(wc -l < all_subdomains_final.txt)"
```

---

### Complete Visual Workflow

```
passive_seeds.txt
      │
      ▼
[Normalize & Scope]  ──→  seeds_scoped.txt
      │
      ▼
[Resolve Seeds]  ──→  seeds_live.txt  (confirms seeds are real)
      │
      ▼
[alterx + gotator]  ──→  permutations_new.txt  (net-new candidates only)
      │
      ▼
[puredns resolve]  ──→  resolved_permutations.txt
  │ wildcard detection automatic
  │ resolver rotation automatic
      │
      ▼
[dnsx enrich]  ──→  dns_enriched.txt  (A, CNAME, TXT, MX records)
      │
      ├──→ [nuclei takeovers]  ──→  takeovers_found.txt
      │
      ▼
[httpx probe]  ──→  http_live.txt  (titles, status codes, tech stack)
      │
      ▼
all_subdomains_final.txt  ←── FINAL DELIVERABLE
```

---

### Professional Notes

- **Never permute depth > 2** unless you have dedicated server infrastructure. The output becomes unmanageable.
- **Re-run enrichment on different days** — DNS is temporal. CNAMEs that pointed to active resources today may dangle tomorrow.
- **Treat SERVFAIL differently from NXDOMAIN** — SERVFAIL may be a broken zone, worth manual investigation. NXDOMAIN is definitive non-existence.
- **Keep your raw puredns logs** — they contain timing and resolver metadata useful for debugging false negatives.
- **alterx `-enrich` is your strongest asset** — it builds permutations from *your target's own naming vocabulary*, which is infinitely more relevant than any generic wordlist.
