#!/bin/bash
#############
#Clark brooks
############
#This file desplays the size of .waste


echo "There are $(find ~/.waste -type f | wc -l) files in .waste "

echo "Would you like to see the size of .waste"
read input

if [[ $input == "Yes" || $input == "yes" ||  $input == "Y" || $input == "y" ]]
then
	echo "The file size is:"
	du -sh ~/.waste
else
	exit
fi


