# PHOW Image Classification

In this Lab we will be exploring a classic computer vision strategy for object recognition namely the "Pyramid histograms of visual words" or "PHOW". Unlike most Labs there will be little coding to do, as we will use the VLFeat Library, originaly developed by Andrea Vedaldi and Brian Fulkerson. Moreover, we will also take a peak a two essential datasets for object recognition task. First the clasic (read solved) caltech 101 dataset, second the ImageNet dataset, currently the de-facto standard for object recognition.


## Setup

First download the [vl_feat](http://www.vlfeat.org/index.html) library. 

After downloading and uncompressing the folder, open matlab and run the following command

```matlab
run('**VLFEATROOT**/toolbox/vl_setup')
```

This simple installation procedure should work for most. For detailed information and troubleshoting see [vl_feat matlab toolbox installation](http://www.vlfeat.org/install-matlab.html).

## Example

The vl_feat library already includes an excellent example on how to use PHOW on the caltech 101 dataset see [phow_caltech101](http://www.vlfeat.org/applications/caltech-101-code.html). 

Analyze the script and understand what it does. If you want, run it using checkpoints to further see how it works. Do not forget to take a close look at the results and file output, be sure you undestand the former, and you know what is being stored for the later.

## Your Turn

Use the techniques illustrated in the example to train and test a classifier in a subset of the [image-net](http://www.image-net.org) database. 

- http://157.253.63.7/imagenet_small.tgz 
- ssh: ``vision@157.253.63.7:datos1/vision/images/imagenet_small.tgz``

**This is a large file (~11GB)!!**, so it would be best to download it using ``wget`` in the couse server

Adapt the script from the example to work on this new dataset. What performance do you get? How does it compare to the results from caltech-101? Can you guess what causes the differences?

Using all the 200 will add a signiicant load on the course server, however the current hardware should be able to handle, try to  use the full dataset.

Also, experiment with the script to try to find out the following

- How does the problem changes when the number of categories increases?
- How does the problem changes when the size of the training set changes?
- How does the result chang when the size of the test (validation) set changes?
- How does the problem changes when the number of dictionary workds changes?
- How does the problem changes when the spatial paritioning changes (``conf.numSpatialX``)?


Answer all questions from the following points of view

- Performance of the classifier (in test and training)
- Computational resources needed

Don't just say *"it improves"*; explain how much it improves. Is it linear? Is it significant? Where are the computing resources being used? What are the practical implications? What are the costs and the benefits? 

## Report

In addition to the source code used in the above exercise, you should upload a report (using the LaTeX style) containing the following points

- Description of the database
- Description of the recognition method (focus on the adjustments you made to adapt it to the database)
- Training and test results
- Discussion of the results
- Discussion on the effecs of
  - number of categories 
  - size of training set
  - number of spatial partitions
- Limitations of the method
- Possible improvements

##Due date
April 7, 2016; 8:00 a.m.
