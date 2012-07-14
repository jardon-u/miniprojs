#!/bin/sh

case $1 in
    "help")
        echo "Option:"
        echo "  check                                           "
        echo "See http://www.debian.org/doc/manuals/maint-guide/"
        exit;;
esac

echo "*-------------------------------------------*"
echo "* Checking Dependancies                     *"
echo "*-------------------------------------------*"

list="Needed Recommended Suggested"
Needed="dpkg-dev file gnupg lintian pbuilder"
Recommended="patch perl autoconf automake dh-make debhelper fakeroot"
Suggested="gcc g++ libc6-dev make devscripts debian-policy \
 developers-reference"

for l in $list
do
echo "                                             "
echo "# $l dependancies:                           "

    eval tmp='$'$l
    for i in $tmp
    do
        if [ ! "`dpkg -s $i 2> /dev/null`" ]
        then
            printf "\e[31m\e[1m $i \e[m \n"
        else
        printf "\e[32m\e[1m $i \e[m \n"
        fi
    done
done

