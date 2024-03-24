#!/bin/bash
#
# File for:    mknew (Github version)
# Comment:     Create new script-project
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
# Copy scripts
install -v -C -m 775 -o root main.sh /usr/bin/toolbox-mknew
echo "Done."
