imtool = ImProcTools;
img = imread('../data/colored/1.png');
%kernel = [0, 1, 0 ; 1,4,1 ;0,1,0];
%conv = imtool.convolution(img, kernel, "fillzero");
figure;imshow(img);
%figure;imshow(conv);
ilpfImg = Filter.spatialFilter(img, "ignore", "alpha_trimmed_mean", 3, 4);
figure;imshow(ilpfImg);