close all;
clear;
clc;

%% Initializations

N = 512*8;              % Symbols per each signal for the train set
Ms = [16 32 64];        % APSK modulation orders
M = 32;                 % APSK modulation orders
stdSuffix = 's2x';      % DVB-S standard
rolloff = 0.2;          % Filter rolloff (0 for ideal sinc interpolation)
span = 10;              % Filter span
sps = 8;                % Samples per Symbol
fc = 384*(10^3);        % Carrier frequency
Ns = N * sps;           % Total number of samples
fd = 38.4*(10^3);       % Symbol rate
fs = fd * sps;          % Sampling rate
t = (0:(Ns-1)) / fs;    %
snr = 7;

%%
for k = 1 : length(Ms)
    %% Test the uniformness of the random raw data
    rng('shuffle');	% seed the random number generator using current time
    % Uniformly distributed Random integers
    data = round(rand(1,N)*(Ms(k)-1))';
    
    figure(1);
    subplot(1,length(Ms),k);
    histogram(data,Ms(k),"FaceColor",'r');
    title(Ms(k)+"-APSK raw data distribution");
    xlabel("data");
    ylabel("count");

    %% Test the constellation points
    % using MATLAB's "dvbsapskmod" function to modulate the data
    modData = dvbsapskmod(data,Ms(k),stdSuffix);

    figure(2);
    subplot(1,length(Ms),k);
    plot(real(modData),imag(modData),'x',"MarkerSize",10,"LineWidth",5);
    grid on;
    title(Ms(k)+"-APSK Modulation Constellation");
    xlabel("In-Phase");
    ylabel("Quadrature");
end

%% Test the received signal

% effect of "sps" and pulse shaping
rrcFilter = rcosdesign(rolloff, span, sps);
pulseShapedData = filter(rrcFilter,1,upsample(modData,sps));

% Up converted data for passband transmition
carrier = sqrt(2)*exp(1j*2*pi*fc*t)';
txSig = real(pulseShapedData.*carrier);

% effect of channel
channelOut = txSig;
rxSig = awgn(channelOut,snr,'measured'); % recieved data in an AWGN channel

% baseband symbols
r = rxSig.*carrier;
dePulsedData = downsample(filter(rrcFilter,1,r), sps);

figure();
subplot(1,2,1);
pwelch(rxSig,[],[],[],fs,'centered');
subplot(1,2,2);
plot(real(dePulsedData),imag(dePulsedData), 'o');