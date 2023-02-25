#!/bin/bash

JUST_A_SECOND=3
funky ()
{ # This is about as simple as functions get.

    echo "This is a funky function."
    echo "Now exiting funky function."
} # Function declaration must precede call

fun ()
{ # A somewhat more complex function. 
    i=0
    REPEATS=30
    echo
    echo "And now the fun really begins."
    echo 
    sleep $JUST_A_SECOND 
    while [ $i -lt $REPEATS ] #use as (<,>,=) or (-lt, -gt, -eq)
        do
        echo   "----------FUNCTIONS---------->"
        echo   "<------------ARE-------------"
        echo   "<------------FUN------------>"
        echo
        let "i+=1"
        done
}

add_fun()
{
# A function just to add numbers
echo $((2+2))
}
#Now, call the functions
funky
fun
echo The return value of add_fun is: $(add_fun)
echo exit $? #check your exit status of the last function/command: if 0-success, otherwise is not
