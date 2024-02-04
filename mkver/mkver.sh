#!/bin/bash
#
# Application: mkver (Github version)
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
VERSION=1.5
if [ -z "$1" ] || [ "$1" == "--help" ];then
	echo -e "Usage: $0 <OPTION>"
	echo -e "Create new version for source,package or github\n"
	echo -e "Options"
	echo -e "--src\t\tCreate new source archive."
	echo -e "--pkg\t\tCreate new package."
	echo -e "--git\t\tCreate new github version.\n"
	exit 0
fi

if [ ! -f "build.cfg" ];then
	echo "Error, missing file build.cfg"
	exit 1
fi

source $PWD/build.cfg
echo -e "##### ${0##*/} version $VERSION #####\n"
TIMESTAMP=$(date +%d-%m-%Y)
GET_VER_NUM=$(grep -m 1 'VERSION=' $NAME.sh | sed 's/^.*=//')

if [ ! -d "builds" ];then
	echo "Creating directory [builds] ..."
	mkdir builds
fi

if [ "$1" == "--src" ];then
	if [ ! -d "builds/src" ];then
		echo "Creating directory [builds/src] ..."
		mkdir builds/src
	fi
	if [ -f "./builds/src/$NAME-$GET_VER_NUM.tar" ];then
		echo -e "\033[31mWarning, a source package with version $GET_VER_NUM already exists!\033[0m"
		read -p "Overwrite [y/n]? " QUEST
		if [ $QUEST != "y" ];then
			echo -e "\nAborted."
			exit 1
		fi
	fi
	echo "Creating source package of current version ($GET_VER_NUM)."
	sleep 1
	echo "Package name: $NAME-$GET_VER_NUM.tar"
	echo "Application: $NAME" > INFO
	echo "Version: $GET_VER_NUM" >> INFO
	echo "Build date: $TIMESTAMP" >> INFO
	echo "Copyright: $COPY" >> INFO
	echo "Website: $WEB" >> INFO
	echo "License: $LICENSE" >> INFO
	tar --exclude={'builds','build.cfg','CHANGELOG','TODO','README'} -cpvf ./builds/src/$NAME-$GET_VER_NUM.tar *
	rm INFO
fi

if [ "$1" == "--pkg" ];then
	if [ ! -d "builds/pkg" ];then
		echo "Creating directory [builds/pkg] ..."
		mkdir builds/pkg
	fi
	if [ -f "./builds/pkg/$NAME-$GET_VER_NUM.pkg" ];then
		echo -e "\033[31mWarning, a package with version $GET_VER_NUM already exists!\033[0m"
		read -p "Overwrite [y/n]? " QUEST
		if [ $QUEST != "y" ];then
			echo -e "\nAborted."
			exit 1
		fi
	fi
	echo "Creating package of current version ($GET_VER_NUM)."
	sleep 1
	echo "Package name: $NAME-$GET_VER_NUM.pkg"
	echo "Application: $NAME" > INFO
	echo "Version: $GET_VER_NUM" >> INFO
	echo "Build date: $TIMESTAMP" >> INFO
	echo "Copyright: $COPY" >> INFO
	echo "Website: $WEB" >> INFO
	echo "License: $LICENSE" >> INFO
	tar --exclude={'builds','build.cfg'} -cpvf ./builds/pkg/$NAME-$GET_VER_NUM.pkg *
	rm INFO
fi

if [ "$1" == "--git" ];then
	if [ ! -d "builds/git" ];then
		echo "Creating directory [builds/git] ..."
		mkdir builds/git
	fi
	echo "Preparing version ($GET_VER_NUM) for github."
	sleep 1
	FILES=$(ls | grep -v -e "builds" -e "build.cfg" -e "CHANGELOG" -e "TODO")
	for f in $FILES;do
		cp -v $f ./builds/git/
	done
	for script in $(ls ./builds/git/ | grep .sh);do
		sed -i '2 i\#' ./builds/git/$script
		sed -i '2 i\# License:     '"$LICENSE"'' ./builds/git/$script
		sed -i '2 i\# Website:     '"$WEB"'' ./builds/git/$script
		sed -i '2 i\# Copyright:   '"$COPY"'' ./builds/git/$script
		if [ "$script" == "$NAME.sh" ];then
			sed -i '2 i\# Application: '"$NAME"' (Github version)' ./builds/git/$script
			sed -i '2 i\#' ./builds/git/$script
		else
			sed -i '2 i\# File for:    '"$NAME"' (Github version)' ./builds/git/$script
			sed -i '2 i\#' ./builds/git/$script
		fi
	done
fi

sleep 1
echo -e "\nDone."
