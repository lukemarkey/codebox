## FAIL2BAN CONFIGURATION
## LOGS: /var/log/fail2ban.log

sudo apt install -y fail2ban sendmail iptables-persistent
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local

## CHANGES TO JAIL.D DEFAULTS DEBIAN
read -r -d '' DEFAULT_DEBIAN <<-'EOF'
[DEFAULT]
ignoreip = 127.0.0.1/8 76.97.68.93
bantime = 3600
findtime = 3600
maxretry = 6
destemail = luke.h.markey@gmail.com
sendername = Fail2Ban
action = %(action_mwl)s
mta = sendmail

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = %(sshd_log)s

[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http, https
logpath = /var/log/nginx/error.log

[nginx-botsearch]
enabled = true
filter = nginx-botsearch
port = http, https
maxretry = 2

[nginx-limit-req]
port    = http,https
filter = nginx-limit-req
logpath = %(nginx_error_log)s

[sendmail-auth]
enabled = true
port = submission, 465, smtp
logpath = %(syslog_mail)s
EOF

## CHECK IPTABLES
sudo iptables -S
## RESET UFW IF NEEDED
sudo ufw reset
## FLUSH IPTABLES IF NEEDED
sudo iptables -F

## BASE IPTABLES (ESTABLISHED, INTERNAL, SSH AND WEB SERVER ALLOWED)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW --source 76.97.68.93 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP
sudo iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
sudo iptables -A INPUT -j DROP

## SAVE IPTABLES
sudo iptables-save

## CHECK CONFIGURATION OF FAIL2BAN
sudo fail2ban-client status
## GET SSH JAIL STATUS
sudo fail2ban-client status sshd

sudo fail2ban-client reload

## RESTART FAIL2BAN SERVICE
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
sudo systemctl status fail2ban
