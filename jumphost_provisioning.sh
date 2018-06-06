#!/bin/bash
#
#   Internet
#     |
#    eno1 192.168.1.108
#     |     haproxy
#  jumphost
#     |     dnsmasq, default gw
#  vboxnet0 192.168.35.1
#     |
#  k8s_cluster VMs
#  3 master nodes, 3 worker nodes

echo "" >> /etc/hosts
echo "# Cluster nodes" >> /etc/hosts
echo "192.168.35.101    host1.cluster.local host1" >> /etc/hosts
echo "192.168.35.102    host2.cluster.local host2" >> /etc/hosts
echo "192.168.35.103    host3.cluster.local host3" >> /etc/hosts
echo "192.168.35.104    host4.cluster.local host4" >> /etc/hosts
echo "192.168.35.105    host5.cluster.local host5" >> /etc/hosts
echo "192.168.35.106    host6.cluster.local host6" >> /etc/hosts

route add -net 10.100.0.0/24 gw 192.168.35.104
route add -net 10.100.1.0/24 gw 192.168.35.105
route add -net 10.100.2.0/24 gw 192.168.35.106
route add -net 10.200.0.0/24 gw 192.168.35.104

iptables -t nat -A POSTROUTING -s 192.168.35.0/24 -o eno1 -j MASQUERADE

apt-get install -y dnsmasq haproxy

cp dnsmasq.service /etc/systemd/system/dnsmasq.service

cp haproxy.cfg /etc/haproxy/haproxy.cfg

systemctl daemon-reload
systemctl enable dnsmasq
systemctl enable haproxy 
systemctl restart dnsmasq
systemctl restart haproxy


cat /etc/hosts

netstat -rn

iptables -L -t nat

systemctl status dnsmasq
systemctl status haproxy


