% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                             4.5 Speech Recognition                      %
%                         Original version - March 2018                   %                        
%                                Shafa Balaram                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%     Model order investigation for all sounds using LMS algorithm      %%
load('sound_a.mat');
load('sound_e.mat');
load('sound_s.mat');
load('sound_t.mat');
load('sound_x.mat');

% Adaptation gain for all signals
mu = 1.5; 

clear figure;
figure(1) = figure('Color',[1 1 1]); grid on; hold on;

time = 1:1000;
order = [2 3 5];

% Sound a
for i = 1:length(order)
    
    subplot(5,3,i); grid on; hold on;
    [ ahat, aerr, acoeff ] = ar_lms( sound_a, mu, order(i) );
    
    for j = 1:order(i)
        plot(time,acoeff(j,:),'linewidth',1.5);
       hold on 
    end
%     
    title(['\bf{Sound a with $$p=' num2str(order(i)) '$$}'],'FontSize',16,'Interpreter','latex');
end

% Sound e
order = [2 3 5];

for i = 1:length(order)
    
    subplot(5,3,i+3); grid on; hold on;
    [ ehat, eerr, ecoeff ] = ar_lms( sound_e, mu, order(i) );
    
    for j = 1:order(i)
        plot(time,ecoeff(j,:),'linewidth',1.5);
       hold on 
    end
%     
    title(['\bf{Sound e with $$p=' num2str(order(i)) '$$}'],'FontSize',16,'Interpreter','latex');
end

% Sound s
order = [3 4 5];

for i = 1:length(order)
    
    subplot(5,3,i+6); grid on; hold on;
    [ shat, serr, scoeff ] = ar_lms( sound_s, mu, order(i) );
    
    for j = 1:order(i)
        plot(time,scoeff(j,:),'linewidth',1.5);
       hold on 
    end
%     
    title(['\bf{Sound s with $$p=' num2str(order(i)) '$$}'],'FontSize',16,'Interpreter','latex');
end

% Sound t
order = [2 3 4];

for i = 1:length(order)
    
    subplot(5,3,i+9); grid on; hold on;
    [ that, terr, tcoeff ] = ar_lms( sound_t, mu, order(i) );
    
    for j = 1:order(i)
        plot(time,tcoeff(j,:),'linewidth',1.5);
       hold on 
    end
%     
    title(['\bf{Sound t with $$p=' num2str(order(i)) '$$}'],'FontSize',16,'Interpreter','latex');
end

% Sound x
order = [5 7 9];

for i = 1:length(order)
    
    subplot(5,3,i+12); grid on; hold on;
    [ xhat, xerr, xcoeff ] = ar_lms( sound_x, mu, order(i) );
    
    for j = 1:order(i)
        plot(time,xcoeff(j,:),'linewidth',1.5);
       hold on 
    end
%     
    title(['\bf{Sound x with $$p=' num2str(order(i)) '$$}'],'FontSize',16,'Interpreter','latex');
end

xlabel('Iteration number','FontSize',16,'Interpreter','latex')
ylabel('a$$_{opt}$$','FontSize',18,'Interpreter','latex')