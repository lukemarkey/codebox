#!/bin/bash


# SCRIPT VARIABLES

OPTIND=1;
SCRIPT=$( basename "${BASH_SOURCE[0]}" ); # SCRIPT NAME
SCRIPTPATH=$( cd "$(dirname "$0")" || exit; pwd -P ); # ABSOLUTE PATH OF SCRIPT DIRECTORY
SCRIPTMOD=$( stat -c %Y "${SCRIPTPATH}"/"${SCRIPT}" ); # SCRIPT LAST MOD TIMESTAMP
NUMARGS=$#; # NUMBER OF ARGUMENTS PASS FROM CLI

DATE=`date +%Y-%m-%d`
TIMESTAMP=$(date +%F_%T | tr ':' '-')

## USER VARIABLES

FOLDER="$1"
FILENAME="${FOLDER}-${DATE}"
BACKUP_FILE="/home/luke/backup/${FILENAME}"
S3DIR="s3://luke.h.markey-backup/office"
# S3DIR="http://lukemarkey-backups.s3.amazonaws.com/office"
DESTINATION="${S3DIR}/${FOLDER}/${FILENAME}"

## TODO: RUN COMMAND AND GET FULL VARIABLE PRINTOUT
BASE64MD5="$(/usr/bin/openssl md5 -binary ${BACKUP_FILE} | base64)"

echo "$FOLDER"
echo "$BASE64MD5"
echo "$BACKUP_FILE"
echo "$S3DIR"
echo "$DESTINATION"

## LOOK INTO S3CMD MODIFY HEADER
## SEE IF SAME FILENAME NECESSARY FOR HASH
/usr/bin/s3cmd put ${BACKUP_FILE} ${DESTINATION}
