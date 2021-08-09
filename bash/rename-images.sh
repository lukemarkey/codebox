#!/bin/bash

###########################################################################
## RENAMES ALL IMAGES IN CURRENT DIRECTORY 001-00X.jpg
###########################################################################

a=1
for i in *.jpg ; do
	new=$(printf "%03d.jpg" "$a")
	mv -i -- "$i" "$new"
	let a=a+1
done
