#!/bin/sh

export PH=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
export PD=$(openssl rand -base64 32)
sh /app/cfg.json.template >  /app/cfg.json
/docker-entrypoint.sh nginx
