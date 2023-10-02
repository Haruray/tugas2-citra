imtool = ImProcTools;
img = imread('../data/grayscaled/Lena.bmp');
%kernel = [0, 1, 0 ; 1,4,1 ;0,1,0];
%conv = imtool.convolution(img, kernel, "fillzero");
figure;imshow(img);
%figure;imshow(conv);
ilpfImg = Filter.blpf(img, 50, 1);
figure;imshow(ilpfImg);