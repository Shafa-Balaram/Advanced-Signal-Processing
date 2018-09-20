% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The function computes the LMS algorithm                                 % 
% Usage: [ yhat, e, w ] = lms( x, z, mu, order )                          %
% Arguments:    x - N-sample 1D signal                                    %
%               z - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%           order - order of the adaptive filter                          %
%                                                                         %
% Returns:   yhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - weight vector                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


function [ yhat, e, w ] = lms( x, z, mu, order )

    Nw = order-1;
    N = length(x);
    yhat = zeros(N, 1);
    e = zeros(N,1);
    w = zeros(order, N);

    for n = order:N
        yhat(n) = w(:,n)'*x(n:-1:n-Nw);
        e(n) = z(n) - yhat(n);
        w(:,n+1) = w(:,n) + mu*e(n)*x(n:-1:n-Nw);
    end

end


 


