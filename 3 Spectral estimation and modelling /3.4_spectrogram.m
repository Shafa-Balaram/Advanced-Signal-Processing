% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%        3.4 Spectrogram for time-frequency analysis: dial tone pad       %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;

% Part 1
% Generate the last 8 digits of a landline number from a uniform distribution
lastdig = round(9.*(rand(1,8)));
ldl = [0 2 0 lastdig];

% sampling frequency  
fs = 32768;

% the data length
N = fs*0.25;

% the idle sequence between dialling
idle_sig(1:N) = 0;
signal = [];

% the discrete time
n = 1:N;

% The DTMF System
for i = 1:length(ldl)
    digit = ldl(i);
    if digit == 0
       f1 = 941; f2 = 1336;
    elseif digit == 1
       f1 = 697; f2 = 1209;
    elseif  digit == 2
       f1 = 697; f2 = 1336;
    elseif  digit == 3
       f1 = 697; f2 = 1477;
    elseif  digit == 4
       f1 = 770; f2 = 1209;
    elseif  digit == 5
       f1 = 770; f2 = 1336;
    elseif  digit == 6
       f1 = 770; f2 = 1477;
    elseif  digit == 7
       f1 = 852; f2 = 1209;
    elseif  digit == 8
       f1 = 852; f2 = 1336;
    elseif  digit == 9
       f1 = 852; f2 = 1477;
    end
    
    y = sin(2*pi*f1.*n/fs)+sin(2*pi*f2.*n./fs);
    signal = [signal y idle_sig];

end

% Actual signal does not have a pause at the end
signal = signal(1:length(signal)-N);

% Discrete time in seconds
time = [1:length(signal)]./fs;

clear figure;
figure(1) = figure('Color',[1 1 1]);
plot(time,signal);
full_seq = [0 2 0 lastdig];
xlabel('\bf{Time [seconds]}','FontSize',16,'Interpreter','latex');
ylabel('\bf{Magnitude}','FontSize',16,'Interpreter','latex'); 
title(['\bf{Dialled Sequence, y = [' num2str(full_seq) ']}'],'FontSize',18,'Interpreter','latex');

% Choose the first two digits 0 and 2 as they are different
clear figure;
figure(2) = figure('Color',[1 1 1]); 
subplot(2,1,1); plot(time,signal); xlim([0.23 0.26]);
title('\bf{Key 0 is pressed followed by idle time}','FontSize',18,'Interpreter','latex');
%xlabel('\bf{Time [seconds]}','FontSize',16,'Interpreter','latex'); 
%ylabel('\bf{Amplitude}','FontSize',16,'Interpreter','latex');

subplot(2,1,2); plot(time,signal); xlim([0.49 0.52]);
title('\bf{Idle time followed by pressing key 2}','FontSize',18,'Interpreter','latex');
xlabel('\bf{Time [seconds]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{Amplitude}','FontSize',18,'Interpreter','latex');

%% Part 2: Spectral components of y 
% divide the signal into 21 segments to separate each pressed key from its
% idle time
seg_length = length(signal)/21;

% FFT of the non-overlapping segments
clear figure;
figure(2) = figure('Color',[1 1 1]); 
% s = spectrogram(signal,hann(seg_length),0,'yaxis');
spectrogram(signal,hann(seg_length),0,8192,fs,'yaxis');
ylim([0 2.5])

set(get(colorbar,'label'),'string','\bf{PSD [dB/rad/sample]}','FontSize',16,'Interpreter','latex');
xlabel('\bf{Time [seconds]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{Frequency [kHz]}','FontSize',16,'Interpreter','latex');
title(['\bf{FFT segments of the sequence y}'],'FontSize',18,'Interpreter','latex');
    
%% Part 4
% Variance of the white noise to be added to y 
noise_var = [0.01 0.5 5];
randn('state',1);

clear figure;
figure(3) = figure('Color',[1 1 1]); 

for i = 1:length(noise_var)
    
    % Noisy sequence
    w = noise_var(i)*randn(1,length(signal));
    noisy_sig = signal+w;
    nsig(i,:) = noisy_sig;
    seg_length = length(signal)/21;

    % FFT of the non-overlapping segments
    subplot(1,3,i)
    s = spectrogram(noisy_sig,hann(seg_length),0,8192,fs,'yaxis');
    spectrogram(noisy_sig,hann(seg_length),0,8192,fs,'yaxis');
    title(['$$\bf{\sigma^2=' num2str(noise_var(i)) '}$$'],'FontSize',20,'Interpreter','latex');
    ylim([0 2])
end

set(get(colorbar,'label'),'string','\bf{PSD  [dB/rad/sample]}','FontSize',18,'Interpreter','latex');
xlabel('\bf{Time [s]}','FontSize',20,'Interpreter','latex'); 
ylabel('\bf{Frequency [kHz]}','FontSize',20,'Interpreter','latex');
   
clear figure;
figure(4) = figure('Color',[1 1 1]); 

for i = 1:length(noise_var)
    subplot(3,1,i); 
    % Noisy sequence
    plot(time,nsig(i,:),'linewidth',1)
    xlim([0.23 0.26]);
    title(['$$\bf{Noisy \ sequence \ with \ \sigma^2=' num2str(noise_var(i)) '}$$'],'FontSize',16,'Interpreter','latex');
end

xlabel('\bf{Time [seconds]}','FontSize',18,'Interpreter','latex'); 
ylabel('\bf{Magnitude}','FontSize',18,'Interpreter','latex');