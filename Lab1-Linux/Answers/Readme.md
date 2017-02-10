VISIÓN POR COMPUTADOR: LABORATORIOS 1 Y 2 
Catalina Gómez Caballero, Diana Sofía Herrera Valenzuela

1. What is the grep command?
It searches for a pattern specified after the command in the input files that are specified too. By default it prints the matching lines.

2. What does the -prune option of find do? Give an example
The syntaxis used must be as follows: find [path] [conditions to prune] -prune -o \ [your usual conditions] [actions to perform]
Prune option allows to skip a directory when looking for something in many files. It is usual the -o after -prune, because the first part of the test, until -prune, will return false for the things we are looking for.
Example: find . -name .snapshot -prune -o -name '*.foo' -print
The command will find the "*.foo" files that aren't under ".snapshot" directories. In this example, -name .snapshot is the "tests for stuff you want to prune", and -name '*.foo' -print is what usually goes after the path [1]. 

3. What does the cut command do?
It removes the sections from each line of files.

4. What does the rsync command do?
It is a file copying tool, which can copy locally, to/from another host, over any remote shell, or to/from a remote rsync daemon. It permits specifications to the set of files to be copied.
It also synchronizes files and directories remotely and locally. So basically, it is used to copy and synchronize data across directories, disks and networks [2].

5. What does the diff command do?
It is used to analyze files and find the lines that differ between them. The default output includes the line numbers of the first file, a letter that indicates the modification that should be make in order to make the lines equal, and the line numbers of the second file. This command is also used to compare directories.

6. What does the tail command do?
It outputs the last part of files. By default it prints the last 10 lines of each file to standard output. If there is more than one file, each output has a header with the name of the respective file.

7. What does the tail -f command do?
This option is equivalent to the descriptor follow, and it outputs appended data as the file grows.

8. What does the link command do?
It calls the link function to create a link to a file. It creates a hard link in which both pointers direct same data and editing any of them changes the other. It is different to a symbolic soft link which does not direct to the same data.

9. What is the meaning of #! /bin/bash at the start of scripts?
The #! tell the shell, which interprets the UNIX commands, the program to be used to interpret the script when executed. When bin/bash is specified, it means to be run and interpreted by bash shell. In other words, this is required at the start of scripts to indicate the system which program to use to run the file.

10. How many users exist in the course server?
To find out the number of users in the course server, we used the command /etc/passwd. The output was a detailed list of all the users, so in order to count then we added the command wc -l, which counts the lines of the output of /etc/passwd. There were 39 users in the course server. 

11. What command will produce a table of Users and Shells sorted by shell (tip: using cut and sort)
The command: cat /etc/passwd | cut -d \: -f 1,7 | sort -t":" -k 2
Here, cat concatenates and prints the result, /etc/passwd is the file where names and specifications of the users are saved, the | operator uses the output from the previous command as the input for the following one, and therefore, cut command cuts each line, delimited by : operator, as the -d option allows to state which delimiter use to cut, and the subsequent \: us used to set the delimiter. Then, -f option is used to determine which fields to take, in this case 1 and 7 as stated in the command. In the end, the output of this command is used as input for sort command (by using |), which organizes the content according to the second field (-k 2), which is found by stating that the delimiter to separate fields is the : (by using -t”:”)

12. Create a script for finding duplicate images based on their content (tip: hash or checksum) You may look in the internet for ideas, Do not forget to include the source of any code you use.
There is a package developed for Linux environment called Fslint, which can make the task easier. To install it, we used the command: sudo apt-get install fslint
After installation process is properly completed, although it offers a graphical interface, we will use the terminal to find duplicate images. To do so, the fslint command is activated through the following commands:
$  cd /usr/share/fslint/fslint
$ ./fslint /path/to/directory
where /path/to/directory is the actual path you must follow until the folder where your images are kept. By doing so, a list with the duplicate images will be shown [3].

You could also use the fdupes command, with -r option followed by the path, or compare every image hash to check whether it is repeated.

Another code developed to find duplicate images is by using cksum, which calculates the sum of the bytes of the file, and shows it with the number of bytes contained. Therefore, files with the same result will probably be the same files.

#!/bin/bash
imagenes=$(find aerials -name *.tiff)
touch suma.txt
touch unicas.txt
for im in ${imagenes[*]}
do 
cksum $im >> suma.txt
done
sort -u suma.txt >> unicas.txt

This code is an executable script which searches duplicate images in a determined folder (aerials in this case), and then takes out only the non-repeated ones in another script.
 
13. Download the bsds500 image segmentation database and decompress it (keep it in you hard drive, we will come back over this data in a few weeks).
To download the database from the terminal, the command used was wget with the link of the files to be downloaded. The compressed file is saved by default in the current directory. To decompress the folder with the extension .tgz, the command tar with the options xvzf was used, followed by the complete name of the folder.  

