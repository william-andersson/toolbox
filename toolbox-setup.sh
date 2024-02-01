#!/bin/bash
#
# Run through all scripts and install them
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

install -v -C -m 775 -o root depin.sh /usr/bin/toolbox-depin
if [ -n "$1" ]; then
	if [ ! -d "$1" ]; then
		echo "Error, no such directory [$1]"
		exit 1
	else
		cd $1
		echo "Installing $1"
		sleep 1
		./install.sh
		cd ..
	fi
else
	for tool in $(ls -d */);do
		cd $tool
		echo "Installing ${tool%/} ..."
		sleep 1
		./install.sh
		cd ..
	done
fi
