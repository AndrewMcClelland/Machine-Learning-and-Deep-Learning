function gradient = activation_tanh_gradient(y)
    % Here y is a vector, so you need to compute gradient with regard
    % to each of element in y;
    gradient = 1 - (tanh(y) .^ 2);
end