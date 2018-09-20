% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                      3 Spectral Estimation and Modelling                %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Estimated PSD based on FFT
randn('state',1);
i =1; % counter
clear figure;
figure(1) = figure('Color',[1 1 1]);
PxN = zeros(3,512); % initialise a matrix to save the periodograms
mean_PSD = []; var_PSD = [];

for N = [128 256 512]
    x = randn(N,1);
    [Px, f] = pgm(x);
    avPx(i) = mean(Px);
    PxN(i,1:N)=Px; 
    subplot(3,1,i)
    plot(f,Px,'linewidth',1)
    title(['\bf{Periodogram of x with ' num2str(N) ' samples}'],'FontSize',18,'Interpreter','latex')
    i = i+1;
    mean_PSD = [mean_PSD mean(Px)];
    var_PSD = [var_PSD var(Px)];
end

xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',18,'Interpreter','latex');
    
%%                   3.1 Averaged periodogram estimates                  %%

% Part 1: Smoothing the estimates
% impulse response
ir = 0.2.*ones(1,5);
i =1; % counter
clear figure;
figure(2) = figure('Color',[1 1 1]);

for N = [128 256 512]
    filtPx = filter(ir,1,PxN(i,1:N));
    avfiltPx(i) = mean(filtPx);
    varfiltPx(i) = var(filtPx);
    f = [0:N-1]./N;
    subplot(3,1,i)
    plot(f,filtPx,'linewidth',1);
    title(['\bf{Smoothed periodogram of x with ' num2str(N) ' samples}'],'FontSize',18,'Interpreter','latex')
    i = i+1;
end

xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',18,'Interpreter','latex');

%% Part 2: Averaged periodogram of 8 segments 
close all; clear all; clc; 
randn('state',1);

% 1024 sample-long WGN process
y = randn(1024,1);

% length of each segment
N = 128; 

% counter and new figure
i = 1;
clear figure;
figure(3) = figure('Color',[1 1 1]);

for i = 1:8
    segPy = pgm(y((i-1)*N+1:i*N));
    Py(i,:) = segPy;
    l = length(segPy);
    f = [0:l-1]./l;
    subplot(4,2,i);
    plot(f,segPy,'linewidth',1);
    title(['\bf{Segment ' num2str(i) '}'],'FontSize',18,'Interpreter','latex')
    
    mean_segPy(i) = mean(segPy);
    var_segPy(i) = var(segPy);
    i = i+1;
end

xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',18,'Interpreter','latex');

clear figure;
figure(5) = figure('Color',[1 1 1]);

subplot(2,1,1); grid on; hold on;
stem(1:8,mean_segPy,'k','filled');
xlabel('\bf{Segment number}','FontSize',16,'Interpreter','latex');
ylabel('\bf{Mean of $$\hat{P}_x$$}','FontSize',16,'Interpreter','latex');
title('\bf{Mean of the PSD estimates for the 8 segments of x}','FontSize',18,'Interpreter','latex')


subplot(2,1,2); grid on; hold on;
stem(1:8,var_segPy,'k','filled');
xlabel('\bf{Segment number}','FontSize',16,'Interpreter','latex');
ylabel('\bf{Variance of $$\hat{P}_x$$}','FontSize',16,'Interpreter','latex');
title('\bf{Variance of the PSD estimates for the 8 segments of x}','FontSize',18,'Interpreter','latex')

%% Averaged periodogram
avPy = mean(Py,1);
clear figure;
figure(5) = figure('Color',[1 1 1]);
plot(f,abs(avPy),'linewidth',1);
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',16,'Interpreter','latex'); 
title('\bf{Averaged periodogram of the 8 segments}','FontSize',18,'Interpreter','latex');

var_avPy = var(avPy);
mean_avPy = mean(avPy);

%%               3.2 Spectrum of autoregressive processes                %%
close all; clc; clear;

% WGN process x filtered by IIR filter
a = [1 0.9];
b = 1;
randn('state',1);
x = randn(1064,1);
y = filter(b,a,x);
n = 1:1064;

% Remove the transient effects of the filter
y = y(41:1064,1);

% Plot x and y for comparison
clear figure;
figure(1) = figure('Color',[1 1 1]);
subplot(2,1,1);

plot(n,x); 
% xlabel('\bf{Sample Number}','FontSize',16,'Interpreter','latex'); 
% ylabel('\bf{Amplitude}','FontSize',16,'Interpreter','latex'); 
title('\bf{Sequence x}','FontSize',18,'Interpreter','latex');
grid on

subplot(2,1,2); plot(n(41:1064),y); % xlim([0 length(y)]);
xlabel('\bf{Sample Number}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{Amplitude}','FontSize',18,'Interpreter','latex'); 
title('\bf{Sequence y}','FontSize',18,'Interpreter','latex');
grid on

