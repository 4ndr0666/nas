# FFmpeg Encoding and Editing Course

---

## Container Formats

Containers contain media data. Typical examples:

   - MP4: MPEG-4 Part 14 container for H.264, H.264, AAC audio, …
   - MKV: Versatile container for any media format
   - WebM: Subset of MKV, usage in Web streaming
   - AVI: Legacy container

See supported containers with:
bash
$ ffmpeg -formats
File formats:
 D. = Demuxing supported
 .E = Muxing supported
 --
 D  3dostr          3DO STR
  E 3g2             3GP2 (3GPP2 file format)
  E 3gp             3GP (3GPP file format)
 D  4xm             4X Technologies
  E a64             a64 - video for Commodore 64
 D  aa              Audible AA format files
Container Formats Containers contain media data. Typical examples: MP4: MPEG-4 Part 14
container for H.264, H.264, AAC audio, … MKV: Versatile container for any media format WebM:
Subset of MKV, usage in Web streaming AVI: Legacy container See supported containers with: $
ffmpeg -formats File formats: D. = Demuxing supported .E = Muxing supported -- D 3dostr 3DO
STR E 3g2 3GP2 (3GPP2 file format) E 3gp 3GP (3GPP file format) D 4xm 4X Technologies E
a64 a64 - video for Commodore 64 D aa Audible AA format files ...

---

## Codecs

   - CODEC = Coder / Decoder
   - Specification on how to code and decode video, audio, …
   - Usually not a specification on how to encode / compress data
   - Sometimes “codec” == actual encoding/decoding software

See supported codecs with:
bash
$ ffmpeg -codecs
Codecs:
 D..... = Decoding supported
 .E.... = Encoding supported
 ..V... = Video codec
 ..A... = Audio codec
 ..S... = Subtitle codec
 ...I.. = Intra frame-only codec
 ....L. = Lossy compression
 .....S = Lossless compression
 -------
 D.VI.. 012v                 Uncompressed 4:2:2 10-bit
 D.V.L. 4xm                  4X Movie
 D.VI.S 8bps                 QuickTime 8BPS video
 .EVIL. a64_multi            Multicolor charset for Commodore 64 (encoders: a64multi )
 .EVIL. a64_multi5           Multicolor charset for Commodore 64, extended with 5th color (colram) (encoders: a64multi5 )
 D.V..S aasc                 Autodesk RLE
 D.VIL. aic                  Apple Intermediate Codec
Codecs CODEC = Coder / Decoder Specification on how to code and decode video, audio, …
Usually not a specification on how to encode / compress data Sometimes “codec” == actual
encoding/decoding software See supported codecs with: $ ffmpeg -codecs Codecs: D..... =
Decoding supported .E.... = Encoding supported ..V... = Video codec ..A... = Audio codec ..S... =
Subtitle codec ...I.. = Intra frame-only codec ....L. = Lossy compression .....S = Lossless
compression ------- D.VI.. 012v Uncompressed 4:2:2 10-bit D.V.L. 4xm 4X Movie D.VI.S 8bps
QuickTime 8BPS video .EVIL. a64_multi Multicolor charset for Commodore 64 (encoders:
a64multi ) .EVIL. a64_multi5 Multicolor charset for Commodore 64, extended with 5th color
(colram) (encoders: a64multi5 ) D.V..S aasc Autodesk RLE D.VIL. aic Apple Intermediate Codec

---

## Most Important (Lossy) Codecs

Currently mostly used, standardized by ITU/ISO:

   - 🎥 H.262 / MPEG-2 Part H: Broadcasting, TV, used for backwards compatibility
   - 🎥 H.264 / MPEG-4 Part 10: The de-facto standard for video encoding today
   - 🎥 H.265 / HEVC / MPEG-H: Successor of H.264, up to 50% better quality
   - 🔊 MP3 / MPEG-2 Audio Layer III: Used to be the de-facto audio coding standard
   - 🔊 AAC / ISO/IEC 14496-3:2009: Advanced Audio Coding standard

