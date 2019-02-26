clc;
clear;
close;

%% get the test image and clip out patch of image
image = 1 - im2double(imread('dilbert1.jpg'));
image = double(image > 0.5);

patch = image(50:64,375:386);
imwrite(patch,'template.jpg','JPEG');

%% filp the template and correclate with the image
template = rot90(patch,2);
corrResult = conv2(image,template,'same');
figure;
imagesc(corrResult);
colormap(jet);
colorbar;
truesize;
title('correlation');

%% thresholding

Left = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,2:end-1);
Right = corrResult(2:end-1,2:end-1) > corrResult(3:end,2:end-1);
Threshold = corrResult(2:end-1,2:end-1) > 45;
maxima = Left & Right & Threshold;

%% plot final result
figure;
imshow(image);
title('final detection result');
hold on;
[templateHeight,templateWidth] = size(template);
[y,x] = size(maxima);
for i = 1:x
   for j = 1:y
      if maxima(j,i) == 1 
          rectangle('Position',[i - templateWidth/2,j - templateHeight/2,templateWidth,templateHeight],'LineWidth',1,'EdgeColor','r');
      end
   end
end
