#!/bin/bash

function interrupt()
{
	echo "Interrupt received"
}

trap interrupt USR1

while : 
do 
	echo "Hello world!"
	sleep 10
done

