
# HOG Detection
Just like in the last Lab we will be using another classic computer vision strategy, namely, the multi-scale HOG descriptor for object detection. Again our codebase will be the VLFeat Library,
and once more, we will use a subset of a modern large scale database the [WIDER FACE: A Face Detection Benchmark](http://mmlab.ie.cuhk.edu.hk/projects/WIDERFace/).

##Resources

This lab uses resources from the [Multimedia Laboratory, of the Chinese University of Hong Kong](http://mmlab.ie.cuhk.edu.hk), you might want to check their website.
The wider face dataset is a modern and **very challenging** face detection dataset with over 393,703 face instances from several every day scenarios like public events, family meetings, common
leisure activities, etc.

To better approach approach the problem (read to get results above 0.0) we will operate over a very small subset of annotations. We will work only on detections whose area is over 10000 pixels (100x100), avoiding those who have a significant amount of blur.

Again most of the heavy lifting is already done, as the codebase for this Lab is provided and thoroughly explained by the [Visual Geometry Group at Oxford](http://www.robots.ox.ac.uk/~vgg/practicals/category-detection/). Read the tutorial and make sure the multiscale detection procedure is clear.

##Data description
The basic resources for this lab can be downloaded at:

There are 3 directories in the download:

- Train: Set of train images that contain at least 1 face (as by the specs of our subset).
- Train Crops: Face crops with approximately the same
- Test: Set of validation images that contain at least 1 face (as by the specs of our subset).


##Evaluation
As we work on a very small subset of the dataset the default challenge, the standard evaluation code is not appropriate, therefore we will be using a modified version of the original evaluation code that applies only to the subset we selected. This modified version can be obtained at:


##Your Turn
Create a multi-scale HOG detector for faces using the provided dataset.
As we are now far more experienced in the Computer vision world, **you are free to apply any modification, extension pre/post-processing to the base algorithm or data as long as the core of your strategy remains a multi-scale HOG detector**

