# AMR-APSK-ANN
Automatic modulation recognition of DVB-S2X standard-specific with an
APSK-based neural network classifier

## Instructions
Reading the below sections in the written order will help better understand all the codes.

## Matlab
### myAPSK.m
Takes the parameters in "Table 2" of the paper and the channel information, then returns an APSK signal as defined in the DVB-S2X standard. Note that this signal goes through the channel, so it is the received signal at the receiver.

### testTheData.m
This script is to check if the "myAPSK.m" function is correct or not. Different parts of that function is separated and plotted to be sure of the correctness of the algorithm.

### featureExtract.m
Takes the received signal as input, and outputs the extraced features as defined in "Equations 4~8 and 13" of the paper.

### GenerateDatasetTemp.m
This script was initially used for proof checking. See "GenerateDataset.m" as the final completed function.

### paperFigsPlots1.m
Use the output files of "GenerateDatasetTemp.m" to generate "Figures 3 and 7". Note that the "main.m" script will also generate the dataset for these figures, so you can easily ignore "GenerateDatasetTemp.m".

The expected output files of this "paperFigsPlots1.m" script has also been uploaded here, see "misc/figures". The input files for this code have also been uploaded, see "misc/results".

### GenerateDataset.m
Takes the parameters for the dataset as given in "Section 5: The classifier entity" of the paper (dataset size and desired SNRs), and creates a dataset using the "myAPSK.m" and "featureExctract.m" functions. This dataset is used in "Table 4", but because other datasets with different parameters are required for "Figures 3, 4, 7~10 and 12~14", this function is also used there.

Note that these datasets only hold the final features in them, therefore the main signals which the features are extracted from them are thrown away.

### main.m
This scripts uses the "GenerateDataset.m" function to generate all the train sets and test sets that are required for all the tables and figures. Note that this scripts is the main part of this project and takes the longest to execute.

Up until this point, only the Matlab codes are executed. To be able to run "paperFigsPlots2.m", it is necessary to first run the Python codes and then come back with the results to generate the final plots.

The expected output files of this "main.m" script has also been uploaded here, see "misc/trainSets" and "misc/testSets".

### paperFigsPlots2.m
After using the Python codes for the Machine Learning task, the results and output files are used in this function to simulate all the tables and figures of the paper.

The expected output files of this "paperFigsPlots2.m" script has also been uploaded here, see "misc/figures". The input files for this code are generated using the "generateAvData.py" script, but they have also been uploaded, see "misc/results".

## Python
### train.py
Train an artificial neural network (ANN) using the information in "Figures 5 and 6", "Equation 14" and "Table 3". Second to "main.m", this code takes a lot of time to run.

The expected output files of this "train.py" script has also been uploaded here, see "misc/NNmodels". The input files for this code are generated using the "main.m" script, but they have also been uploaded, see "misc/trainSets".

### evaluate.py
Use the learned ANN model and the test sets to evaluate the accuracy of the model. This code was initially used for proof checking, but was later completed in the "generateAvData.py" script. But still it needs to be run to create "Table 4" of the paper.

The expected output files of this "evaluate.py" script has also been uploaded here, see "misc/results". The input files for this code are generated using the "main.m" and "train.py" scripts, but they have also been uploaded, see "misc/testSets" and "misc/NNmodels".

### generateAvData.py
Use the learned ANN model and the test sets to evaluate the accuracy of the model. This code is used to generate all the remaining figures of the paper which are about the accuracies.

The expected output files of this "generateAvData.py" script has also been uploaded here, see "misc/results". The input files for this code are generated using the "main.m" and "train.py" scripts, but they have also been uploaded, see "misc/testSets" and "misc/NNmodels".

## Refernce
[1] A. K. Ali and E. Erçelebi:
*Automatic modulation recognition of DVB-S2X standard-specific with an APSK-based neural network classifier*. Measurement, vol. 151, p. 107257, Feb. 2020, doi: 10.1016/j.measurement.2019.107257.