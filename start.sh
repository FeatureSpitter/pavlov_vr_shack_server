#!/bin/bash

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1

mkdir mods_dust216
mkdir mods_dust2csgo

chmod -R 777 mods_dust2*

docker compose down --remove-orphans && docker compose build && docker compose up -d && docker compose logs -f -t