# Thunar: Custom Actions

>The following documents helpful tips, tricks and gotchas when writting custom actions for the Thunar file manager.

---

## Recent://

- **The Problem**:
This directory requires a live GVFS daemon session. If a normal script is called as a custom action, it runs a subprocess context where the GVFS session bus is either not ingerited or "recent://" is not mounted. The call failes silently `||true`, `PLAYLIST` is empty, and "no media found" fires. 

- **The Correct Approach**: 
The GTK recent files database is a plain XML file `(~/.local/share/recently-used.xbel)`. Every GTK3/4 application including Thunar writes to it directly. No daemon, no VFS, no session dependency. Parse it with `xmllint` and extract `href` attributes directly.

### **Direct XBEL Parse**: 
The GTK recently-used database `(~/.local/share/recently-used.xbel)` is a plain XML file written synchronously by every GTK3/4 app, including Thunar, with zero daemon dependency. The new pipeline:

```
xmllint --xpath '//bookmark/@href' recently-used.xbel
  → all href attributes as a space-separated string
tr ' ' '\n'
  → one href="file:///abs/path" per line
sed strip quotes + file:// scheme
  → /abs/path (still percent-encoded)
python3 urllib.parse.unquote
  → /abs/path with spaces and special chars decoded
grep -iE "$MEDIA_EXT"
  → media files only
head -n 150 | shuf
  → capped and randomised
```
Python3 is used for URL-decoding because the `sed/printf '%b'` approach from the previous revision only handles `\xNN` escape sequences — it does not handle`%20`-style percent-encoding that XBEL stores for paths with spaces. `python3 -c urllib.parse.unquote` handles the full RFC 3986 decode in one pass with no additional dependencies.

---
