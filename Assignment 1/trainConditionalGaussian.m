function [variance, mean_featureI_classK] = trainConditionalGaussian()
%% Training Conditional Gaussian Classifiers

clear all;
close all;
clc;

% 64 (8x8 image of digit in raster scan order) x 700 train cases x 10
% digit labels (1-0) where label 10 is 0
load('./data/a1digits.mat');

%% Training

% Class label k in [1,2...K]
% Real value vector of D features x = (x1, ... xD)

% number of training data points in class k
mk = 700;

% uki mean of feature i condiitoned on class k. 2D array where k (labels
% 0-9) and i (features 1-64)
mean_featureI_classK = zeros(10,64);

% Loop through each class k (1:10), and for each feature i (1:64), sum its
% value in each of the k training datapoints and divide by total number of
% training datapoints mk
for class_k = 1:10
    for feature_i = 1:64
        mean_featureI_classK(class_k, feature_i) = mean(digits_train(feature_i, :, class_k));
    end
end

% Calculating variance
variance = 0;

% Loop through each class k, training point j, and feature i, to calculate
% variance
for class_k = 1:10
    for trainingPoint_j = 1:700
        for feature_i = 1:64
            variance = variance + ((digits_train(feature_i, trainingPoint_j, class_k) - mean_featureI_classK(class_k, feature_i))^2);
        end
    end
end

% Divide by DM (64 features * (700 training samples * 10 classes))
variance = variance / (64 * (700 * 10));

end

