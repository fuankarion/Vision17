from keras.datasets import mnist

from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.optimizers import SGD
from matplotlib import pyplot as plt
from keras.utils import np_utils
from keras.layers import Convolution2D, MaxPooling2D
 
# Load pre-shuffled MNIST data into train and test sets
(X_train, y_train), (X_test, y_test) = mnist.load_data()

print ('X_train.shape ',X_train.shape)
X_train = X_train.reshape(X_train.shape[0], 1, 28, 28)
X_test = X_test.reshape(X_test.shape[0], 1, 28, 28)
print ('X_train.shape ',X_train.shape)


X_train = X_train.astype('float32')
X_test = X_test.astype('float32')
X_train /= 255
X_test /= 255

Y_train = np_utils.to_categorical(y_train, 10)
Y_test = np_utils.to_categorical(y_test, 10)


model = Sequential()
model.add(Convolution2D(64, 3, 3,  input_shape=(1,28,28),dim_ordering="th"))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))

model.add(Convolution2D(32, 3, 3,dim_ordering="th"))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))
model.add(Dropout(0.25))

model.add(Convolution2D(32, 3, 3,dim_ordering="th"))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2,2),dim_ordering="th"))
model.add(Dropout(0.25))


model.add(Flatten())
model.add(Dense(10, activation='softmax'))

model.summary()

model.compile(loss='categorical_crossentropy',
              optimizer='sgd',
              metrics=['accuracy'])

model.fit(X_train, Y_train, batch_size=900, nb_epoch=20, verbose=1)
	
score = model.evaluate(X_test, Y_test, verbose=0)
print(score)