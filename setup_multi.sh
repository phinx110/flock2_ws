#!/bin/sh
iptables -t nat -A OUTPUT -d 192.168.11.1 -j DNAT --to-destination 192.168.10.1
iptables -t nat -A INPUT -i wlp59s1 -j SNAT --to-source 192.168.11.1

# iptables -t nat -A POSTROUTING -i wlp59s1 -p udp --dport 11111 -- change ports

ip route add table 26 192.168.10.1 dev wlp59s1
ip rule add priority 10000 fwmark 26 table 26

iptables -t mangle -A OUTPUT -d 192.168.11.1 -j MARK --set-mark 26

route del -net 192.168.10.0 netmask 255.255.255.0 dev wlp59s1
route del -net 0.0.0.0 netmask 0.0.0.0 dev wlp59s1
 
