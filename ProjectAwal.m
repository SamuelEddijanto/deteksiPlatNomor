warning off;

gambar_real = imread('E:\mobil_belakang.jpg');
real_resize = imresize(gambar_real,[480 NaN]);

subplot(1,2,1); imshow(gambar_real); title('gambar asli');
subplot(1,2,2); imshow(real_resize); title('gambar resize');
pause(10);

real_resize_gray= rgb2gray(real_resize);
imshow(real_resize_gray); title('gambar GrayScale');
pause(10);

gambar_sobel= edge(real_resize_gray,'Sobel');
imshow(gambar_sobel); title('Edge Detection dengan Sobel');
pause(10);

gambar_dilasi= imdilate(gambar_sobel,strel('disk',1));
imshow(gambar_dilasi); title('gambar dilasi');
pause(10);
%imshow(gambar_dilasi);

gambar_filHole = imfill(gambar_dilasi,'holes');
imshow(gambar_filHole); title('gambar setelah Filling Hole');
pause(10);

st1 = strel('line',15,0);
st2 = strel('line',15,90);
openingH= imopen(gambar_filHole,st1);
imshow(openingH);title('opening horizontal'); pause(10);
openingV= imopen(openingH,st2);
imshow(openingV);title('opening horizontal+vertical');pause(10);

%sekarang buat motong bebarap block yang putih pake labelling
[lab,n]= bwlabel(openingV);
dat = regionprops(lab,'All');
%figure, imshow(real_resize), title('gambar Asli');
figure, imshow(openingV), title ('Gambar Akhir');

a=1;
display(n)
for i=1:n
    b=dat(i);
    b1=b.BoundingBox;
    b2=b.Extent;
    b3=b.Area;
    
    if b3>a
        a=b3;
        out=b1;
    end
end
imrect(gca,out);
pause(10);

gambar_final= imcrop(real_resize,out);
figure,imshow(gambar_final),title('Crop');

% pesan: konsisten dg gambar
% cobakan perebedaanya dg edgedetection lainya
% cobakana dengna pencahayaan yg beberbeda
% meanmpilkan dlm bentuk array



