
# HOG Detection
Just like in the last laboratory, we will be using another classic computer vision strategy, namely, the multi-scale HOG descriptor for object detection. Again our codebase will be the VLFeat Library. This time we will switch our attention from generaci objects to a different problem, for this Lab, will use a small subset of a modern and database the [WIDER FACE: A Face Detection Benchmark](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/). This dataset is **very challenging** with over 393,703 and contains face instances from several every day scenarios like public events, family meetings, common
leisure activities, etc.

## Resources

This lab uses resources from the [Multimedia Laboratory, of the Chinese University of Hong Kong](http://mmlab.ie.cuhk.edu.hk), you might want to check their website.
To better approach approach the problem (read to get results above 0.0) we will operate over a very small subset of WIDER FACE. We will work only on detections whose area is larger than 90x90, avoiding those who are rather small and/or have a significant amount of blur.

Once again most of the heavy lifting is already done, as the codebase for this Lab is provided and thoroughly explained by the [Visual Geometry Group at Oxford](http://www.robots.ox.ac.uk/~vgg/practicals/category-detection/). Read the tutorial and make sure that the technical aspects of their implementations are clear.

## Data 
The basic resources for this lab can be downloaded at:

XXXX

There are 3 directories in the download:

- Train: Set of train images that contain at least 1 face (as by the specs of our subset).
- Train Crops: Resized face crops with approximately the same size.
- Test: Set of validation images that contain at least 1 face (as by the specs of our subset).


## Evaluation
As we work on a very small subset of the dataset from the default challenge, the standard evaluation code is not appropriate, therefore we will be using a modified version of the original evaluation code that applies only to the subset we selected. This modified version can be obtained at:

XXX Available on Monday April 3 

## Your Turn

Create a multi-scale HOG detector for faces using the provided dataset. Then test your detector on the test set using the provided script

We are now far more experienced in the Computer vision world, hence there are no further guidelines for this lab, moreover **you are free to apply any modification, extension pre/post-processing to the base algorithm or data, as long as the core of your strategy remains a multi-scale HOG detector**.    

## Report 
The report for this laboratory must include:
- A brief description of the multiscale multi-scale HOG  strategy, why can you apply it to a detection problem?
- Can you identify any hyper parameter on the multi-scale HOG?, why is it usefull?
- How can you evaluate a general detection problem? 
- Overall description of your strategy including any modifications/enhancements you applied to it.
- Your results on our test subset of the wider-face dataset.
- What seems to be the limitations of the strategy  you developed?.
- Do you think the false positives follow a pattern?
- Do you think the false negatives follow a pattern?
- How could you improve your algorithms? Think big, be creative, we are in the what if domain :)

