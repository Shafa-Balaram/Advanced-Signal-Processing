% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                                  March 2018                             %  
%                                Shafa Balaram                            %
% The function computes the ARLMS algorithm                               % 
% Usage: [ xhat, e, a ] = ar_lms( x, mu, order )                          %
% Arguments:    x - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%           order - order of filter                                       %
%                                                                         %
% Returns:   xhat - LMS estimate                                          %
%               e - error vector                                          %
%               a - adaptive weights                                      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, e, a ] = ar_lms( x, mu, order )

    % Sample length
    N = length(x);

    % Initialise weights w at n=0
    a = zeros(order,N);

    for n = order+1:N-1 
        % LMS estimate
        xhat(n) = a(:,n)'*x(n-1:-1:n-order);
    
        % Error
        e(n) = x(n)-xhat(n)';
    
        % Evolution of adaptive weights
        a(:,n+1) = a(:,n) + (mu*e(n)*x(n-1:-1:n-order));
    end

    xhat(N) = a(:,N)'*x(N-1:-1:N-order);

end