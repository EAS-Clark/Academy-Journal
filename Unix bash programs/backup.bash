#!/bin/bash
#############
#Clark brooks
############
#This file makes a backup of a list of files

if [ $# -lt 1 ]
then
	echo "Would you like to back all the files in /bin"
	read input
	if [[ $input == "Yes" || $input == "yes" || $input == "Y" || $input == "y" ]]
	then
		echo "Everthing has been back up"

		for file in $*
		do
			mv -v ~/bin/$file ~/bin/"$file"_$file_$(date +%d-%m-%Y)
			cp  -v ~/bin/"$file"_$file_$(date +%d-%m-%Y) ~/backups
			mv -v ~/bin/"file"_$file_$(date +d%-%m-%Y) ~/bin/"$file"


		exit
	else
		echo "Nothing has been back up"
		exit
	fi
fi

for file in "$@"
do
	if [ ! -f ~/bin/$file ]
	then
		echo "Can't find the file $file"
	else
		echo "The file $file has been backed up"
		cp -v ~/bin/$file ~/backups
		mv ~/backups/$file ~/backups/"$file"_$file_$(date +%d-%m-%Y)
	fi
done

