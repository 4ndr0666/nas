# Jason Haddix Methodology

## Overview & Tools

### Phase 1

**Grabbing IP space from ASNs:** 

Mapping infrastructure, endpoints , cloud, hybrid-cloud

URLS: https://bgp.he.net, https://dnschecker.org, https://whois.arin.net/ui/query.do 
*  **Browser Extension (BE): Instant Data Scraper**

1. BGP: Infrastructure mapping. Use the (BE) to paste the data and export it.

2. DNS lookup: Gather hybrid/cloud infrastructure ip range

3. ARRIN: IP Enumeration (Registrars)


**Apex Domain Enumeration:**

URLS:

1. tenant-domains.sh

---

### Phase 2

**ASN to Port Scan:**

URLS: https://github.com/projectdiscovery/naabu, https://github.com/s0md3v/Smap 
* **Pkg: ASNmap**

*MassScan RustScan:* Fastest portscanner (might miss targets)

1. ASNmap: Break down ASN number in to ranges a port scanner can handle. 
>Usefull flags (-nmap-cli 'namp -sV')

2. Naabu: Streamlined port scanner.

3. Smap: Wrapper around Shodan (no api key required) query that feels like nmap. 
>No target touch port information.

### Phase 3

**Shodan:**

Passive subdomains, IP addresses, vuln data and more...

URLS: https://www.shodan.io/search?query=twitch.tv,  
* **

1. Karma v2: Shoan API wrapper that allows vuln checks with Shodan dorks.
>Still not touching target. Similar to nuclei or nessus.

2.  
