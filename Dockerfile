FROM ubuntu:22.04

RUN apt update && apt install -y ffmpeg nginx procps bash

RUN mkdir -p /tmp/hls /app

COPY nginx.conf /etc/nginx/nginx.conf
COPY images.txt /app/images.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["bash", "/start.sh"]

