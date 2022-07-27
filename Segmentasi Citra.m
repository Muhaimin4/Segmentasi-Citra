clc; clear
close all; warning off all;

Img = imread('kudalaut.jpg');
figure, imshow(Img), title('Citra Awal/1');


I = double(rgb2gray(Img));
dlx = [-1 0 1];
dly = [-1 0 1];
Ix = conv2(I,dlx,'same');
Iy = conv2(I,dly,'same');
J = sqrt((Ix.^2)+(Iy.^2));
figure, imshow(J,[]), title('Citra 2');


K = J>10;
L = imclearborder (K);
M = imfill (L,'holes');
N = bwareaopen(M,100);
figure, imshow(N), title('Citra 3')
area = sum(sum(N));


O = bwmorph(N,'remove');
figure, imshow(O), title('Citra 4');
perimeter = sum(sum(O));


[B,L] = bwboundaries(N,'noholes');
figure, imshow(Img), title('Citra 5')
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end


[row, col] = find (N==1);
[a,b] = size (N);
mask = false(a,b);
mask(min(row):max(row),min(col):max(col)) = 1;
mask = bwperim(mask,8);
mask = imdilate(mask,strel('square',4));
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
R(mask) = 225;
G(mask) = 225;
B(mask) = 0;
RGB = cat(3,R,G,B);
figure,imshow(RGB), title('Citra 6');


crop = imcrop(Img,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);
figure, imshow(crop), title('Citra Akhir/7');