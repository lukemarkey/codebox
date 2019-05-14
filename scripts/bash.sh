## SETUP ACCT

sudo apt-get install acct

## NETWORK COMMANDS

sudo journalctl -n 100 -f -u NetworkManager
ifconfig eno1
ping -c 5 192.168.1.22
netstat -r
bmon

## /ETC/HOSTS.ALLOW

sshd: 73.82.241.34/255.255.255.0
sshd: 192.168.0.0/255.255.255.0

## /ETC/HOSTS.DENY

sshd: ALL

## LOCAL HARDWARE

sudo lspci -v
sudo lshw -class network

## SYSTEM LOGS

dmesg

## GET ETHERNET CONNECTION BACK ONLINE

ifconfig
sudo lshw -C network

sudo nano /etc/network/interfaces
---
auto eno1
iface eno1 inet static
address 192.168.1.150
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.1 8.8.8.8
---
sudo service network-manager restart
sudo ifup -v eno1
sudo service network-manager restart