Competitors that are royalty-free:

   - 🎥 VP8: Free, open-source codec from Google (not so much in use anymore)
   - 🎥 VP9: Successor to VP8, almost as good as H.265
   - 🎥 AV1: A successor to VP9, claims to be better than H.265


Most Important (Lossy) Codecs Currently mostly used, standardized by ITU/ISO: 🎥 H.262 /
MPEG-2 Part H: Broadcasting, TV, used for backwards compatibility 🎥 H.264 / MPEG-4 Part 10:
The de-facto standard for video encoding today 🎥 H.265 / HEVC / MPEG-H: Successor of
H.264, up to 50% better quality 🔊 MP3 / MPEG-2 Audio Layer III: Used to be the de-facto audio
coding standard 🔊 AAC / ISO/IEC 14496-3:2009: Advanced Audio Coding standard Competitors
that are royalty-free: 🎥 VP8: Free, open-source codec from Google (not so much in use
anymore) 🎥 VP9: Successor to VP8, almost as good as H.265 🎥 AV1: A successor to VP9,
claims to be better than H.265

---

## Most Important Lossless Codecs

Lossless codecs are useful for archival, editing, ...

Lossless = no compression artifacts at lower file size

   - 🎥 Raw YUV, HuffYUV, FFV1, ffvhuff …
   - 🔊 Raw PCM, FLAC, ALAC, …

Also, "visually lossless" codecs exist:

   - 🎥 Apple ProRes, Avid DNxHD, JPEG2000, high-quality H.264/H.265, ...
   - High bitrate and usually only I-frames


Most Important Lossless Codecs Lossless codecs are useful for archival, editing, ... Lossless = no
compression artifacts at lower file size 🎥 Raw YUV, HuffYUV, FFV1, ffvhuff … 🔊 Raw PCM,
FLAC, ALAC, … Also, "visually lossless" codecs exist: 🎥 Apple ProRes, Avid DNxHD,
JPEG2000, high-quality H.264/H.265, ... High bitrate and usually only I-frames

---

## Encoders

   - Encoders are the actual software that outputs a codec-compliant bitstream
   - Encoders can vary in quality and performance, some are better than others (and some are free, some are not)

Examples:

   - 🎥 libx264: most popular free and open-source H.264 encoder
   - 🎥 NVENC: NVIDIA GPU-based H.264 encoder
   - 🎥 libx265: free and open-source HEVC encoder
   - 🎥 libvpx: VP8 and VP9 encoder from Google
   - 🎥 libaom: AV1 encoder
   - 🔊 libfdk-aac: AAC encoder
   - 🔊 aac: native FFmpeg AAC encoder

Encoders Encoders are the actual software that outputs a codec-compliant bitstream Encoders
can vary in quality and performance, some are better than others (and some are
free, some are not) Examples: 🎥 libx264: most popular free and open-source H.264 encoder 🎥 NVENC:
NVIDIA GPU-based H.264 encoder 🎥 libx265: free and open-source HEVC encoder 🎥 libvpx:
VP8 and VP9 encoder from Google 🎥 libaom: AV1 encoder 🔊 libfdk-aac: AAC encoder 🔊 aac:
native FFmpeg AAC encoder … → lots of competition

---

## Encoders supported in FFmpeg
bash
$ ffmpeg -encoders
Encoders:
 V..... = Video
 A..... = Audio
 S..... = Subtitle
 .F.... = Frame-level multithreading
 ..S... = Slice-level multithreading
 ...X.. = Codec is experimental
 ....B. = Supports draw_horiz_band
 .....D = Supports direct rendering method 1
 ------
 V..... a64multi             Multicolor charset for Commodore 64 (codec a64_multi)
 V..... a64multi5            Multicolor charset for Commodore 64, extended with 5th color (colram) (codec a64_multi5)
 V..... alias_pix            Alias/Wavefront PIX image
Encoders supported in FFmpeg $ ffmpeg -encoders Encoders: V..... = Video A..... = Audio S..... =
Subtitle .F.... = Frame-level multithreading ..S... = Slice-level multithreading ...X.. = Codec is
experimental ....B. = Supports draw_horiz_band .....D = Supports direct rendering method 1 ------
V..... a64multi Multicolor charset for Commodore 64 (codec a64_multi) V..... a64multi5 Multicolor
charset for Commodore 64, extended with 5th color (colram) (codec a64_multi5) V..... alias_pix
Alias/Wavefront PIX image ...

