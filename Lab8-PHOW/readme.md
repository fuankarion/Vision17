
# PHOW Image Classification

In this Lab we will be exploring a classic computer vision strategy for object recognition namely the "Pyramid histograms of visual words" or "PHOW". Unlike most Labs there will be little coding to do, as we will use the VLFeat Library, originally developed by Andrea Vedaldi and Brian Fulkerson. Moreover, we will also take a peek a two essential datasets for the object recognition task.  The classic (read old) caltech 101 dataset, and the ImageNet dataset, currently the de-facto standard for object recognition.

## Setup

First download the [vl_feat](http://www.vlfeat.org/index.html) library. After downloading and uncompressing the folder, open matlab and run the following command:

```matlab
run('**VLFEATROOT**/toolbox/vl_setup')
```

This simple installation procedure should work for most. For detailed information and troubleshooting see [vl_feat matlab toolbox installation](http://www.vlfeat.org/install-matlab.html).

## Example

The vl_feat library already includes an excellent example on how to use PHOW on the caltech 101 dataset see [phow_caltech101](http://www.vlfeat.org/applications/caltech-101-code.html).

Analyze the script and do your best to understand what it does. If you want, run it using checkpoints to further see how it works. Do not forget to take a close look at the results and its file output, be sure you understand the former, and you know what is being stored for the later. Tip: there are relevant parameters ‘hidden’ well beyond the first few lines of the script.

Experiment further with the script to try to find out the following

- How does the problem changes when the number of categories increases?
- How does the problem changes when the size of the train set changes?
- How does the result changes when the size of the test set changes?
- How does the result changes when the number of dictionary words changes?
- How does the result changes when SVM C parameter changes?
- How does the problem changes when the spatial partitioning changes (``conf.numSpatialX/Y``)?

Try also to figure out how these settings change the memory and CPU time required, we are switching to a larger dataset.

## Your Turn

Use PHOW to train and test a classifier in a **very small** subset of the [image-net](http://www.image-net.org) database.

- http://157.253.63.7/imageNet200.tar

**This is a large file (~2.4GB)**, so it would be best to download it using ``wget`` in the course server

Adapt the script from the example to work the train set on this new dataset. What performance do you get with default params? How does it compare to the results from caltech-101? Any idea what causes the differences?.

Finally develop a small classification function which allows to use your best model with the test Set.

Tip: Using 100 images from 200 classes will add a significant load on the course server, and you probably will run out of memory. You can, however, reduce the number of images per class and train with the whole class-set.


## Report

The report for this laboratory must include:

- Short description of the Caltech 101 and Imagenet dataset (max 1 paragraph each)
- Short description of the  PHOW strategy (max 2 paragraphs)
- What are the most relevant hyperparameters for the PHOW strategy.  Did you found any other relevant parameters inside the script?
- How can you choose the best set of hyper parameters for Caltech 101 and imagenet set?, what are their values?
- Evaluate the performance (ACA) of the classifier in the train set of imagenet and Caltech 101 and imagenet. Repor a single number for the whole set. Why is there such a big difference?
- Performance (ACA) Using your classification function on imagenet test, again a single figure.
- What seem to be the ‘easy’ classes, what seem to be the hardest?, why?
- How could  you improve  your results, go beyond a better parameter set/exploration as this is rather obvious. Think big, be creative, again we are in the what if domain :)

## Deadline
**April 6 11:59pm**, as usual just upload your report to you github repo.



