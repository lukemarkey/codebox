## CONVERT MP4 TO WEBM

ffmpeg -i ${INPUT}.mp4 -vcodec libvpx -acodec libvorbis -b:v 2000k -cpu-used 4 -threads 8 ${OUTPUT}.webm

## CONVERT MP4 TO OGV

ffmpeg -i ${INPUT}.mp4 -vcodec libtheora -acodec libvorbis -b:v 2000k -cpu-used 4 -threads 8 ${OUTPUT}.ogv

## DOWNLOAD MP3 FROM YOUTUBE

youtube-dl --extract-audio --audio-format mp3 ${URL}