%% Part 1: The theoretical PSD 
[h,w] = freqz([1],[1 0.9],512);
clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on;
plot(w./(2*pi),20*log10(abs(h)),'b','linewidth',1.5);
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{PSD [dB/rad/sample]}','FontSize',16,'Interpreter','latex'); 
title('\bf{Power spectrum of sequence y in decibels}','FontSize',18,'Interpreter','latex') 

clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on;

plot(w./(2*pi),abs(h).^2,'b','linewidth',2);
hold on

% Part 2: The estimated PSD
[pgmy, f] = pgm(y);
plot(f(1:512),pgmy(1:512),'r');

legend1 = legend('Theoretical PSD','Periodogram','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',16,'Interpreter','latex'); 
title('\bf{Theoretical and estimated PSDs of sequence y}','FontSize',18,'Interpreter','latex') 

%% Part 3: Zoomed-in plot
clear figure;
figure(3) = figure('Color',[1 1 1]); grid on; hold on;

plot(w./(2*pi),abs(h).^2,'b','linewidth',2); hold on;
plot(w./(2*pi),pgmy(1:512),'r','linewidth',1.5); xlim([0.4 0.5]);
legend1 = legend('Theoretical PSD','Periodogram','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');

xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{PSD [/rad/sample]}','FontSize',16,'Interpreter','latex'); 
title('\bf{Zoomed-in comparison of the theoretical and estimated PSDs of y}','FontSize',18,'Interpreter','latex') 
 
%% Part 4: The model-based PSD estimate
% Estimated ACF of y
Ry = xcorr(y,'unbiased');
l = length(y);

% Parameter estimates
a1 = -Ry(l+1)/Ry(l);
var_y = Ry(l)+(a1*Ry(l+1));

% The model-based PSD estimate
[h,w] = freqz([var_y],[1 a1],512);

clear figure;
figure(4) = figure('Color',[1 1 1]); grid on; hold on; 
plot(w./(2*pi),abs(h).^2,'b','linewidth',2);
hold on

% The periodogram
[pgmy, f] = pgm(y);
plot(f(1:512),pgmy(1:512),'r');

legend1 = legend('Model-based PSD','Periodogram','Location','NorthWest');
set(legend1,'FontSize',14,'Interpreter','latex');
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{PSD [sample/rad]}','FontSize',16,'Interpreter','latex'); 
title('\bf{A comparison of the model-based PSD and and periodogram of y}','FontSize',18,'Interpreter','latex') 

%% Part 5: The sunspot time series
close all; clear all; clc; 

% load the data
load('sunspot.dat');
ss = sunspot(:,2);

% mean-centred sunspot data
mcss = ss-mean(ss);

% Periodogram of original and mean-centred data
Pss = pgm(ss);
Pmcss = pgm(mcss);

% Unbiased estimated ACF 
Rss = xcorr(ss,'unbiased');
Rmcss = xcorr(mcss,'unbiased');

l = length(ss);

% Parameter estimates
a1_ss = -Rss(l+1)/Rss(l);
a1_mcss = -Rmcss(l+1)/Rmcss(l);
var_ss = Rss(l)+(a1_ss*Rss(l+1));
var_mcss = Rmcss(l)+(a1_mcss*Rmcss(l+1));

% The model-based PSD estimate
[h_ss,w_ss] = freqz([var_ss],[1 a1_ss],l/2);
[h_mcss,w_mcss] = freqz([var_mcss],[1 a1_mcss],l/2);

i = 1;
clear figure;
figure(5) = figure('Color',[1 1 1]);

for p = [1 2 5 10]   % model orders
    [mod_Pss,w] = pyulear(ss,p);
    subplot(2,2,i)
    l = length(mod_Pss);
    plot(w./(2*pi),Pss(1:l)); 
    hold on
    plot(w./(2*pi),abs(mod_Pss),'linewidth',1.5); 
    i = i+1;
   
    legend1 = legend('Periodogram','Model-Based','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
    title(['\bf{AR(' num2str(p) ')}'],'FontSize',18,'Interpreter','latex') 
    
    ylim([0 7*10^4])
end
xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [sample/rad]}','FontSize',18,'Interpreter','latex');    

i = 1;
clear figure;
figure(6) = figure('Color',[1 1 1]);

for p = [1 2 5 10]   % model orders
    [mod_Pmcss,w] = pyulear(mcss,p);
    subplot(2,2,i)
    l = length(mod_Pmcss);
    plot(w./(2*pi),Pmcss(1:l)); 
    hold on
    plot(w./(2*pi),abs(mod_Pmcss),'linewidth',1.5); 
    i = i+1;
    
    legend1 = legend('Periodogram','Model-Based','Location','NorthEast');
    set(legend1,'FontSize',14,'Interpreter','latex');
    title(['\bf{AR(' num2str(p) ')}'],'FontSize',18,'Interpreter','latex') 
    ylim([0 7*10^4])
end

xlabel('\bf{Normalised frequency [x 2$$\pi$$ rad/sample]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{PSD [sample/rad]}','FontSize',18,'Interpreter','latex');
