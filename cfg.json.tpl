#!/bin/sh
cat <<EOF
{
  "log": {
    "loglevel": "warning",
    "error": "/app/error.log",
    "access": "/app/access.log"
  },
  "inbounds": [
    {
      "tag": "ddws",
      "listen": "127.0.0.1",
      "port": 2002,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "${HOST}",
        "network": "tcp",
        "followRedirect": false
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/${PH}"
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": "127.0.0.1",
      "port": 2003,
      "protocol": "shadowsocks",
      "settings": {
        "method": "2022-blake3-chacha20-poly1305",
        "password": "${PD}",
        "ivCheck": true,
        "email": "not@ex.ist"
      }
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "ddws"
        ],
        "outboundTag": "loopback"
      },
      {
        "type": "field",
        "protocol": [
          "bittorrent"
        ],
        "outboundTag": "blocked"
      }
    ]
  },
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "loopback",
      "protocol": "freedom",
      "settings": {
        "redirect": "127.0.0.1:2003"
      }
    },
    {
      "tag": "blocked",
      "protocol": "blackhole",
      "settings": {}
    }
  ]
}
EOF
