#!/bin/bash

# export AWS_ACCESS_KEY_ID=""
# export AWS_SECRET_ACCESS_KEY=""
# export PASSPHRASE=""

BACKUP_DIRECTORY="/home/luke/backup"
DESTINATION="s3://lukemarkey-backups/office"

## SET UP SOME VARIABLES FOR LOGGING
DATE=`date +%Y-%m-%d`
TODAY=$(date +%d%m%Y)
TIMESTAMP=$(date +%F_%T | tr ':' '-')

/bin/tar -czvf ${BACKUP_DIRECTORY}/projects.gz /home/luke/projects
# /bin/tar -czvf ${BACKUP_DIRECTORY}/assets.gz /home/luke/assets
# /bin/tar -czvf ${BACKUP_DIRECTORY}/documents.gz /home/luke/Documents
# /bin/tar -czvf ${BACKUP_DIRECTORY}/videos.gz /home/luke/Videos
# /bin/tar -czvf ${BACKUP_DIRECTORY}/codebox.gz /home/luke/codebox /home/luke/toolbox /home/luke/kirin /home/luke/.config/sublime-text-3/Packages/User/snippets

MD5_PROJECTS = /usr/bin/md5sum ${BACKUP_DIRECTORY}/projects.gz

s3cmd --add-header='Content-MD5: ${MD5_PROJECTS}' put ${BACKUP_DIRECTORY}/projects.gz ${DESTINATION}/projects/projects-${TIMESTAMP}
# s3cmd put ${BACKUP_DIRECTORY}/assets.gz ${DESTINATION}/assets/assets-${TIMESTAMP}
# s3cmd put ${BACKUP_DIRECTORY}/documents.gz ${DESTINATION}/documents/documents-${TIMESTAMP}
# s3cmd put ${BACKUP_DIRECTORY}/videos.gz ${DESTINATION}/videos/videos-${TIMESTAMP}
# s3cmd put ${BACKUP_DIRECTORY}/codebox.gz ${DESTINATION}/codebox/codebox-${TIMESTAMP}

## UNSET ENV VARIABLES
# unset AWS_ACCESS_KEY_ID
# unset AWS_SECRET_ACCESS_KEY
# unset PASSPHRASE

# s3cmd put --add-header='Content-MD5: ' backup/projects.gz s3://lukemarkey-backups/office/projects/projects-2019-06-16