---

## Pixel Formats

   - Representation of raw pixels in video streams
   - Specifies order of luma/color components and chroma subsampling

[ Image Source: Wikipedia ]

Supported pixel formats: ffmpeg -pix_fmts

Pixel Formats Representation of raw pixels in video streams Specifies order of luma/color
components and chroma subsampling Image Source: Wikipedia Supported pixel formats: ffmpeg
-pix_fmts

---

## Transcoding and Transmuxing

Transcoding from one codec to another (e.g. H.264 using libx264):
bash
ffmpeg -i <input> -c:v libx264 output.mp4
Transmuxing from one container/format to another – without re-encoding:
bash
ffmpeg -i input.mp4 -c copy output.mkv
ffmpeg will take one video, audio, and subtitle stream from the input and map it to the output.

Explanation:

   - -c sets the encoder (see ffmpeg -encoders)
   - -c copy only copies bitstream
   - -c:v sets only video encoders
   - -c:a sets only audio encoders
   - -an and -vn would disable audio or video streams

Transcoding and Transmuxing Transcoding from one codec to another (e.g. H.264 using libx264):
ffmpeg -i <input> -c:v libx264 output.mp4 Transmuxing from one container/format to another –
without re-encoding: ffmpeg -i input.mp4 -c copy output.mkv ffmpeg will take one video, audio,
and subtitle stream from the input and map it to the output. Explanation: -c sets the encoder (see
ffmpeg -encoders) -c copy only copies bitstream -c:v sets only video encoders -c:a sets only
audio encoders -an and -vn would disable audio or video streams

---

## Seeking and Cutting

Cut a video from timestamp <start> for <duration>, or until <end>:
bash
ffmpeg -ss <start> -i <input> -t <duration> -c copy <output>
ffmpeg -ss <start> -i <input> -to <end> -c copy <output>
Examples:
bash
ffmpeg -ss 00:01:50 -i <input> -t 10.5 -c copy <output>
ffmpeg -ss 2.5 -i <input> -to 10 -c copy <output>
Seeking and Cutting Cut a video from timestamp <start> for <duration>, or until <end>: ffmpeg -ss
<start> -i <input> -t <duration> -c copy <output> ffmpeg -ss <start> -i <input> -to <end> -c copy
<output> Examples: ffmpeg -ss 00:01:50 -i <input> -t 10.5 -c copy <output> ffmpeg -ss 2.5 -i
<input> -to 10 -c copy <output>

---

## Setting Quality

   - The output quality depends on encoder defaults and the source material
   - Do not just encode without setting any quality level!
   - Generally: You need to choose a target bitrate or quality level
   - Target bitrate depends on the video genre, size and framerate


Setting Quality The output quality depends on encoder defaults and the source material Do not
just encode without setting any quality level! Generally: You need to choose a target bitrate or
quality level Target bitrate depends on the video genre, size and framerate

---

## Options for Setting Quality

Possible options (just examples):

   - -b:v or -b:a to set bitrate
      * e.g., -b:v 1000K = 1000 kbit/s, -b:v 8M = 8 Mbit/s
   - -q:v or -q:a to set fixed-quality parameter
      * e.g., -q:a 2 for native AAC encoder

Examples of encoder-specific options:

   - -crf to set Constant Rate Factor for libx264/libx265
   - -vbr to set constant quality for FDK-AAC encoder
   - Many many more; see e.g. ffmpeg -h encoder=libx264 for examples


Options for Setting Quality Possible options (just examples): -b:v or -b:a to set bitrate e.g., -b:v
1000K = 1000 kbit/s, -b:v 8M = 8 Mbit/s -q:v or -q:a to set fixed-quality parameter e.g., -q:a 2 for
native AAC encoder Examples of encoder-specific options: -crf to set Constant Rate Factor for
libx264/libx265 -vbr to set constant quality for FDK-AAC encoder Many many more; see e.g.
ffmpeg -h encoder=libx264 for examples

