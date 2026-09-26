#!/bin/sh

set -e

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# configure firewall
iptables-nft -t nat -A POSTROUTING -s 10.99.99.0/24 ! -d 10.99.99.0/24 -j MASQUERADE
iptables-nft -A FORWARD -s 10.99.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356
iptables-nft -A INPUT -i ppp+ -j ACCEPT
iptables-nft -A OUTPUT -o ppp+ -j ACCEPT
iptables-nft -A FORWARD -i ppp+ -j ACCEPT
iptables-nft -A FORWARD -o ppp+ -j ACCEPT

exec "$@"
