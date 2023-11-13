% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The pgm function takes in a column vector x and computes its estimated  %
% PSD based on FFT as Px.                                                 % 
% Usage: [ xpsd, f ] = pgm( x )                                           %
% Arguments:    x - 1D signal                                             %
% Returns:   xpsd - PSD estimate of x                                     %
%               f - frequency                                             %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xpsd, f] = pgm( x )

    % Data length of x
    N = length(x);

    % frequency
    f = [0:N-1]./N;

    % Discrete Fourier Transform of x
    xdft = fft(x,N);

    % PSD estimate
    xpsd = (abs(xdft).^2)./N;

end
