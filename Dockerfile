FROM ubuntu:22.04

RUN apt update && apt install -y ffmpeg nginx

RUN mkdir -p /tmp/hls

COPY nginx.conf /etc/nginx/nginx.conf

CMD ffmpeg \
    -f concat -safe 0 -i <(for url in $(cat images.txt); do echo "file '$url'"; done) \
    -vf "scale=1280:720,format=yuv420p" \
    -t 86400 -c:v libx264 -f flv rtmp://localhost/live/brunaut & \
    nginx -g "daemon off;"
