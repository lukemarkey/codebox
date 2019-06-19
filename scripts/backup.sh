###########################################################################
## S3 BUCKET POLICY
###########################################################################

{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${BUCKET_NAME}",
                "arn:aws:s3:::${BUCKET_NAME}/*"
            ]
        }
    ]
}

###########################################################################
## SCRIPT TEMPLATE
###########################################################################

#!/bin/bash

export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export PASSPHRASE=""

DESTINATION="s3://s3.amazonaws.com//luke-office-backups/backup"

## SET UP SOME VARIABLES FOR LOGGING
LOGFILE="/var/log/duplicity/backup.log"
DAILYLOGFILE="/var/log/duplicity/backup.daily.log"
FULLBACKLOGFILE="/var/log/duplicity/backup.full.log"
HOST=`hostname`
DATE=`date +%Y-%m-%d`
MAILADDR="luke.h.markey@gmail.com"
TODAY=$(date +%d%m%Y)

if [ ! -d /var/log/duplicity ];then
    mkdir -p /var/log/duplicity
fi

if [ ! -f $FULLBACKLOGFILE ]; then
    touch $FULLBACKLOGFILE
fi

## CLEAR OLD DAILY LOG FILE
cat /dev/null > ${DAILYLOGFILE}

# TRACE FUNCTION FOR LOGGING, DON'T CHANGE THIS
trace () {
    stamp=`date +%Y-%m-%d_%H:%M:%S`
    echo "$stamp: $*" >> ${DAILYLOGFILE}
}

## SOURCE
SOURCE=/home/luke/codebox

## UNSET ENV VARIABLES
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset PASSPHRASE

###########################################################################
## BACKUP FILES AND UPLOAD TO REMOTE STORAGE
###########################################################################

sudo apt-get install -y duplicity python-boto
sudo apt-get install --reinstall python-gi

## GENERATE GPG KEY PASSWORD
openssl rand -base64 20

## GENERATE GPG KEY
gpg --gen-key

/usr/bin/duplicity \
--progress \
--no-encryption \
--s3-use-new-style \
--num-retries 3 \
--asynchronous-upload -v 4 \
--full-if-older-than 14D \
--exclude=/home/luke/Trash \
--exclude=/home/luke/Downloads \
--exclude=/home/luke/studio3t \
--exclude=/home/luke/themes \
--exclude=/home/luke/VirtualBox VMs \
--exclude=/home/luke/.cache \
--exclude=/home/luke/.local/share/Steam \
--exclude=/home/luke/.gradle \
--exclude=/home/luke/.vagrant.d \
--exclude=/home/luke/.3T \
/home/luke "s3://s3.amazonaws.com//luke-office-backups/backup"

