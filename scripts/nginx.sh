## HARDEN NGINX CONF

http {

    ## grep processor /proc/cpuinfo | wc -l FOR CPU CORES / WORKERS
    worker_processes 2;
    ## ulimit -n (AMOUNT OF CONNECTIONS AT SAME TIME / SECOND)
    worker_connections 1024;

    server_tokens off;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options nosniff;

    add_header X-XSS-Protection "1; mode=block";
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log error;

    ## BROTLI SETTINGS

    brotli on;
    brotli_comp_level 6;
    brotli_static on;
    brotli_types text/plain text/css application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript image/x-icon image/vnd.microsoft.icon image/bmp image/svg+xml;

    ## GZIP SETTINGS

    gzip on;
    gzip_disable "msie6";
    gzip_min_length 256;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_vary on;
    gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;

    ## PAGESPEED SETTINGS

    pagespeed on;
    pagespeed FileCachePath "/var/ngx_pagespeed_cache/";
    pagespeed FileCacheSizeKb 102400000;
    pagespeed FileCacheCleanIntervalMs 3600000;
    pagespeed FileCacheInodeLimit 500000;

    pagespeed RewriteLevel CoreFilters;
    pagespeed ListOutstandingUrlsOnError on;



}

## PAGESPEED SERVER BLOCK SETTINGS

server {

    ## PAGESPEED SETTINGS
    ## UNABLE TO USE NGINX CACHE WITH PAGESPEED

    location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
        add_header "" "";
    }
    location ~ "^/pagespeed_static/" { }
    location ~ "^/ngx_pagespeed_beacon$" { }

    pagespeed EnableFilters rewrite_javascript;
    pagespeed EnableFilters rewrite_css;
    pagespeed EnableFilters defer_javascript;
    pagespeed EnableFilters prioritize_critical_css;
    pagespeed EnableFilters resize_rendered_image_dimensions;

    pagespeed EnableFilters lazyload_images;
    pagespeed LazyloadImagesAfterOnload off;
    pagespeed LazyloadImagesBlankUrl "https://www.gstatic.com/psa/static/1.gif";
    pagespeed EnableFilters rewrite_images;

    pagespeed EnableFilters collapse_whitespace;
    pagespeed EnableFilters remove_comments;

    ## MAKE SURE WORDPRESS DOESNT ALREADY CACHE
    pagespeed EnableFilters extend_cache;

    pagespeed EnableFilters insert_dns_prefetch;

    ## pagespeed EnableFilters debug;
}

## STATIC FILE CACHE SERVER BLOCK SETTINGS

server {

     ## STATIC FILE CACHE
     location ~* .(ico|css|js|gif|jpeg|jpg|png|woff|ttf|otf|svg|woff2|eot)$ {
        expires 365d;
        add_header Cache-Control "public, max-age=31536000";
    }

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
    # location ~* \.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
    #   expires max;
    #   log_not_found off;
    #   access_log off;
    # }

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
    ## location /wp-includes/ { internal; }

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
