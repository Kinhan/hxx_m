#!/bin/sh
# xx generate configuration
# Download and install xx
#config_path="/xx.json"
#install -m 755 /xx/xx /usr/local/bin/xx
#install -m 755 /xx/v2ctl /usr/local/bin/v2ctl
# Remove temporary directory
#rm -rf /xx
# xx new configuration
#install -d /usr/local/etc/xx
#envsubst '\$UUID' < $config_path > /xx/xxtemp.json
#/bin/bash -c "envsubst '\$UUID' < /xx.json > /xx/config.json"
#sed -e "s/\$UUID/$UUID/g" /xx.json > /xx/config.json
# MK TEST FILES
mkdir /opt/test
cd /opt/test
dd if=/dev/zero of=100mb.bin bs=100M count=1
dd if=/dev/zero of=10mb.bin bs=10M count=1
# Run xx
/xx/xx -config /xx/config.json &

## Run caddy
#mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "" > /usr/share/caddy/robots.txt
#sed -i "1c :$PORT" /etc/caddy/CaddyfileTemp
#/bin/bash -c `sed -i "1c :$PORT" > /etc/caddy/Caddyfile`

# run caddy
tor &
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

cat /xx/config.json
cat /etc/caddy/Caddyfile