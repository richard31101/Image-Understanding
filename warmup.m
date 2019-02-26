%read the original image and take a sub-region 100*100 of it
temp = imread('lena.jpg');
A = temp((201:300),(201:300));  
%a
sort_A = sort(A(:));
figure;
plot(sort_A);
%b
figure;
hist(double(A(:)), 32);
%c
threshold = 128;
C = A > threshold;
figure;
imshow(C);
%d
figure;
D = imshow(A(50:100, 50:100));
%e
E = A - mean(sort_A);
E(E<0) = 0;
figure;
imshow(E);
%f
F = flip(A, 2)
figure;
imshow(F)
%g
x= min(min(A));
[r, c] = find(A == x, 1);
%h
v = [1 8 8 2 1 3 9 8];
w = unique(v);
size(w, 2)