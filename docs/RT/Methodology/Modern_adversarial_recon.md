# The Jason Haddix Methodology: Modern Adversarial Reconnaissance

## Overview & Execution Strategy
The goal of this methodology is continuous, cyclical, and deeply granular reconnaissance. We do not just look for subdomains; we map the entire corporate entity, its acquisitions, its cloud tenant structures, and its hidden infrastructure before ever firing a single exploit.

---

### Phase 1: Infrastructure & Apex Domain Discovery (The "Wide" Scope)

**Objective:** Map the absolute boundaries of the target. Find all ASNs, IP blocks, and Apex domains (e.g., `target.com`, `target.io`, `target-subsidiary.com`) owned by the organization.

**1. Autonomous System Number (ASN) & IP Mapping:**
To find the physical and hybrid-cloud infrastructure, we trace the network block assignments.
* **BGP Toolkit (Hurricane Electric):** Navigate to `https://bgp.he.net`. Search the target company name.
    * **Use Case:** Identifies large IP prefixes (IPv4/IPv6) announced by the company's ASN. 
    * **Execution:** Use the **Instant Data Scraper** browser extension on the "Prefixes v4" tab to seamlessly extract the raw CIDR ranges into a `.csv` or `.txt` file (`target_cidrs.txt`).
* **ARIN / RIPE Whois:** Regional registries for address space.
    * **Execution:** Query `https://whois.arin.net/ui/query.do` using the target's corporate LLC names to find unadvertised or privately held IP ranges.
* **CLI Automation (Amass):**
    * `amass intel -org "Target Company Name" -max-dns-queries 2500 | tee target_asns.txt`

**2. Apex Domain Enumeration (Acquisitions & Reverse WHOIS):**
* **Pitchbook / Crunchbase:** Search for `Target Company` to find all corporate acquisitions. Treat subsidiaries as in-scope apex domains.
* **Reverse WHOIS (Whoxy):** Find all domains registered to the same corporate email or organization string.
* **Cloud Tenant Enumeration (`tenant-domains.sh`):**
    * **Use Case:** Microsoft 365 / Azure tenant IDs often leak associated domains. 
    * **Execution:** Run the script against a known target domain to extract all other domains federated under that same Azure tenant.
    * `tenant-domains.sh target.com | sort -u > apex_domains.txt`

---

### Phase 2: ASN & IP Range to Port Scan

**Objective:** Convert the massive, raw IP ranges gathered in Phase 1 into actionable, alive targets with specific listening services, prioritizing speed and OPSEC.

**1. IP Range Processing:**
* **ASNmap (ProjectDiscovery):** Takes the raw ASNs and converts them into normalized CIDR ranges that port scanners can digest.
    * **Command:** `echo "AS12345" | asnmap -silent > target_ips.txt`

**2. High-Speed Port Scanning:**
* **Masscan / RustScan:** The tools of choice for blindly scanning massive `/16` or `/8` subnet ranges. Use this to identify living IPs before detailed fingerprinting.
    * **RustScan Command:** `rustscan -a target_ips.txt --ulimit 5000 -- -sV -sC -oA rustscan_out`
* **Naabu:** A highly reliable, streamlined port scanner written in Go. Ideal for piping into web-probing tools.
    * **Command:** `naabu -list target_ips.txt -top-ports 1000 -c 50 -rate 3000 -silent -o active_ports.txt`

**3. Passive Port Scanning (Zero-Touch):**
* **Smap:** A drop-in replacement/wrapper for Nmap that queries Shodan's API *instead* of touching the target directly.
    * **Use Case:** When you need stealth, Smap acts exactly like Nmap but pulls historical port data from Shodan. No API key is required.
    * **Command:** `smap -iL target_ips.txt -oG smap_output.txt`

---

### Phase 3: Shodan, Cloud Exposures, & SSL Recon

**Objective:** Discover unlinked, cloud-hosted, or ephemeral assets by scraping global scanning data, Certificate Transparency, and IoT search engines.

**1. Advanced Shodan Profiling:**
* **Karma v2 / WTFIS:** Automated API wrappers that leverage Shodan dorks to pull passive vulnerability checks and endpoint data without touching the target.
* **Shodan Dorking:** Search by favicon hash, SSL hash, or org name to find dev servers. 
    * `ssl:"Target Company"`, `org:"Target Company"`, `http.favicon.hash:123456789`

