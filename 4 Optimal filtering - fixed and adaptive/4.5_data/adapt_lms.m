% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                                  March 2018                             %
%                                Shafa Balaram                            %
% The function computes the Adaptive LMS algorithm                        % 
% Usage: [ xhat, e, w ] = adapt_lms( x, mu )                              %
% Arguments:    x - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%                                                                         %
% Returns:   xhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - adaptive weights                                      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, e, w ] = adapt_lms( x, mu )

    % Sample length
    N = length(x);

    % order of the filter
    order = 3;

    % Initialise weights w at n=0
    a1 = zeros(1,N); 
    a2 = zeros(1,N);
    e = zeros(N,1);
    xhat = zeros(N, 1);

    for n = order:N-1
        % LMS estimate
        xhat(n) = (a1(n)*x(n-1)) + (a2(n)*x(n-2));
    
        % Error
        e(n) = x(n)-xhat(n)';
    
        % Evolution of adaptive weights
        a1(n+1) = a1(n)+ (mu*e(n)*x(n-1));
        a2(n+1) = a2(n)+ (mu*e(n)*x(n-2));
    end
    
    xhat(N) = (a1(N)*x(N-1)) + (a2(N)*x(N-2));
    w = [a1;a2];
    
end