#!/bin/bash

CODEBOX_PATH=/home/luke/codebox
KIRIN_PATH=/home/luke/kirin

if [ ! -d $CODEBOX_PATH ]; then
	cd /home/luke && /usr/bin/git clone git@github.com:lukemarkey/codebox.git
fi

if [ ! -d $KIRIN_PATH ]; then
	cd /home/luke && /usr/bin/git clone git@github.com:lukemarkey/kirin.git
fi
cd

cd $CODEBOX_PATH && /usr/bin/git pull
cd $KIRIN_PATH && /usr/bin/git pull
cd
