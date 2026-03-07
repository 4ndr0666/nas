#!/usr/bin/env python3
# 4ndr0guard Icon Assimilator
import urllib.request
import base64
from PIL import Image
import io

url = "https://raw.githubusercontent.com/4ndr0666/nas/refs/heads/main/images/cyanglassarch.png"
print(f"[*] Fetching target asset: {url}")

req = urllib.request.Request(url, headers={'User-Agent': '4NDR0666OS-Agent/1.0'})
with urllib.request.urlopen(req) as response:
    img_data = response.read()

img = Image.open(io.BytesIO(img_data)).convert("RGBA")

def synthesize_b64(size):
    resized = img.resize((size, size), Image.Resampling.LANCZOS)
    buf = io.BytesIO()
    resized.save(buf, format="PNG", optimize=True)
    return "data:image/png;base64," + base64.b64encode(buf.getvalue()).decode('utf-8')

print("\n[+] INJECT THESE DIRECTIVES INTO YOUR USERSCRIPT HEADER:")
print("-" * 80)
print(f"// @icon         {synthesize_b64(32)}")
print(f"// @icon64       {synthesize_b64(64)}")
print("-" * 80)
