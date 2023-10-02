classdef Filter
   methods (Static)
       function lpfImg = lpf(img, h)
           [height, width] = size(img);
           %padding
           lpfImg = img;
           pad_h = 2*height;
           pad_w = 2*width;
           lpfImg = padarray(lpfImg, [height, width], 0, "post");
           %fourier
           fourier_img = fft2(double(lpfImg));
           
           ilpf_f = h .* fourier_img;

           ilpf_f2 = real(ifft2(ilpf_f));
           lpfImg = ilpf_f2(1:height, 1:width);
           lpfImg = uint8(lpfImg);

           

       end
       function ilpfImg = ilpf(img, d0)
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           ilpfImg = zeros(size(img));
           for ch=1:channels
               u = 0:(pad_h - 1);
               v = 0:(pad_w - 1);
               %indices in meshgrid
               idx = find(u > pad_h / 2);
               u(idx) = u(idx) - pad_h;
               idy = find(v > pad_w / 2);
               v(idy) = v(idy) - pad_w;
               %meshgrid arrays
               [V,U] = meshgrid(v,u);
               d = sqrt(U .^ 2 + V .^ 2);
               h = double(d <= d0);

               h = fftshift(h);
               h = ifftshift(h);

               ilpfImg(:,:,ch) = Filter.lpf(img(:,:,ch), h);
           end
           ilpfImg = uint8(ilpfImg);
       end
       function glpfImg = glpf(img, d0)
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           glpfImg = zeros(size(img));
           for ch=1:channels
               u = 0:(pad_h - 1);
               v = 0:(pad_w - 1);
               %indices in meshgrid
               idx = find(u > pad_h / 2);
               u(idx) = u(idx) - pad_h;
               idy = find(v > pad_w / 2);
               v(idy) = v(idy) - pad_w;
               %meshgrid arrays
               [V,U] = meshgrid(v,u);
               d = sqrt(U .^ 2 + V .^ 2);
               h = exp(-(d.^2) ./(2 * (d0^2)));

               h = fftshift(h);
               h = ifftshift(h);

               glpfImg(:,:,ch) = Filter.lpf(img(:,:,ch), h);
           end
           glpfImg = uint8(glpfImg);
       end
       function blpfImg = blpf(img, d0, n)
           if (n < 1)
               n = 1;
           end
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           blpfImg = zeros(size(img));
           for ch=1:channels
               u = 0:(pad_h - 1);
               v = 0:(pad_w - 1);
               %indices in meshgrid
               idx = find(u > pad_h / 2);
               u(idx) = u(idx) - pad_h;
               idy = find(v > pad_w / 2);
               v(idy) = v(idy) - pad_w;
               %meshgrid arrays
               [V,U] = meshgrid(v,u);
               d = sqrt(U .^ 2 + V .^ 2);
               h = 1 ./ (1 + (d ./d0) .^(2*n));

               h = fftshift(h);
               h = ifftshift(h);

               blpfImg(:,:,ch) = Filter.lpf(img(:,:,ch), h);
           end
           blpfImg = uint8(blpfImg);
       end
               
   end
end