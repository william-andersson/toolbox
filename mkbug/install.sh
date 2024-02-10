#!/bin/bash
#
# File for:    mkbug (Github version)
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

DEPENDENCIES=("")

install -v -C -m 775 -o root mkbug.sh /usr/bin/toolbox-mkbug

if [ ! -z "$DEPENDENCIES" ];then
    /usr/bin/toolbox-depin ${DEPENDENCIES[@]}
fi

echo "Done."
