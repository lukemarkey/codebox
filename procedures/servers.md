## MONTHLY SERVER MANAGEMENT

sudo apt-get update && sudo apt-get upgrade

wordpress use:
0.5GB ram
1vCPU
20GB hd

lightsail:
wp server: $5 monthy x3
loadbalance $18 monthly

aws s3:
enable object lock
enable governance mode
set 60 day retention period

## SERVER BACKUPS

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
