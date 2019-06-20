#!/bin/bash

###########################################################################
## BACKUP WEB SERVERS
###########################################################################
## SUDO CRONTAB SUNDAYS @ 6PM: 0 18 * * 0 /home/luke/codebox/bash/server-backup.sh /home /var/spool/mail /etc /root /boot /opt /usr $


# SCRIPT VARIABLES
OPTIND=1;
SCRIPT=$( basename "${BASH_SOURCE[0]}" ); # SCRIPT NAME
SCRIPTPATH=$( cd "$(dirname "$0")" || exit; pwd -P ); # ABSOLUTE PATH OF SCRIPT DIRECTORY
SCRIPTMOD=$( stat -c %Y "${SCRIPTPATH}"/"${SCRIPT}" ); # SCRIPT LAST MOD TIMESTAMP
NUMARGS=$#; # NUMBER OF ARGUMENTS PASS FROM CLI

## SCRIPT VARIABLES
DATE=`date +%Y-%m-%d`
TIMESTAMP=$(date +%F_%T | tr ':' '-')

## BACKUP FILES

FILES="$@"
DESTINATION="/home/luke/backup"
FILENAME="django-${DATE}.gz"

echo "$@"

## BACKUP FILES TO DESTINATION
/bin/tar -zcf ${DESTINATION}/${FILENAME} ${FILES}
