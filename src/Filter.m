classdef Filter
   methods (Static)
       function pfImg = pf(img, h)
           [height, width] = size(img);
           %padding
           pfImg = img;
           pad_h = 2*height;
           pad_w = 2*width;
           pfImg = padarray(pfImg, [height, width], 0, "post");
           %fourier
           fourier_img = fft2(double(pfImg));
           
           ilpf_f = h .* fourier_img;

           ilpf_f2 = real(ifft2(ilpf_f));
           pfImg = ilpf_f2(1:height, 1:width);
           pfImg = uint8(pfImg);
       end
       function ipfImg = ipf(img, d0, high)
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           ipfImg = zeros(size(img));
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
               if (high)
                   h = 1-h;
               end
               h = fftshift(h);
               h = ifftshift(h);

               ipfImg(:,:,ch) = Filter.pf(img(:,:,ch), h);
           end
           ipfImg = uint8(ipfImg);
       end
       function gpfImg = gpf(img, d0, high)
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           gpfImg = zeros(size(img));
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
               if (high)
                   h = 1-h;
               end
               h = fftshift(h);
               h = ifftshift(h);

               gpfImg(:,:,ch) = Filter.pf(img(:,:,ch), h);
           end
           gpfImg = uint8(gpfImg);
       end
       function bpfImg = bpf(img, d0, n, high)
           if (n < 1)
               n = 1;
           end
           [height, width, channels] = size(img);
           pad_h = height * 2;
           pad_w = width * 2;
           bpfImg = zeros(size(img));
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
               if (high)
                   h = 1-h;
               end

               h = fftshift(h);
               h = ifftshift(h);

               bpfImg(:,:,ch) = Filter.pf(img(:,:,ch), h);
           end
           bpfImg = uint8(bpfImg);
       end
               
   end
end