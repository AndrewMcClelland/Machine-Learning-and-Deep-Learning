%% Answer to Question 3 - Training Naive Bayes Classifiers

clear all;
close all;
clc;

%% Training Naive Bayes

% Call Naive Bayes training function and retrieve n_ki
mean_featureI_classK = trainNaiveBayes();

% Create subplot of 1x10 that plots each class with correct label
for class_k = 1:10
    subplot(1,10,class_k);
    imagesc(reshape(mean_featureI_classK(class_k,:),8,8)'); axis equal; axis off; colormap gray;
    title(strcat("Mean of Label '", num2str(mod(class_k, 10)), "'"))
end

% Set figure to fullscreen
set(gcf,'units','normalized','outerposition',[0 0 1 1])