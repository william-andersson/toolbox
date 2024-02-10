#!/bin/bash
#
# Application: mkver (Github version)
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
VERSION=1.7
if [ -z "$1" ] || [ "$1" == "--help" ];then
	echo -e "Usage: $0 <OPTION>"
	echo -e "Create new version for source,package or github\n"
	echo -e "Options"
	echo -e "--src\t\tCreate new source archive."
	echo -e "\t\tMakes a backup of current version in ./builds/src/"
	echo -e "--pkg\t\tCreate new package."
	echo -e "\t\tMakes a distributable package in ./builds/pkg/"
	echo -e "\t\texcluding unnecessary files."
	echo -e "--git\t\tCreate new github version."
	echo -e "\t\tMakes a copy of current version in ./builds/pkg/"
	echo -e "\t\texclude unnecessary files and write a header to all .sh files."
	exit 0
fi

if [ ! -f "$PWD/build.cfg" ];then
	echo "Error, missing file $PWD/build.cfg"
	exit 1
fi

source $PWD/build.cfg
echo -e "##### ${0##*/} version $VERSION #####\n"
TIMESTAMP=$(date +%d-%m-%Y)
GET_VER_NUM=$(grep -m 1 'VERSION=' $NAME.sh | sed 's/^.*=//')

if [ ! -d "$PWD/builds" ];then
	echo "Creating directory [$PWD/builds] ..."
	mkdir $PWD/builds
fi

if [ "$1" == "--src" ];then
	if [ ! -d "$PWD/builds/src" ];then
		echo "Creating directory [$PWD/builds/src] ..."
		mkdir $PWD/builds/src
	fi
	if [ -f "$PWD/builds/src/$NAME-$GET_VER_NUM.tar" ];then
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
	echo "Application: $NAME" > $PWD/INFO
	echo "Version: $GET_VER_NUM" >> $PWD/INFO
	echo "Build date: $TIMESTAMP" >> $PWD/INFO
	echo "Copyright: $COPY" >> $PWD/INFO
	echo "Website: $WEB" >> $PWD/INFO
	echo "License: $LICENSE" >> $PWD/INFO
	tar --exclude='builds' -cpvf $PWD/builds/src/$NAME-$GET_VER_NUM.tar *
	rm INFO
fi

if [ "$1" == "--pkg" ];then
	if [ ! -d "$PWD/builds/pkg" ];then
		echo "Creating directory [builds/pkg] ..."
		mkdir $PWD/builds/pkg
	fi
	if [ -f "$PWD/builds/pkg/$NAME-$GET_VER_NUM.pkg" ];then
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
	echo "Application: $NAME" > $PWD/INFO
	echo "Version: $GET_VER_NUM" >> $PWD/INFO
	echo "Build date: $TIMESTAMP" >> $PWD/INFO
	echo "Copyright: $COPY" >> $PWD/INFO
	echo "Website: $WEB" >> $PWD/INFO
	echo "License: $LICENSE" >> $PWD/INFO
	tar --exclude={'builds','build.cfg','BUGS','NOTES'} -cpvf $PWD/builds/pkg/$NAME-$GET_VER_NUM.pkg *
	rm INFO
fi

if [ "$1" == "--git" ];then
	if [ ! -d "$PWD/builds/git" ];then
		echo "Creating directory [builds/git] ..."
		mkdir $PWD/builds/git
	fi
	echo "Preparing version ($GET_VER_NUM) for github."
	sleep 1
	FILES=$(ls | grep -v -e "builds" -e "build.cfg" -e "CHANGELOG" -e "NOTES" -e "BUGS")
	for f in $FILES;do
		cp -v $f $PWD/builds/git/
	done
	for script in $(ls $PWD/builds/git/ | grep .sh);do
		sed -i '2 i\#' $PWD/builds/git/$script
		sed -i '2 i\# License:     '"$LICENSE"'' $PWD/builds/git/$script
		sed -i '2 i\# Website:     '"$WEB"'' $PWD/builds/git/$script
		sed -i '2 i\# Copyright:   '"$COPY"'' $PWD/builds/git/$script
		if [ "$script" == "$NAME.sh" ];then
			sed -i '2 i\# Application: '"$NAME"' (Github version)' $PWD/builds/git/$script
			sed -i '2 i\#' $PWD/builds/git/$script
		else
			sed -i '2 i\# File for:    '"$NAME"' (Github version)' $PWD/builds/git/$script
			sed -i '2 i\#' $PWD/builds/git/$script
		fi
	done
fi

sleep 1
echo -e "\nDone."