**2. Cloud Recon via SSL Certificates:**
Hidden cloud assets often leak the target's name in the `Subject Alternative Name` (SAN) or `Common Name` (CN) fields of their SSL certificates.
* **Caduceus:** A custom SSL scanner designed to rip certificate metadata from raw IP ranges on port 443.
    * **Execution:** Pipe your Phase 1 IP lists directly into Caduceus to find hidden cloud hosts.
    * `cat target_ips.txt | caduceus -a -c 1000 -o target_certs.json`
    * `cat target_certs.json | jq -r '.subject_alt_names[]?' | grep -i "targetdomain" | sort -u >> apex_domains.txt`
* **Kaeferjaeger.gay Data Parsing:**
    * **Use Case:** Kaeferjaeger provides massive, globally scanned `.txt` files of cloud infrastructure (AWS, GCP, Azure).
    * **Execution:** Download the specific cloud provider files (`ipv4_merged_sni.txt`). You must parse these correctly to extract the target domains hidden within the pipe-delimited data.
    * `curl -s "https://kaeferjaeger.gay/?dir=sni-ip-ranges/amazon/ipv4_merged_sni.txt" | grep -iE "\.targetdomain\.com|targetdomain\.com" | awk -F' \\| ' '{print $2}' | tr ',' '\n' | sed -e 's/^[ \t]*//' -e 's/\[//g' -e 's/\]//g' -e 's/"//g' | grep -iE "targetdomain\.com" | sort -u > target_cloud_domains.txt`

---

### Phase 4: Deep Subdomain Enumeration (The "Subdo" Phase)

**Objective:** Horizontal and vertical expansion using the apex domains found in Phases 1-3.

**1. Passive Subdomain Scraping:**
* **Subfinder:** High-speed passive discovery using APIs and OSINT. 
    * `subfinder -dL apex_domains.txt -all -silent -o subfinder_out.txt`
* **Amass:** Deep, recursive graph-based asset discovery. 
    * `amass enum -passive -df apex_domains.txt -config ~/.config/amass/config.ini -o amass_out.txt`

**2. Certificate Transparency (CT) Logs:**
* **Crt.sh:** Pull historical CT logs. 
    * `curl -s "https://crt.sh/?q=%25.target.com&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u >> ct_subs.txt`

**3. Active Subdomain Bruteforcing:**
* **Puredns:** Ridiculously fast domain resolver and bruteforcing tool. Relies on fresh public resolvers.
    * **Wordlists:** Use Assetnote's `best-dns-wordlist.txt` or `commonspeak2`.
    * `puredns bruteforce best-dns-wordlist.txt target.com -r valid_resolvers.txt -w puredns_brute.txt`

**4. Permutation / Alteration Scanning:**
* **Gotator / Ripgen:** Generate permutations (e.g., `dev-target.com`, `target-stg.com`) from valid subdomains to find hidden staging environments.
    * `gotator -sub known_subs.txt -perm permutations_list.txt -depth 1 -silent | puredns resolve -r valid_resolvers.txt > altered_subs.txt`

---

### Phase 5: Web Probing & Technology Fingerprinting

**Objective:** Move from resolving hosts/IPs to finding the actual web applications, status codes, and underlying technology stacks.

**1. Web Service Identification:**
* **Httpx:** The essential bridge between network ports and web applications. It filters out dead DNS records and identifies active HTTP/HTTPS services.
    * **Execution:** Feed the master list of all resolved subdomains and active IPs into httpx.
    * `cat all_resolved_targets.txt | httpx -sc -td -title -tech-detect -follow-redirects -silent -o httpx_alive.txt`

**2. Visual Reconnaissance:**
* **Gowitness / Eyewitness:** Feed the `httpx_alive.txt` output into a headless browser automation tool to rapidly visually parse for Admin panels, Jenkins instances, or default installations.
    * `gowitness file -f httpx_alive.txt -t 10`

**3. Application Profiling (Nuclei & Wappalyzer):**
* Feed the live URLs into **Nuclei** using strictly the `technologies/` and `misconfiguration/` templates to identify the exact stack and known default credential portals before attempting deeper web exploitation.
    * `nuclei -l httpx_alive.txt -t technologies/ -o tech_stack.txt`

!P
