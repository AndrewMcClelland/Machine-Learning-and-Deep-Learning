function [mean_featureI_classK] = trainNaiveBayes()

% 64 (8x8 image of digit in raster scan order) x 700 train cases x 10
% digit labels (1-0) where label 10 is 0
load('./data/a1digits.mat');

%% Training

% Convert real-valued features x into binary features b by thresholding: bi = 1 if xi > 0.5 otherwise bi = 0
digits_train_thresholded = zeros(64, 700, 10);

for class_k = 1:10
    for trainingPoint_j = 1:700
        digits_train_thresholded(:, trainingPoint_j, class_k) = digits_train(:, trainingPoint_j, class_k) > 0.5;
    end
end

% nki is 2D array where k (labels 0-9) and i (features 1-64)
mean_featureI_classK = ones(10,64);

% For each class k and feature i, calculate n_ki by calculating p(b_i=1 | Ck)
for class_k = 1:10
    for feature_i = 1:64
        mean_featureI_classK(class_k, feature_i) = sum(digits_train_thresholded(feature_i, :, class_k)) / 700;
    end
end

end

