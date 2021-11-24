%takes in cell of multiple grayscale images
%returns resized square images by cropping/padding in fourier space
%input = image cell, size = desired output image size
function output = resize(input, size, x_dim, y_dim)
    imgs = {};
    scale = size/x_dim;
    for i = 1:length(input)
        freq = fftshift(fft2(input{i}));
        if size>x_dim && size>y_dim
            x = ceil((size-x_dim)/2); %padding in x direction
            y = ceil((size-y_dim)/2);
            freq = padarray(freq,[x y],0,'both'); % pad w/ 0s in fourier space
        end
        if size<x_dim && size<y_dim
            x_center = floor(x_dim/2)+1; % center of image
            y_center = floor(y_dim/2)+1; % center of image
            crop = floor(size/2);
            freq = freq(x_center-crop:x_center+crop, y_center-crop:y_center+crop);
        end
        %imshow(freq)
        imgs{i} = uint8(real(ifft2(ifftshift(freq*scale^2))));
    end
    output = imgs;
end