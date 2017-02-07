
# Lab 5 - Features 

In this lab you will create a code to represent images using Textons. Then you will train and test a classifier based on the initial representation. 
Try to create good quality code so that you can reuse it in the following labs.

## Database

The database for this lab comes from the [ponce group](http://www-cvr.ai.uiuc.edu/ponce_grp/data/)

You can download it from the following mirrors in the university (might be faster if you are connected to the university network)

-   http: http://157.253.63.7/textures.tar.gz
    
## Image Representation

The *lib* folder contains functions that can be used to represent images as textons, and
the ``example.m`` file illustrates how to use them. 

Pay special attention to the following functions (you will find them in the example), find out what they do, what their inputs and outputs are.

    -   fbCreate
    -   fbRun
    -   computeTextons
    -   assignTextons

Use ``computeTextons`` to create an appropriate set of descriptors for the database. **Do not forget** that at this stage you can only use images from the *train* folder.
    
## Classification

After images are represented as a dictionary of textons, train and test a classifier using the database. Notice that the images in the mirrors have been already divided into train and test sets. This was done by randomly assigning 10 images from each category to the test. Try two different kinds of classifiers:

-   **Nearest neighbour:** Use intersection of histograms or Chi-Square metrics (see The matlab documentation for  [KNN Clasifiers](https://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html#btap7k2) and [distance metrics] (https://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html)
    for more information).
-   **Random forest:** Use the matlab [tree bagger](http://www.mathworks.com/help/stats/treebagger.html) function. See an example at [kawahara.ca](http://kawahara.ca/matlab-treebagger-example/)

Train both classifiers with images in the *train* directory and test them once with images in the *test* directory. Calculate the confusion matrix for training and test datasets. 

## Your Turn

The report for this laboratory should include

-   Small (one or two paragraphs) description of the database
-   Description of the method and filters used for representing the images
    -   How did you create the dictionary?
    -   How many textons are you using? Why?
    -   What filters discriminate the most?
-   Description of the classifiers, hyperparameters and distance metrics
    -   What hyperparameters are you using? Why?
    -   What adjustments did you apply to the data?
-   Results
-   Discussion of the results
    -   Which classifier works best?
    -   How much time it takes to train and apply both kinds of classifiers?
    -   Which categories cause the most confusion?
    -   What are the limitations of the method?
    -   What are the limitations of the database?
    -   How could the method be improved?

         

**Due date:**


