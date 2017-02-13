# Lab 5 - Features 

In this lab you will create a code to represent images using Textons. Then train and test a classifier based on the texton representation. 
Try to develop quality code so that you can reuse it in the following labs.

## Database

The database for this lab is provided by the [ponce group](http://www-cvr.ai.uiuc.edu/ponce_grp/data/)

You can download it from the following mirrors in the university (might be faster if you are connected to the university's network)

-   http: http://157.253.63.7/textures.tar.gz
    
## Image Representation

The *lib* folder contains functions that can be used to represent images as textons.

Pay special attention to the following functions (you will find them in the example), try to figure out what they do, what their inputs and outputs are.

    -   fbCreate
    -   fbRun
    -   computeTextons
    -   assignTextons

The following script will give you some ideas on how to create a texton dictionary from 2 sample images, then use it  to compare another 2 images

```Matlab
addpath('/home/jcleon/visionTest/Lab05/lib')

%%Create a filter bank with deafult params
[fb] = fbCreate;

%%Load sample images from disk
imBase1=double(rgb2gray(imread('/home/fuanka/Vision17/Lab5-features/img/person1.bmp')))/255;
imBase2=double(rgb2gray(imread('/home/fuanka/Vision17/Lab5-features/img/goat1.bmp')))/255;

%Set number of clusters
k = 16*8;

%Apply filterbank to sample image
filterResponses=fbRun(fb,horzcat(imBase1,imBase2))

%Computer textons from filter
[map,textons] = computeTextons(filterResponses,k);

%Load more images
imTest1=double(rgb2gray(imread('/home/fuanka/Vision17/Lab5-features/img/person2.bmp')))/255;
imTest2=double(rgb2gray(imread('/home/fuanka/Vision17/Lab5-features/img/goat2.bmp')))/255;

%Calculate texton representation with current texton dictionary
tmapBase1 = assignTextons(fbRun(fb,imBase1),textons');
tmapBase2 = assignTextons(fbRun(fb,imBase2),textons');
tmapTest1 = assignTextons(fbRun(fb,imTest1),textons');
tmapTest2 = assignTextons(fbRun(fb,imTest2),textons');

%Check the euclidean distances between the histograms and convince yourself that the images of the goats are closer because they have similar texture pattern
%Can you tell why we need to create a histogram before measuring the distance?
D = norm(histc(tmapBase1(:),1:k)/numel(tmapBase1) - histc(tmapTest1(:),1:k)/numel(tmapTest1))
D = norm(histc(tmapBase1(:),1:k)/numel(tmapBase1) - histc(tmapTest2(:),1:k)/numel(tmapTest2))

D = norm(histc(tmapBase2(:),1:k)/numel(tmapBase2) - histc(tmapTest1(:),1:k)/numel(tmapTest1))
D = norm(histc(tmapBase2(:),1:k)/numel(tmapBase2)  - histc(tmapTest2(:),1:k)/numel(tmapTest2))
```
    
## Classification

After the images are represented using a learnt texton dictionary, train and test a classifier using the provided database. Notice that the images in the mirror have been already divided into train and test sets. This was done by randomly assigning 10 images from each category to the test. Try two different classifiers:

-   **Nearest neighbour:** Use intersection of histograms or Chi-Square metrics (see The matlab documentation for  [KNN Clasifiers](https://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html#btap7k2) and [distance metrics] (https://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html)
    for more information).
-   **Random forest:** Use the matlab [tree bagger](http://www.mathworks.com/help/stats/treebagger.html) function. See an example at [kawahara.ca](http://kawahara.ca/matlab-treebagger-example/)

Train both classifiers **only** with images from the *train* directory and then test them with images **Only** from the *test* directory. Provide the confusion matrix for training and test datasets. 

## Your Turn

The report for this laboratory must include:

-   Small (one or two paragraphs) description of the database.
-   Overall description of the method and filters used for representing the images
    -   How can we classify an image using textons? (don't be overly detailed on this, just one or two paragraphs)
    -   What does the texton representation of an image tell us?
    -   How did you create the dictionary?
    -   How many textons are you using?, Why?
    -   Can you tell if some filters are more discriminative than others?, why would this happen?    
-   Description of the classifiers, hyperparameters and distance metrics
    -   What hyperparameters can you find in the classifiers? How can you choose their values?
    -   Did you apply any adjustments or preprocessing to the data? why?
-   Results
    - Provide the confusion matrix for the training and test sets, what is it telling you?. 
    - Do you have another metric to measure the performance of your method? why do you need it?
-   Discussion of the results
    -   Which classifier works best?, any idea why?
    -   How much time does it takes to create the texton dictionary? why is it so slow?
    -   How much time does it takes to train and apply both kinds of classifiers?
    -   What categories cause the most confusion? could you give some insight on why this happens?
    -   What are the limitations of the method? (CPU and RAM constraints are well known limitations, go beyond this!!)
    -   What are the limitations of the database?
    -   How could your method be improved?

###Some advice on creating your texton dictionary
Creating a large texton dictionary takes A LOT of time and uses A LOT of memory. Creating a dictionary with the full set of training images **Is not possible, on the course server**. Unless you can find a larger machine on your own, you will have to subsample the training database. Be sure to report and discuss your sub-sampling strategy. Do not forget that textures are local patterns that repeat over the whole images.


## Deadline 
**March 2 11:59 pm,**, as usual just upload your report to you github repo.


