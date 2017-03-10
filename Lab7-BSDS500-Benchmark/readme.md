# Berkeley Segmentation Dataset and Benchmark (BSDS500)

In this lab you will be testing your previously developed segmentation functions in a real and large segmentation database, the BSDS500. To add some extra motivation, you will also be comparing your methods against those of your teacher, can you beat him?

## Resources

This lab uses resources from the
[Berkley Computer Vision Group](http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html),
you might want to check their website.

## Download data

All the data you need for this lab is already packed on the course server and can be downloaded at:

- http://157.253.63.7/BSDS500FastBench.tar.gz

It contains both the images and the fast benchmark code.

**Note**: You probably don't want to add these files to your repository, they are really big.

## Data description

The folder will contain the following directories

- bench_fast: Faster version of the original BSDS benchmark code.
- BSD500:
- Data: Images and their manual segmentations (ground truth).
  - ucm2: Precalculated results of the *Ultrametric Contour Map* segmentation algorithm.
  - Documentation: Paper describing the UCM algorithm
- Grouping: Implementation of the UCM algorithm

## Ground truth data

The ground truth data is saved as matlab data, it contains a manual segmentation from several persons. For example,
to look at the ground truth for image ``train/22090`` we can use the following code

```matlab
load('BSDS500/data/groundTruth/train/22090.mat')

% Load segmentation from first human
segm=groundTruth{1}.Segmentation;
image(segm)
colormap colorcube

% Compare to segmentation of another human
segm2=groundTruth{3}.Segmentation;
image(horzcat(segm,segm2))
colormap colorcube

% Boundaries are also built in the ground truth
figure
% Boundaries from first human
bound=groundTruth{1}.Boundaries;
image(bound)
colormap flag

% Compare to boundaries of another human
bound2=groundTruth{3}.Boundaries;
image(horzcat(bound,bound2))
colormap colorcube
```

Notice how there is not a single ground Truth in the data. This is a constant along all images


## Benchmark

Before you proceed with the actual benchmark, first keep in mind that the provided mex files provided are **only compatible with linux**. Second, just like with the texton lab, this one might be **quite computationally expensive**. Plan ahead and be mindful of the course limited resources. Unlike Lab05, this time the computation time in the 'test set' is as expensive as in the train or val set.

The file ``bench/test_benchs.m`` contains several examples of how to use the benchmark functions for different types of *result* images. Look at it and run the examples.

There is little coding to do in this lab, most of the 'heavy lifting' was already done in Lab06. To start, take a  look at the file that defines the function ``boundaryBench`` (BSR/bench/benchmarks/)and read the description of its inputs.

## Your Turn

### Start with your best segmentation method

Choose two of the functions you developed during the Lab06, use those with that yield the best performance. Feel free to modify or enhance any algorithm based on your findings for the last lab.

Now, adjust the function you designed in the past lab so that it works on the BSDS Benchmark. Essentially you must be able to process all the images in 'data' and then write the segmentation results in the same format as those in '/bench_fast/data/segs'. This is just as cell array where each element is a segmentation of the original image calculated with a different K; be consistent across all images, that is the Nth element on the array for any image should be calculated with the same K. 

There is at least one hyper-parameter for your segmentation method: K. Use the ``train``  and ``eval`` sets to explore the best values for K and any other hyper parameter.

### Test your method

Run a **segmentation benchmark** (labeled as  "4. morphological version for : all the benchmarks for results stored as a cell of segmentations") for your two methods, also  run the segmentation benchmark for the provided UCM segmentations (at BSDS500/ucm2). Use the **only** the ``test`` for comparisons.

The final plot should contain at least three lines (two instances of your function and the UCM algorithm). You can also use the plot found [in this repository](Figure02.fig) as a base. Look at the code of the ``plot_eval`` function for more information on how to create these plots.

Use different thresholds values to generate a curve.

See http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html#bench for an example otuput.


### Report

The report for this laboratory must include:
- A brief description of the selected segmentation methods, why did you choose them?, did you make any modification, or  enhancements?
- What are the hyper parameters of the methods, what do they mean?, how do you choose them? 
- Results for the BSDS benchmark for the three methods.  Include a graphic where you compare the curves you generated for the three methods.
- Which methods is the best, why? among the methods you developed, which one works best, why? do you think your selection of K could improve/worsen the results?
- You made a simpler comparison of methods on the last Lab, does the BSDS have similar results (i.e. your best algorithm remains the best), why or why not?
- What seem to be the limitations of the algorithms you developed, do you think the errors on your segmentation methods follow any pattern(s)?. Again execution time and resource usage are not our main concern.
- How could your improve your algorithms?

### Deadline


