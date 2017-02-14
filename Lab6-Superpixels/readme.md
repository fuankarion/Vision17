# Segmentation practice

## Data


The data for this lab can be downloaded from the course server using http or ssh protocols

- `scp vision@SERVER_IP:/datos1/vision/images/images.tar.gz .`
- http://157.253.63.7/images.tar.gz

For using ssh in windows you may use [putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) 
or [filezilla](http://portableapps.com/apps/internet/filezilla_portable)  


## Implement a segmentation method

Implement your own segmentation method using what you have learned in class. It should be a matlab/python (opencv3 conmpatible) function with the following signature

Matlab
```matlab
function segmentation = segmentByClustering( rgb_image, featureSpace, clusteringMethod, numberOfClusters)
```

Python
```python
def segmentByClustering( rgb_image, featureSpace, clusteringMethod, numberOfClusters):
...
    return segmentation
```
Where

- featureSpace : 'rgb', 'lab', 'hsv', 'rgb+xy', 'lab+xy' or 'hsv+xy'
- clusteringMethod = 'k-means', 'gmm', 'hierarchical' or 'watershed' (code seen in class).

The output of the function should be an  matrix with the same withd and  height of the original image and only one channel, where each pixel has a cluster label. In other words, pixels that belong to the same cluster should have the same positive integer label.

## Test your function

To test the output of your function use something like

```matlab
image(segm)
colormap colorcube
```

You should see an image similar to the following, where each color represents a different cluster.

![Example of segmentation](segmented.png)

Try different parameters of your function, and see which ones work best. 


## Ground truth data

The ground truth data is saved as matlab data, it contains manual segmentation from different people. For example,
to look at the ground truth for image ``train/22090`` we can use the following code

```matlab
load('BSDS500/data/groundTruth/train/22090.mat')
% Load segmentation from first human
segm=groundTruth{1}.Segmentation;
image(segm)
colormap colorcube

% create a new figure
figure
% Boundaries from first human
bound=groundTruth{1}.Boundaries;
image(bound)
colormap flag
```

## Notes

- If you run into memory problems try scaling the image
- *xy* stands for the spatial _x_ and _y_ coordinates
- You may need to normalize the different channels to make them comparable, or to make some of them more important in the clustering process. For example _coords = ( α\*r, α\*g, α\*b, β\*x, β\*y)_

#Your turn

The report for this laboratory must include:

-   Small (Max. one paragraph per method) description of the clustering algorithms.
-   Did  you have to scale (up or down) any of the channesl (r,g,b,x,y). why?
-   Does it make sense to use other color spaces different from RGB?  why?
-   Do you think any of the channels seems to be most discriminative?
-   The hyperparameter 'numberOfClusters', is probably the most important parameter in this problem, how can you choose it
-   How can we evaluate a segmentation problem?, is the accuracy per class enough?


