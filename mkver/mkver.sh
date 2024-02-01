#!/bin/bash
VERSION=1.2

if [ ! -f "build.cfg" ];then
	echo "Error, missing file build.cfg"
	exit 1
fi
source $PWD/build.cfg

echo -e "##### ${0##*/} version $VERSION #####\n"
TIMESTAMP=$(date +%d-%m-%Y)
GET_VER_NUM=$(grep -m 1 'VERSION=' $NAME.sh | sed 's/^.*=//')
if [ -f "./builds/$NAME-$GET_VER_NUM.tar" ];then
	echo "Warning, a package with version $GET_VER_NUM already exists!"
	read -p "Overwrite [y/n]? " QUEST
	if [ $QUEST != "y" ];then
		echo -e "\nAborted."
		exit 1
	fi
fi
if [ ! -d "builds" ];then
	echo "Creating directory [builds] ..."
	mkdir builds
fi
echo "Creating package of current version ($GET_VER_NUM)."
sleep 1
echo "Package name: $NAME-$GET_VER_NUM.tar"
echo "Version: $GET_VER_NUM" > INFO
echo "Build date: $TIMESTAMP" >> INFO
echo "Copyright: $COPY" >> INFO
echo "License: $LICENSE" >> INFO
tar --exclude='builds' -cpvf ./builds/$NAME-$GET_VER_NUM.tar *
sleep 1
echo -e "\nDone."
