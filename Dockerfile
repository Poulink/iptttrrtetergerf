FROM ubuntu:22.04

# Установка зависимостей
RUN apt update && apt install -y ffmpeg procps wget build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev git

# Скачиваем nginx + rtmp module
RUN wget http://nginx.org/download/nginx-1.24.0.tar.gz && \
    tar -zxvf nginx-1.24.0.tar.gz && \
    git clone https://github.com/arut/nginx-rtmp-module.git && \
    cd nginx-1.24.0 && \
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make && make install

RUN mkdir -p /tmp/hls /app

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY images.txt /app/images.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