---

## Example: Transcoding to H.264, pt. 1

Constant quality (CRF) encoding:
bash
ffmpeg -i <input> -c:v libx264 -crf 23 -c:a aac -b:a 128k output.mkv
For H.264, CRF between 18 and 28 looks "good", lower is better. (Different CRF for HEVC and
VP9.)

## Example: Transcoding to H.264, pt. 2

Two-pass encoding:
bash
ffmpeg -y -i <input> -c:v libx264 -b:v 8M -pass 1 -c:a aac -b:a 128k -f mp4 /dev/null
ffmpeg -i <input> -c:v libx264 -b:v 8M -pass 2 -c:a aac -b:a 128k output.mp4
See https://trac.ffmpeg.org/wiki/Encode/H.264

Example: Transcoding to H.264, pt. 1 Constant quality (CRF) encoding: ffmpeg -i <input> -c:v
libx264 -crf 23 -c:a aac -b:a 128k output.mkv For H.264, CRF between 18 and 28 looks "good",
lower is better. (Different CRF for HEVC and VP9.) Example: Transcoding to H.264, pt. 2 Two-
pass encoding: ffmpeg -y -i <input> -c:v libx264 -b:v 8M -pass 1 -c:a aac -b:a 128k -f mp4
/dev/null ffmpeg -i <input> -c:v libx264 -b:v 8M -pass 2 -c:a aac -b:a 128k output.mp4
See https://trac.ffmpeg.org/wiki/Encode/H.264

---

## Rate Control

Different kinds of rate control:

   - Constant Bitrate (CBR)
   - Variable Bitrate (VBR)
      * Average bitrate (ABR)
      * Constant quantization parameter (CQP)
      * Constant quality, based on psychovisual properties, e.g. CRF in x264/x265/libvpx-vp9
      * Constrained bitrate (VBV)

Which rate control to use for which case? More info: https://slhck.info/video/2017/03/01/rate-
control.html

Important: Rate depends on content characteristics!


Rate Control Different kinds of rate control: Constant Bitrate (CBR) Variable Bitrate (VBR)
Average bitrate (ABR) Constant quantization parameter (CQP) Constant quality, based on
psychovisual properties, e.g. CRF in x264/x265/libvpx-vp9 Constrained bitrate (VBV) Which rate
control to use for which case? More info: https://slhck.info/video/2017/03/01/rate-control.html
Important: Rate depends on content characteristics!

---

## Speed/Quality Presets in x264

Choose the encoding speed for libx264 with the preset option:
bash
ffmpeg -i <input> -c:v libx264 -crf 23 -preset ultrafast -an output.mkv
ffmpeg -i <input> -c:v libx264 -crf 23 -preset medium -an output.mkv
ffmpeg -i <input> -c:v libx264 -crf 23 -preset veryslow -an output.mkv
All presets: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower,
veryslow

Example results (all have the same quality!):

**Preset**	**Encoding Time**	**File Size**
ultrafast	4.85s			15M
medium		24.13s			5.2M
veryslow	112.23s			4.9M

Speed/Quality Presets in x264 Choose the encoding speed for libx264 with the preset option:
ffmpeg -i <input> -c:v libx264 -crf 23 -preset ultrafast -an output.mkv ffmpeg -i <input> -c:v libx264
-crf 23 -preset medium -an output.mkv ffmpeg -i <input> -c:v libx264 -crf 23 -preset veryslow -an
output.mkv All presets: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow
Example results (all have the same quality!): Preset Encoding Time File Size ultrafast 4.85s 15M
medium 24.13s 5.2M veryslow 112.23s 4.9M

---

## Changing Framerate

Simple way to change the framerate by dropping or duplicating frames:
bash
ffmpeg -i <input> -r 24 <output>
More complex ways involve filtering, see fps, mpdecimate, minterpolate filters:
bash
ffmpeg -i <input> -filter:v fps=24 <output>
Changing Framerate Simple way to change the framerate by dropping or duplicating frames:
ffmpeg -i <input> -r 24 <output> More complex ways involve filtering, see fps, mpdecimate,
minterpolate filters: ffmpeg -i <input> -filter:v fps=24 <output>

