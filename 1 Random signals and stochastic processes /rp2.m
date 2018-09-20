% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% Function to generate an ensemble of M realisations of N samples for     %
% stochastic process 2.                                                   % 
% Usage: v = rp2(M,N)                                                     %
% Arguments: M - number of realisations                                   %
%            N - number of samples                                        %
% Returns:   v - stochastic process 2                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function v=rp2(M,N)
Ar=rand(M,1)*ones(1,N);
Mr=rand(M,1)*ones(1,N);
v=(rand(M,N)-0.5).*Mr+Ar;
end
