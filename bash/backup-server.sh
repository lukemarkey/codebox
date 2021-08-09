#!/bin/bash

###########################################################################
## BACKUP WEB SERVERS
###########################################################################
## SUDO CRONTAB SUNDAYS @ 12AM: 0 0 * * 0 /home/luke/codebox/bash/server-backup.sh /home /var/spool/mail /etc /root /boot /opt /usr /var/log


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

## FILES="/home /var/spool/mail /etc /root /boot /opt /usr /var/log"
FILES="$@"
DESTINATION="/home/luke/backup"
FILENAME="django-server-${DATE}.tar.gz"

echo "$@"

## DELETE OLD BACKUP
/bin/rm -rf ${DESTINATION}/${FILENAME}*
## BACKUP FILES TO DESTINATION
/bin/tar -zcf ${DESTINATION}/${FILENAME} ${FILES}
