clc;
close;
clear;

image1 = load('image/cifar-10-batches-mat/data_batch_1.mat');
image2 = load('image/cifar-10-batches-mat/data_batch_2.mat');
image3 = load('image/cifar-10-batches-mat/data_batch_3.mat');
image4 = load('image/cifar-10-batches-mat/data_batch_4.mat');
image5 = load('image/cifar-10-batches-mat/data_batch_5.mat');
label = load('image/cifar-10-batches-mat/batches.meta.mat');
test = load('image/cifar-10-batches-mat/test_batch.mat');

%% test the code with small amout of test data
confusionMatrix = zeros(10,10);

data = [image1.data;image2.data;image3.data;image4.data;image5.data];
labels = [image1.labels;image2.labels;image3.labels;image4.labels;image5.labels];
total = length(test.labels);
testLabel = zeros(total,1);
for i = 1 :total
    display(i);
    testImage = test.data(i,:);
    %testLabel(i) = NNClassifier(data,labels,testImage);
    %testLabel(i) = kNNClassifier(5,data,labels,testImage);
    testLabel(i) = kNNClassifierCorr(5,data,labels,testImage);
end

%% set the confusion matrix
for i = 1 :total
    confusionMatrix(test.labels(i)+1,testLabel(i)+1) = confusionMatrix(test.labels(i)+1,testLabel(i)+1) + 1;
end
sum_confusion = sum(confusionMatrix,2);
for i = 1:10
    for j = 1:10
        confusionMatrix(i,j) = confusionMatrix(i,j)./sum_confusion(i);
    end
end
%% set the error rate
error = 0;
for i = 1 :10
   error = error + confusionMatrix(i,i);
end
display(1 -error/total);
%% plot confusion matrix
figure;
imagesc(confusionMatrix);
colorbar;

%% display few easily confused pictures
easy = [0,0,0,0,0,0,0,0,0,0];
k = 1;
for i = 1:total
    if testLabel(i) == 4
        if test.label(i) == 7
            easy(k) = i;
            k= k+1;
            if k == 11
                break;
            end
        end
    end
end
for i = 1:10
    image = zeros(32,32,3);
    R = test.data(easy(i),1:1024);
    G = test.data(easy(i),1025:2048);
    B = test.data(easy(i),2049:3072);
    k = k+1;
    for j = 1:32
        for k = 1:32
            image(j,k,1) = R(k);
            image(j,k,2) = G(k);
            image(j,k,3) = B(k);
            k = k+1;
        end
    end
    image = uint8(image);
    subplot(2,5,i);
    imshow(image);
end