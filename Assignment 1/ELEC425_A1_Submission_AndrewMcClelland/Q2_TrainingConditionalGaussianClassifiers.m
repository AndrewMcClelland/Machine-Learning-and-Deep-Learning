%% Answer to Question 2 - Training Conditional Gaussian Classifiers

clear all;
close all;
clc;

%% Training Gaussian

% Call Gaussian training function and retrieve variance and u_ki
[variance, mean_featureI_classK] = trainConditionalGaussian();

% Create subplot of 1x10 that plots each class with correct label
for class_k = 1:10
    subplot(1,10,class_k);
    imagesc(reshape(mean_featureI_classK(class_k,:),8,8)'); axis equal; axis off; colormap gray;
    title(strcat("Mean of Label '", num2str(mod(class_k, 10)), "'"))
    annotation('textbox', [.4 .1 .3 .3], 'String', strcat("Pixel noise standard deviation = ", num2str(sqrt(variance))), 'FitBoxToText','on');
end

% Set figure to fullscreen
set(gcf,'units','normalized','outerposition',[0 0 1 1])