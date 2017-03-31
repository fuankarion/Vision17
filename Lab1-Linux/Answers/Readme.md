
Integrantes: José Campo 201412002
	Mariana Franky 201313944


1. The grep command is a command which helps in the file text manipulation , this command permits search for pattern in each file or standar input, print all lines in those files that match a pattern. 
Syntax of grep:
``` bash
	grep[options] pattern [Files] [1]
```
2. If the file is a directory, do not descend or traverse into it. Example: 
$ find . -prune
. 

[7]
3. The cut command extracts columns of text from files.[1]
4. The rsync command copies a set of files. Sintaxis: [options] source destination[1]
5. The diff command checks difference between two files. [2]
6. The tail command prints the last 10 lines of a file.[1]
7. The tail -f is an option that keep the file open, and when new lines are added to the file by another process, this option updates the display.[1] 
8. To explain the link command is necessary its syntax : link FILE1 FILE2 , the command links creates a link named FILE2 to an existing FILE1 .
9. #!/bin/bash that is called a shebang. Shebang is a line to tell the interpreter path, in this case the 'bin/bash'is the interpreter command path for bash [3]  

10. There are 9 users in the course server.
	Code : 
``` bash
	less /etc/passwd  - this command shows the attributes of each user in the server, each line contain : name, password, user ID, group ID, geco, home directory and shell.[5] 
	grep home /etc/passwd | wc -l  - this command shows the users that are in home and with wc -l  shows  how many they are. 
```

11. grep home /etc/passwd | sort | cut -d ':' -f 1,7  -This command  produce a table of Users and Shells , the first command shows all the user that are in home and cut command and option d ':' permit separate the each line in 7 columns, -f option shows the User (column 1) and the Shells (column 7 )

12. We didn't create a script  for finding duplicate images based on their content , but we found a code that makes it : 
``` bash
images=$(find ./ -main *.jpg)
md5sum $images | sort | uniq -w33 -D [6] This script only shows files that are duplicate. 
```


13. Download: 
	scp vision@157.253.63.7:/datos1/vision/BSR_bsds500.tgz Documents -command scp permits to copy BSR_bsds500.tgz from our server to Documents.

	tar -xvzf BSR_bsds500.tgz  -command tar permits to descompress

14.	The disk size of the uncompressed dataset: 70763455
 	ls -l - 

	There are 500 images in the directory 'BSR/BSDS500/data/images'
	It was used this command find ./ -name *.jpg   - find in the actual carpet all jpg images, note : actual carpet is images

15. This code shows  the resolution and format of each image
``` bash
#!/bin/bash

# Find all JPEG images
images=$(find ./ -name *.jpg)

# Iteration
for im in ${images[*]}
do
   # Get resolution , the  identify command describes the format and characteristics of image, then with awk command takes the element of the first(Name), second(Format) and third( Resolution) column and prints.
   identify $im | awk '{print $1,$2,$3}'
  
done
```

16. There are 152 in landscape orientation. 
``` bash
#!/bin/bash

# Find all JPEG images
images=$(find ./ -name *.jpg)
# variable
numhor=0

# Iteration
for im in ${images[*]}
do


   # Get the dimensions , fil correspond a vertical orientation and col landscape, indentify  describes the format and characteristics of image, then with  awk command  takes the element of third( Resolution) column, and cut command  separates the resolution with command -d 'x' and then print the first one in fil and second one in col.
   fil=$(identify $im | awk '{print $3}' | cut -d 'x' -f 1)
   col=$(identify $im | awk '{print $3}' | cut -d 'x' -f 2)
   
   # Compare dimensions if fil is lest than col sum to numhor 1. 
   if [ $fil -lt $col ]
   then
	# Sum landscape images
	numhor=$(($numhor+1))
   fi

done
#Print how many images are in landscape orientation 
echo "Num of landscape images: $numhor" 
```

17. Source : http://www.imagemagick.org/Usage/crop/#crop , we took the command convert to resize the size of each image. 
``` bash
#!/bin/bash

# Find all JPEG images

images=$(find ./ -name *.jpg)

# Iteration

for im in ${images[*]}

do

      # Name the  identify command describes the format and characteristics of image, then with awk commmand takes the element of the first(Name) column 

   name=$(identify $im | awk '{print $1}')

   # Crop the conver command is capable of reading and writing images in a variety of formats and performing operations like resize, in this case it was used the option crop to resize the image.[5] 

   convert $name -crop 256x256+0+0 $name

done

echo "Num of landscape images: $numhor"
```

References:
[1]Barrett, D.J.(2016).Linux Pocket Guide: Essential Commands.O'Reilly Media

[2] Negus, C., & Caen, F. (2008). SUSE Linux Toolbox : 1000+ Commands for OpenSUSE and SUSE Linux Enterprise. Indianapolis, IN: Wiley. 
[3]	Lakshman, S.2011.Linux Shell Scripting Cookbook.Packt Publishing, Limited
[4] The /etc/passwd File  url : http://www.linfo.org/etc_passwd.html
[5]How to Convert and Optimize an Image from Linux Command Line https://www.maketecheasier.com/convert-images-linux-command-line/
[6]Linux – Script Bash para encontrar ficheros duplicados con diferentes nombres en el mismo directorio
http://www.elsotanillo.net/2006/10/linux-script-bash-para-encontrar-ficheros-duplicados-con-diferentes-nombres-en-el-mismo-directorio-2/
[7]find command: 15 examples to exclude directories using prune. http://www.theunixschool.com/2012/07/find-command-15-examples-to-exclude.html
