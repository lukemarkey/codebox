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

## USER ARGUMENT FLAGS

if [ "${NUMARGS}" -gt 1 ]; then
	for file in "$@"; do
		SOURCE+="/home/luke/${file} "
		# echo ${SOURCE}
	done
else
	SOURCE=/home/luke/${1}
fi

BACKUPDIR=/home/luke/backup/${1}
FILEPATH=${BACKUPDIR}-${DATE}.tar.gz

## PRINT VARIABLES
# for i in [${TIMESTAMP} ${SOURCE} ${BACKUPDIR} ${FILEPATH}]; do
# 	echo "${i}"
# done

## UPDATE TAR
/bin/rm -rf ${BACKUPDIR}*
/bin/tar -czf ${FILEPATH,,} ${SOURCE} ## FILEPATH LOWERCASE
