#!/bin/bash
#
# Application: mkbug (Github version)
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
VERSION=1.2

if [ ! -f "$PWD/BUGS" ];then
	touch $PWD/BUGS
fi

if [ ! -f "$PWD/build.cfg" ];then
	echo "Error, missing file $PWD/build.cfg"
	exit 1
fi

source $PWD/build.cfg
GET_DATE=$(date +%d-%m-%Y)
GET_VERSION=$(grep -m 1 'VERSION=' /usr/bin/toolbox-$NAME | sed 's/^.*=//')
echo -e "##### ${0##*/} version $VERSION #####\n"
echo "Filing bug for $NAME version $GET_VERSION"
sleep 1

for id in $(grep ID. BUGS | sed 's/^.*\.//' | awk '{print $1}');do
	ID=$id
done
ID=$((ID+1))
if [ "$ID" -lt "10" ];then
	SET_ID="000$ID"
elif [ "$ID" -lt "100" ];then
	SET_ID="00$ID"
elif [ "$ID" -lt "1000" ];then
	SET_ID="0$ID"
else
	SET_ID="$ID"
fi

read -p "Title: " GET_TITLE
read -p "Summary: " GET_SUMMARY
read -p "Severity [critical,security,major,minor]: " GET_SEVERITY
read -p "Priority [high,medium,low]: " GET_PRIORITY
read -p "Reproduce [always, some times, unknown]: " GET_REPRODUCE

echo "ID.$SET_ID - $GET_TITLE" >> $PWD/BUGS
echo -e "\tSummary: $GET_SUMMARY" >> $PWD/BUGS
echo -e "\tDate: $GET_DATE" >> $PWD/BUGS
echo -e "\tVersion: $GET_VERSION" >> $PWD/BUGS
echo -e "\tSeverity: $GET_SEVERITY" >> $PWD/BUGS
echo -e "\tPriority: $GET_PRIORITY" >> $PWD/BUGS
echo -e "\tReproduce: $GET_REPRODUCE" >> $PWD/BUGS
echo -e "\tFixed:" >> $PWD/BUGS
echo -e "" >> $PWD/BUGS

echo -e "\nNew bug filed [ID.$SET_ID]"
echo -e "Done.\n"
