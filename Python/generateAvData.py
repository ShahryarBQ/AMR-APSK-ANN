import tensorflow as tf
import pandas as pd
import numpy as np
import os
from sklearn.metrics import confusion_matrix


# load the dataset for testing
dataFileName = "testSet_fig8_ChanMultipath.csv"
dataPath = os.path.join(os.getcwd(), dataFileName)
df = pd.read_csv(dataPath, header=None)
df = df.values.tolist()	# convert dataframe to list of lists

# load the trained neural network model
if dataFileName[8:-4] == "fig12" or dataFileName[8:-4] == "fig13":
	L = 1080
	modelFileName = f"AMC_fig1213_L{L}.model"
	saveFileName = f"Av_{dataFileName[8:-4]}_L{L}.csv"
elif dataFileName[8:-4] == "fig14":
	num = 2
	modelFileName = f"AMC_fig14_{num}.model"
	saveFileName = f"Av_{dataFileName[8:-4]}_{num}.csv"
else:
	saveFileName = f"Av_{dataFileName[8:-4]}.csv"
	modelFileName = f"AMC_{dataFileName[8:-4]}.model"

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
AvPerSnr = []	# accuracy per each SNR
confMats = []	# confusion matrix for 4 of the desited SNR values
for snr in snrRange:
	tmp = [correctPreds[i] for i in range(m) if snr == snrValues[i]]
	AvPerSnr.append(sum(tmp)/len(tmp))

names = [str(snr) for snr in snrRange]
outDf = pd.DataFrame(AvPerSnr, index=names)
outDf.to_csv(saveFileName)