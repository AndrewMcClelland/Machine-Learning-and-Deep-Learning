function y = activation_tanh(alpha) 
    %Here both alpha and y are vectors and they have the same size. 
    y = (exp(alpha) - exp(-alpha)) ./ (exp(alpha) + exp(-alpha));
end