---

## Stream Mapping

Each file and its streams have a unique ID, starting with 0.

Examples:

   - 0:0 is the first stream of the first input file
   - 0:1 is the second stream of the first input file
   - 2:a:0 is the first audio stream of the third input file

You can map input streams to output, e.g. to add audio to a video:
bash
ffmpeg -i input.mp4 -i input.m4a -c copy -map 0:v:0 -map 1:a:0 output.mp4
See: http://trac.ffmpeg.org/wiki/Map

Stream Mapping Each file and its streams have a unique ID, starting with 0. Examples: 0:0 is the
first stream of the first input file 0:1 is the second stream of the first input file 2:a:0 is the first audio
stream of the third input file … You can map input streams to output, e.g. to add audio to a video:
ffmpeg -i input.mp4 -i input.m4a -c copy -map 0:v:0 -map 1:a:0 output.mp4 See:
http://trac.ffmpeg.org/wiki/Map

---

## Scaling

Scale to 320×240:
bash
ffmpeg -i <input> -vf "scale=w=320:h=240" <output>
Scale to a height of 240 and keep aspect ratio divisible by 2:
bash
ffmpeg -i <input> -vf scale=w=-2:h=240 <output>
Scale to 1280×720 or smaller if needed:
bash
ffmpeg -i <input> -vf "scale=1280:720:force_original_aspect_ratio=decrease" <output>
More tips:

   - http://trac.ffmpeg.org/wiki/Scaling%20(resizing)%20with%20ffmpeg
   - https://superuser.com/questions/547296/

Scaling Scale to 320×240: ffmpeg -i <input> -vf "scale=w=320:h=240" <output> Scale to a height
of 240 and keep aspect ratio divisible by 2: ffmpeg -i <input> -vf scale=w=-2:h=240 <output>
Scale to 1280×720 or smaller if needed: ffmpeg -i <input> -vf
"scale=1280:720:force_original_aspect_ratio=decrease" <output> More tips:
http://trac.ffmpeg.org/wiki/Scaling%20(resizing)%20with%20ffmpeg
https://superuser.com/questions/547296/

---

## Padding

Add black borders to a file, e.g. 1920×800 input to 1920×1080:
bash
ffmpeg -i <input> -vf "pad=1920:1080:(ow-iw)/2:(oh-ih)/2" <output>
[ Image Here ]

Note that:

   - You can use mathematical expressions
   - ow and oh are output width and height
   - iw and ih are input width and height

Padding Add black borders to a file, e.g. 1920×800 input to 1920×1080: ffmpeg -i <input> -vf
"pad=1920:1080:(ow-iw)/2:(oh-ih)/2" <output> Note that: You can use mathematical expressions
ow and oh are output width and height iw and ih are input width and height

---

## Fading

Simple fade-in and fade-out at a specific time for a specific duration.
bash
ffmpeg -i <input> -filter:v \
  "fade=t=in:st=0:d=5,fade=t=out:st=30:d=5" \
  <output>
  
- t sets the fade type (in or out), d sets the duration
   - st sets the start time in seconds or HH:MM:SS.msec
   - ffmpeg can't "search from the back"; you have to find the total duration yourself (e.g. with ffprobe)
   - See https://ffmpeg.org/ffmpeg-filters.html#fade

Fading Simple fade-in and fade-out at a specific time for a specific duration. ffmpeg -i <input>
-filter:v \ "fade=t=in:st=0:d=5,fade=t=out:st=30:d=5" \ <output>

---

## Drawing Text

Complex system for printing text on video:
bash
ffmpeg -i <input> -vf \
drawtext="text='Test Text':x=100:y=50:\
fontsize=24:fontcolor=yellow:box=1:boxcolor=red" \
<output>
- Various options related to font family, size, position, color, …
   - Text expansion (burn in frame number or timecode)

See: http://ffmpeg.org/ffmpeg-all.html#drawtext-1


