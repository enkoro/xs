#!/bin/sh

export PH=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
export PD=$(openssl rand -base64 32)
sh /app/cfg.json.template >  /app/cfg.json
nohup /app/app -c /app/cfg.json 2>&1 > /app/app.log &
/docker-entrypoint.sh nginx -g 'daemon off;'
