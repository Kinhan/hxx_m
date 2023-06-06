FROM php:7-fpm-alpine
COPY xx.zip /xx/xx.zip
COPY caddy/static-html /usr/share/caddy/
COPY caddy/h5-st /usr/share/caddy/st/
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
COPY caddy/Caddyfile /etc/caddy/CaddyfileTemp

ARG PORT
ARG UUID

ENV PORT=${PORT} \
    UUID=${UUID}

RUN chmod +x /xx/configure.sh
EXPOSE ${PORT}
CMD sed -e "s/\$UUID/$UUID/g" /xx.json > /xx/config.json && sed -e "1c $HOST" /etc/caddy/CaddyfileTemp > /etc/caddy/Caddyfile && sh /xx/configure.sh
