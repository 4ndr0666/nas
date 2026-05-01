# Bunkr Headers

## Streaming From AntiHotlinked Sites

In order to stream from bunkr the gateqay must be bypassed without triggering CORS. To do this we use a simple header pointing to the domain we came from:

**(Header Injection)** Append `|Referer=https://bunkr.cr/` to the copied .mp4 URL to bypass the hotlink block.
