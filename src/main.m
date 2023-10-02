imtool = ImProcTools;
img = imread('../data/colored/1.png');
%kernel = [0, 1, 0 ; 1,4,1 ;0,1,0];
%conv = imtool.convolution(img, kernel, "fillzero");
figure;imshow(img);
%figure;imshow(conv);
ilpfImg = Filter.bpf(img, 50, 1, true);
figure;imshow(ilpfImg);