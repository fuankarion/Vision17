# Lab 3: Introduction to LaTeX

## LaTeX Books

LaTeX is feature rich is a document preparation system. Opposed to WYSIWYG editors (like word and google drive), LaTeX requires special markup and tagging conventions to specify the structure of a document, its style, citations and,  possibly, other cross-references (like hyperlinks). 
We will only go through a few of the most basic features in LaTeX. Thus, we encourage you to further read about it in:

- http://en.wikibooks.org/wiki/LaTeX
- https://tobi.oetiker.ch/lshort/lshort.pdf

## Installing LaTeX
According to  your operative system

### On Windows
These two include latex basic packages and provide a user friendly editor:

- MikTex
- TexLive

Tip: You might want to install *sumatraPDF* instead of Adobe Acrobat to preview generated pdfs.

### Linux

Use the package manager to retrieve LaTeX base packages, for example in Ubuntu and similar distributions
´apt-get install texlive´

You might also want to install an editor like:

 - Texmaker
 - Lyx
 - kile

#### Other handy packages for linux

- dvipng (DVI to PNG/GIF converter)
- ghostscript ( interpreter for the PostScript language)
- texlive-latex-extra (LaTeX supplementary packages)
- JabRef (Java application for managing bibtex)
- kbibtex (BibTeX editor for KDE )
- texlive-humanities (Extra LaTeX packages for law, linguistics, social sciences, humanities)
- texlive-latex-recommended

### Osx

- MacTex 


## Compiling (rendering) LaTeX files

LaTeX files are written as plain text, and must be compiled into PDF or DVI to produce publication ready documents. The compilation process feels a lot like compiling  C/C++ source code  (or any other compiled language), you use the tex  file as input for a LaTex compiler, which will then produce a PDF or DVI file or an error log. 

From the commandline you can use the ´pdflatex´ (recommended) or ´latex´ commands. Some modern alternatives are ´xelatex´
and ´luatex´, which have better handling of non ascii characters.

Most LaTeX IDEs can call these command automatically and show the results. Moreover, they can link text in the rendered file to text in the source. 

## Style files  
  
Latex files contain the actual text, and most of the aesthetic aspects for the document. When writing articles for a journal or a conference, the will provide you with the style file and instructions on how to use it. Style files should
be copied to the *same directory* as the rest of your latex source files. This repository already includes the 
[cvpr](http://www.pamitc.org/cvpr15/author_guidelines.php) style. Have a look at it, by compiling their example file
``egpaper_final.tex``.

## CVPR Style 

http://cvpr2016.thecvf.com/submission/main_conference/author_guidelines, Download their article template, and keep it in your pc. From now on forward **you must use this template for every lab**.

## Images

  - The directory ``images`` contains a small example on how to add images in LaTeX.
  - It contains the same image in several different formats and resolutions
  	- Can you see the differences?
  	- What format you think is more appropriate?
  - To edit vector graphics (svg or pdf) you may use [inkscape](https://inkscape.org)
  - To edit raster graphics (png or jpg) you may use [gimp](https://gimp.org)

### Some Supported Image Formats
  
- Vectorial (svg -> pdf)
 - Stores geometry information
 - Can be scaled to any size
 - Great for diagrams and plots
 
- Raster lossless (png/bmp)
 - Stores pixel information
 - Limited resolution
 - Great for renders, screenshots, photos
 - Be carefull with the size of raw images (bmp)
 
- Raster lossy (jpg)
 - The compression process discards information
 - Optimized based on human perception of natural images
 - Great for natural photos for humans (Frequencies that our eyes can't perceive are removed, but maybe computers could use this information)
 
 
##  Code Fragments

  - The directory ``code`` shows how to add a 'good looking' code fragment in LaTeX.
  - It uses the [listings](https://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings) package 
  - Check the directive \lstdefinestyle{mystyle}. Notice how you can edit the style and even define a new one on your own
      

##  Bibliography

Latex uses the *bibtex* program to insert bibliography into documents. Bibtex reads its data from a documents
database with ``.bib`` extension. This database is a plain text file with the format described 
[here](http://www.bibtex.org/Format/). In order to add a reference in LaTeX use ``\cite{ref}`` where ref
is the identifier of the reference in the bibtex database. Notice the database may contain several more items
than the ones you are citing in the current document. 

The bibtex database format is complex, and hard to maintain by hand. Fortunately there are several 
graphical applications that can do this for you.

-   Local
	-   JabRef
	-   kbibtex
-	Cloud
	-   Zotero
	-   Mendeley

Be sure to check them out and start using them.

The directory ``bibliography`` illustrates how to add bibliography in LaTeX; using the database file ``vision.bib``


## LaTeX and git

Latex files work very well with version control as they are plain text. However latex uses several intermediary files that we don't need in the version control system. The only files we truly want are the source files (.text) along with the images and some other assets. 

The ``.gitignore``file tells git to ignore files whose name match a certain pattern. Take a look at it. 
This is a sample .gitignore file that I use for versioning tex documents, it keeps a lot of intermediate files and large binary files out of the repository, thus saving space and commit times.

```
*.aux
*.log
*.nav
*.out
*.snm
*.synctex.gz
*.gz
*.toc
*.avi
*.mp4
*.pdf
```

## Cloud Latex

There cloud services that allow to write and easily compile latex documents (less hassle handling dependencies ). Additionally some allow  collaborative editing of the files (just like google drive).

- [Overleaf](https://www.overleaf.com/signup?ref=e22adb5e092e)
- [Sharelatex](https://www.sharelatex.com?r=646eabb2&rm=d&rs=b)


##Homework

There are no deliverables for this Lab (and therefore there will be no grades), just take you time to install LaTeX base packages whatever your OS of choice is, also get an editor (or use a cloud service), and make sure you can properly edit and compile a simple LaTeX document with images, code and references using the cvpr style.



