FROM php:7-fpm-alpine
COPY xx.zip /xx/xx.zip
COPY caddy/static-html /usr/share/caddy/
COPY caddy/h5-speedtest /usr/share/caddy/speedtest/
COPY caddy/Caddyfile /etc/caddy/CaddyfileTemp
#COPY nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
#COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY configure.sh /xx/configure.sh
COPY xx_config /
RUN apk update && \
    apk add --no-cache ca-certificates tor wget ca-certificates bash curl caddy && \
    unzip /xx/xx.zip -d /xx/ && \
    chmod +x /xx/xx && \
    chmod +x /xx/v2ctl && \
    rm -rf /var/cache/apk/*

ARG port
ARG uuid

ENV port=${port} \
    uuid=${uuid}

RUN chmod +x /xx/configure.sh
EXPOSE 8080
CMD sed -e "s/\$UUID/5a92dcf2-5ea4-474d-a491-145cac7e7f16/g" /xx.json > /xx/config.json && sed -e "1c :8080" /etc/caddy/CaddyfileTemp > /etc/caddy/Caddyfile && sh /xx/configure.sh
