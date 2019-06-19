#!/bin/bash

template=`cat website/templates/website/home.html`

echo -e "CSS Links"

while read line; do

	if [[ $line == *"rel=\"stylesheet\""* ]]; then
		echo $line
	fi

done < website/templates/website/home.html