Drawing Text Complex system for printing text on video: ffmpeg -i <input> -vf \
drawtext="text='Test Text':x=100:y=50:\ fontsize=24:fontcolor=yellow:box=1:boxcolor=red" \
<output> Various options related to font family, size, position, color, … Text expansion (burn in
frame number or timecode) See: http://ffmpeg.org/ffmpeg-all.html#drawtext-1

---

## Complex Filtering

Complex filters have more than one in- and/or output:
bash
ffmpeg -i <input1> -i <input2> -filter_complex \
    "[0:v:0][1:v:0]overlay[outv]" \
    -map "[outv]" <output>
**Steps**:

   - Specify inputs to filterchain (e.g. [0:v:0][1:v:0])
   - Specify filters in the chain (e.g. overlay)
   - Specify output labels of chain (e.g. [outv])
   - Map output labels to final output file
   - You can have multiple filterchains with ;

See: http://ffmpeg.org/ffmpeg-all.html#Filtergraph-syntax-1


Complex Filtering Complex filters have more than one in- and/or output: ffmpeg -i <input1> -i
<input2> -filter_complex \ "[0:v:0][1:v:0]overlay[outv]" \ -map "[outv]" <output> Steps: Specify
inputs to filterchain (e.g. [0:v:0][1:v:0]) Specify filters in the chain (e.g. overlay) Specify output
labels of chain (e.g. [outv]) Map output labels to final output file You can have multiple filterchains
with ; See: http://ffmpeg.org/ffmpeg-all.html#Filtergraph-syntax-1

---

## Concatenating Streams

Decode three video/audio streams and append to one another:

[ Image Here ]
bash
ffmpeg -i <input1> -i <input2> -i <input3> -filter_complex \
    "[0:0][0:1][1:0][1:1][2:0][2:1]concat=n=3:v=1:a=1[outv][outa]" \
    -map "[outv]" -map "[outa]" <output>
See: http://trac.ffmpeg.org/wiki/Concatenate (also for other methods)


Concatenating Streams Decode three video/audio streams and append to one another: ffmpeg -i
<input1> -i <input2> -i <input3> -filter_complex \ "[0:0][0:1][1:0][1:1][2:0]
[2:1]concat=n=3:v=1:a=1[outv][outa]" \ -map "[outv]" -map "[outa]" <output> See:
http://trac.ffmpeg.org/wiki/Concatenate (also for other methods)

---

## Timeline Editing

Enable filters only at a specific point in time.

Example:

   - Show a watermark in the top left corner
   - Between seconds 1 and 2 only
bash
ffmpeg -i <video> -i <watermark> -filter_complex \
    "[0:v][1:v]overlay=10:10:enable='between(t,1,2)'[outv]" \
    -map "[outv]" <output>
See: http://ffmpeg.org/ffmpeg-all.html#Timeline-editing


Timeline Editing Enable filters only at a specific point in time. Example: Show a watermark in the
top left corner Between seconds 1 and 2 only ffmpeg -i <video> -i <watermark> -filter_complex \ "
[0:v][1:v]overlay=10:10:enable='between(t,1,2)'[outv]" \ -map "[outv]" <output> See:
http://ffmpeg.org/ffmpeg-all.html#Timeline-editing

---

## Calculating Simple Quality Metrics

PSNR (Peak Signal To Noise Ratio):
bash
$ ffmpeg -i <degraded> -i <reference> -filter_complex psnr -f null
/dev/null
[Parsed_psnr_0 @ 0x7fdb187045c0] PSNR y:33.437789 u:39.814416
v:39.319141 average:34.698320 min:29.305186 max:inf
SSIM (Structural Similarity):
bash
$ ffmpeg -i <degraded> -i <reference> -filter_complex ssim -f null
/dev/null
[Parsed_ssim_0 @ 0x7fbf0500b660] SSIM Y:0.925477 (11.277116)
U:0.948906 (12.916325) V:0.946795 (12.740513) All:0.932935 (11.735054)
- Optionally add: 2>&1 | grep SSIM to filter only relevant output
   - PSNR is an unreliable and inaccurate quality metric, SSIM is better but not perfect
   - Try to use "proper" video quality metrics instead, e.g. VQM or VMAF

