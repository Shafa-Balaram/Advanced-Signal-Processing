% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The function computes the sign-LMS algorithm                            % 
% Usage: [ xhat, e, w ] = sign_lms( x, mu, order )                        %
% Arguments:    x - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%           order - order of filter                                       %
%                                                                         %
% Returns:   xhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - adaptive weights                                      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, e, w ] = sign_lms( x, mu, order )

    % Sample length
    N = length(x);

    % Order of filter
    Nw = order-1;

    % Initialise weights w at n=0
    w = zeros(order-1,N);

    for n = order:N
    
        % LMS estimate
        xhat(n) = w(:,n)'*x(n-1:-1:n-order+1);
    
        % Error
        e(n) = x(n)-xhat(n)';
        sign_e(n) = abs(e(n))/e(n);

        % Evolution of adaptive weights
        w(:,n+1) = w(:,n) + (mu*sign_e(n)*x(n-1:-1:n-order+1));
    end

end