close all;
clear;
clc;

%%
df = csvread('trainSet.csv');
% df(:,4:6) = 1./df(:,4:6);

m = size(df,1);
n = size(df,2);
SNRs = df(1,2):df(m,2);
features = df(:,3:6);

apsk16 = df(df(:,1)==16,:);
apsk32 = df(df(:,1)==32,:);
apsk64 = df(df(:,1)==64,:);

%%
subplot(121);
pairPlot = corrplot(features,'varNames',{'f1' 'f2' 'f3' 'f4'});
subplot(122);
imagesc(pairPlot);
colorbar;
colormap(jet)
title('Correlations');

%%
mean16 = zeros(1,length(SNRs));
mean32 = zeros(1,length(SNRs));
mean64 = zeros(1,length(SNRs));

figure();
for k = 3:n
    subplot(2,2,k-2);
    hold on;
    for snr = SNRs
        snrIndex = find(SNRs == snr);
        mean16(snrIndex) = mean(apsk16(apsk16(:,2)==snr,k));
        mean32(snrIndex) = mean(apsk32(apsk32(:,2)==snr,k));
        mean64(snrIndex) = mean(apsk64(apsk64(:,2)==snr,k));
    end
    plot(SNRs,mean16,'bo-','MarkerSize',6,'LineWidth',1.2);
    plot(SNRs,mean32,'g*-','MarkerSize',6,'LineWidth',1.2);
    plot(SNRs,mean64,'rs-','MarkerSize',6,'LineWidth',1.2);
    
    legend('16APSK','32APSK','64APSK');
    xlabel('SNR (dB)');
    ylabel('f' + string(k-2));
end

%%
snr = -5;
apsk16snr = apsk16(apsk16(:,2)==snr,:);
apsk32snr = apsk32(apsk32(:,2)==snr,:);
apsk64snr = apsk64(apsk64(:,2)==snr,:);

figure();
for k = 3:2:5
    subplot(1,2,(k-1)/2);
    hold on;
%     plot(apsk16snr(:,k),apsk16snr(:,k+1),'^');
%     plot(apsk32snr(:,k),apsk32snr(:,k+1),'^');
%     plot(apsk64snr(:,k),apsk64snr(:,k+1),'^');
    
    plot(apsk16(:,k),apsk16(:,k+1),'^');
    plot(apsk32(:,k),apsk32(:,k+1),'^');
    plot(apsk64(:,k),apsk64(:,k+1),'^');
    
    legend('16APSK','32APSK','64APSK');
    xlabel('f' + string(k-2));
    ylabel('f' + string(k-1));
end