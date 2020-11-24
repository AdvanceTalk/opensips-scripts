#!/bin/bash
other_server_ip = 
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -j DROP -p udp --dport 5060 -m string --string "friendly-scanner" --algo bm --icase
iptables -A INPUT -j DROP -p udp --dport 5060 -m string --string "sipcli/" --algo bm --icase
iptables -A INPUT -j DROP -p udp --dport 5060 -m string --string "VaxSIPUserAgent/" --algo bm --icase
iptables -A INPUT -j DROP -p udp --dport 5060 -m string --string "pplsip" --algo bm --icase
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p udp --dport 5060 -j ACCEPT
#iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp -s $other_server_ip/32 --dport 5555 -j ACCEPT
iptables -A INPUT -p tcp -s $other_server_ip/32 --dport 5432 -j ACCEPT
iptables -t mangle -A OUTPUT -p udp -m udp --sport 5060 -j DSCP --set-dscp 26
iptables -t mangle -A OUTPUT -p tcp -m tcp --sport 5060 -j DSCP --set-dscp 26
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

apt-get install ptables-persistent
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
apt-get install -y iptables-persistent
