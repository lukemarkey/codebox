## INSTALL AND CONFIGURE BROTLI AND PAGESPEED FOR NGINX

## DOWNLOAD PREREQUISITES FOR BROTLI

sudo apt-get install build-essential libxslt-dev zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd-dev libgeoip-dev libgoogle-perftools-dev libperl-dev checkinstall

## DOWNLOAD PREREQUISITES FOR PAGESPEED

sudo apt-get install build-essential zlib1g-dev libpcre3 libpcre3-dev unzip uuid-dev gcc libpcre3-dev libssl-dev

## OTHER DEPENDENCIES

sudo apt-get install build-esential checkinstall zlib1g-dev libgeoip-dev

## CHECK http://nginx.org/en/download.html FOR LATEST NGINX

cd /usr/local/src
sudo wget http://nginx.org/download/nginx-1.19.9.tar.gz ## CHANGE VERSION
sudo tar -xzvf nginx-1.15.10.tar.gz ## CHANGE VERSION
sudo rm -rf nginx-1.15.10.tar.gz ## CHANGE VERSION

## DOWNLOAD SOURCE FOR BROTLI

cd /usr/local/src
sudo git clone https://github.com/google/ngx_brotli.git
cd ngx_brotli
sudo git submodule update --init --recursive

## DOWNLOAD LATEST PAGESPEED MODULE - SEE https://github.com/apache/incubator-pagespeed-ngx/releases FOR RELEASES

cd /usr/local/src
sudo wget https://github.com/apache/incubator-pagespeed-ngx/archive/latest-stable.tar.gz
sudo tar -xzvf latest-stable.tar.gz
sudo rm latest-stable.tar.gz

## GET PSOL FOR CURRENT RELEASE OF PAGESPEED

cd incubator-pagespeed-ngx-latest-stable
sudo scripts/format_binary_url.sh PSOL_BINARY_URL
sudo wget https://dl.google.com/dl/page-speed/psol/1.13.35.2-x64.tar.gz ## CHANGE VERSION
sudo tar -xzvf 1.13.35.2-x64.tar.gz ## CHANGE VERSION

## GET EXISTING NGINX CONFIGURATION ARGUMENTS
sudo nginx -V
## USE THESE CONFIGURATION ARGUMENTS FOR NOW
--with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads --add-module=/usr/local/src/ngx_brotli --sbin-path=/usr/sbin/nginx --with-cc=/usr/lib/gcc-mozilla/bin/gcc --with-ld-opt=-static-libstdc++ --add-module=/usr/local/src/incubator-pagespeed-ngx-latest-stable


###########################################################################
## CONFIGURATION ARGUMENTS COMPILED AND SHOULD WORK BELOW
## COPYING ALL CONFIG ARGUMENTS AND EDITING FROM NGINX NOT NECESSARY
## NOTES FROM PREVIOUS ATTEMPTS KEPT IN CASE OF ERRORS

## COPY ALL CONFIGURE ARGUMENTS
--with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads
## ADD ADDITIONAL CONFIGURATION ARGUMETNS TO END OF EXISTING CONFIG
--add-module=/usr/local/src/ngx_brotli --sbin-path=/usr/sbin/nginx
## ADD PAGESPEED MODULE TO END OF CONFIGURATION ARUGMETNS
--add-module=/usr/local/src/incubator-pagespeed-ngx-latest-stable
## ADD PAGESPEED NGINX EXTRA FLAGS
## REMOVED: DOES NOT COMPILE WITH THESE FLAGS USED
## --with-cc=/usr/lib/gcc-mozilla/bin/gcc  --with-ld-opt=-static-libstdc++
## REMOVE ALL --add-dynamic-module ARGUMENTS FROM CONFIG: RESULT IS BELOW
--with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads --add-module=/usr/local/src/ngx_brotli --sbin-path=/usr/sbin/nginx --with-cc=/usr/lib/gcc-mozilla/bin/gcc --with-ld-opt=-static-libstdc++ --add-module=/usr/local/src/incubator-pagespeed-ngx-latest-stable
###########################################################################

