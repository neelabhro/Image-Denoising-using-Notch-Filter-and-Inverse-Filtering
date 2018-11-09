%Neelabhro Roy
%IIIT-Delhi
clear all;
close all;
clc;

%Question 1

A = rgb2gray(imread('newsprint.jpg'));
imshow(A);
title('Original Image');
figure;

%A = rgb2gray(A);
%imshow(A);
%title('Grayscaled Image');
%figure;

F = fftshift(fft2(A));

S = log(1 + abs(F));
imshow(S,[]);
[x0,y0] = getpts();
%Select the Points having distinct white lights on the displayed image and then press "Enter"
title('Magnitude Spectrum of the Original Image');
figure;



SZ = size(F);
 for i = 1 : SZ(1)
     for j = 1 : SZ(2)
         for n = 1 : 8
          x = x0(n);
          y= y0(n);
          
          if(((x - j).^2 )+((y - i).^2) < 121)
              F(i,j)=0;
          end
         end
     end
 end


S2 = log(1 + abs(F));
imshow(S2,[]);
title('Magnitude Spectrum of the De-Notched Image');
figure;

Y = real(ifft2(fftshift(F)));
Y1 = imcrop(Y,[0,0,168,246]);
imshow(Y1,[]);
title('De-Notched Image');
figure;






%%%
%Question 3
B = padarray(Y1,[512,512],0,'post');
B = fftshift(fft2(B));
S3 = log(1 + abs(B));
imshow(S3,[]);
title('Reverse Filtered Magnitude Transform');

figure;

c = 0.002;

SZ1 = size(B);
 for i = 1 : SZ1(1)
     for j = 1 : SZ1(2)
         gauss = exp(c*(i + j));
         B(i,j) = B(i,j) .* gauss;
         
     end
 end
 
 
 
Y2 = real(ifft2(fftshift(B)));
%Y3 = imcrop(Y2,[0,0,512,512]);
%imshow(Y3,[]);
imshow(Y2,[]);
title('Reverse Filtered Image');


Y3 = awgn(Y2,10);

B1 = padarray(Y3,[512,512],0,'post');
B1 = fftshift(fft2(B1));
S4 = log(1 + abs(B1));
imshow(S4,[]);
title('Reverse Filtered Magnitude Transform for Degraded Image with AWGN');

figure;

c = 0.002;

SZ2 = size(B1);
 for i = 1 : SZ2(1)
     for j = 1 : SZ2(2)
         gauss = exp(c*(i + j));
         B1(i,j) = B1(i,j) .* gauss;
         
     end
 end
 
 
 
Y4 = real(ifft2(fftshift(B1)));
%Y3 = imcrop(Y2,[0,0,512,512]);
%imshow(Y3,[]);
imshow(Y4,[]);
title('Reverse Filtered Degraded Image after the Addition of AWGN');
figure;

Y5 = imcrop(Y4,[0,0,512,512]);
imshow(Y5,[]);
title('Reverse Filtered Cropped Degraded Image after the Addition of AWGN');
