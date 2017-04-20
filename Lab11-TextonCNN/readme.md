# Convolutional Neural Networks for Image Classification
In this lab we will be exploring the use of Convolutional Neural Networks (CNN) for image classification. We will start from the very beginning, that is, as will design a CNN and will train it from a random weight initialization.

**Note, while executing the code does not take that long as in thers Lab you will have to discover an appropaite network by trial an error, this might be time consuming, plan ahead and dont get descouraged with the negative results.**

## Resources
The [VGG Convolutional Neural Networks Practical](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html) will be a great reference for this tutorial. We will also stick to our traditions and use the [vl-feat](http://www.vlfeat.org/matlab/matlab.html) along with its extension for CNNs [MatConvNet](http://www.vlfeat.org/matconvnet/functions/).


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

The file [textonsdb](), contains the a modified version of the dataset from Lab5. Yup, we will deal again with those pesky repeated local patterns. In our favor, this time we have a far better tool in our hands.

Unlike the set you already know from Lab5, we randomly sampled *128x128* patches from each image in the train set in order to create a 'new' set of 25000 training images, this sampling is a merely technical shortcut, as larger images will require a lot more time to process.

## Your turn

Design a network to classify this new texton dataset. Just like in Lab 10 you are on your own, and **for the first phase of this lab** (more on that later) the one requirement is to use **only a CNN**, that is no pre-processing, you are not allowed to apply any postprocessing, other vision or learning strategies. Additionally you must **stick to the provided data** as it would be easy to cheat with the already known texton dataset.

## Report
The report for this lab should be brief (no more than 3 pages, - you can still use additional pages for figures and references-). It must contain the following information

- A brief description of your network, and the ideas you tried to implement on its design . What challenges you faced while designing the architecture?
- Ablation tests, we will try to explain why the networkworld by removing some layers of your network, how does it affect the performance?
- The results of your network in train and test, also indicate the time it took to train

Do not forget to upload a .m file containing the description of the network (similar to ``initializeCharacterCNN.m``). At the start of each layer include a comment indicating the size of the input

**Do not include in the report your best network!!**

## Due Date:


## Phase 2, The Texton Challenge




