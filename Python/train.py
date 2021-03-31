import tensorflow as tf
import pandas as pd
import numpy as np
import random
import os


# load the dataset for training to a dataframe using pandas
loadFileName = "trainSet_fig8_ChanMultipath.csv"
loadPath = os.path.join(os.getcwd(), loadFileName)
df = pd.read_csv(loadPath, header=None)
df = df.values.tolist()	# convert dataframe to list of lists
random.shuffle(df)	# shuffle the data to have better performance in each epoch

# extract features and labels from the dataframe
Ntypes = 3	# number of classes corresponding to {16, 32, 64}-APSK
CATEGORIES = [16, 32, 64]	# classification outputs
X = []	# features
y = []	# labels
for record in df:
	X.append(record[2:])

	# e.g. outputs are like [1 0 0] for 16-APSK
	y.append([1 if c == record[0] else 0 for c in CATEGORIES])
X = np.array(X)

# seperate training, validation and test sets
m = len(df)
trainValBound = round(0.7*m)	# 70% of data is for training
valTestBound = round(0.85*m)	# 15% is for validation and 15% for testing
Xtrain = X[0:trainValBound]
ytrain = y[0:trainValBound]
Xval = X[trainValBound:valTestBound]
yval = y[trainValBound:valTestBound]
Xtest = X[valTestBound:m]
ytest = y[valTestBound:m]

# normalize the features
Xtrain = tf.keras.utils.normalize(Xtrain)
Xval = tf.keras.utils.normalize(Xval)
Xtest = tf.keras.utils.normalize(Xtest)

# building the neural network (MLP) architecture
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.InputLayer(input_shape=(4,)))
model.add(tf.keras.layers.Dense(12, activation=tf.keras.activations.tanh))
model.add(tf.keras.layers.Dense(16, activation=tf.keras.activations.sigmoid))
model.add(tf.keras.layers.Dense(Ntypes, activation=tf.keras.activations.softmax))
model.compile(optimizer='adam',
	loss='mean_squared_error',
	metrics=['accuracy'])

# start training. epochs are set to give MSE of 10e-6
callback = tf.keras.callbacks.EarlyStopping(monitor='loss', patience=3)
model.fit(Xtrain, ytrain, validation_data=(Xval, yval), epochs=300, callbacks=[callback])

# save the model for later use without training again
saveFileName = "AMC_" + loadFileName[9:-4] + ".model"
savePath = os.path.join(os.getcwd(), saveFileName)
model.save(savePath)

# test the model to see if it generalizes
model = tf.keras.models.load_model(savePath)
val_loss, val_acc = model.evaluate(Xtest, ytest)
print(val_loss, val_acc)