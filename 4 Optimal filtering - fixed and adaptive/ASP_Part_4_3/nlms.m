% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The function computes the NLMS algorithm                                % 
% Usage: [ yhat, e, w ] = nlms( x, z, mu, order, epsilon )                %
% Arguments:    x - N-sample 1D signal                                    %
%               z - N-sample 1D signal                                    %
%              mu - adaptation gain                                       %
%           order - order of the adaptive filter                          %
%         epsilon - factor                                                %
% Returns:   yhat - LMS estimate                                          %
%               e - error vector                                          %
%               w - weight vector                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %



function [ yhat, e, w ] = nlms( x, z, mu, order, epsilon )

    Nw = order-1;
    N = length(x);
    yhat = zeros(N, 1);
    e = zeros(1, N);
    Mu = mu*ones(1, N);
    w = zeros(order, N);

    for n = order:N-1
    
        yhat(n) = w(:,n)'*x(n:-1:n-Nw);
        e(n) = z(n) - yhat(n);
    
        % Update the weights
        if n == order
            Mu(n) = mu;
        else
            Mu(n) = mu/(epsilon + (x(n:-1:n-Nw)'*x(n:-1:n-Nw)));
        end
    
        w(:,n+1) = w(:,n) + Mu(n)*e(n)*x(n:-1:n-Nw);
    end

    yhat(N) = w(:,N)'*x(N:-1:N-Nw);
end
