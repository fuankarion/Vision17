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

**Note**: You probably don't want to add all these files to your repository, most of them are images, and they are really big.

## Data description

The folder contains the following directories:

- bench_fast: Approximate, faster version of the original BSDS benchmark code.
- BSD500:
- Data: Images along with their manual segmentations (ground truth).
  - ucm2: Precalculated results of the *Ultrametric Contour Map* segmentation algorithm.
  - Documentation: Paper describing the UCM algorithm.
- Grouping: Implementation of the UCM algorithm (for those rad students that get offended at the very mention of precalculated results ;) )   

## Ground truth data

The ground truth data is saved as matlab data files, it contains manual segmentation from several persons. As a short reminder, this is how you look at the ground truth for image ``train/22090``:

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

## BSDS Benchmark

Before you proceed keep in mind that, just like with the texton lab, this benchmak is **quite computationally expensive**. Plan ahead and be mindful of the limited resources on the course servers. Unlike Lab05, the computation time in the 'test set' is as expensive as in the train or val set.

The file ``bench_fast/test_benchs_fast.m`` contains two examples on how to use the fast benchmark functions with two different types of output images. You might want to focus on the one labeled "%% 4. morphological version for : all the benchmarks for results stored as a cell of segmentations", as this one works directly with superpixels.


## Your Turn

There is little coding to do in this lab, most of the 'heavy lifting' was already done in Lab06. To start, take a  look at the  files at (./BSR/bench_fast/data/segs), the ultimate goal of your code is to produce matlab data files just like these. They are just cell arrays, where each element is a segmentation of the original image calculated with a different K; Be consistent across all images, that is, the N-th element on the array for any image should be calculated with the same K.  

### Start with your best segmentation method

Choose two of the functions you developed during the Lab06, use those that had the best performance. Feel free to modify or enhance any algorithm based on your findings for the last lab. If you think any of the functions is too computationally expensive, this is the moment to make some adjustments. Remember the benchmark must be run with **all 200 images**.

Now, adjust the function you designed in the past lab so that it works on the BSDS Benchmark. Essentially you must be able to process a full set of images (train/eval/test) and then write the segmentation results in the same format as those in '/bench_fast/data/segs'. 

There is, at least, one hyper-parameter for your segmentation method: K (number of clusters). Use the ``train``  and ``eval`` sets to explore the best set of values for K and any other hyper parameter.

### Testing your method

Once you get the segmented images in the proper format, run the benchmark for your selected methods, also run the  benchmark for the provided UCM segmentations (at BSDS500/ucm2). Use **only** the ``test`` for comparisons.

Do not forget to use different thresholds values to generate a nice curve. See http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html#bench for an example output.


### Report

The report for this laboratory must include:
- A brief description of the selected segmentation methods, why did you choose them?, did you make any modification, or  enhancements? why?
- What are the hyper parameters of these methods, what do they mean?, how could you choose them? 
- What  does the precision-recall curve tells us?, what would be the ideal result?
- Results for the BSDS benchmark (full test set) for the three methods.  Do not forget to include a graphic where you compare the curves you generated for the three methods.
- Among the methods you developed, which one works best, why? do you think your selection of K could improve/worsen the results?
- Did you beat Pablo, No? why?.
- On the last Lab, you made a simple comparison of segmentation methods, does the BSDS benchmark has similar results (i.e. your best algorithm remains the best), why? or why not?
- What seems to be the limitations of the algorithms you developed?. Again execution time and resource usage are not our main concern.
- Do you think the errors on your segmentation methods follow any pattern(s)?
- How could you improve your algorithms? Think big, be creative, we are in the what if domain :)

### Deadline
**March 23 11:59 pm,**, as usual just upload your report to your github repo.


