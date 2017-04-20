# Neural Networks Tutorial

In this lab we will introduce the very basic concepts of neural networks using the classic MNIST dataset. Just like the very first Labs, this is a tutorial, hence there are no deliverables or deadlines.


## Resources

This lab uses the [Keras Library](https://github.com/fchollet/keras), an easy to use deep learning library built on top of Google's own machine intelligence library [Tensor Flow](https://www.tensorflow.org). You might want to check their websites.

TensorFlow and keras are already installed at the course servers, however there are no gpus avaible on them, so the execution time will be longer than the demo during the class. If you want, you can install the mentioned libraries and run the examples in your pc, if you own a computer with a discrete **Nvidia** graphics card it will run much faster (porably faster than in the course servers).

The full scripts for this Lab are avilable [here](convMNIST.py) and [here](fcMNIST.py), no comments though.

## Handwritten digits recognition using Neural Networks
The data for the lab is available online and can be automatically download using the Keras library, it is as simple as:


```python
#Utilities for MNIST dataset on keras
from keras.datasets import mnist

# Load pre-shuffled MNIST data into train and test sets
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# Inspect the size of the train data
print(X_train.shape)
# Inspect the size of the train labels
print(y_train.shape)
```

MNIST images are very small (28x28) grayscale images containing a single handwritten digit, you can render the first image in the training set using the following code:

```python
from PIL import Image
import numpy as np

#0 is the first image on the train set
img = Image.fromarray(X_train[0,:,:])
img.show()
```

We will first approach the recognition problem using fully connected networks, therefore our first step will be to turn images into an array of 1x784


```python
X_train = X_train.reshape(X_train.shape[0], 28 * 28)
X_test = X_test.reshape(X_test.shape[0], 28 * 28)

# Inspect the new size of the train data
print ('X_train.shape ', X_train.shape)
print ('X_test.shape ', X_test.shape)
```

Now we can build a Neural Network to classify the MNIST data. As first example, we will use a minimal 1 layer 1 fully connected neural network


```python
from keras.layers import Dense
from keras.models import Sequential

#Normalize data for better convergence
X_train = X_train.astype('float32')
X_test = X_test.astype('float32')
X_train /= 255
X_test /= 255

#Define a new neural network model
model = Sequential()

#Add 1 fully connected layer with 1 neuron
model.add(Dense(1, input_dim=X_train.shape[1], init='uniform'))

#display the model summary, check the number of parameters
model.summary()

```

Before we start the optimization process, take a time to think about the network, how many parameters does it have?, what kind of operation does the neuron?

Now start the optimization process, using Stochastic gradient descent (sgd), a learning rate of 0.01, no decay and a momentum of 0.9. since we have a single neuron we have to relax the classification problem into an estimation one, thus, we use a mean squared error loss function (a bit of a cheapshot, but is the only way to train a network of this size for a classification problem):


```python

#Optimization params
model.compile(loss='mean_squared_error',optimizer='sgd',metrics=['accuracy'],lr=0.01,decay=0.0, momentum=0.9)

#Start training process
model.fit(X_train, y_train, nb_epoch=100, verbose=1,batch_size=900)
```

what does the loss value over the epochs tells you?, why the does the accuracy seems to reach a plateau at 0.2 accuracy?, do you think this a problem on the optimization parameters, feel free to change them.

## A Bigger network


The result on our first network was rather lackluster, but remember it is the smallest network than can be designed, and is still better than a random classification, we are probably heading in the right direction and just need a bigger network to improve the results, let's modify the network to use 10 neurons on the first layer, followed by our current 1 neuron layer.

```python
#Define a new neural network model
model = Sequential()

#Add 1 fully connected layer with 10 neurons
model.add(Dense(10, input_dim=X_train.shape[1], init='uniform'))
model.add(Dense(1, init='uniform'))

#display the model summary, check the number of parameters
model.summary()

```
## Non Linear Gating
The result improves but just a bit, as long as we don't add any nonlinearities, even the largest network will still perform a linear operation over the input, and won't be much better than the single neuron network

```python
#Define a new neural network model
model = Sequential()

#Add 1 fully connected layer with 10 neurons
model.add(Dense(10, input_dim=X_train.shape[1], init='uniform'))

#rectified linear unit nonlinearity
model.add(Activation('relu'))
model.add(Dense(1, init='uniform'))

#display the model summary, check the number of parameters
model.summary()

```

This time our classification accuracy is close to 0.48, a big jump that suggest to keep adding several more layers (convolutional and non linear filters) which will, likely, improve our results. Try adding several more layers to the current network, what's the best accuracy you can get?

## A convolutional neural network

The very first step in the first example was to destroy the images spatial information in order to work  with 1d neural layers. Convolutional neural layers will allow us to keep this spatial information.

The overall set up for the experiment is the same, however, as we now have a much bigger network, we can properly formulate the problem as a classification problem rather than a regression one, hence we modify the shape of the labels by using 

```python
Y_train = np_utils.to_categorical(y_train, 10)
Y_test = np_utils.to_categorical(y_test, 10)
```

Define the convolutional network as:

```python
model = Sequential()
#Add a layer with 64 2d convolutional filter of size 3x3
model.add(Convolution2D(64, 3, 3,  input_shape=(1,28,28),dim_ordering="th"))
model.add(Activation('relu'))
#Perform a Maximum pooling operation over the nonlinear responses of the convolutional #layer
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))

model.add(Convolution2D(32, 3, 3,dim_ordering="th"))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))
#Try to control overfit on the network, by randomly excluding 25% of neurons on the last #layer during each iteration
model.add(Dropout(0.25))

model.add(Convolution2D(32, 3, 3,dim_ordering="th"))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))
model.add(Dropout(0.25))

#Turn the 2d response of the network into a 1d array so we can output a 1x10 array
model.add(Flatten())
model.add(Dense(10, activation='softmax'))

model.summary()
```
And use a suitable loss function for a classification problem:

```python
model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])
```

## Final thoughts
While there are no deliverables for this lab, you might want to play around with this dataset and the convolutional neural layers, it will give you some ideas on how to design and train them from scratch. 


