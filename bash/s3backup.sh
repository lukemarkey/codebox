#!/bin/bash

# SCRIPT VARIABLES

OPTIND=1;
SCRIPT=$( basename "${BASH_SOURCE[0]}" ); # SCRIPT NAME
SCRIPTMOD=$( stat -c %Y "${SCRIPTPATH}"/"${SCRIPT}" ); # SCRIPT LAST MOD TIMESTAMP
NUMARGS=$#; # NUMBER OF ARGUMENTS PASS FROM CLI

DATE=`date +%Y-%m-%d`
TIMESTAMP=$(date +%F_%T | tr ':' '-')

## USER VARIABLES

FOLDER="$1"
FILENAME="$1-${DATE}.tar.gz"
BACKUP_FILE="/home/luke/backup/$FILENAME"
S3DIR="s3://luke.h.markey-backup/django"
DESTINATION="${S3DIR}/$FILENAME"

## TODO: RUN COMMAND AND GET FULL VARIABLE PRINTOUT
# BASE64MD5="$(/usr/bin/openssl md5 -binary ${BACKUP_FILE} | base64)"

# echo "$FOLDER"
# echo "$FILENAME"
# echo "$BASE64MD5"
# echo "$BACKUP_FILE"
# echo "$S3DIR"
# echo "$DESTINATION"

## DEBUG MULTIPART UPLOAD FOR S3CMD
## dry run: -n
## verbose: -v
## debug: -d

## aws s3 cp /home/luke/backup/videos-2019-06-21.tar.gz s3://luke.h.markey-backup/office/videos/videos-2019-06-21.tar.gz

## s3cmd info s3://luke.h.markey-backup
## s3cmd ls s3://luke.h.markey-backup/office/

## md5sum videos-2019-06-21.tar.gz
## aws s3api list-multipart-uploads --bucket luke.h.markey-backup
## s3cmd abortmp s3://luke.h.markey-backup/office/videos/videos-2019-06-21.tar.gz .DbYXz_4oJdbbMTH966BBt1J.ukt4OC.LCntE17g9I5zD2qWYQ0LWFd_.QawSO7yfSyFOh5kM7wYNHsaa6U8Bzk6fwqgJPrzVv1zRYiA4XYtmky2mpV.qjHHfloI0hJu

## /usr/bin/s3cmd multipart s3://luke.h.markey-backup/django/django-2019-06-19.tar.gz
## /usr/bin/s3cmd put -v --add-header=content-md5:d97557b96eceead5de4e4d706a15ce1b /home/luke/backup/videos-2019-06-21.tar.gz s3://luke.h.markey-backup/office/videos/videos-2019-06-21.tar.gz

/usr/bin/aws s3 cp ${BACKUP_FILE} ${DESTINATION}
