FROM ubuntu:22.04

RUN apt update && apt install -y ffmpeg nginx

RUN mkdir -p /tmp/hls

COPY nginx.conf /etc/nginx/nginx.conf

CMD ffmpeg -re -loop 1 -i https://i.ytimg.com/vi/skq6c96rw64/maxresdefault.jpg -c:v libx264 -t 86400 -pix_fmt yuv420p -f flv rtmp://localhost/live/brunaut & \
    nginx -g "daemon off;"
