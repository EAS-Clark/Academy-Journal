#! /bin/bash
# Comp (file1) (file2) - Compares the sizes of two files and outputs the difference
# Originally named compare but conflicted with another command
# Useful for comparing two versions of the same file to quickly see which is larger

#Checks for the correct number of args
if [ $# -eq 2 ]
then
	wc -c < $1 1> /dev/null || exit 3
	wc -c < $2 1> /dev/null || exit 3
	
	#Initializes the two size variables
	size_1=$(wc -c < $1)
	size_2=$(wc -c < $2)
	
	#If both files are the same size
	if [ $size_1 -eq $size_2 ] > /dev/null
	then
		echo Both Files are the Same Size!
	
	#If file2 is larger
	elif [ $size_1 -lt $size_2 ] > /dev/null
	then
		dif=$(($size_2-$size_1))
		echo $2 is larger than $1 by $dif bytes
	
	#If file1 is larger
	elif [ $size_1 -gt $size_2 ] > /dev/null
	then
		dif=$(($size_1-$size_2))
		echo $1 is larger than $2 by $dif bytes
	
	#Should never execute
	else
		echo One of those files was not valid!
	fi

#If more or less than two args were provided
else
	echo Please Provide 2 and only 2 files
fi
