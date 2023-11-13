% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                             4.5 Speech Recognition                      %
%                                  March 2018                             %                             
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%            LMS versus GSLMS ALgorithms applied to sound a             %%
close all; clear all; clc;
load('sound_a.mat');

time = 1:1000;
order = 3;
mu = [0.5 1 1.5 2];

clear figure;
figure(1) = figure('Color',[1 1 1]);

for i = 1:length(mu)
    subplot(2,2,i); grid on; hold on;
    [ ahat, lmserr, acoeff ] = ar_lms( sound_a, mu(i), order );
    
    for j = 1:order
        plot(time,acoeff(j,:),'linewidth',1.5);
        hold on 
    end
    
    title(['\bf{LMS with $$\mu=' num2str(mu(i)) '$$}'],'FontSize',18,'Interpreter','latex');
end

xlabel('\bf{Iteration number}','FontSize',18,'Interpreter','latex')
ylabel('\bf{Adaptive weights of sound a}','FontSize',18,'Interpreter','latex')

mu = [10 15 20 25];
clear figure;
figure(2) = figure('Color',[1 1 1]);
for i = 1:length(mu)
    subplot(2,2,i); grid on; hold on;
    [ ahat, gserr, acoeff, Mu ] = gslms( sound_a, mu(i), order );
    
    for j = 1:order
        plot(time,acoeff(j,:),'linewidth',1.5);
        hold on 
    end
    
    title(['\bf{GSLMS with $$\mu=' num2str(mu(i)) '$$}'],'FontSize',18,'Interpreter','latex');
end

xlabel('\bf{Iteration number}','FontSize',18,'Interpreter','latex')
ylabel('\bf{Adaptive weights of sound a}','FontSize',18,'Interpreter','latex')



