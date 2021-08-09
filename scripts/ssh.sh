## REFRESH SSH PRIVATE KEY

eval `ssh-agent -s`
ssh-add ~/.ssh/${PRIVATE_KEY}

## PREVENT USER SSH SESSIONS FROM EXPIRING ( CLIENT SIDE )

sudo nano /etc/ssh/ssh_conifg
---
Host *
	GSSAPIDelegateCredentials no
	ServerAliveInterval 100
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
----

## PREVENT USER SSH SESSIONS FROM EXPIRING ( SERVER SIDE )

sudo nano /etc/ssh/sshd_config
---
ClientAliveInterval 60
ClientAliveCountMax 10000
---
