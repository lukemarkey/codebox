###########################################################################
## NGINX DOCUMENTATION PROCEDURE
#
# - the daemon     at /usr/sbin/netdata
# - config files   in /etc/netdata
# - web files      in /usr/share/netdata
# - plugins        in /usr/libexec/netdata
# - cache files    in /var/cache/netdata
# - db files       in /var/lib/netdata
# - log files      in /var/log/netdata
# - pid file       at /var/run/netdata.pid
# - logrotate file at /etc/logrotate.d/netdata
###########################################################################

## ONE-LINE INSTALL / CONFIGURE / UPDATE NETDATA
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
## ACCESS NETDATA @ http://209.97.158.46:19999

## UPDATE NETDATA CONF
[global]
	history = 86400 ## 24 HOURS - 600MB RAM

## ADD NGINX SERVER BLOCK FOR NETDATA
sudo nano /etc/nginx/sites-available/netdata

