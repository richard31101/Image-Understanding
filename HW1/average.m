clc
clear

% read file from set1
filelist = dir('image/set1/*.jpg');
grayResult = zeros(300, 215);
rgbResult = zeros(300, 215);
flipResult = zeros(300, 215);

for i=1:length(filelist)
    imname = ['image/set1/' filelist(i).name];
    nextim = imread(imname);
    % resize the picture
    renextim = imresize(nextim, [300, 215]);
    
    % turn to gray and sum up
    renextim_gray = rgb2gray(renextim);
    renextim_gray = im2double(renextim_gray);
    grayResult = grayResult + renextim_gray;
    
    % rgb channel and sum up
    renextim_rgb = im2double(renextim);
    rgbResult = rgbResult + renextim_rgb;
    
    % rgb with flip
    x = rand;
    renextim_flip = im2double(renextim);
    if x >= 0.5
        renextim_flip = flip(renextim_flip, 2);
    end
    flipResult = flipResult + renextim_flip;
    
end

figure;
grayResult = grayResult ./ length(filelist);
%subplot(2, 3, 1);
imshow(grayResult);
title('grayscale for set1');

figure;
rgbResult = rgbResult ./ length(filelist);
%subplot(2, 3, 2);
imshow(rgbResult);
title('rgbscale for set1');

figure;
flipResult = flipResult ./length(filelist);
%subplot(2, 3, 3);
imshow(flipResult);
title('randomly flip rgbscale for set1');

clc
clear

% read file from set2
filelist = dir('image/set2/*.jpg');
grayResult = zeros(300, 215);
rgbResult = zeros(300, 215);
flipResult = zeros(300, 215);

for i=1:length(filelist)
    imname = ['image/set2/' filelist(i).name];
    nextim = imread(imname);
    % resize the picture
    renextim = imresize(nextim, [300, 215]);
    
    % turn to gray and sum up
    renextim_gray = rgb2gray(renextim);
    renextim_gray = im2double(renextim_gray);
    grayResult = grayResult + renextim_gray;
    
    % rgb channel and sum up
    renextim_rgb = im2double(renextim);
    rgbResult = rgbResult + renextim_rgb;
    
    % rgb with flip
    x = rand;
    renextim_flip = im2double(renextim);
    if x >= 0.5
        renextim_flip = flip(renextim_flip, 2);
    end
    flipResult = flipResult + renextim_flip;
    
end

figure;
grayResult = grayResult ./ length(filelist);
%subplot(2, 3, 4);
imshow(grayResult);
title('grayscale for set2');

figure;
rgbResult = rgbResult ./ length(filelist);
%subplot(2, 3, 5);
imshow(rgbResult);
title('rgbscale for set2');

figure;
flipResult = flipResult ./length(filelist);
%subplot(2, 3, 6);
imshow(flipResult);
title('randomly flip rgbscale for set2');







