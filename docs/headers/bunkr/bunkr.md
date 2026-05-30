# Bunkr Core Architecture & Stream Engineering

An enterprise-grade analysis and configuration matrix detailing the platform's multi-tiered edge security, spatial-temporal cryptographic signatures, and programmatic streaming pipeline overrides.

---

## 1. Architectural Anatomy & Token Mechanics

The platform relies on a distributed CDN routing layer controlled by anti-hotlinking edge engines. To successfully bypass gateway barriers and authorize external streams without precipitating CORS exceptions or explicit block states, two discrete mechanics must be aligned.

### The Temporal XOR Encryption Loop
Platform stream lookups (`/api/vs`) validate transactions using a localized cryptographic shift. If an encrypted asset payload is returned, the layout expects an immediate, byte-aligned XOR decryption matrix:
* **The Seed**: A computed parameter derived directly from the application transaction state.
* **The Shift Key**: Generated dynamically by appending the hourly execution segment to a protected baseline identifier string:
  $$\text{Key} = \text{"SECRET\_KEY\_"} + \lfloor\frac{\text{data.timestamp}}{3600}\rfloor$$
* **The Operation**: An array iteration mapping `data.url` character codes against the rotating shift key block to normalize the underlying media string.

### The Spatial Content ID Paradox (Slug vs. UUID)
A structural decoupling exists between front-facing presentation pages and edge storage engines:
1. **The Routing Slug**: The alphanumeric token present in the public URL matching standard navigation blocks (e.g., `eH2x75mqlFhkk`). This is strictly a front-end router alias and is completely un-recognized by core stream infrastructure.
2. **The Media UUID**: A native 128-bit structural block identifier (e.g., `227a859b-6de0-436c-8811-55bed9632064`). The edge token engine (`/sign`) *only* validates signatures requested directly against raw asset paths containing this structural identity. 
3. **Programmatic Capture**: When lazy loading or dynamic scripts obstruct DOM evaluation, this structural token is consistently exposed inside the site's OpenGraph image metadata node:
   ```html
   <meta property="og:image" content="[https://static.scdn.st/.../thumbs/](https://static.scdn.st/.../thumbs/)[MEDIA_UUID].png">

```

---

## 2. The Granular Referrer Enforcement Rule

### The Fallacy of the Pipe (`|`) Appended String

Historically, appending `|Referer=https://bunkr.cr/` onto a media file string worked inside downstream software architectures containing specific regex header-splitting intercept layers (e.g., certain legacy plugins or custom media pipelines).

**This is fundamentally invalid for modern core web applications and raw streaming configurations for two reasons:**

* **Non-Standard Addressing:** The pipe syntax is structurally broken. Passing it directly to standard HTTP engines or standard Unix command-line utilities causes a structural syntax error or `400 Bad Request` because the application evaluates the appended text as part of the domain destination string.
* **Cryptographic Hotlink Block:** Even if an utility parses the append block and updates the request header field to `Referer: https://bunkr.cr/`, **the stream will still fail to initialize.**

### The Explicit Path Match Principle

The platform's token signature verification routines evaluate hotlinks matching the **exact specific page URL location address** rather than the broad root origin domain.

```
❌ REJECTED BASE ORIGIN:
Referer: [https://bunkr.cr/](https://bunkr.cr/)

▲ Result: Token authentication failure. Edge throws HTTP Error / dropping stream chunks.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CRITICALLY REQUIRED FULL PATH:
Referer: [https://bunkr.cr/v/](https://bunkr.cr/v/)[URL_SLUG]  (or /a/[ALBUM_ID] for collection loops)

▲ Result: Token cryptographic checks evaluate successfully. Asset pipeline opens for transit.

```

---

## 3. Production Hardened MPV Media Player Profile

To streaming raw signed `.mp4` chunks directly via native media instances, any global, static root referrers inside your config file must be stripped. The player must be supplied with explicit context parameters directly matching the source transaction signature.

Place the following configuration inside your production `mpv.conf` profile:

```ini
# =========================================================================
# SYSTEM HEADERS & EMULATED USER ENVIRONMENT
# =========================================================================
user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

# Overrides default cross-origin destination filtering
http-header-fields="Origin: [https://bunkr.cr](https://bunkr.cr)"

# Note: NEVER define a static "referrer=" inside this configuration.
# The referrer path string must change dynamically to match the current URL slug.

# =========================================================================
# HARDENED BUFFERING & DEMUXER LOOKAHEAD (PREVENTS PIPELINE TIMEOUTS)
# =========================================================================
cache=yes

# Enforce aggressive RAM-based caching over localized storage allocations
cache-on-disk=no
cache-pause=no
cache-pause-initial=no

# Prevent mpv from stalling under sudden cross-site network variance
cache-pause-wait=5

# Expand lookahead constraints significantly for high-bitrate media files
cache-secs=300
demuxer-max-bytes=1000MiB
demuxer-max-back-bytes=256MiB
demuxer-readahead-secs=300

# =========================================================================
# RENDERING OPTIMIZATION
# =========================================================================
hls-bitrate=max
hr-seek=always
hr-seek-framedrop=no
hwdec=auto-safe

```

### Scripted Operational Invocation

When pushing a stream from an external environment or browser worker context, you must explicitly bind the complete layout path via the terminal command switch:

```bash
mpv "[https://c4s9-b.cdn.cr/storage/media/](https://c4s9-b.cdn.cr/storage/media/)[MEDIA_UUID].mp4?token=[GENERATED_TOKEN]&ex=[TIMESTAMP]" --referrer="[https://bunkr.cr/v/](https://bunkr.cr/v/)[URL_SLUG]"

```
