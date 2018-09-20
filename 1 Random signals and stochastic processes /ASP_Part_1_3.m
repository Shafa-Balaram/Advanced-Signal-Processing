% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                  1.3 Estimation of probability distributions            %
%                        Original version - March 2018                    %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
close all; clear all; clc;

% Part 1: Testing the pdf function
% Number of samples
N = 250;

% Stationary process with a Gaussian pdf
v = randn(1,N);

% The pdf estimate
clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on; 
est_vpdf = pdf(v);
xlabel('\bf{v}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(v)}','FontSize',16,'Interpreter','latex')
title('\bf{Estimated pdf of v}','FontSize',18,'Interpreter','latex')

%% Part 2: Estimates pdf of process 3
% Initialise an index
i = 1;
clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on; 

for N = [100 1000 10000]
    v3=rp3(1,N);
    subplot(4,1,i)
    est_v3pdf = pdf(v3);
    xlabel('\bf{v3}','FontSize',16,'Interpreter','latex')
    ylabel('\bf{p(v3)}','FontSize',16,'Interpreter','latex')
    title(['\bf{Estimated densities for N=' num2str(N) '}'],'FontSize',18,'Interpreter','latex')
    i = i+1;
end

% Theoretical pdf of v3
subplot(4,1,4)
v3 = -1:0.01:2;
pdfv3(1:length(v3)) = 1/3;
plot(v3,pdfv3,'r','linewidth',1.5)
xlabel('\bf{v3}','FontSize',18,'Interpreter','latex')
ylabel('\bf{p(v3)}','FontSize',18,'Interpreter','latex')
title('\bf{Theoretical pdf}','FontSize',18,'Interpreter','latex')

%% Part 3:Estimating the pdf of a non-stationary process
% Generate randomly the non-stationary signal from a uniform distribution
x = [rand(1,500)-0.5 (rand(1,500)+0.5)];
clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on; 

plot(x)
hold on
xlabel('\bf{n}','FontSize',16,'Interpreter','latex')
ylabel('\bf{x}','FontSize',16,'Interpreter','latex')
title('\bf{Non-stationary signal with a step change in mean at N=500}','FontSize',18,'Interpreter','latex')

% Method 1: Test the pdf function directly
clear figure;
figure(2) = figure('Color',[1 1 1]); grid on; hold on; 

est_xpdf = pdf(x);
xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
title('\bf{Estimated pdf of x}','FontSize',16,'Interpreter','latex')

% Method 2: Compute the estimated pdf of each segment separately
clear figure;
figure(3) = figure('Color',[1 1 1]); grid on; hold on; 

x1=rand(1,500)-0.5;
x2=rand(1,500)+0.5;
% Check
mean(x1);
mean(x2);

% estimated pdf of x1
subplot(3,1,1)
est_x1pdf = pdf(x1);
xlabel('\bf{x$$_1$$}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(x$$_1$$)}','FontSize',16,'Interpreter','latex')
title('\bf{Estimated pdf of x$$_1$$}','FontSize',18,'Interpreter','latex')

% estimated pdf of x2
subplot(3,1,2)
est_x2pdf = pdf(x2);
xlabel('\bf{x$$_2$$}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(x$$_2$$)}','FontSize',16,'Interpreter','latex')
title('\bf{Estimated pdf of x$$_2$$}','FontSize',18,'Interpreter','latex')

% Overall estimated pdf
subplot(3,1,3)
% Halve the pdfs
bar(est_x1pdf.BinEdges(1:end-1),est_x1pdf.Values./2,'b')
hold on; 
bar(est_x2pdf.BinEdges(1:end-1),est_x2pdf.Values./2,'r')
xlim([-0.6 1.6])
xlabel('\bf{x}','FontSize',16,'Interpreter','latex')
ylabel('\bf{p(x)}','FontSize',16,'Interpreter','latex')
title('\bf{Overall estimated pdf of x}','FontSize',18,'Interpreter','latex')

