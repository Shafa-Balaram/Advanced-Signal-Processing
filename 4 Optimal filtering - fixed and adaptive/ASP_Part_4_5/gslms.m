% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The function computes the GSLMS algorithm   (Method 1)                  % 
% Usage: [ xhat, e, w, mu ] = gslms( x, mu_max, order )                   %
% Arguments:    x - N-sample 1D signal                                    %
%          mu_max - maximum adaptation gain                               %
%           order - order of the adaptive filter                          %
%                                                                         %
% Returns:   xhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - weight vector                                         %
%              mu - adaptation gain                                       %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, e, w, mu ] = gslms( x, mu_max, order )

    Nw = order -1;
    N = length(x);
    xhat = zeros(N, 1);
    e = zeros(1, N);
    w = zeros(order, N);
    mu=zeros(1,N);

    for n = order:N-1
        xhat(n) = w(:,n)'*x(n:-1:n-Nw);
     
        % Error
        e(n) = x(n)-xhat(n)';
    
        mu(n) = mu_max*(1- exp(-e(n)^2));
    
        if mu(n) > mu_max
           mu(n) = mu_max;
        end
    
        w(:,n+1) = w(:,n) + mu(n)*e(n)*x(n:-1:n-Nw);
      
    end

    xhat(N) = w(:,N)'*x(N:-1:N-Nw);

end
