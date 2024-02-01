#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
VERSION=1.0

DNF="dnf -y install"
APT="apt-get -y install"
ZYP="zypper -n install"
PKG_MGR=""
if command -v zypper &> /dev/null;then
	PKG_MGR=$ZYP
elif command -v apt-get &> /dev/null;then
	PKG_MGR=$APT
elif command -v dnf &> /dev/null;then
	PKG_MGR=$DNF
else
	echo "No package-manager found!"
	echo "Please install dependencies: $@"
	exit 0
fi
for DEP in $@;do
	if ! command -v $DEP &> /dev/null;then
		$PKG_MGR $DEP}
	fi
done
