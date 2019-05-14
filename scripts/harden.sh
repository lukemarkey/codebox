## LINUX HARDENING
##
## HOSTNAME: LUKE
## IP ADDRESS: ENO1 192.168.1.150/24
## IP ADDRESS: TUN0 10.8.0.1 PEER 10.8.0.2/32
## MAC ADDRESS: ENO1 40:16:7e:36:cd:57

## SECURE BIOS WITH ADMINISTRATOR PASSWORD
## ENCRYPT HARD DISK
## BACKUP OS / SERVER
## SEPARATE PARTITIONS FOR / /boot /usr /home /tmp /var /opt

## LOCK BOOT DIRECTORY
sudo nano /etc/fstab
---
LABEL=/BOOT 	/boot 	ext2 	defaults,ro 	1 2
---
sudo mount -a

sudo chown root:root /etc/fstab
sudo chown root:root /boot/grub/grub.cfg
sudo chmod og-rwx /boot/grub/grub.cfg

## SET ROOT PASSWORD
sudo passwd root

## CHECK INSTALLED PACKAGES
sudo apt-cache pkgnames

## CHECK FOR OPEN PORTS
sudo netstat -antp

## SECURE SSH
sudo nano /etc/ssh/sshd_config
---
Port 2222
PermitRootLogin no
AllowUsers luke
Protocol 2
IgnoreRhosts yes
HostbasedAuthentication no
PermityEmptyPasswords no
X11Forwarding no
MaxAuthTries 5
Ciphers aes128-ctr,aes192-ctr,aes256-ctr
ClientAliveInterval 900
ClientAliveCountMax 0
UsePAM yes
---
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 600 /etc/sshd/sshd_config
sudo service sshd restart

## SETUP APP ARMOR
sudo apt-get install apparmor
sudo apt-get install apparmor-profiles
sudo apt-get install apt-get install apparmor-utils
sudo apparmor_status
sudo nano /etc/default/grub
---
apparmor=1 security=apparmor
---
sudo /etc/init.d/apparmor start

## SECURE NETWORK
sudo nano /etc/sysctl.conf
---
net.ipv4.ip_forward=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.all.accept_redirects=0
---

## SETUP IPTABLES
TODO

## HARDEN PASSWORD
sudo nano /etc/pam.d/common-passwords
---
auth sufficient pam_unix.so likeauth nullok
password sufficient pam_unix.so remember=4
---

## PERMISSIONS AND VERIFICATIONS
sudo chown root:root /etc/anacrontab
chmod og-rwx  /etc/anacrontab
sudo chown root:root /etc/crontab
chmod og-rwx /etc/crontab
sudo chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
sudo chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
sudo chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
sudo chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
sudo chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d

chmod 644 /etc/passwd
sudo chown root:root /etc/passwd
chmod 644 /etc/group
sudo chown root:root /etc/group

chmod 600 /etc/shadow
sudo chown root:root /etc/shadow
chmod 600 /etc/gshadow
sudo chown root:root /etc/gshadow
