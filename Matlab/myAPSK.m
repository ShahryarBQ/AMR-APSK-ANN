function r = myAPSK(M, N, fc, fd, sps, snr, channelType, varargin)
%myAPSK Generate signal rows for the paper below
%   A. K. Ali and E. Erçelebi, “Automatic modulation recognition of
%   DVB-S2X standard-specific with an APSK-based neural network
%   classifier,” Measurement, vol. 151, p. 107257, Feb. 2020,
%   doi: 10.1016/j.measurement.2019.107257.
%
%   M = Modulation order
%   N = Number of symbols
%   fc = Carrier frequency
%   fd = Symbol rate (Rb)
%   sps = Samples per symbol
%   snr = Signal to Noise ratio
%   channelType = type of the channel, which can be:
%                 AWGN-Only, Multipath, Unknown, PhaseOffset, FreqOffset

%% Initializations

Ns = N * sps;           % Total number of samples
fs = fd * sps;          % Sampling rate
rolloff = 0.2;          % Filter rolloff (0 for ideal sinc interpolation)
span = 10;              % Filter span
t = (0 : (Ns-1)) / fs;	%
stdSuffix = 's2x';      % DVB-S standard

%% Data Generation and Modulation

rng('shuffle');	% seed the random number generator using current time
data = round(rand(1,N)*(M-1))';	% Uniformly distributed Random integers

% using MATLAB's "dvbsapskmod" function to modulate the data
% modData = dvbsapskmod(data,M,stdSuffix);
modData = dvbsapskmod(data,M,stdSuffix,'UnitAveragePower',true);

if channelType == "PhaseOffset" || channelType == "FreqOffset"
    commData = 0:M-1;
    commMod = comm.GeneralQAMModulator;
    commMod.Constellation = dvbsapskmod(commData,M,stdSuffix);
    modData = step(commMod, data);
end

% effect of "sps" and pulse shaping
rrcFilter = rcosdesign(rolloff, span, sps);
pulseShapedData = filter(rrcFilter,1,upsample(modData,sps));
% pulseShapedData = upfirdn(modData,rrcFilter,sps);
% pulseShapedData = rectpulse(modData,sps);

% Up converted data for passband transmition
carrier = sqrt(2)*exp(1j*2*pi*fc*t)';
txSig = real(pulseShapedData.*carrier);
% txSig = pulseShapedData;  # baseband transmission

% effect of channel
switch channelType
    case 'AWGN-Only'
        channelOut = txSig;
    case 'Multipath'
        channel = comm.RicianChannel(...
            'SampleRate', 20e6,...
            'PathDelays',[0 1 2]*1e-7,...
            'AveragePathGains',[0 -15 -20],...
            'KFactor',20^(3/10),...
            'MaximumDopplerShift',15.5);
    case 'Unknown'
    case 'PhaseOffset'
        channel = comm.PhaseFrequencyOffset(...
            'SampleRate', fs,...
            'PhaseOffset',varargin{1});
    case 'FreqOffset'
        channel = comm.PhaseFrequencyOffset(...
            'SampleRate', fs,...
            'FrequencyOffset',varargin{1}*fc);
end
if channelType ~= "AWGN-Only" && channelType ~= "Unknown"
    channelOut = channel(txSig);
end

rxSig = awgn(channelOut,snr,'measured'); % recieved data in an AWGN channel
r = rxSig;

end