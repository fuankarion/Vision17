# Berkeley Segmentation Dataset and Benchmark (BSDS500)

In this lab you will be testing your previously developed segmentation functions in a real and large segmentation database, the BSDS500. You will also be comparing your methods against those of your  teacher, as you will also benchmark UCM segmentation algorithm.

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

- bench_fast: Fast code for running benchmarks and comparing algorithms.
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

Before you proceed with the actual benchmark, first keep in mind that the provided mex files provided are **only compatible with linux**. Second, just like with the texton lab, this one might be **quite computationally expensive**. Plan ahead and be mindfuld of the course limited resources. Unlike Lab05, this time the computation time in the 'test set' is as expensive as in the train or val set.

The file ``bench/test_benchs.m`` contains several examples of how to use the benchmark functions for different types of *result* images. Look at it and run the examples.

There is little codign to do in this lab, most of the 'heavy lifting' was already done in Lab06. To start, take a  look at the file that defines the function ``boundaryBench`` (BSR/bench/benchmarks/)and read the description of its inputs.

# Your Turn

## Start with your best segementation method

Choose two of the functions you developed during the Lab06, use those with that yield the best performance. Feel free to modifiy or enhance any algortihm based on your findings for the last lab.

Now, adjust the function you designed in the past lab so that it works on the BSDS Benchmark. Essentialy you must be able to process all the images in 'data' and then write the segmentation results in the same format as those in '/bench_fast/data/segs'. This is just as cell array where each element is a segmentation of the original image calculated with a different K; be consisten across all images, that is the Nth elemenet on the array for any image should be calculated with the same K. 

There is at least one hyper-parameter for your segmentation method: K. Use the ``train``  and ``eval`` sets to explore the best values for K and any other hyper parameter.

## Test your method

Run a **segmentations benchmark** (labeled as  4. morphological version for : all the benchmarks for results stored as a cell of segmentations) for your two methods, compare it to the state of the art. Use the **only** the ``test`` set of the BSDS500. 

The final plot should contain at least three lines (two instances of your function and the UCM algorithm). You can also use the plot found [in this repository](Figure02.fig) as a base. Look at the code of the ``plot_eval`` function for more information on how to create these plots.

See http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html#bench for an example otuput.

Use different thresholds values to generate a curve.

A summary of the steps required is:

- Apply your function to each of the images in the *test* dataset
- For each image, create a *.mat* file that contains a cell array, which contains severa matrices representing the output of the function for different values of the parameter. Look at the *bench/data/segs* folder for examples.
- Run the ``boundaryBench`` function specifying the folder with the *.mat* files as ``pbDir``. See the third example in the *test_benchs* file.
- Generate the plot using the code from the ``test_eval`` function.

## Report

Write a report describing your chosen segmentation methods, the testing methodology, the results from the tests, and a discussion about the results and potential improvements to the function. Use the CVPR LaTeX template. Upload to your repository the report (tex and pdf) and the code for your segmentation function. A rubric of how this report will be graded can be found [here](rubric.md). You may work in pairs.


**Due:** March 17, 2016; 8:00 a.m.

## Running the benchmark remotely

The full benchmark on the 200 test images can take a several hours. If you prefer, you may run it on the course server.

However, all of you would be using the same account so please take into account the following

- Be careful not to mess with other people's data or processes
- Create a new directory and work only there, don't go into other people's directories

In order to be able to disconnect from the server and let it keep working you can use [sceen](http://linux.die.net/man/1/screen).
Connect using ``ssh`` and afterwards type

```bash
screen -S <session_name>
```

Use your name as session name, so that you don't get confused with other people working at the same time. If you disconnect from the session, you can return to it by typing

```bash
screen -r <session_name>
```

## Extra Credit

- Run the benchmark with at least *three* segmentation methods from
- k-means
- gmm
- hierarchical
- watershed


