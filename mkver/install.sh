#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

##### Script installation instructions #####
DEPENDENCIES=("")
# Copy scripts
install -v -C -m 775 -o root mkver.sh /usr/bin/toolbox-mkver

if [ ! -z "$DEPENDENCIES" ];then
	/usr/bin/toolbox-depin ${DEPENDENCIES[@]}
fi

echo "Done."
