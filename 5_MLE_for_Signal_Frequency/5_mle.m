% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                           Advanced Signal Processing                    %
%                      5 MLE for the frequency of a signal                %
%                                  March 2018                             %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clear all; close all; clc; 

% The range of frequencies for f0
f0 = [0.001:0.001:0.5-0.001]';

% Number of samples
N = 10;

% The noiseless data
n = 0:N-1;
pgmx = zeros(length(f0),1);

for i = 1:length(f0)
    x = cos(2*pi*f0(i)*n)';
    
    % Periodogram 
    [psdx,f] = pgm(x);
    
    [val,I] = min(abs(f-f0(i)));
    pgmx(i,1) = psdx(I);
    
    % MLE estimate
    for j = 0:N-1
        c(j+1,1) = cos(2*pi*f0(i)*j);
        s(j+1,1) = sin(2*pi*f0(i)*j);
    end
    
    M1 = [c'*x ; s'*x]';
    M3 = M1';
    M2 = inv([N/2 0;0 N/2]);
    mle(i,1) = M1*M2*M3;
end

clear figure;
figure(1) = figure('Color',[1 1 1]); 
grid on; hold on;

plot(f0,2*10*log10(pgmx),'linewidth',1.5); hold on;
plot(f0,10*log10(mle),'linewidth',1.5); 

legend1 = legend('Periodogram','MLE Estimate','Location','South');
set(legend1,'FontSize',14,'Interpreter','latex');

xlabel('\bf{Normalised frequency, $$f_0$$ [x $$\pi$$ rad/sample]}','FontSize',16,'Interpreter','latex'); 
ylabel('\bf{Magnitude [dB/rad/sample]}','FontSize',16,'Interpreter','latex');
title('\bf{Periodogram and MLE estimate for x[n]=cos(2$$\pi$$$$f_0$$n)}','FontSize',18,'Interpreter','latex')

