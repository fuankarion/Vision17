# Fully Convolutional Networks for Image Segmentation

This one is for nature lovers :). In this lab you will fine tune a fully convolutional network to segment horses on the “weizmann horse image database” provided by [Eran Borenstein](http://www.msri.org/people/members/eranb/), 

## Resources
This Laboratory is based on the [tutorial](https://github.com/NVIDIA/DIGITS/tree/master/examples/semantic-segmentation) provided by Nvidia. It is strongly recommended to read the tutorial and get a nice grasp on the main ideas. Our task is just a tuned down version of the fine tuning exercise presented there. 

### Database

The data for this lab can be obtained from [Eran’s website](http://www.msri.org/people/members/eranb/), it contains 2 main directories
- Rgb: Color images of 328  horses
- Figure_ground: Hand labeled segmentation of the horse images. There are only two labels: Horse (white), background (black)

You might ignore the gray images as they have no extra information over the color images.

### Deep Learning  Engine
The baseline code works over the [caffe deep learning library](https://github.com/BVLC/caffe), specifically its python bindings.  If you need a quick introduction for python you might want to check the resources available on [Laboratory 13](https://github.com/fuankarion/Vision17/tree/master/Lab13-OpticalFLow). If you have an Nvidia GPU available it should have at least 2GB Memory, otherwise you will not be able to complete this Lab.

### Python Library
For the sake of simplicity your Lab instructor has coded a minimal Python library to work with Fully Convolutional networks over Caffe’s default python wrapper. The library is available [here](https://github.com/fuankarion/FCNThinLib)

There are two files you might want to take a look:
- createLMDBFNC: Two utility functions to create LMDB files for both labels and image data.
- trainFCN. Sample routine for **finetuning** an FCN network, it will log train data to ./net/log.txt

Additionally inside the directory ./net you will find 3 relevant resources
- Model.txt: URL to download the weights for the fully convolutional version of AlexNet trained in pascal VOC.
- Solver.prototxt: Overall training/fine-tuning configuration.
- trainVal.prototxt: Network descriptor.

If you need some help with the prototxt files, you can check the caffe reources on [layers](http://caffe.berkeleyvision.org/tutorial/layers.html)

### A Handy layer

Unlike most fine tune procedures, where the final layer of a network is removed and learnt from scratch while some of the other layers are fine tuned. We will finetune **only** the layers related to the deconvolution process, while freezing the lower layers, and finally adjust our net output with a simple 3 class output at the very top of the network. This final layer is called *score_3classes* and can be found on the trainVal.prototxt.

## Your turn
Finetune the provided network for the “weizmann horse image database”, remember there are 5 main steps:
- Create image labels, pay attention to the scheme used in the nvidia tutorial and use pixel intensity to label horses, background and ignore labels
- Create LMDBs, use the utilities  provided by your instructor, this can be tricky with caffe default binaries
- Decide a training schedule, find a proper configuration on the solver so you can get the better train results.  
- Import pretrained model, pay attention to line 18 on trainFCN.py
- Start learning, provided everything is on its place, just run *python trainFCN.py*

## Report
We will relax the usual delivery requirements for this one. Upload a small report to you github, any format you like; Describe your approach to train the FCN including the data prepartion. Perform a simple evaluation on a subset of the horses dataset using the jaccard index. Finally upload your code, and the general instructions to run it.

## Deadline
**Friday 19 2017 11:59**

