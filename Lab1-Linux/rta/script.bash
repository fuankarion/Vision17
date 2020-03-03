#!/bin/bash

#I find all the file with names finishing in .jpg
images=$(find -name '*.jpg'| cut -d '/' -f 2)
echo "$images"
#Delete repeated folder
rm -r repeated 2>/dev/null

#I make a new folder called repeated
mkdir repeated
for im in ${images[*]}
do

    for im2 in ${images[*]}
    do
    #I check if the names are equal
    if [ "$im2" != "$im" ];then

	#I get the necesary information about the images to compare them
	dat1_1=$(cksum $im | cut -d ' ' -f 1)
	dat1_2=$(cksum $im | cut -d ' ' -f 2)

	dat2_1=$(cksum $im2 | cut -d ' ' -f 1)
	dat2_2=$(cksum $im2 | cut -d ' ' -f 2)

	if [ "$dat1_1" == "$dat2_1" ];then
	    if [ "$dat1_2" == "$dat2_2" ];then
		cp $im repeated
	    fi
	fi
    fi


done
done
