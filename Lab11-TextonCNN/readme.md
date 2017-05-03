# Convolutional Neural Networks for Image Classification
In this lab we will be exploring the use of Convolutional Neural Networks (CNN) for image classification. We will start from the very beginning, that is, we will design and train a CNN from a random weight initialization.

**Note, while executing the code does not take that long as in other Labs, you will have to discover an appropriate network by trial and error, this might be time consuming, plan ahead and don't get discouraged by the negative results.**

## Resources
The [VGG Convolutional Neural Networks Practical](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html) will be a great kick start for this Lab. We will stick to our traditions and use the [vl-feat](http://www.vlfeat.org/matlab/matlab.html) along with its extension for CNNs [MatConvNet](http://www.vlfeat.org/matconvnet/functions/). If you have a computer with an Nvidia-GPU, make sure you install the GPU compatibility for MatConvNet it might be a bit tricky but the speed up is totally worth it.

## Cluster and GPU Access 

We have 4 gpus available for the whole group, therefore we must be very careful on its usage. According to the class discussion, each group will be assigned to a single GPU, and only one 'uniandes account' per team will have access to the cluster infrastructure.

The assignation is a follows 


 Account | GPU 
 --- | --- 
Guillaume's team | GPU 0
 Jorge's Team | GPU 0
 Edgard | GPU 1
 Crhistian's Team | GPU 1
 Fabian's team | GPU 1 
 Sebastian's Team | GPU 2
 Laura's team | GPU 2
 Mariajose's team | GPU 2 
 Ruben's team | GPU 3 
 Alejandro's team | GPU 3
 

GPU RAM memory is by far the most sensitive resource, unlike most Labs,  you will have a **very strict resource limit**:
- Teams in GPUs 1 & 2 will not be allowed to run any process over 4GB, 
- Teams on GPUs 0 and 3 you will not be allowed to run any process with more than 6GB. 

While I  can not directly enforce this resource limit, I will be checking from time time the resource usage, if any team fails to comply with the resource limit, I will first politely ask the team leader (the ones with access to the cluster) to tune down the parameters on their experiments. Anyway, if  you repeatedly fail to comply with the limit, I will ask the DSIT to temporarily block the access to the cluster. Lets never get there.

This assignation **will not be modified** unless it absolutely necessary or if the DSIT requires otherwise.

### Cluster Access Times

The DSIT has granted us exclusive access to the GPUs on the cluster for the following time frames:

- Weekdays -> 18:00  to 0:00
- Weekends -> 13:00  to 19:00


### Creating a CNN
Read through [Part 1](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part1) of the practical.
Learn about the different types of layers and what they do, specially:

- Convolution filters
- Nonlinear gating
- Pooling
- Dropout layers

Specifically, try to understand the dimensions of their inputs and outputs. How can you connect them? How does the data flows across the network?

### Training a CNN

Go through [Part 4](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part-4-learning-a-character-cnn) of the practical.

What is *training with Jitter*?
What are its advantages?

### Classifying images with a CNN

Go through [Part 5](http://www.robots.ox.ac.uk/~vgg/practicals/cnn/index.html#part-5-using-pretrained-models) of the practical.

- Visualize the model and see the different layers.
- Test it on the *peppers* image
- Test it on some of the *ImageNET* images from the PHOW Lab (Lab 08)
- Test it on a random image

### Recommended Resources
This [paper](https://arxiv.org/abs/1407.1610) will give you further insight on what to try while training a CNN. It is certainly not a technical tutorial, but I strongly recommend to read it before you start designing CNN architectures

## Data

We will fall back to the texture dataset (because those pesky local patterns have been asking for it!!). Unlike the set you already know from Lab5, we randomly sampled *128x128* patches from each image in the train set in order to create a 'new' texture dataset with 25000 images, this sampling is a mere technical shortcut, as larger images will require a lot more time to process.

The file [texturedb](http://157.253.63.7/texturesPublic) is a matlab file, which contains the modified texture dataset for this Lab. The file contains the images, its label and the set they belong to (check the meta-info for a more detailed description), also notice all the test images have '0' as label.

## Phase 1, Your turn

Design a Neural Network to classify this new texture dataset. Just like in Lab 10 you are on your own, 

**For the first phase of this lab** (more on that later) the one requirement is to use **only a CNN**, that is you are not allowed to apply any pre/postprocessing and other vision or learning strategies are forbidden. Additionally you must **stick to the provided data** as it would be rather easy to cheat with the already known texture dataset.

## Report
The report for this lab should be brief (no more than 4 pages, - you can still use additional pages for figures and references-). It must contain the following information:

- A description of your network, and the ideas you tried to implement on that design.
- What challenges did you face while designing the architecture?, how much you had to change your original design until it worked?
- Does the use of jitter helps?
- Ablation tests, we will try to explain why the network works by removing some layers from it, how does each removed layer affect the performance?, what does it tell about your architecture?
- The results of your network in train and validation sets.

Do not forget to upload a MATLAB .m file containing the description of the network (similar to ``initializeCharacterCNN.m``). At the start of each layer include a comment indicating the size of the input.

Last but not least **Do not include in the report your best network!!**, if you only have 1 network architecture remove some layers, use less convolutional filters or do whatever change that brings a suboptimal performance on the network. This bizarre requirement will become clear as we enter phase 2.

### About the jitter function
The function *getBatchWithJitter* is hardcoded for 32x32 images, its adaptation for images with different sizes is not exactly trivial. If you want, you can use my modification of that function called [getBatchWithJitter128.m](getBatchWithJitter128.m) . But beware, while it worked ok for me, it just a quick and dirty hack over the initial function, I can't guarantee it works as expected in every possible scenario.

## Due Date:
**May 4 2016** As usual just upload you report to git

## Phase 2, The Texture Recognition Challenge (Available 27 April)
We will be holding our small 'texture classification challenge', like most real-world challenges you are free to use **any strategy (cheating is not a valid strategy!)** to produce the better classification over the test set of our modified texture database. Your Submissions will have a standard format (just like in lab 10), they will be evaluated and ranked according to their (F1?/ACA?)..... Finally, unlike real world challenges, you cannot develop a joint solution with another group, any such submission will be disregarded. 

As this extra credit requires a lot of effort, there will be a special bonus. The best two submission will be able to change one of their Labs grades (and that is **any grade**) for a 5.0. Any other submission that ranks above (.....) will get a +1.0 that can be added to any one of their Labs grades. 