Calculating Simple Quality Metrics PSNR (Peak Signal To Noise Ratio): $ ffmpeg -i <degraded> -i
<reference> -filter_complex psnr -f null /dev/null [Parsed_psnr_0 @ 0x7fdb187045c0] PSNR
y:33.437789 u:39.814416 v:39.319141 average:34.698320 min:29.305186 max:inf SSIM
(Structural Similarity): $ ffmpeg -i <degraded> -i <reference> -filter_complex ssim -f null /dev/null
[Parsed_ssim_0 @ 0x7fbf0500b660] SSIM Y:0.925477 (11.277116) U:0.948906 (12.916325)
V:0.946795 (12.740513) All:0.932935 (11.735054)

---

# FFPROBE

## Practical ffprobe Examples Pt. 1

Show all available streams:
bash
ffprobe <input> -show_streams
Show info on video stream:
bash
ffprobe <input> -select_streams v -show_format
Show presentation timestamp and frame type of every frame, in CSV
format (p=0 disables CSV section headers)
bash
ffprobe <input> -select_streams v -show_frames \
-show_entries frame=pkt_pts_time,pict_type -of csv=p=0
Practical ffprobe Examples Pt. 1 Show all available streams: ffprobe <input> -show_streams
Show info on video stream: ffprobe <input> -select_streams v -show_format Show presentation
timestamp and frame type of every frame, in CSV format (p=0 disables CSV section headers)
ffprobe <input> -select_streams v -show_frames \ -show_entries frame=pkt_pts_time,pict_type -of
csv=p=0

---

## Practical ffprobe Examples Pt. 2

Change output to JSON format for parsing:
bash
ffprobe <input> -select_streams v -show_packets -of json
Get the number of streams in a file (nk=1 disables keys):
bash
ffprobe <input> -show_format -show_entries format=nb_streams -of
compact=nk=1:p=0
Get the duration in seconds or HH:MM:SS.ms:
bash
ffprobe <input> -show_format -show_entries format=duration -of
compact=nk=1:p=0
ffprobe -sexagesimal <input> -show_format -show_entries
format=duration -of compact=nk=1:p=0
Get bitrate of audio stream in Bit/s:
bash
ffprobe <input> -select_streams a -show_entries stream=bit_rate -of
compact=nk=1:p=0
Practical ffprobe Examples Pt. 2 Change output to JSON format for parsing: ffprobe <input> -
select_streams v -show_packets -of json Get the number of streams in a file (nk=1 disables keys):
ffprobe <input> -show_format -show_entries format=nb_streams -of compact=nk=1:p=0 Get the
duration in seconds or HH:MM:SS.ms: ffprobe <input> -show_format -show_entries
format=duration -of compact=nk=1:p=0 ffprobe -sexagesimal <input> -show_format -show_entries
format=duration -of compact=nk=1:p=0 Get bitrate of audio stream in Bit/s: ffprobe <input> -
select_streams a -show_entries stream=bit_rate -of compact=nk=1:p=0

---

## Debugging Motion Vectors

Simple way to visualize motion in FFmpeg with H.264 codecs (does not work for other codecs):
bash
ffplay -flags2 +export_mvs input.mp4 -vf codecview=mv=pf+bf+bb
ffmpeg -flags2 +export_mvs -i input.mp4 -vf codecview=mv=pf+bf+bb
<output>
- pf – forward predicted motion vectors of P pictures
   - bf – forward predicted motion vectors of B pictures
   - bb – backward predicted motion vectors of B pictures

Debugging Motion Vectors Simple way to visualize motion in FFmpeg with H.264 codecs (does
not work for other codecs): ffplay -flags2 +export_mvs input.mp4 -vf codecview=mv=pf+bf+bb
ffmpeg -flags2 +export_mvs -i input.mp4 -vf codecview=mv=pf+bf+bb <output> pf – forward
predicted motion vectors of P pictures bf – forward predicted motion vectors of B pictures bb –
backward predicted motion vectors of B pictures

---

 
