##Command list:
 
grep: Search one or various files for lines that matches the given pattern within the file. It is used in the following way:
$ grep [-option] Pattern [File]
In the “[File]” option, if the command ./* is used, then grep will find the given pattern in every file in the current folder.
 
find: search for one or multiple files given some characteristics like name, size or file type. It can be used given the next structure:
$ find [-option] [path] [expression] Pattern
The options can be various. There are some examples: -name, -size, -mtime -N, -mmin -M (Search by name, size, modified in the pasts N hours, modified in the pasts M minutes)
The -prune option it’s an action, not a test. It can be used for extracting paths until a matching pattern, if found, (example 1) or it can be used to extract those paths where the pattern are not included (example 2).
An example:

$ find . -printf "%y %p\n"    # print the file type the first time FYI

d .

f ./test

d ./dir1

d ./dir1/test

f ./dir1/test/file

f ./dir1/test/test

d ./dir1/scripts

f ./dir1/scripts/myscript.pl

f ./dir1/scripts/myscript.sh

f ./dir1/scripts/myscript.py

d ./dir2

d ./dir2/test

f ./dir2/test/file

f ./dir2/test/myscript.pl

f ./dir2/test/myscript.sh




Example 1

$ find . -name test -prune

./test

./dir1/test

./dir2/test

 
Example 2

$ find . -name test -prune -o -print
.
./dir1

./dir1/scripts

./dir1/scripts/myscript.pl

./dir1/scripts/myscript.sh

./dir1/scripts/myscript.py

./dir2

 
 
Cut:

 This command divides a file into multiple ones. It can be applied in the following way:
$ cut [option] … [File] …
The available options are: -c (get characters), -f (get the field, used with -d option), -d (delimiter), and others…
 
rsync: 

this command is used to copy and synchronize file and directories. It can be handle using the next syntax:
Local file to local file

$ rsync [option] … Source [Source] … Destination
Local to Remote:

$ rsync [option] … Source [Source] … [user@]host:Destination    #

$ rsync [option] … [user@]host::Source … [Destination]

$ rsync [option] … rsync://[user@]host[:PORT]/Source … [Destination]

Remote to Local:

$ rsync [option] … [user@]host:Source … [Destination]    #

$ rsync [option] … [user@]host::Destination

$ rsync [option] … rsync://[user@]host[:PORT]/Destination

 
In this case # means via remote shell rather than the rsync daemon
 
Some available options are -r (copy recursively), -a (copy recursively and preserves symbolic links, permissions, users/group ownership ans timestamps), -z (compressed files)
 
diff: 

this command display the differences between two files given. Those files can be in different directories.
Syntax:

$ diff [options] FILES

Some options that can be used are: -q (output tells if the files differ), -a (treat all files as test files), -b (ignore spaces)
If no option is used, then the output will tell with line differs from both files.
 
tail: Output the las part of the chosen files, printing 10 lines by default.

Syntax:

$ [option] … [FILE] …

The option -f allow to see the last lines of the file and if it is updated, the output will grow accordly to the update.
 
Link: Create a link to a selected file

Syntax:

$ link FILE LINKNAME
 
'#! /bin/bash': It is worth saying that that symbol “#” is for a comment. Then it can be only be read if it is read as an executable (the line of code). The “#! /bin/bash” indicates that it is a shell script (Design for running in a terminal, like it is the bash)
 
 
10

To know the amout of users in the server, it's essential to use the "/etc/passwd" file. It stores information required for the login, but for each line, it stores information about one user. The structure of each individual line is the next one: username:password:user_ID:group_ID:user_ID_information:home_directory:shell. Then to count the amount, it's easy using the command "wc -l /etc/passwd" giving the number of users. In the course server, there are: 39.

11 

To create a list we simply use the command "cut -d ':' -f 1,7 /etc/passwd | sort -t ':' -k2" or "$cut -d ':' -f 1,7 /etc/passwd | sort -t ':' -k2 > users_list.txt" to create a text file (users_list.txt)  with the users sorted by shell. The command "cut -d ':' -f 1,7 /etc/passwd" cut each line of the file /etc/passwd by the ':' symbol. Using the '|' command will input the result of the last command into the next one. The command "sort -t ':' -k2" will order alphabeticaly the users by the second field (created with the "-t ':' -k2" option, where -k2 is the second colomn), in this case the shell.

12

The file script.bash is the file script. The code is presented next (There are "'#" in the code. They should be replaced by "#" to get them to work if the text is copied):

'#!/bin/bash

'#I find all the file with names finishing in .jpg

images=$(find -name '*.jpg'| cut -d '/' -f 2)

echo "$images"

'#Delete repeated folder

rm -r repeated 2>/dev/null

'#I make a new folder called repeated

mkdir repeated

for im in ${images[*]}

do

    for im2 in ${images[*]}
    do
    '#I check if the names are equal
    if [ "$im2" != "$im" ];then

	'#I get the necesary information about the images to compare them
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

13

Database Downloaded using the next command: "$ wget www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz". Decompressed with the command "$tar -zxvf BSR_bsds500.tgz"

14

Once the database downloaded, I got into the folder and for every folder (train,test,val) I used the command "$find -name '*.jpg' | wc -l" wicth gives me the number of elements finishing with ".jpg". The test folder has 200 images, the val folder has 100 images and the train folder has 200 too. Applying the same command in the BSR/BSDS500/data/images folder gives us the same result (500 in total).

To know the total amount of space of the dataset, the command "$ du -ch <folder>" was used, where <folder> is the name of the folder that you want to know the disk usage. For the disk usage of BSR folder is 250684 kylobytes (around 245 MB) and for the BSR/BSDS500/data/image folder is 37852 kylobytes (around 37 MB).

15

With the command "$ find -name "*.*" | cut -d '.' -f 3 | sort -u" we can extract the number of types of files the folder BSR/BSDS500/data/images has. In this case, there are only ".jpg" and ".db" file types. If the command "$ find -name "*.*" | cut -d '.' -f 3 | sort -u | wc -l" the answer given by the terminal is 3 (.jpg, .db and empty format).

To get the resolution of the images, first, we get the resolution of the images we get the names of the images with the command "$ identify $(find -name "*.jpg") | cut -d ' ' -f 3 | sort -u". It is necesary to use the command in this way and not in the following way "$find -name '*.jpg' | cut -d ' ' -f 3 | identify" because identify doesn't recognize the input. There are only 2 resolution avaible: 321x481 and 481x321.

16

The Landscape images have the resolution of 481X321, then, to extract the amount of images with landscape resolution the next command will acomplish the goal: "$ identify $(find -name "*.jpg") | cut -d ' ' -f 3 | grep '481x321' | wc -l". The number of landscape images is 348. Using the command "$ identify $(find -name "*.jpg") | cut -d ' ' -f 3 | grep '321x481' | wc -l" will give the number of portrail images (152).

17

For the command, a loop was used. By standing in the test, val or train folder the next command was used: "$for file in *.jpg;do convert -crop 256x256 $file crop_$file; done". This sintaxis gives us that for every file named 'filename'.jpg the image will be cropped into a 256x256 image. Thus resulting in 4 images (in this case) name crop_'filename'-n.jpg, n from 0 to 3, where 0 is the 256x256 image. Then, to get rid off the images, the command "$rm crop_*-[1-3].jpg" was used.
 
References:

(1999). An A-Z Index of the bash command line for Linux. Link: http://ss64.com/bash/

Attwood, J. (2008) Stack Overflow. Link: http://stackoverflow.com/

(2000). nixCraft. Link: https://www.cyberciti.biz/

ImageMagick Studio LLC (1994). ImageMagick. Link: https://www.imagemagick.org/

(2015). HeatWare. Link: http://www.heatware.net/

(2017). Computer Hope. Link: http://www.computerhope.com/
