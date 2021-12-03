% Takes in cell of multiple grayscale images
% Returns resized images by cropping/padding in fourier space.
% Parameters: input = image cell, scale = factor to scale image by.

function output = resize(input, scale)
    imgs = {};
    for i = 1:length(input)
        [x_dim, y_dim] = size(input{i}); % get dimensions of input image
        freq = fftshift(fft2(input{i})); % take Fourier transform
        if scale>=1 % if desired image size is larger than input image, pad in Fourier space
            x = floor(x_dim*(scale-1)/2); % padding in x direction
            y = floor(y_dim*(scale-1)/2); % padding in y direction
            freq = padarray(freq,[x y],0,'both'); % pad w/ 0s in fourier space
        end
        if scale<1 % if the desired image is smaller than input image, crop in Fourier space
            x_center = floor(x_dim/2)+1; % center of image along x direction
            y_center = floor(y_dim/2)+1; % center of image along y direction
            crop_x = floor(x_dim*scale/2); % crop size along x direction
            crop_y = floor(y_dim*scale/2); % crop size along y direction

            freq = freq(x_center-crop_x:x_center+crop_x, y_center-crop_y:y_center+crop_y); % crop to keep low frequencies
        end
        %imshow(freq)
        [xo_dim, yo_dim] = size(freq); % get dimensions of output image
        mult = xo_dim*yo_dim/(x_dim*y_dim); % scaling factor to scale Fourier transform
        imgs{i} = uint8(real(ifft2(ifftshift(freq*mult)))); % inverse FFT back to spatial domain
    end
    output = imgs;
end