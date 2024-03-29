#!/bin/bash
#
# File for:    mkver (Github version)
# Comment:     Create new version for source,package or github
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

##### Script installation instructions #####
DEPENDENCIES=("")
# Copy scripts
install -v -C -m 775 -o root main.sh /usr/bin/toolbox-mkver

if [ ! -z "$DEPENDENCIES" ];then
	/usr/bin/toolbox-depin ${DEPENDENCIES[@]}
fi

echo "Done."
