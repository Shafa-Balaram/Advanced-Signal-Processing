% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             4.5 Speech Recognition                      %
%                         Original version - March 2018                   %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%% fs = 44100

close all; clear all; clc;
load('sound_a.mat');
load('sound_e.mat');
load('sound_s.mat');
load('sound_t.mat');
load('sound_x.mat');

mu = 1.5;
asigsq = var(sound_a);
esigsq = var(sound_e);
ssigsq = var(sound_s);
tsigsq = var(sound_t);
xsigsq = var(sound_x);

for p = 1:10
    [ ahat, aerr, acoeff ] = ar_lms( sound_a, mu, p);
    aR(p) = 10*log10(asigsq/var(aerr));
    
    [ ehat, eerr, ecoeff ] = ar_lms( sound_e, mu, p);
    eR(p) = 10*log10(esigsq/var(eerr));
    
    [ shat, serr, scoeff ] = ar_lms( sound_s, mu, p);
    sR(p) = 10*log10(ssigsq/var(serr));
    
    [ that, terr, tcoeff ] = ar_lms( sound_t, mu, p);
    tR(p) = 10*log10(tsigsq/var(terr));
    
    [ xhat, xerr, xcoeff ] = ar_lms( sound_x, mu, p);
    xR(p) = 10*log10(xsigsq/var(xerr));
end

order = 1:10;

clear figure;
figure(1) = figure('Color',[1 1 1]);grid on; hold on;
plot(order, aR,'-*', 'linewidth',1.5); hold on; 
plot(order, eR,'-*', 'linewidth',1.5); hold on; 
plot(order, sR,'-*', 'linewidth',1.5); hold on; 
plot(order, tR,'-*', 'linewidth',1.5); hold on; 
plot(order, xR,'-*', 'linewidth',1.5);

legend1 = legend('a','e','s','t','x','Location','SouthEast');
set(legend1,'FontSize',16,'Interpreter','latex');
title('\bf{Prediction gain of recordings at f$$_s$$=44100}','FontSize',18,'Interpreter','latex');
xlabel('Model order','FontSize',16,'Interpreter','latex')
ylabel('R$$_{p}$$ / dB','FontSize',18,'Interpreter','latex')
