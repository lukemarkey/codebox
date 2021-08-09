## MONTHLY SERVER MANAGEMENT

curl https://github.com/lukemarkey.keys

sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y update && sudo apt-get -y dist-upgrade
sudo aptitude -y update && sudo aptitude -y full-upgrade

wordpress use:
0.5GB ram
1vCPU
20GB hd

lightsail:
wp server: $5 monthy x3
loadbalance $18 monthly

## SERVER PROCEDURES

circle back to:
check s3 to glacier automated transition
consolidate s3 buckets
office repository crontab
s3 backups - home
aws rds backups
confirm bitbucket mfa
ssh server between server
ssh repository sync alias / automated pull
nginx limit_req for logins
nginx reconfigure bad bot blocker
server intrusion detection
server / office update / dist-upgrade
office update firewall
remote server ssh update
chromebook ssh update
debug office backup remove old backups
aws restructure user permissions / roles
aws resource groups
aws cloud watch dashboards
netdata debug node urls
netdata alarms
aws elasticsearch service
mfa google accounts
@atlwebsitedesign.com emails
clutch vpn scrape
aws kms / policies
server change ssh port
rtcwake for office cronjob execute

school:

security updates:
s3 backups
s3 lock policy
s3 automated transfers to cold storage
server fail2ban
server log monitoring
server harden nginx
server cloud firewall
server metrics
server netdata
server sync public private keys
server iptables
aws console lock root
aws iam user roles / permissions
aws configure alerts

server netdata:
netdata deny stub_status server block
netdata configure metrics - django / wordpress / office
netdata simple home dashboard
netdata configure alarms
netdata node debug http https

https://www.elastic.co/guide/en/beats/filebeat/current/ilm.html
https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules.html
server log monitoring:
kibana auth
filebeat modules
beats central management
filebeat index lifecycle management
kibana home dashboard configuration

server metrics:
configure netdata

firewall:
inbound:
ssh tcp 22 (office IP)
dns tcp 53
dns udp 53
http tcp 80
https tcp 443
postgresql tcp 5432
outbound:
tcp all
udp all
imcp all

aws s3:
enable object lock
enable compliance mode
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
sudo apt install python3-pip
pip3 install awscli --upgrade
aws configure

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

## SERVERS
office:
76.97.68.93
id_rsa.pub

home:
209.97.158.46
home.pub

django:
159.65.218.140
django.pub

wordpress:
167.99.158.138
wordpress.pub

## AWS S3
luke.h.markey-backup policies:
object lock: compliance 60 days
transition to glacier: 60 days
expires: 90 days
clean incomplete multipart: 7 days
