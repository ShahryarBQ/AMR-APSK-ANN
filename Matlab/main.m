close all;
clear;
clc;

%% Initialization
Ltrain = 1080;
Ltest = 720;
N1 = 512*8;
N2 = 512*4;
SNRs1 = 0:20;

%% Fig 3 & 4
dataSet_fig34 = GenerateDataset(Ltrain,N1,-5:30,'AWGN-Only');
csvwrite('dataSet_fig34.csv', dataSet_fig34);

%% Table 4
dataSet_fig34 = csvread('dataSet_fig34.csv');
trainSet_table4 = dataSet_fig34(dataSet_fig34(:,2) >= min(SNRs1) & ...
                  dataSet_fig34(:,2) <= max(SNRs1), :);
csvwrite('trainSet_table4.csv', trainSet_table4);

testSet_table4 = GenerateDataset(Ltest,N1,SNRs1,'AWGN-Only');
csvwrite('testSet_table4.csv', testSet_table4);

%% Fig 7
N_fig5 = [1000, 2000, 5000, 10000];
for N = N_fig5
    trainSet_fig5 = GenerateDataset(Ltrain,N,SNRs1,'AWGN-Only');
    csvwrite('trainSet_fig7_N' + string(N) + '.csv', trainSet_fig5);
    
    testSet_fig5 = GenerateDataset(Ltest,N,SNRs1,'AWGN-Only');
    csvwrite('testSet_fig7_N' + string(N) + '.csv', testSet_fig5);
end

%% Fig 8
% channels_fig8 = ["AWGN-Only", "Multipath", "Unknown"];
% channels_fig8 = ["AWGN-Only", "Multipath"];
channels_fig8 = "Multipath";
SNRs_fig8 = 0:30;
for channelType = channels_fig8
    trainSet_fig8 = GenerateDataset(Ltrain,N2,SNRs_fig8,channelType);
    csvwrite('trainSet_fig8_Chan' + channelType + '.csv', trainSet_fig8);
    
    testSet_fig8 = GenerateDataset(Ltest,N2,SNRs_fig8,channelType);
    csvwrite('testSet_fig8_Chan' + channelType + '.csv', testSet_fig8);
end

%% Fig 9
phases_fig9 = [0 5 15 20 30];
for phase = phases_fig9
    trainSet_fig9 = GenerateDataset(Ltrain,N2,SNRs1,'PhaseOffset',phase);
    csvwrite('trainSet_fig9_Phase' + string(phase) + '.csv', trainSet_fig9);
    
    testSet_fig9 = GenerateDataset(Ltest,N2,SNRs1,'PhaseOffset',phase);
    csvwrite('testSet_fig9_Phase' + string(phase) + '.csv', testSet_fig9);
end

%% Fig 10
freqs_fig10 = [0 1 2 3 6];
for freq = freqs_fig10
    trainSet_fig10 = GenerateDataset(Ltrain,N2,SNRs1,'FreqOffset',freq);
    csvwrite('trainSet_fig10_Freq' + string(freq) + '.csv', trainSet_fig10);
    
    testSet_fig10 = GenerateDataset(Ltest,N2,SNRs1,'FreqOffset',freq);
    csvwrite('testSet_fig10_Freq' + string(freq) + '.csv', testSet_fig10);
end

%% Fig 12 & 13
Ltest_fig13 = 2*1080;
L_values = [240, 360, 480, 720, 1080];
for L = L_values
    trainSet_fig1213 = GenerateDataset(L,N2,SNRs1,'AWGN-Only');
    csvwrite('trainSet_fig1213_L' + string(L) + '.csv', trainSet_fig1213);
end

testSet_fig12 = GenerateDataset(Ltest,N2,SNRs1,'AWGN-Only');
csvwrite('testSet_fig12.csv', testSet_fig12);

testSet_fig13 = GenerateDataset(Ltest_fig13,N2,SNRs1,'AWGN-Only');
csvwrite('testSet_fig13.csv', testSet_fig13);

%% Fig 14
SNR_values1 = 0:15;
SNR_values2 = 0:2:20;
trainSet_fig14_1 = GenerateDataset(Ltrain,N2,SNR_values1,'AWGN-Only');
csvwrite('trainSet_fig14_1.csv', trainSet_fig14_1);

trainSet_fig14_2 = GenerateDataset(Ltrain,N2,SNR_values2,'AWGN-Only');
csvwrite('trainSet_fig14_2.csv', trainSet_fig14_2);

testSet_fig14 = testSet_fig12;
csvwrite('testSet_fig14.csv', testSet_fig14);