#!/bin/bash
PROJECT=exam
VERSION=1.0
EMAIL=xr3118@163.com
autoscan
sed -i s/FULL-PACKAGE-NAME/$PROJECT/g configure.scan
sed -i s/VERSION/$VERSION/g configure.scan
sed -i s/BUG-REPORT-ADDRESS/$EMAIL/g configure.scan
head -n -2 configure.scan > configure.ac

# Enable debug feature for configure
echo "
# enable debug or not                                                          
AC_ARG_ENABLE([debug],
    AS_HELP_STRING([--enable-debug], [enable DEBUG mode(default=no)]),
    [],                                                            
    [enable_debug=no])                                              
AS_IF([test \"x\$enable_debug\" = \"xyes\"], [CXXFLAGS=\"-g2 -O0 -DDEBUG -Wall\"],        
    [test \"x\$enable_debug\" = \"xno\"], [CXXFLAGS=\"-O3 -Wall\"],                  
    [])       
" >> configure.ac

echo AM_INIT_AUTOMAKE\([foreign]\) >> configure.ac
echo AC_CONFIG_FILES\([Makefile]\) >> configure.ac
echo AC_OUTPUT >> configure.ac
rm configure.scan autoscan.log
aclocal
autoheader
autoconf
echo "Filenames with spaces is INVALID."
# names for excutable programs generated
read -e -p "Input names of excutable programs: " PROGRAMS
echo bin_PROGRAMS=$PROGRAMS > Makefile.am
for PROGRAM in $PROGRAMS; do
    # There is NO need to input header files
    read -e -p "Input dependent files for $PROGRAM: " FILES
    echo $PROGRAM\_SOURCES\=$FILES >> Makefile.am
done
automake --add-missing
