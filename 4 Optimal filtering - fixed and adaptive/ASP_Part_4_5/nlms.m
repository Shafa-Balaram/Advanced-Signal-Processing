% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The function computes the NLMS algorithm                                % 
% Usage: [ xhat, e, w ] = nlms( x, mu, order, epsilon )                   %
% Arguments:    x - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%           order - order of the adaptive filter                          %
%         epsilon - factor                                                %
% Returns:   xhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - weight vector                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, e, w ] = nlms( x, mu, order, epsilon )

    % Sample length
    N = length(x);
    Mu = zeros(N,1);

    % Initialise weights w at n=0
    w = zeros(order,N);

    for n = order:N-1
        % LMS estimate
        xhat(n) = w(:,n)'*x(n:-1:n-order+1);
    
        % Error
        e(n) = x(n)-xhat(n)';

        % Initial gain
        if n == order
            Mu(n)=mu;
        else 
         Mu(n) = mu/(epsilon + (x(n:-1:n-order+1)'*x(n:-1:n-order+1)));
        end
    
        % Evolution of adaptive weights
        w(:,n+1) = w(:,n) + Mu(n)*e(n)*x(n:-1:n-order+1);
    
    end

    xhat(N) = w(:,N)'*x(N:-1:N-order+1);
    
end

  

 