14. What is the disk size of the uncompressed dataset, How many images are in the directory 'BSR/BSDS500/data/images'?
The disk size was computed using the command du (disk usage) with the options -sh, where h specifies the human readable format and s the summary of the grand total disk usage in a directory. The disk size is 73 Mega bytes.
To count the images, the following code was used:

#!/bin/bash
# go to Home directory
cd ~
FILES=/home/catalina/BSR/BSDS500/data/images/*
declare -i total=0
declare -i actual=0
for f in $FILES
do
 #echo "Processing $f file..."
actual=$(ls $f| wc -l)
total=$total+$actual
 #echo $actual
done
echo the number of images in the directory 'BSR/BSDS500/data/images' is $total

The code works as follows: cd ~ takes us to home directory, then we are telling it to keep as FILES all the lines in the path provided.
then, we declare as integer variables the total number and actual number of counted images and initialize both as 0. Afterwards, we look in each folder in FILES, and count the number of images inside with the wc command preceded by ls, which shows all the lines contained in the folder. This is saved as the actual number of files, and then is added to the total amount saved, which at the end of the cycle will have the total amount of images inside each folder contained in FILES. Echo commands are used to show the count.
 
The answer was 503 images, although with this method, we are reading all kind of lines we can find inside each folder, even if they are not images. Hence, another code can be used to find only the images contained in the path: find . -name “*.jpg” | wc -l 
This command finds the images whose name contains “.jpg” extension in the current path (.), therefore we are only taking out images. Afterwards, we take the output of find and use it as an input for the word count command (|), which counts the number of lines obtained with find. The result was 500, hence the first method contained 3 files that were not images [4]. 

15. What is their resolution, what is their format?
To have access to these properties from the terminal, the command identify name of file provides the information about the resolution and format of each image, among others. 
The following code was used to recover all the information about the format and resolution of all the images within the directory ‘BSR/BSDS500/data/images'. The code was executed from the directory ‘BSR/BSDS500/data’. 

#!/bin/bash
#cd /home/catalina/BSR/BSDS500/data/images
touch rta.txt
touch formatAndRes.txt
images=$(find images -name *.jpg)

#iterate over them
  for im in ${images[*]}
  do
 identify $im | tee -a rta.txt
  done
awk '{print $1,$2,$3;}' rta.txt > formatAndRes.txt

The code works as follows: first, two files for storing the information were created. rta.txt to save all the information of every image, and formatAndRes.txt to extract the format and resolution with a label for each image. The variable image contains all the files that end with the extension .jpg within the directory ‘BSR/BSDS500/data/images'. The for loop was used to iterate over all the elements within the variable images. For each element, the command identify was used to obtain all its information and this information was piped to the text file (after the last line of the file with the commando tee -a). Finally, the first three columns of the txt file were extracted with the command awk and sent to a new txt file, which contains the path of the image, its format and resolution. 

16. How many of them are in landscape orientation (opposed to portrait)?
An image with landscape orientation has its width greater than its height. The resolution of the image provides this information (found in the previous question). 
Two steps were executed from the terminal at the directory ‘BSR/BSDS500/data’:
Step 1) Extract the column of resolution from the file formatAndRes.txt, replace the “x” by “ “ in order to have two separate columns, which was saved in the file p16.txt. 
awk '{print $3;}' formatAndRes.txt| cut -d \x -f 1,2 | tr 'x' ' ' > p16.txt
Step 2) Compare the contents of the two columns, if the second dimension (height) was smaller than the first (width) one, then the image is in landscape orientation. This input was piped to the word count command to count the result lines. 
awk '{if ($2<$1) print $1,$2;}' p16.txt | wc -l
The answer was 348 . 

17. Crop all images to make them square (256x256). Tip: do not forget about imagemagick.
A script was created to resize all images to 256x256 using Imagemagick option resize.

#!/bin/bash
cd ~
cd Ejemplo/BSR/BSDS500/data/images/
FILES=$(find . -name “*.jpg”)
for f in $FILES
do
convert $f -resize 256x256! $f
done

The code finds and saves in FILES all the images contained in the database, whose extension must be .jpg, and then each one is then converted through resize to a 256x256 image and saved with their original name ($f) [5].

FORKS GITHUB: 
https://github.com/DianaSHV/Vision17
https://github.com/cgomez11/Vision17

References:
[1] StackOverflow (2009). How to use ‘-prine’ option of ‘find’ in sh? [online]. Retrieved from http://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh
[2] Shrivastava, T (2013). Rsync (Remote Sync): 10 Practical Examples of Rsync Command in Linux [online]. Retrieved from: http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
[3] Hoffman, C. (2014) How to find and remove duplicate files on Linux [online]. Retrieved from http://www.howtogeek.com/201140/how-to-find-and-remove-duplicate-files-on-linux/
[4] Vivek Gite (2010). Bash Shell Loop Over Set of Files. [online]. Available at: https://www.cyberciti.biz/faq/bash-loop-over-file/
[5] Hoffman, C. (2015). How to quickly resize, convert & modify images from the Linux terminal [online]. Retrieved from: http://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/

