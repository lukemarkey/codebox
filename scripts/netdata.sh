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
	update every = 10 ## UPDATE EVERY 10 SECONDS
	access log = none

## ADD NGINX SERVER BLOCK FOR NETDATA
sudo nano /etc/nginx/sites-available/netdata
sudo printf "luke:`openssl passwd -apr1`" > /etc/nginx/htpasswd.netdata

## ADD HTTPS SUPPORT
certbot --nginx -d netdata.django.atlwebsitedesign.com

## CHECK NETDATA CONF ONLINE
https://netdata.atlwebsitedesign.com/netdata.conf

## CONFIGURE NETDATA.CONF
[plugins]
        # PATH environment variable = /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sb$
        # PYTHONPATH environment variable =
        proc = yes
        diskspace = yes
        cgroups = yes
        tc = yes
        idlejitter = yes
        enable running new plugins = yes
        check for new plugins every = 60
        node.d = yes
        go.d = yes
        fping = yes
        charts.d = yes
        apps = yes
        python.d = yes

## ENABLE NGINX PLUGIN
## TODO: RESTRICT STUB_STATUS TO NECESSARY IPS
nginx -V 2>&1 | grep -o with-http_stub_status_module ## CHECK IF STUB STATUS MODULE AVAILABLE
sudo su -s /bin/bash netdata
. edit-config python.d/nginx.conf
...
update_every: 10
priority: 90100

localhost:
  name : 'local'
  url  : 'https://netdata.atlwebsitedesign.com/stub_status'

localipv4:
  name : 'local'
  url : 'https://netdata.atlwebsitedesign.com/stub_status'

localipv6:
  name : 'local'
  url: 'https://netdata.atlwebsitedesign.com/stub_status'
...
sudo service netdata restart

## ENABLE NGINX WEB LOG
sudo su -s /bin/bash netdata
. edit-config python.d/web_log.conf
...
...
sudo service netdata restart

