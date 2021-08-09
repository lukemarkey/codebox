## ADD NEW SUDO USER TO SERVER

sudo adduser ${USERNAME}
sudo usermod -aG sudo ${USERNAME}

sudo nano /etc/ssh/sshd_config
---
AllowUsers root ${USERNAME}
ClientAliveInterval 60
ClientAliveCountMax 10000
---
sudo systemctl reload sshd

sudo su ${USERNAME}
mkdir ~/.ssh && touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys

## SET USER AND ROOT PASSWORDS
su ${USERNAME} && passwd
sudo su && passwd

###########################################################################
## ADD SSH BACKUP ACCOUNT TO SERVER
###########################################################################

sudo adduser ${USERNAME}

sudo nano /etc/ssh/sshd_config
---
## REMOVE ROOT FROM ALLOWUSERS
AllowUsers ${USERNAME}
PasswordAuthentication yes
PermitRootLogin no
---
sudo systemctl reload sshd

## INSTALL FAIL2BAN

sudo apt install fail2ban

## INSTALL AND SETUP UFW

sudo apt-get install ufw
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow https
sudo ufw allow http
sudo ufw allow ssh
sudo ufw enable

## INSTALL LEMP STACK

sudo apt-get install nginx

sudo apt-get install mariadb-server mariadb-client
sudo mysql_secure_installation

sudo mysql -u root
CREATE USER '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'localhost' WITH GRANT OPTION;
CREATE USER '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

sudo apt-get install php7.0-fpm php7.0-mbstring php7.0-xml php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl

## SETUP SWAPFILE FOR SERVER RAM

free -h
df -h
sudo touch /swapfile
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
