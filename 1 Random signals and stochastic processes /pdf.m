% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                                  March 2018                             %
%                                Shafa Balaram                            %
% Function to estimate the probability density function of an input sample% 
% signal using its normalised histogram of values.                        %
% Usage: [est_pdf] = pdf(sample_sig)                                      %
% Arguments: sample_sig - 1D input array/matrix                           %
% Returns:   est_pdf    - Estimated pdf of the signal                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ est_pdf ] = pdf( sample_sig)

    est_pdf = histogram(sample_sig,'Normalization','pdf');
    
end

