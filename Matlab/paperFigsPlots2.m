close all;
clear;
clc;
%% Fig 7
df1 = csvread('Av_fig7_N1000.csv');
df2 = csvread('Av_fig7_N2000.csv');
df3 = csvread('Av_fig7_N5000.csv');
df4 = csvread('Av_fig7_N10000.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);
df3 = df3(2:length(df3),:);
df4 = df4(2:length(df4),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
plot(df3(:,1),100*df3(:,2),'s-','LineWidth',1.2);
plot(df4(:,1),100*df4(:,2),'d-','LineWidth',1.2);
ylim([50,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('N=1000','N=2000','N=5000','N=10000');

%% Fig 8
figure();
df1 = csvread('Av_fig8_ChanAWGN-Only.csv');
df2 = csvread('Av_fig8_ChanMultipath.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
ylim([20,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('AWGN','Multipath fading');

%% Fig 9
figure();
df1 = csvread('Av_fig9_Phase0.csv');
df2 = csvread('Av_fig9_Phase5.csv');
df3 = csvread('Av_fig9_Phase15.csv');
df4 = csvread('Av_fig9_Phase20.csv');
df5 = csvread('Av_fig9_Phase30.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);
df3 = df3(2:length(df3),:);
df4 = df4(2:length(df4),:);
df5 = df5(2:length(df5),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
plot(df3(:,1),100*df3(:,2),'s-','LineWidth',1.2);
plot(df4(:,1),100*df4(:,2),'d-','LineWidth',1.2);
plot(df5(:,1),100*df5(:,2),'*-','LineWidth',1.2);

ylim([75,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('Phase offset= 0','Phase offset= 5',...
    'Phase offset= 15','Phase offset= 20',...
    'Phase offset= 30');

%% Fig 10
figure();
df1 = csvread('Av_fig10_Freq0.csv');
df2 = csvread('Av_fig10_Freq1.csv');
df3 = csvread('Av_fig10_Freq2.csv');
df4 = csvread('Av_fig10_Freq3.csv');
df5 = csvread('Av_fig10_Freq6.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);
df3 = df3(2:length(df3),:);
df4 = df4(2:length(df4),:);
df5 = df5(2:length(df5),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
plot(df3(:,1),100*df3(:,2),'s-','LineWidth',1.2);
plot(df4(:,1),100*df4(:,2),'d-','LineWidth',1.2);
plot(df5(:,1),100*df5(:,2),'*-','LineWidth',1.2);

ylim([75,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('Frequency offset= 0%fc','Frequency offset= 1%fc',...
    'Frequency offset= 2%fc','Frequency offset= 3%fc',...
    'Frequency offset= 6%fc');

%% Fig 12
figure();
df1 = csvread('Av_fig12_L240.csv');
df2 = csvread('Av_fig12_L360.csv');
df3 = csvread('Av_fig12_L480.csv');
df4 = csvread('Av_fig12_L720.csv');
df5 = csvread('Av_fig12_L1080.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);
df3 = df3(2:length(df3),:);
df4 = df4(2:length(df4),:);
df5 = df5(2:length(df5),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
plot(df3(:,1),100*df3(:,2),'s-','LineWidth',1.2);
plot(df4(:,1),100*df4(:,2),'d-','LineWidth',1.2);
plot(df5(:,1),100*df5(:,2),'*-','LineWidth',1.2);

ylim([70,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('L=240','L=360','L=480','L=720','L=1080');

%% Fig 13
figure();
df1 = csvread('Av_fig13_L240.csv');
df2 = csvread('Av_fig13_L360.csv');
df3 = csvread('Av_fig13_L480.csv');
df4 = csvread('Av_fig13_L720.csv');
df5 = csvread('Av_fig13_L1080.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);
df3 = df3(2:length(df3),:);
df4 = df4(2:length(df4),:);
df5 = df5(2:length(df5),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);
plot(df3(:,1),100*df3(:,2),'s-','LineWidth',1.2);
plot(df4(:,1),100*df4(:,2),'d-','LineWidth',1.2);
plot(df5(:,1),100*df5(:,2),'*-','LineWidth',1.2);

ylim([70,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('L=240','L=360','L=480','L=720','L=1080');

%% Fig 14
figure();
df1 = csvread('Av_fig14_1.csv');
df2 = csvread('Av_fig14_2.csv');
df1 = df1(2:length(df1),:);
df2 = df2(2:length(df2),:);

hold on;
plot(df1(:,1),100*df1(:,2),'o-','LineWidth',1.2);
plot(df2(:,1),100*df2(:,2),'^-','LineWidth',1.2);

ylim([70,100]);
xlabel('SNR (dB)');
ylabel('Av (%)');
legend('Training SNR=0~15','Training SNR=0~2~20');