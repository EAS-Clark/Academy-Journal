#!/bin/bash
#############
#Clark brooks
############
#This file reads all file in the dicatiory by the amont the user inputs

if [ $# -lt 2 ]
then
	echo "You need to input [head/tail] [number of lines]"
	exit
fi

headOrTail=$1
numOfLines=$2

if ! [[ "$numOfLines" =~ ^[0-9]+$ ]]
then
	echo "The secound input needs to be a number"
	exit
fi

if [[ $headOrTail == "Head" || $headOrTail == "head" || $headOrTail == "H" || $headOrTail == "h" ]]
then
	echo "Head"
	head -n +$numOfLines * | cat -n

elif [[ $headOrTail == "Tail" || $headOrTail == "tail" || $headOrTail == "T" || $headOrTail == "t" ]]
then
	echo "Tail"
	tail -n -$numOfLines * | cat -n
else
	echo "Input one needs to be ever tail or head"
	exit
fi


