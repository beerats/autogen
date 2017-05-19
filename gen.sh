#!/bin/bash
PROJECT=exam
VERSION=1.0
EMAIL=xr3118@163.com
autoscan
sed -i s/FULL-PACKAGE-NAME/$PROJECT/g configure.scan
sed -i s/VERSION/$VERSION/g configure.scan
sed -i s/BUG-REPORT-ADDRESS/$EMAIL/g configure.scan
head -n -2 configure.scan > configure.ac
echo AM_INIT_AUTOMAKE\([foreign]\) >> configure.ac
echo AC_CONFIG_FILES\([Makefile]\) >> configure.ac
echo AC_OUTPUT >> configure.ac
rm configure.scan autoscan.log
aclocal
autoheader
autoconf
echo "Filenames with spaces is INVALID."
read -e -p "Input programs: " PROGRAMS
echo bin_PROGRAMS=$PROGRAMS > Makefile.am
for PROGRAM in $PROGRAMS; do
    read -e -p "Input files for $PROGRAM: " FILES
    echo $PROGRAM\_SOURCES\=$FILES >> Makefile.am
done
automake --add-missing
