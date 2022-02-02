#!/bin/bash
# chmx (files)    -   Takes multiple file inputs and makes them executable

if [ $# -lt 1 ]
then
echo Please state some files to be made executable\!
else
for var in $*
do
chmod +x $var
#mv $var /usr/bin
done
fi
