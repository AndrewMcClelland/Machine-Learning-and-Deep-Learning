%% Answer to Question 4 - Test Performance

clear all;
close all;
clc;

load('./data/a1digits.mat');    

% Create 2 x 11 array where row1 is Gaussian, row2 is Naive Bayes, column represents label 1:10, last column has overall error rate in %
error_rate = zeros(2, 11);

% ak = 1/10 since all classes have same number of observations
prior_class_prob = 1/10;

%% Testing Conditional Gaussian

% Get the variance and mean of Gaussian training function
[variance, mean_featureI_classK] = trainConditionalGaussian();

% Loop through all testpoints for each class
for testPoint_j = 1:400
    for class_k = 1:10
        % Create 1x10 array to hold the calculated probability that a given test point belongs to each of the 10 classes, and loop through
        % each class to calculate its probability
        class_conditional_dist = zeros(1, 10);
        for class_guess = 1:10
            sum_part = 0;
            % Loop through each feature and calculate the relvant part of p(x|Ck) for each class
            for feature_i = 1:64
                sum_part = sum_part + (digits_test(feature_i, testPoint_j, class_k) - mean_featureI_classK(class_guess, feature_i))^2;
            end
            class_conditional_dist(class_guess) = exp((-1/(2 * variance)) * sum_part);
        end
        % Select the highest probability class and guess this
        [val, predicted_class] = max(class_conditional_dist);
        % If prediction is incorrect, add error count to what class it should have been
        if(predicted_class ~= class_k)
            error_rate(1, class_k) = error_rate(1, class_k) + 1;
        end
    end
end

%% Testing Naive Bayes

% Convert real-valued features x into binary features b by thresholding: bi = 1 if xi > 0.5 otherwise bi = 0
digits_test_thresholded = zeros(64, 400, 10);

% Convert real-valued features x into binary features b by thresholding: bi = 1 if xi > 0.5 otherwise bi = 0
for class_k = 1:10
    for testPoint_j = 1:400
        digits_test_thresholded(:, testPoint_j, class_k) = digits_test(:, testPoint_j, class_k) > 0.5;
    end
end

% Get nki values for classes 1-10 and features 1-64
mean_featureI_classK = trainNaiveBayes();

% Loop through all test points and classes
for testPoint_j = 1:400
    for class_k = 1:10
        % Create 1x10 array to hold the calculated probability that a given test point belongs to each of the 10 classes, and loop through
        % each class to calculate its probability
        prob_each_class = ones(1, 10);
        for class_guess = 1:10
            for feature_i = 1:64
                % If current feature is 1, multiply current probability by nki
                if(digits_test_thresholded(feature_i, testPoint_j, class_k))
                    prob_each_class(1, class_guess) = prob_each_class(1, class_guess) * mean_featureI_classK(class_guess, feature_i);
                % If current feature is 0, multiply current probability by (1-nki)
                else
                    prob_each_class(1, class_guess) = prob_each_class(1, class_guess) * (1 - mean_featureI_classK(class_guess, feature_i));
                end
            end
        end
        % Select the highest probability class and guess this
        [val, predicted_class] = max(prob_each_class);
        % If prediction is incorrect, add error count to what class it should have been
        if(predicted_class ~= class_k)
            error_rate(2, class_k) = error_rate(2, class_k) + 1;
        end
    end
end

%% Calculate error rate for both Gaussian and Naive Bayes
error_rate(1, 11) = sum(error_rate(1, :)) / (400 * 10);
error_rate(2, 11) = sum(error_rate(2, :)) / (400 * 10);

fprintf("Errors for Gaussian and Naive Bayes Classification\n\t- First row is Gaussian, second row is Naive Bayes\n\t- Columns 1-10 are # errors for each class 1-10\n\t- Column 11 is error rate for each classifier\n\n")
disp(error_rate)
    