## CONFIGURE NGINX

cd /usr/local/src/nginx-1.19.9
sudo ./configure --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads --add-module=/usr/local/src/ngx_brotli --sbin-path=/usr/sbin/nginx --add-module=/usr/local/src/incubator-pagespeed-ngx-latest-stable
sudo make
sudo make install

## BACKUP CURRENT SITES (OPTIONAL: IN CASE NGINX DIRECTORY GETS REMOVED)

sudo mkdir /etc/nginx/sites-available
sudo mkdir /etc/nginx/sites-enabled

cd /etc/nginx/sites-available
sudo tar -czf sites.tar.gz /etc/nginx/sites-available/*
scp ${SSH_SERVER}:/etc/nginx/sites-available/sites.tar.gz sites.tar.gz

## REMOVE CURRENT NGINX AND CHECK NEW INSTALLATION
## DEBUGGING: REMOVED PAGESPEED NGINX EXTRA FLAGS

cd /usr/local/src/nginx-1.15.10
sudo apt-get remove nginx nginx-core nginx-common
sudo checkinstall

## IF YOU HAVE CONFLICTS INSTALLING

sudo apt list --installed | grep -i nginx

## ADD NGINX SERVICE IF NOT FOUND
sudo nano /etc/systemd/system/nginx.service

---
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/bin/nginx -t
ExecStart=/usr/bin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
---


## CHECK NEWLY INSTALLED NGINX

sudo service nginx restart
nginx -v

## IF NGINX SERVICE IS MASKED

sudo systemctl unmask nginx.service
sudo systemctl start nginx
sudo systemctl status nginx
sudo systemctl enable nginx

## ADD BROTLI TO NGINX CONF

http {
	## BROTLI SETTINGS
	brotli on;
	brotli_comp_level 4;
	brotli_static on;
}

## ADD GZIP AS A FALLBACK

http {
	## GZIP SETTINGS
	gzip on;
	gzip_proxied any;
	gzip_comp_level 6;
	gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;
}

## SETUP PAGESPEED FOR NGINX CONF
http {
	pagespeed on;
	pagespeed FileCachePath "/var/ngx_pagespeed_cache/";
	pagespeed RewriteLevel CoreFilters;
	pagespeed ListOutstandingUrlsOnError on;
}

## PAGESPEED FOR SERVER BLOCK
server {
	location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
		add_header "" "";
	}
	location ~ "^/pagespeed_static/" { }
	location ~ "^/ngx_pagespeed_beacon$" { }

	pagespeed EnableFilters rewrite_javascript;
	pagespeed EnableFilters rewrite_css;
	pagespeed EnableFilters defer_javascript;
	pagespeed EnableFilters prioritize_critical_css;
	pagespeed EnableFilters move_css_to_head;

	pagespeed EnableFilters lazyload_images;
	pagespeed LazyloadImagesAfterOnload off;
	pagespeed LazyloadImagesBlankUrl "https://www.gstatic.com/psa/static/1.gif";
	pagespeed EnableFilters rewrite_images;

	pagespeed EnableFilters collapse_whitespace;
	pagespeed EnableFilters remove_comments;

	pagespeed EnableFilters debug;
}

## ADD BROWSER CACHING TO SERVER BLOCK

server {
	location ~*  \.(jpg|jpeg|png|gif|ico|css|js|pdf)$ {
		expires 7d;
	}
}


###########################################################################
## FLUSH PAGESPEED CACHE FOR APPLICATION UPDATES
###########################################################################

## NOT PREFFERED sudo rm -rf /var/ngx_pagespeed_cache/*
sudo touch /var/ngx_pagespeed_cache/cache.flush ## POSSIBLE WITH CONFIG
