clear
clc
%{
%% (a)Compute the DFT of the signal and plot the magnitude of the spectrum
figure;
single = zeros(100, 1);
single(50, 1) = 1;
singleF = fft(single);
singleF = fftshift(singleF);
plot(abs(singleF));
title('magnitude of the spectrum');

%% (b)box function of 5 and 10
figure;
A = zeros(100, 1);
A(45:54, 1) = 5;
AF = fft(A);
AF = fftshift(AF);
%subplot(2, 1, 1);
plot(abs(AF));
title('Box function 5 with 10 samples');

B = zeros(100, 1);
B(46:55, 1) = 1;
BF = fft(B);
BF = fftshift(BF);
subplot(2, 1, 2);
plot(abs(BF));
title('Box function 10');

%% (c) Gaussian function with £m= 1 and £m = 2
figure;
x = -49:50;
G1 = gaussmf(x, [1 0]);
G1F = fft(G1);
G1F = fftshift(G1F);
subplot(2, 1, 1);
plot(abs(G1F));
title('Gaussian Function with sigma=1');

G2 = gaussmf(x, [2 0]);
G2F = fft(G2);
G2F = fftshift(G2F);
subplot(2, 1, 2);
plot(abs(G2F));
title('Gaussian Function with sigma=2');

%% (d) 2D DFT and inverse DFT
figure;
zebra1 = im2double(rgb2gray(imread('zebra1.jpg')));
zebra2 = im2double(rgb2gray(imread('zebra2.jpg')));
[m,n,d] = size(zebra2);
zebra1 = imresize(zebra1,[m n]);
subplot(2, 1, 1);
colormap gray;
imagesc(zebra1);
axis image
title('zebra1');
subplot(2, 1, 2);
colormap gray;
imagesc(zebra2);
axis image
title('zebra2');

zebra1 = fft2(zebra1);
zebra2 = fft2(zebra2);
zebra1_magnitude = abs(zebra1);
zebra2_magnitude = abs(zebra2);
zebra1_phase = angle(zebra1);
zebra2_phase = angle(zebra2);

combination1 = ifft2(zebra1_magnitude.*exp(zebra2_phase*i));
combination1 = im2uint8(abs(combination1));
combination2 = ifft2(zebra2_magnitude.*exp(zebra1_phase*i));
combination2 = im2uint8(abs(combination2));
figure;
subplot(2, 1, 1);
colormap gray;
imagesc(combination1);
axis image
title('Magnitude : zebra1 + Phase : zebra2');

subplot(2, 1, 2);
colormap gray;
imagesc(combination2);
axis image
title('Magnitude : zebra2 + Phase : zebra1');
%}
Fs=9827.2*2;
t=0:1/Fs:0.06756;
f=14.8;
f_1=1228.4;
x=cos(2*pi*t*f)+cos(2*pi*t*f_1);
nfft=664;
X=fft(x,nfft);
X = X(1:nfft/2); 
mx=abs(X);
f=(0:nfft/2-1)*Fs/nfft;
figure(1);
plot(t,x);
title('Cosine wave Signal');
ylabel('Amplitude');
figure(2); 
plot(f,mx);
title('Power Spectrum of a cosine wave');
xlabel('Frequency(hz)');
ylabel('Power') 