#! /bin/bash
# masher [text] - Takes an optional text argument, then keeps taking input
#                 until ta * is input

# Initialises the variables required, setting them to zero

alpha=0
number=0
special=0
control=0


# Initial loop, checks through the arguments, and counts the characters
# If no input is given, the loop skips

for str in "$@"; do

  # Cycles through each character

  for (( i=0; i<${#str}; i++ )); do

    # Checks if the character is a letter, and if the control character has
    # not been found

    if [[ "${str:$i:1}" == [a-zA-Z] && $control -lt 1 ]]; then

       # Increments the Alpha variable

       ((++alpha))

    # Checks if the character is a letter, and if the control character has
    # not been found

    elif [[ "${str:$i:1}" == [0-9] && $control -lt 1 ]]; then

       # Increments the Number variable

       ((++number))

    # Checks for the control character

    elif [[ "${str:$i:1}" == "*" ]]; then

       # Increments the control variable, showing that the special character
       # has been found, then increments the special character variable

       ((++control))
       ((++special))

     # Checks if the control character is found and, if not, assumes the input
     # is a special character

    elif [[ $control -lt 1 ]]; then

       # Increments the special variable

       ((++special))
	fi
  done
done

while [[ $control -lt 1 ]]; do
  read -p "Text: " str

  # Cycles through each character

  for (( i=0; i<${#str}; i++ )); do

    # Checks if the character is a letter, and if the control character has
    # not been found

    if [[ "${str:$i:1}" == [a-zA-Z] && $control -lt 1 ]]; then

       # Increments the Alpha variable

       ((++alpha))

    # Checks if the character is a letter, and if the control character has
    # not been found

    elif [[ "${str:$i:1}" == [0-9] && $control -lt 1 ]]; then

       # Increments the Number variable

       ((++number))

    # Checks for the control character

    elif [[ "${str:$i:1}" == "*" ]]; then

       # Increments the control variable, showing that the special character
       # has been found, then increments the special character variable

       ((++control))
       ((++special))

     # Checks if the control character is found and, if not, assumes the input
     # is a special character

    elif [[ $control -lt 1 ]]; then

       # Increments the special variable

       ((++special))
	fi
  done
done


echo ""
echo "Total: " $((alpha+number+special))
echo "Characters: " $alpha
echo "Numbers: " $number
echo "Special Chars: " $special

