#!/bin/bash
#
# File for:    depin (Github version)
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

install -v -C -m 775 -o root depin.sh /usr/bin/toolbox-depin
echo "Done."
