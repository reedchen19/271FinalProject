% Takes in cell of multiple grayscale images
% Returns resized images by cropping/padding in fourier space.
% Parameters: input = image cell, size_x = desired output image size in
% x-direction, size_y = desired output image size in y-direction.

% size_x and size_y parameters should both be larger/smaller than the
% input image dimensions, ie, if size_x > x-dimension of input image, then
% size_y should also be greater than the y-dimension of input image and not
% less.
function output = resize(input, size_x, size_y)
    imgs = {};
    for i = 1:length(input)
        [x_dim, y_dim] = size(input{i}); % get dimensions of input image
        freq = fftshift(fft2(input{i})); % take Fourier transform
        if size_x>x_dim && size_y>y_dim % if desired image size is larger than input image, pad in Fourier space
            x = ceil((size_x-x_dim)/2); % padding in x direction
            y = ceil((size_y-y_dim)/2); % padding in y direction
            freq = padarray(freq,[x y],0,'both'); % pad w/ 0s in fourier space
        end
        if size_x<x_dim && size_y<y_dim % if the desired image is smaller than input image, crop in Fourier space
            x_center = floor(x_dim/2)+1; % center of image along x direction
            y_center = floor(y_dim/2)+1; % center of image along y direction
            crop_x = floor(size_x/2); % crop size along x direction
            crop_y = floor(size_y/2); % crop size along y direction

            freq = freq(x_center-crop_x:x_center+crop_x, y_center-crop_y:y_center+crop_y); % crop to keep center of image
        end
        %imshow(freq)
        scale = size_x*size_y/(x_dim*y_dim); % scaling factor to scale Fourier transform
        imgs{i} = uint8(real(ifft2(ifftshift(freq*scale)))); % inverse FFT back to spatial domain
    end
    output = imgs;
end