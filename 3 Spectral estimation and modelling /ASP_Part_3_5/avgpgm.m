% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The avpgm function takes in a column vector rr and computes its averaged%
% periodogram.                                                            % 
% Usage: [ avgPrr ] = avgpgm( rr, N )                                     %
% Arguments:     rr - 1D signal                                           %
%                N - length of each segment over which to compute each    %
%                    periodogram                                          %  
% Returns:   avgPrr - averaged periodogram of x                           %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ avgPrr ] = avgpgm( rr, N )

    % Number of segments
    K = floor(length(rr)/N);

    segPrr = zeros(K,N);
    avgPrr = zeros(1,N);

    for i = 1:K
        segment = rr((i-1)*N+1:i*N);

        % Discrete Fourier Transform of segment
        segdft = fft(segment,N);

        % PSD estimate
        segPrr(i,:) = (abs(segdft).^2)./N;
     
    end

    % Averaged periodogram
    avgPrr = mean(segPrr,1);

end

