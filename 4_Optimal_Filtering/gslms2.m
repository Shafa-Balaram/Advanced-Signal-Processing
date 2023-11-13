% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                          Advanced Signal Processing                     %
%                                  March 2018                             %  
%                                Shafa Balaram                            %
% The function computes the GSLMS algorithm   (Method 2)                  % 
% Usage: [ yhat, e, w, mu ] = gslms2( x, z, mu_max, order )               %
% Arguments:    x - N-sample 1D signal                                    %
%               z - N-sample 1D signal                                    %
%          mu_max - maximum adaptation gain                               %
%           order - order of the adaptive filter                          %
%                                                                         %
% Returns:   yhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - weight vector                                         %
%              mu - adaptation gain                                       %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ yhat, e, w, mu ] = gslms2( x, z, mu_max, order )

    Nw = order -1;
    N = length(x);
    yhat = zeros(N, 1);
    e = zeros(1, N);
    w = zeros(order, N);
    mu=zeros(1,N);

    for n = order:N-1
        yhat(n) = w(:,n)'*x(n:-1:n-Nw);
        e(n) = z(n) - yhat(n);
        mu(n) = mu_max*(e(n)^2)/2;
    
        if mu(n) > mu_max
           mu(n) = mu_max;
        end
    
        w(:,n+1) = w(:,n) + mu(n)*e(n)*x(n:-1:n-Nw);
        
    end

    yhat(N) = w(:,N)'*x(N:-1:N-Nw);

end


 


