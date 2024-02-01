#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
# Copy scripts
install -v -C -m 775 -o root toolbox-create.sh /usr/bin/toolbox-create
echo "Done."
