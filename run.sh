#!/bin/sh

export PH=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
export PD=$(openssl rand -base64 32)
sh /app/cfg.json.tpl >  /app/cfg.json
sh /app/default.conf.tpl > /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh nginx
