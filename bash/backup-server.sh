#!/bin/bash

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
FILES="/home /var/spool/mail /etc /root /boot /opt /usr /var/log"
## FILES="/home"
DESTINATION="/mnt/backup"
FILENAME="django-${DATE}"

## BACKUP FILES TO DESTINATION
/bin/tar -zcf ${DESTINATION}/${FILENAME} ${FILES}

## LIST FILES TO CHECK FILE SIZES
ls -lh ${DESTINATION}
