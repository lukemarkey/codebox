## INSATLL LOGWATCH

sudo apt-get install logwatch
sudo nano /usr/share/logwatch/default.conf/logwatch.conf
---
Output = mail
Format = file
MailTo = luke.h.markey@gmail.com
MailFrom = Logwatch
Detail = 5
Filename = /tmp/logwatch
---

sudo apt-get install sendmail
nano /etc/hosts
...
127.0.0.1 localhost yourhostname
...
sudo sendmailconfig
echo "Subject: sendmail test" | sendmail -v luke@markey.agency
sendmail -vt < ~/mail.txt
...
To: luke@markey.agency
Subject: sendmail test two
From: luke@home

And here goes the e-mail body, test test test..
...


## MAIL SETUP

sudo nano /etc/postfix/main.cf
---
relayhost = [smtp.mailgun.com]:587
myhostname = markey.agency
mydestinaton = markey.agency

smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = static:postmaster@mg.markey.agency:7e8a09f244c09f6c054fe85481de9498-f45b080f-2b1d80d0
smtp_sasl_security_options = noanonymous
smtp_tls_security_level = encrypt
header_size_limit = 4096000
---

sudo nano /etc/postfix/master.cf
---
submission inet n       -       -       -       -       smtpd
---

sudo nano /etc/mailname
---
markey.agency
---

sudo postfix check

sudo service postfix restart

## You should see this output that ports 25, 465 and 587 are only running on the loopback adapter
## which means no external users can access it from its internet IP address.
sudo netstat -lntp | grep master

## FORWARD ALL SERVER EMAIL TO EMAIL
sudo nano /etc/postfix/virtual-regexp
---
/.+@localhost/ luke@markey.agency ## LOCALHOST DOMAINS
/.+@.+/ luke@markey.agency ## ALL DOMAINS
---
postmap /etc/postfix/virtual-regexp
sudo service postfix reload

## TEST THAT MAILGUN IS WORKING AND FORWARDS WORK
sudo apt-get install mailutils -y

echo "This is testing SMTP Relay." | mail -s "Postfix Mailgun" luke@markey.agency

tail -n 100 /var/log/mail.log ## CHECK MAIL LOGS

echo "This is testing forwarding." | mail -s "Postfix Mailgun Forward" root@localhost

## OPEN UFW

sudo ufw allow 587/tcp

## LOGWATCH COMMANDS

sudo logwatch --detail High --mailto luke.h.markey@gmail.com --range today


