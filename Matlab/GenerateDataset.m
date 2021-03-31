function set = GenerateDataset(L,N,SNRs,channelType,varargin)
%GenerateDataset Generate the Dataset with given parameters for the paper
% below
%   A. K. Ali and E. Erçelebi, “Automatic modulation recognition of
%   DVB-S2X standard-specific with an APSK-based neural network
%   classifier,” Measurement, vol. 151, p. 107257, Feb. 2020,
%   doi: 10.1016/j.measurement.2019.107257. 
%
%   L = count of Signal samples per each modulation
%   N = Symbols per each signal
%   SNRs = SNRs for the AWGN channel
%   channelType = type of the channel, which can be:
%                 AWGN-Only, Multipath, Unknown, PhaseOffset, FreqOffset

%% Initializations

nTypes = 3;         % number of modulation types
featureCount = 4;   % number of features
sps = 8;            % Samples per Symbol
M = [16 32 64];     % APSK modulation orders

fc = 384*(10^3);    % Carrier frequency
fd = 38.4*(10^3);   % Symbol rate
fs = 307.2*(10^3);  % Sampling rate (sps*fd)
Ns = N*sps;         % Total number of samples

%%

% features plus SNR and mod for train set and test set
set = zeros(L*length(SNRs)*nTypes, featureCount + 2);
for k = 1:nTypes
    disp('Generating ' + string(M(k)) + '-APSK');
    for j = 1:length(SNRs)
        snr = SNRs(j);
        disp('    for SNR = ' + string(snr));
        for i = 1:L
            if nargin == 4
                r = myAPSK(M(k),N,fc,fd,sps,snr,channelType);
            else
                r = myAPSK(M(k),N,fc,fd,sps,snr,channelType,varargin{1});
            end
            f = featureExtract(r);
 
            dataRow = [M(k) snr f];
            set((k-1)*length(SNRs)*L + (j-1)*L + i, :) = ...
                dataRow;
        end
    end
end

end