#!/bin/bash

## SCRIPT VARIABLES

DATE=`date +%Y-%m-%d`
TIMESTAMP=$(date +%F_%T | tr ':' '-')

## USER ARGUMENT FLAGS

FILENAME=${1}
COMPRESSION_SOURCE=${HOME}/${1}
COMPRESSION_PATH=/home/luke/backup

/bin/tar -czvf ${COMPRESSION_PATH}/${FILENAME}.gz /home/luke/codebox /home/luke/toolbox /home/luke/kirin /home/luke/.config/sublime-text-3/Packages/User/snippets
