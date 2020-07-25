#!/bin/sh
set -e -u

echo "$USERNAME" > auth.conf
echo "$PASSWORD" >> auth.conf

openvpn --config "/vpn/TorGuard.${REGION}.config" --auth-user-pass auth.conf
