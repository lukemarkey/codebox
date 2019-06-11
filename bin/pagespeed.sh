#!/bin/bash

WEBSITE=()
WEBSITE+=('https://aimresearchservices.com/')

API_KEY='AIzaSyC1HpXKskB1L26v3EvPI4VQLbg3hJz_yOc'

curl https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=https://aimresearchservices.com/&key=$API_KEY
