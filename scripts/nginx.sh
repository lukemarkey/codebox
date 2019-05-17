## HARDEN NGINX CONF

http {

	server_tokens off;

	add_header X-Frame-Options "SAMEORIGIN";
	add_header X-Content-Type-Options nosniff;

	add_header X-XSS-Protection "1; mode=block";

}

## CREATE NGINX SERVER BLOCK

sudo touch /etc/nginx/sites-available/${SITE_NAME}
sudo ln -s /etc/nginx/sites-available/${SITE_NAME} /etc/nginx/sites-enabled/

## WORDPRESS SERVER BLOCK

sudo nano /etc/nginx/sites-available/${SITE_NAME}
---
server {

	listen 80;
	server_name ${DOMAINS};
	root ${SITE_PATH};
	index index.php index.html index.htm;

	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	location ~ \.php$ {
		try_files $uri =404;
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
		root ${SITE_PATH};
	}

	location = /favicon.ico { log_not_found off; access_log off; }
	location = /robots.txt { log_not_found off; access_log off; allow all; }

	# BROWSER CACHE
	location ~* \.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
		expires max;
		log_not_found off;
		access_log off;
	}

	# HARDEN UPLOADS
	location ~* ^/wp-content/uploads/.*.(html|htm|shtml|php|js|swf)$ {
		deny all;
	}

	# DENY ACCESS TO WP-CONFIG
	location ~* wp-config.php {
	    deny all;
	}

	## WORDFENCE SECURITY - ADD TO NGINX SERVER FOR WEBSITE
	location ~ ^/\.user\.ini {
		deny all;
	}

	## BLOCK WP BROWSING AND FILE EDITING
	location ~* wp-admin/includes { deny all; }
	location ~* wp-includes/theme-compat/ { deny all; }
	location ~* wp-includes/js/tinymce/langs/.*.php { deny all; }
	location /wp-includes/ { internal; }

	## NOTE: MUST ADD limit_req_zone $binary_remote_addr zone=one:10m rate=1r/s; TO HTTP CONFIG
	# DENY BRUTE FORCE ON WP-LOGIN
	#location = /wp-login.php {
	#    limit_req zone=one burst=1 nodelay;
	#    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	#}

	location ~ /\.ht {
		deny all;
	}

}
---

## DJANGO SERVER BLOCK

sudo nano /etc/nginx/sites-available/${SITE_NAME}
---
server {

	server_name ${DOMAIN};

	root ${SITE_DIRECTORY};

	location = /favicon.ico { access_log off; log_not_found off; }

	location /static/ {
		root ${SITE_DIRECTORY};
	}

	location /media/ {
		root ${SITE_DIRECTORY};
	}

	location ~*  \.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
	    expires 7d;
	}

	location / {
		include proxy_params;
		proxy_pass http://unix:/home/luke/projects/${SITE_NAME}/${SITE_NAME}.sock;
	}

	location ~ /.well-known {
		allow all;
	}

}
---

## NGINX REDIRECT

sudo nano /etc/nginx/sites-available/${SITE_NAME}
---
server {
	listen 80;
	# listen 443 ssl;
	server_name ${REDIRECT_DOMAINS};
	return 301 $scheme://${REDIRECT_DOMAIN}$request_uri;
}
---
