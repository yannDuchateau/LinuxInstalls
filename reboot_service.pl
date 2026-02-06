#!/bin/bash
systemctl enable ntpd
systemctl start ntpd
timedatectl set-timezone Europe/Paris
systemctl ebnable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=123/udp --permanent
systemctl enable sshd
systemctl start sshd
systemctl status sshd
systemctl stop firewalld
systemctl disable firewalld
systemctl enable ntpd
systemctl -l status NetworkManager network