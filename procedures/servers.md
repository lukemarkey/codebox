## MONTHLY SERVER MANAGEMENT

sudo apt-get -y update && sudo apt-get -y upgrade

wordpress use:
0.5GB ram
1vCPU
20GB hd

lightsail:
wp server: $5 monthy x3
loadbalance $18 monthly

## SERVER BACKUPS

server log monitoring:
https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules.html

server harden nginx:
remove unnecessary modules
filter user agents
nginx load balancing / session persistence
nginx rate / connection limit DDoS
nginx http / server pagespeed optimization
diffie hellman ssl ciphers

aws s3:
enable object lock
enable governance mode
set 60 day retention period

server fail2ban:
fail2ban.sh
configure servers
update iptables
configure sendmail

office / server backups:
compress script
office s3push cronjobs
s3 migration / expiration policy
django compress script

server load balancers:
costs for server rollouts and load balancer
nginx pagespeed separation - cache server?
asset separation for websites
server duplication solutions
block storage to sync servers?

server harden nginx:
remove unnecessary modules
filter user agents
nginx load balancing / session persistence
nginx rate / connection limit DDoS
nginx http / server pagespeed optimization
nginx wordpress conf / site
diffie hellman ssl ciphers

django rds:
iam access / database
rds direct access security group
vpc security group
update website env / settings
-backup-psql-remote alias
-restore-psql-rds alias
update live website
debug django rds access
debug vpc security groups
migrate django databases to rds
-psql-rds-migrate alias

server backups:
ssh backup accounts:
update server script
configure sshd_config
disable root login
update server script
paper copy backup
django backups:
s3cmd script to postgres.sh
add backup script to server
mongodb backups using s3cmd
crontab automated backups
server snapshots:
configure digital ocean
create doctl script
cold storage backups:
config gscloud script
gsutil cp to bucket

## SERVER CRONJOBS

office:
## RUN COMPRESS EVERY SUNDAY AT 12:00AM
0 0 * * 0 /home/luke/codebox/bash/compress.sh Videos
0 0 * * 0 /home/luke/codebox/bash/compress.sh codebox toolbox kirin .config/sublime-text-3/Packages/User/snippets
0 0 * * 0 /home/luke/codebox/bash/compress.sh assets
0 0 * * 0 /home/luke/codebox/bash/compress.sh projects
0 0 * * 0 /home/luke/codebox/bash/compress.sh Documents
## BACKUP ASSETS EVERY SUNDAY @ 6:00AM
0 6 * * 0 /home/luke/bash/s3backup.sh videos
0 6 * * 0 /home/luke/bash/s3backup.sh codebox
0 6 * * 0 /home/luke/bash/s3backup.sh assets
0 6 * * 0 /home/luke/bash/s3backup.sh projects
0 6 * * 0 /home/luke/bash/s3backup.sh documents
