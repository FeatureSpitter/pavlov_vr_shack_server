#!/bin/bash

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1

mkdir -p mods_dust2cs16
mkdir -p mods_dust2csgo
mkdir -p mods_halo

chmod -R 755 *

docker compose down --remove-orphans && docker compose build && docker compose up -d && docker compose logs -f -t