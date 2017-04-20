# Convolutional Neural Networks for Image Classification
In this lab we will be exploring the use of Convolutional Neural Networks (CNN) for image classification. We will start from the very beginning, that is, we will design and train a CNN from a random weight initialization.

**Note, while executing the code does not take that long as in other Labs, you will have to discover an appropriate network by trial and error, this might be time consuming, plan ahead and don't get discouraged by the negative results.**

## Resources
The [VGG Convolutional Neural Networks Practical](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html) will be a great reference for this tutorial. We will also stick to our traditions and use the [vl-feat](http://www.vlfeat.org/matlab/matlab.html) along with its extension for CNNs [MatConvNet](http://www.vlfeat.org/matconvnet/functions/). If you have a computer with an Nvidia-GPU, make sure you install the GPU comptibility for MatConvNet it might be a bit tricky but the speed up is totally worth it.


### Creating a CNN
Read through [Part 1](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part1) of the practical.
Learn about the different types of layers and what they do, specially:

- Convolution filters
- Nonlinear gating
- Pooling
- Normalisation

Specifically, try to understand the dimensions of their inputs and outputs. How can you connect them? How does the data flows across the network?

### Training a CNN

Go through [Part 4](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part-4-learning-a-character-cnn) of the practical.

What is *training with Jitter*?
What are its advantages?


### Classifying images with a CNN

Go through [Part 5](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part-5-using-pretrained-models) of the practical.

- Visualize the model and see the different layers.
- Test it on the *peppers* image
- Test it on some of the *ImageNET* images from the PHOW Lab
- Test it on a random image

## Data

We will fall back to the texton dataset (beacuse those pesky local patterns have been asking for it!!). Unlike the set you already know from Lab5, we randomly sampled *128x128* patches from each image in the train set in order to create a 'new' texton dataset with 25000 images, this sampling is a mere technical shortcut, as larger images will require a lot more time to process.

The file [textonsdb](), contains the modified texton dataset for this Lab.

## Phase 1, Your turn

Design a Neural Network to classify this new texton dataset. Just like in Lab 10 you are on your own, 

**For the first phase of this lab** (more on that later) the one requirement is to use **only a CNN**, that is you are not allowed to apply any pre/postprocessing, other vision or learning strategies are also forbidden. Additionally you must **stick to the provided data** as it would be rather easy to cheat with the already known texton dataset.

## Report
The report for this lab should be brief (no more than 3 pages, - you can still use additional pages for figures and references-). It must contain the following information:

- A description of your network, and the ideas you tried to implement on that design.
- What challenges you faced while designing the architecture?
- Does the use of jitter helps?
- Ablation tests, we will try to explain why the network works by removing some layers from it, how does each removed layer affect the performance?, what does it tell about your architecture?
- The results of your network in train and validation sets.

Do not forget to upload a MATLAB .m file containing the description of the network (similar to ``initializeCharacterCNN.m``). At the start of each layer include a comment indicating the size of the input

Last but not least **Do not include in the report your best network!!**, if you only have 1 network architecture remove some layers, use less convolutional filters or do whatever change that brings a suboptimal performance on the network. This bizarre requirement will become clear as we start phase 2.

### About the jitter function
The function *getBatchWithJitter* is hardcoded for 32x32 images, its dapatation for images with diffrent sizes is not exactly trivial. You can use my modification if that function called *getBatchWithJitter128.m* if you want. But beware, while it worked ok for me, it just a quick and dirty hack over the initial function.

## Due Date:
**May 4 2016** As ussual just upload you report to git

## Phase 2, The Texton Challenge (Available 27 April)

