close all;
clear;
clc;

%% Initializations

nTypes = 3;         % number of modulation types
featureCount = 4;	% number of features
L = 1080/20;        % count of Signal samples per each modulation
Ltest = 720/20;     % count of signal samples for testing
sps = 8;            % Samples per Symbol
SNRs = -5:30;        % SNRs for the AWGN channel
M = [16 32 64];     % APSK modulation orders

fc = 384*(10^3);    % Carrier frequency
fd = 38.4*(10^3);   % Symbol rate
fs = 307.2*(10^3);  % Sampling rate
N = 512*8;          % Symbols per each signal for the train set
Ntest = 512*8;      % Symbols per each signal for the test set
Ns = 32768;         % Total number of samples (sps*N)

%%

% features plus SNR and mod for train set and test set
trainSet = zeros(L*length(SNRs)*nTypes, featureCount + 2);
testSet = zeros(Ltest*length(SNRs)*nTypes, featureCount + 2);
for k = 1:nTypes
    disp('Generating ' + string(M(k)) + '-APSK Train');
    for snr = SNRs
        disp('    for SNR = ' + string(snr));
        for i = 1:L
            r = myAPSK(M(k),N,fc,fd,sps,snr,'AWGN-Only');
            f = featureExtract(r);
 
            dataRow = [M(k) snr f];
            trainSet((k-1)*length(SNRs)*L + ...
                (find(SNRs==snr)-1)*L ...
                + i, :) = dataRow;
        end
    end
%     disp('Generating ' + string(M(k)) + '-APSK Test');
%     for snr = SNRs
%         disp('    for SNR = ' + string(snr));
%         for i = 1:Ltest
%             r = myAPSK(M(k),Ntest,fc,fd,sps,snr,'AWGN-Only');
%             f = featureExtract(r);
% 
%             dataRow = [M(k) snr f];
%             testSet((k-1)*length(SNRs)*Ltest + ...
%                 (find(SNRs==snr)-1)*Ltest ...
%                 + i, :) = dataRow;
%         end
%     end
end

csvwrite('trainSet.csv', trainSet);
% csvwrite('testSet.csv', testSet);