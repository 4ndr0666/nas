# StreamRecorder

The following is the usage details for the [StreamRecorder](https://chromewebstore.google.com/detail/stream-recorder-hls-m3u8/iogidnfllpdhagebkblkgbfijkbkjdmm/reviews) extension for chrome.

##How to clear the settings

All settings are stored in the localStorage of this domain. You can clear the settings by running `localStorage.clear()` on the Developer Console.

## How to download the video from the middle

You can assign "start" and "stop" as parameters of the URL of this page. Please use it when splitting and downloading exceptionally long videos. Note that this parameter is valid only when video and audio are stored in the same .ts file.
(Example) `.../rec.html?start=30`

## How to specify parallel number of downloads in the Boost

The default parallel number is 3, but you can specify a number from 1 to 6 with the Developer Console.
(Example) `localStorage.parallel = 3`
