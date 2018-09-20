% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% Function to generate an ensemble of M realisations of N samples for     %
% stochastic process 1.                                                   % 
% Usage: v = rp1(M,N)                                                     %
% Arguments: M - number of realisations                                   %
%            N - number of samples                                        %
% Returns:   v - stochastic process 1                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function v=rp1(M,N)
a=0.02;
b=5;
Mc=ones(M,1)*b*sin((1:N)*pi/N);
Ac=a*ones(M,1)*[1:N];
v=(rand(M,N)-0.5).*Mc+Ac;
end

