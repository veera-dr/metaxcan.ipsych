#!/bin/sh

while IFS= read line
do
    maf=$(echo $line | cut -f 6 )
    val=$(echo $maf*2 | bc -l)
    echo $line | sed s/NA/$val/g
done < $1

