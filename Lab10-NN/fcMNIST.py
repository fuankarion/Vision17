from keras.datasets import mnist
from keras.layers import Activation
from keras.layers import Dense
from keras.models import Sequential
 

(X_train, y_train), (X_test, y_test) = mnist.load_data()

print ('X_train.shape ', X_train.shape)
X_train = X_train.reshape(X_train.shape[0], 28 * 28)
X_test = X_test.reshape(X_test.shape[0], 28 * 28)
print ('X_train.shape ', X_train.shape)

X_train = X_train.astype('float32')
X_test = X_test.astype('float32')
X_train /= 255
X_test /= 255

model = Sequential()
model.add(Dense(20, input_dim=X_train.shape[1], init='uniform'))
model.add(Activation('relu'))

model.add(Dense(20, init='uniform'))
model.add(Activation('relu'))


model.add(Dense(1, init='uniform'))

model.summary()

model.compile(loss='mean_squared_error',optimizer='sgd',metrics=['accuracy'],lr=0.01,decay=0.0, momentum=0.9)

model.fit(X_train, y_train, nb_epoch=100, verbose=1,batch_size=900)

#Eval
score = model.evaluate(X_test, y_test, verbose=0)
print(score)
