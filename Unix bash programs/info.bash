#! /bin/bash
# info - Outputs useful information about the system

# Creates a border around the information
echo ""
echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
echo ""

# Username
echo -ne "\e[94mUsername: \e[96m"
whoami

echo ""

# Date and Time
echo -ne "\e[94mTime: \e[96m"
date

echo ""

# Home Directory
echo -e "\e[94mHome Directory:\e[96m" ~

# Current Directory
echo -e "\e[94mCurrent Directory: \e[96m$PWD"

echo ""

# Process Count
echo -ne "\e[94mProcesses: \e[96m"
ps -ae | wc -l

echo ""

# System uptime
echo -ne "\e[94mThis station has been \e[96m"
uptime -p
echo -ne "\e[94mIt was brought online at \e[96m"
uptime -s

# Creates a border arount the information
echo ""
echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
echo ""

# Echos all directories in the PATH

echo -e "\e[94mDirectories in the PATH:\n"

dirs=$(echo $PATH | tr ":" "\n")
for x in $dirs; do
  echo -e "\e[94m> \e[96m$x"
done

# Creates a border around the information
echo ""
echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
echo ""

# Echoes all logged in users

echo -e "\e[94mCurrently Logged In Users:\n"

users=$(who | cut -d' ' -f1 | sort | uniq)
for x in $users; do
  echo -e "\e[94m> \e[96m$x"
done

# Creates a border around the information
echo ""
echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
echo ""

