% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             4.5 Speech Recognition                      %
%                         Original version - March 2018                   %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%% Original Frequency 
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
    aR1(p) = 10*log10(asigsq/var(aerr));
    
    [ ehat, eerr, ecoeff ] = ar_lms( sound_e, mu, p);
    eR1(p) = 10*log10(esigsq/var(eerr));
    
    [ shat, serr, scoeff ] = ar_lms( sound_s, mu, p);
    sR1(p) = 10*log10(ssigsq/var(serr));
    
    [ that, terr, tcoeff ] = ar_lms( sound_t, mu, p);
    tR1(p) = 10*log10(tsigsq/var(terr));
    
    [ xhat, xerr, xcoeff ] = ar_lms( sound_x, mu, p);
    xR1(p) = 10*log10(xsigsq/var(xerr));
end

order = 1:10;

clear figure;
figure(1) = figure('Color',[1 1 1]);grid on; hold on;
plot(order, aR1,'-*', 'linewidth',1.5); hold on; 
plot(order, eR1,'-*', 'linewidth',1.5); hold on; 
plot(order, sR1,'-*', 'linewidth',1.5); hold on; 
plot(order, tR1,'-*', 'linewidth',1.5); hold on; 
plot(order, xR1,'-*', 'linewidth',1.5);

legend1 = legend('a','e','s','t','x','Location','East');
set(legend1,'FontSize',16,'Interpreter','latex');
title('\bf{Prediction gain of recordings at f$$_s$$=44100}','FontSize',18,'Interpreter','latex');
xlabel('\bf{Model order}','FontSize',16,'Interpreter','latex')
ylabel('\bf{R$$_{p}$$ [dB]}','FontSize',18,'Interpreter','latex')

%% fs = 16000 %%
load('new_a.mat');
load('new_e.mat');
load('new_s.mat');
load('new_t.mat');
load('new_x.mat');

mu = 1.5;
asigsq = var(new_a);
esigsq = var(new_e);
ssigsq = var(new_s);
tsigsq = var(new_t);
xsigsq = var(new_x);

for p = 1:10
    [ ahat, aerr, acoeff ] = ar_lms( new_a, mu, p);
    aR2(p) = 10*log10(asigsq/var(aerr));
    
    [ ehat, eerr, ecoeff ] = ar_lms( new_e, mu, p);
    eR2(p) = 10*log10(esigsq/var(eerr));
    
    [ shat, serr, scoeff ] = ar_lms( new_s, mu, p);
    sR2(p) = 10*log10(ssigsq/var(serr));
    
    [ that, terr, tcoeff ] = ar_lms( new_t, mu, p);
    tR2(p) = 10*log10(tsigsq/var(terr));
    
    [ xhat, xerr, xcoeff ] = ar_lms( new_x, mu, p);
    xR2(p) = 10*log10(xsigsq/var(xerr));
end

order = 1:10;

clear figure;
figure(1) = figure('Color',[1 1 1]);grid on; hold on;
plot(order, aR2,'-*', 'linewidth',1.5); hold on; 
plot(order, eR2,'-*', 'linewidth',1.5); hold on; 
plot(order, sR2,'-*', 'linewidth',1.5); hold on; 
plot(order, tR2,'-*', 'linewidth',1.5); hold on; 
plot(order, xR2,'-*', 'linewidth',1.5);

legend1 = legend('a','e','s','t','x','Location','East');
set(legend1,'FontSize',16,'Interpreter','latex');
title('\bf{Prediction gain of recordings at f$$_s$$=16000}','FontSize',18,'Interpreter','latex');
xlabel('\bf{Model order}','FontSize',16,'Interpreter','latex')
ylabel('\bf{R$$_{p}$$ [dB]}','FontSize',18,'Interpreter','latex')
