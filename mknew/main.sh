#!/bin/bash
#
# Application: mknew (Github version)
# Comment:     Create new script-project
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
VERSION=3.4
if [ ! $1 ];then
	echo "Create new toolbox-script from template in current location."
	echo -e "Usage: toolbox-mknew <NAME>\n"
	exit 0
fi
echo "Creating directory $PWD/$1 ..."
sleep .2
mkdir $PWD/$1

echo "Creating files ..."
sleep .2
touch $PWD/$1/BUGS
touch $PWD/$1/NOTES
touch $PWD/$1/CHANGELOG
touch $PWD/$1/README
touch $PWD/$1/build.cfg
touch $PWD/$1/install.sh
touch $PWD/$1/main.sh

echo "Configuring build.cfg ..."
sleep .2
echo "NAME=\"$1\"" >> $PWD/$1/build.cfg
echo "COMMENT=\"\"" >> $PWD/$1/build.cfg
echo "COPY=\"William Andersson 2024\"" >> $PWD/$1/build.cfg
echo "WEB=\"https://github.com/william-andersson\"" >> $PWD/$1/build.cfg
echo "LICENSE=\"GPL\"" >> $PWD/$1/build.cfg
sleep 1

echo "Configuring install.sh ..."
sleep .2
echo "#!/bin/bash" >> $PWD/$1/install.sh
echo "if [[ \$EUID -ne 0 ]]; then" >> $PWD/$1/install.sh
echo "   echo \"This script must be run as root\"" >> $PWD/$1/install.sh
echo "   exit 1" >> $PWD/$1/install.sh
echo "fi" >> $PWD/$1/install.sh
echo "" >> $PWD/$1/install.sh
echo "DEPENDENCIES=(\"\")" >> $PWD/$1/install.sh
echo "" >> $PWD/$1/install.sh
echo "install -v -C -m 775 -o root main.sh /usr/bin/toolbox-$1" >> $PWD/$1/install.sh
echo "" >> $PWD/$1/install.sh
echo "if [ ! -z \"\$DEPENDENCIES\" ];then" >> $PWD/$1/install.sh
echo "    /usr/bin/toolbox-depin \${DEPENDENCIES[@]}" >> $PWD/$1/install.sh
echo "fi" >> $PWD/$1/install.sh
echo "" >> $PWD/$1/install.sh
echo "echo \"Done.\"" >> $PWD/$1/install.sh


echo "Configuring main.sh ..."
sleep .2
echo "#!/bin/bash" >> $PWD/$1/main.sh
echo "VERSION=1.0" >> $PWD/$1/main.sh

echo "Done."
