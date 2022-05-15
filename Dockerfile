FROM alpine:edge
COPY xx.zip /xx/xx.zip
COPY caddy/static-html /usr/share/caddy/
COPY caddy/h5-speedtest /usr/share/caddy/speedtest/
COPY caddy/Caddyfile /etc/caddy/CaddyfileTemp
#COPY nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
#COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY configure.sh /configure.sh
COPY xx_config /
RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget ca-certificates bash curl php7 && \
    unzip /xx/xx.zip -d /xx/ && \
    chmod +x /xx/xx && \
    chmod +x /xx/v2ctl && \
    rm -rf /var/cache/apk/*

RUN chmod +x /configure.sh
CMD sed -e "s/\$UUID/$UUID/g" -e "s/\$PORT/$PORT/g" /xx.json > /xx/config.json && sed -e "1c :$PORT" /etc/caddy/CaddyfileTemp > /etc/caddy/Caddyfile && /configure.sh
