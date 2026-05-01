# SVP MPV Settings

The following yield the best results when streaming on SVP using MPV:

```
referrer="https://bunkr.cr/"
user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
http-header-fields="Referer: https://bunkr.cr/","Origin: https://bunkr.cr/"
cache=yes
cache-on-disk=yes
cache-pause=no
cache-pause-initial=yes
cache-pause-wait=10
cache-secs=30
demuxer-max-bytes=1000MiB
demuxer-max-back-bytes=512MiB
demuxer-readahead-secs=30
hls-bitrate=max
hr-seek=always
hr-seek-framedrop=no
#stream-buffer-size=5MiB
#hwdec=auto-copy
```
