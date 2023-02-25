#!/bin/bash
#Task1
echo -E "Printing text with newline. This is the dafult option."
echo -n "What happens when we print text without new line"
echo -e "\nEscaping \t characters \t to print\nnew lines for example"

# Adding comments that do nothing
echo "Testing single line comments"

: '
This is a multi line comment
Nothing happens in this section
'
echo "Back to executable commands"

# Add two numeric values
((sum = 12 + 24))
# Print the sum
echo $sum

echo "What is your favorite fruit?"
read fruit
echo "Hey! I like $fruit too."
