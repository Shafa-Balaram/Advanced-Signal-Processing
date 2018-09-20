% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                       EE3.08 Advanced Signal Processing                 %
%                        Original version - March 2018                    %
%                                Shafa Balaram                            %
% The arpredict function predicts the normalised sunspot series using the %
% ar coefficients obtained from aryule. The predicted data, xhat, and the %
% mean squared error of the prediction are the ouput arguments.The input %
% arguments are the normalised sunspot series, the model order and the    %
% prediction horizon.                                                     % 
% Usage: [ xhat, MSE ] = arpredict( norm_ss, order, horizon )             %
% Arguments: norm_ss - normalised sunspot series                          %
%            order   - model order                                        %
%            horizon - prediction horizon                                 %
% Returns:   xhat    - predicted data                                     %
%            MSE     - mean squared error of the prediction               %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function [ xhat, MSE ] = arpredict( norm_ss, order, horizon )

    % sample length
    N = length(norm_ss);

    % seed
    randn('state',1);

    % WGN realisation for the predicted AR process
    w = randn(N,1);

    % AR coefficients
    arcoeff = aryule(norm_ss, order);
    arcoeff = -arcoeff(2:end);

    % Initialise the predicted data 
    xhat = zeros(N,1);
    xhat(1:order) = norm_ss(1:order);
    m = horizon;

    for n = order+1:m:N-m+1
        old_x = norm_ss(n-1:-1:n-order);
    
        for i = 0:m-1
            x = arcoeff*old_x;
            old_x = [x; old_x(1:end-1)];
            xhat(n+i) = x;
        end
    end

    % Mean squared error
    MSE = immse(xhat,norm_ss);
    
end

