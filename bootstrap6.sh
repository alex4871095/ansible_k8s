#!/usr/bin/env bash

apt-get update
apt-get -y install socat conntrack ipset
apt-get -y install bridge-utils
groupadd alex
password="password"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd --create-home --skel /etc/skel --gid alex --groups sudo --password $pass --home-dir /home/alex --shell /bin/bash alex
mkdir /home/alex/.ssh
touch /home/alex/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHd5yZ2mOqIqCmGj+BKb5nxDEckEuvm9QGB2VL4MrNp+J3pNxmGh2o57YaPlRccU97LBSPN185OKRiEVOs2ZF9ZAyMmE8LiC2FpFrvKBxpC0LhgVBHtpwtUxJtxx07oyg+cozEuoX3pzW5QO/woNLORoGqOhU0CvG8n2m7LxVVx+he63i1ccky56v1a+XXHbL5E3We9OPawLd4PUF/Pxc+LEfAfXyrCVNxso7vqqUu+qqcc9wdFzHGMxrulLtVsfjRIcUbDE+RQtiV4dmygY2A+FP9EQfktqT3o0j156eR64WBIKQSucdS5EXv3rx3Ym6lp4VDQQPrv6WyU0yhJOxF alex@homelab" >> /home/alex/.ssh/authorized_keys
hostname host6
echo "host6" > /etc/hostname
swapoff -a
route add -net 10.100.0.0/24 gw 192.168.35.104
route add -net 10.100.1.0/24 gw 192.168.35.105
route add -net 0.0.0.0/0 gw 192.168.35.1
route delete -net 0.0.0.0/0 gw 10.0.2.2
echo "nameserver 192.168.35.1" > /etc/resolv.conf
touch /etc/rc.local
sed s/exit\ 0// /etc/rc.local > /etc/rc.local.modified
mv /etc/rc.local.modified /etc/rc.local
chmod +x /etc/rc.local
echo "swapoff -a" >> /etc/rc.local
echo "route add -net 10.100.0.0/24 gw 192.168.35.104" >> /etc/rc.local
echo "route add -net 10.100.1.0/24 gw 192.168.35.105" >> /etc/rc.local
echo "      gateway 192.168.35.1" >> /etc/network/interfaces
echo "      dns-nameservers 192.168.35.1" >> /etc/network/interfaces
