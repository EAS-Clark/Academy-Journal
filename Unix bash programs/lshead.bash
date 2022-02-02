#! /bin/bash

syntax="lshead (-head/-tail) (line count) (directory)"

# This is defined as a variable, as bash did not parse the reg-ex when it was defined in the IF statement

rgx='^[0-9]+$'

# Checks if the correct number of arguments was given

if [[ $# -ne 3 ]]; then
  echo "Incorrect Argument Count. Syntax: " $syntax >&2; exit 1
fi


# Checks for the -head Argument

if [[ $1 == "-head" ]]; then

  # Checks if the second argument is a valid number

  if [[ $2 =~ $res ]]; then

    # Checks if the third argument is a directory

    if [[ -d $3 ]]; then

	  # Defines the directory to be looped through
	  FILES=$3"/*"

	  # Loops through all the files in the directory, outputting the defined lines
	  # Colour codes were used to help the user see different files more clearly

	  for f in $FILES; do

		echo ""
	    echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	    echo ""

	    head -$2 $f

	  done

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	  echo ""

	# Checks if a file was input, rather than a directory

	elif [[ -f $3 ]]; then

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	  echo ""

	  head -$2 $3

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
      echo ""

	# If it was not a valid file or directory

	else
	  echo "Invalid file or Directory for Argument 3. Enclose paths with a space inside \" \" "
	  echo "Syntax: " $syntax >&2; exit 3
	fi

  # If the 2nd argument was not a valid number

  else
    echo "Incorrect second argument. Syntax: " $syntax >&2; exit 3
  fi

# If tail

elif [[ $1 == "-tail" ]]; then

  # Checks if the second argument is a valid number

  if [[ $2 =~ $res ]]; then

    # Checks if the third argument is a directory

    if [[ -d $3 ]]; then

	  # Defines the directory to be looped through
	  FILES=$3"/*"

	  # Loops through all the files in the directory, outputting the defined lines
	  # Colour codes were used to help the user see different files more clearly

	  for f in $FILES; do

		echo ""
	    echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	    echo ""

	    tail -$2 $f

	  done

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	  echo ""

	# Checks if a file was input, rather than a directory

	elif [[ -f $3 ]]; then

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	  echo ""

	  tail -$2 $3

	  echo ""
	  echo -e "\e[33m-----------------------------------------------------------------------------------\e[0m"
	  echo ""

	# If it was not a valid file or directory

	else
	  echo "Invalid file or Directory for Argument 3. Enclose paths with a space inside \" \" "
	  echo "Syntax: " $syntax >&2; exit 3
	fi

  # If the 2nd argument was not a valid number

  else
    echo "Incorrect second argument. Syntax: " $syntax >&2; exit 3
  fi

# If incorrect value  

else
  echo "Incorrect first argument. Syntax: " $syntax >&2; exit 2
fi

