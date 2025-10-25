#!/bin/bash
cd /app || exit 1

# создаём плейлист для ffmpeg
> /tmp/ffmplist.txt
while read -r url; do
  echo "file '$url'" >> /tmp/ffmplist.txt
  echo "duration 10" >> /tmp/ffmplist.txt
done < images.txt

# зацикливаем первую картинку
first_line=$(head -n1 images.txt)
echo "file '$first_line'" >> /tmp/ffmplist.txt

# запускаем nginx
nginx -g "daemon off;" &

# запускаем ffmpeg для потока
ffmpeg -f concat -safe 0 -protocol_whitelist "file,http,https,tcp,tls" \
-i /tmp/ffmplist.txt -vf "scale=1280:720,format=yuv420p" \
-c:v libx264 -preset veryfast -tune zerolatency -f flv rtmp://localhost/live/brunaut
