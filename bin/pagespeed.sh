#!/bin/bash

WEBSITE=()
WEBSITE+=('https://aimresearchservices.com/')

curl https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=https://aimresearchservices.com/&key=$API_KEY
