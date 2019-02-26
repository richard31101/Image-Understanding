clear
clc
image = im2double(rgb2gray(imread('zebra1.jpg')));

%% try use different variance Gaussian function to smooth the image
sigma = 5;
smoothImage = imgaussfilt(image,sigma);

%% calculate the horizontal gradient and vertical gradient
filter1 = [-1 1];
horizonGradientImage = conv2(smoothImage,filter1,'same');
filter2 = [-1 1]';
verticalGradientImage = conv2(smoothImage,filter2,'same');
%% compute the gradient magnitude and orientation
gradientMagnitude = abs(horizonGradientImage + verticalGradientImage .* 1i);
orientation = angle(horizonGradientImage + verticalGradientImage .* 1i);
figure;
imagesc(gradientMagnitude);
colormap(gray);
title('gradient magnitude(sigma = 5)');
figure;
imagesc(orientation);
colormap(gray);
title('orientation(sigma = 5)');