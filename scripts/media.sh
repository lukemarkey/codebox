## COMPRESS IMAGES

convert -resize 30% ${TARGET_IMAGE} ${DESTINATION}

## COMPRESS MOV - HANDBRAKE WORKS GREAT

ffmpeg -i ${INPUT}.mov -vcodec wmv3 -acodec aac -strict -2 ${OUTPUT}.mp4

## COMPRESS MP4

ffmpeg -i ${TARGET_VIDEO} -vcodec h264 -acodec mp2 ${DESTINATION}
ffmpeg -i ${TARGET_VIDEO} -vcodec h264 -b ${100000xSECONDS} -acodec mp2 ${DESTINATION}

## COMPRESS GIF

gifsicle -i river-mobile.gif --optimize=3 --colors 64 -o optimized.gif

## CONVERT MP4 TO GIF

ffmpeg -i ${INPUT}.mp4 -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 -layers Optimize - ${OUTPUT}.gif

## CONVERT MP4 TO WEBM

ffmpeg -i ${INPUT}.mp4 -vcodec libvpx -acodec libvorbis -b:v 2000k -cpu-used 4 -threads 8 ${OUTPUT}.webm

## CONVERT MP4 TO OGV

ffmpeg -i ${INPUT}.mp4 -vcodec libtheora -acodec libvorbis -b:v 2000k -cpu-used 4 -threads 8 ${OUTPUT}.ogv

