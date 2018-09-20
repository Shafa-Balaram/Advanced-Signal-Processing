% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% Function to generate an ensemble of M realisations of N samples for     %
% stochastic process 3.                                                   % 
% Usage: v = rp3(M,N)                                                     %
% Arguments: M - number of realisations                                   %
%            N - number of samples                                        %
% Returns:   v - stochastic process 3                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function v=rp3(M,N)

    a=0.5;
    m=3;
    v=(rand(M,N)-0.5)*m + a;
    
end