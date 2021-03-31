function f = featureExtract(r)
%featureExtract Extract features from data for the paper below
%   A. K. Ali and E. Erçelebi, “Automatic modulation recognition of
%   DVB-S2X standard-specific with an APSK-based neural network
%   classifier,” Measurement, vol. 151, p. 107257, Feb. 2020,
%   doi: 10.1016/j.measurement.2019.107257. 
%
%   r = received signal
%   Ns = Number of samples ( = sps*N, N being number of symbols)

%% Initializations

Ns = length(r);
gammaIndexes = [2 3 4 5 7 9]; % kth power of the analytic signal
gammas = zeros(1,max(gammaIndexes));    % gammas are The maximum
                                        % DFT instantaneous features
                                        
%% Feature Extraction
%r = abs(r);
a = abs(hilbert(abs(r)));	% absolute value of the analytic form
a_c = a./mean(a) - 1;	% normalized-centered instantaneous amplitude

% the 6th and 8th gammas aren't needed, so their spot is left empty
gammas(1) = max(abs(fft(a_c)))^2 / Ns;
for i = gammaIndexes
        gammas(i) = max(abs(fft(a.^i)))^2 / Ns;
end

% desired features as is proposed in the paper
f = [gammas(1), gammas(2)./gammas(4), ...
     gammas(3)./gammas(7), gammas(5)./gammas(9)];
% f = [gammas(1), gammas(4)./gammas(2), ...
%      gammas(7)./gammas(3), gammas(9)./gammas(5)];

end