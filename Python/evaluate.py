import tensorflow as tf
import pandas as pd
import numpy as np
import os
from sklearn.metrics import confusion_matrix


# load the dataset for testing
dataFileName = "testSet_table4.csv"
dataPath = os.path.join(os.getcwd(), dataFileName)
df = pd.read_csv(dataPath, header=None)
df = df.values.tolist()	# convert dataframe to list of lists

# load the trained neural network model
modelFileName = "AMC_" + dataFileName[8:-4] + ".model"
modelPath = os.path.join(os.getcwd(), modelFileName)
model = tf.keras.models.load_model(modelPath)

# extract features, labels and corresponding SNR values from the dataframe
Ntypes = 3	# number of classes corresponding to {16, 32, 64}-APSK
CATEGORIES = [16, 32, 64]	# classification outputs
X = []	# featuresW
y = []	# labels
snrValues = []	# snr values for each signal sample
for record in df:
	X.append(record[2:])
	y.append(record[0])
	snrValues.append(record[1])
X = np.array(X)

# normalize the features
X = tf.keras.utils.normalize(X)

# predict the outputs for the testing dataset
m = len(df)
predictions = model.predict([X])
ypred = [CATEGORIES[np.argmax(p)] for p in predictions]	# convert to desired output shape
correctPreds = [1 if y[i] == ypred[i] else 0 for i in range(m)]	# put 1 where prediction is correct
																# and put 0 if its wrong

# plot the desired tables and diagram to evaluate the performance
snrRange = range(int(df[0][1]), int(df[m-1][1]+1))
confusionSnrs = [0, 5, 10, 15]	# we want 4 confusion matrices for these SNR values
AvPerSnr = []	# accuracy per each SNR
confMats = []	# confusion matrix for 4 of the desited SNR values
for snr in snrRange:
	if snr in confusionSnrs:

		# extract true and predicted 'y' values for extracting confusion matrices
		ytrueTmp = [y[i] for i in range(m) if snr == snrValues[i]]
		ypredTmp = [ypred[i] for i in range(m) if snr == snrValues[i]]

		# rows are true values, and columns are predicted values
		tmpMat = confusion_matrix(ytrueTmp, ypredTmp, labels=[16, 32, 64], normalize='pred')
		confMats.append(tmpMat * 100)	# multiply by 100 to get percent

	tmp = [correctPreds[i] for i in range(m) if snr == snrValues[i]]
	AvPerSnr.append(sum(tmp)/len(tmp))

names = [str(c) for c in CATEGORIES]
for i in range(len(confusionSnrs)):
	outConfList = confMats[i].tolist()
	outDf = pd.DataFrame(outConfList, index=names, columns=names)
	outDf.to_csv("confusionMatSnr{}.csv".format(confusionSnrs[i]))
