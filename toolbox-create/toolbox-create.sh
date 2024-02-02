#!/bin/bash
VERSION=3.1
if [ ! $1 ];then
	echo "Create new toolbox-script from template in current location."
	echo -e "Usage: toolbox-create NAME\n"
	exit 0
fi
echo "Creating directory $1 ..."
sleep .2
mkdir $1

echo "Creating files ..."
sleep .2
touch $1/TODO
touch $1/CHANGELOG
touch $1/build.cfg
touch $1/install.sh
touch $1/$1.sh

echo "Configuring build.cfg ..."
sleep .2
echo "NAME=\"$1\"" >> $1/build.cfg
echo "COPY=\"William Andersson 2024\"" >> $1/build.cfg
echo "WEB=\"https://github.com/william-andersson\"" >> $1/build.cfg
echo "LICENSE=\"GPL\"" >> $1/build.cfg
sleep 1


echo "Configuring install.sh ..."
sleep .2
echo "#!/bin/bash" >> $1/install.sh
echo "if [[ \$EUID -ne 0 ]]; then" >> $1/install.sh
echo "   echo \"This script must be run as root\"" >> $1/install.sh
echo "   exit 1" >> $1/install.sh
echo "fi" >> $1/install.sh
echo "" >> $1/install.sh
echo "DEPENDENCIES=(\"\")" >> $1/install.sh
echo "" >> $1/install.sh
echo "install -v -C -m 775 -o root $1.sh /usr/bin/toolbox-$1" >> $1/install.sh
echo "" >> $1/install.sh
echo "if [ ! -z \"\$DEPENDENCIES\" ];then" >> $1/install.sh
echo "    /usr/bin/toolbox-depin \${DEPENDENCIES[@]}" >> $1/install.sh
echo "fi" >> $1/install.sh
echo "" >> $1/install.sh
echo "echo \"Done.\"" >> $1/install.sh

echo "Configuring $1.sh ..."
sleep .2
echo "#!/bin/bash" >> $1/$1.sh
echo "VERSION=1.0" >> $1/$1.sh

echo "Done."
