HR_image = abs(255-rgb2gray(imread('./Circles/High_res Circle.png'))); % High-res/ground truth image
[x_HR, y_HR] = size(HR_image); % high res x pixels

HR_image_ds = resize({HR_image}, x_MR/x_HR); % resize HR images to same size as super-resolved image to perform FSC
[x_HR_ds, y_HR_ds] = size(HR_image_ds{1});
naive = resize({LR_images{1}}, 2); % naive upsampling of LR images

naive = abs(fftshift(fft2(naive)));
super = abs(fftshift(fft2(super)));
final = abs(fftshift(fft2(final)));

naive = xcorr2(HR_image_ds{1}, naive{1});
super = xcorr2(HR_image_ds{1}, final);

[M_n, I_n] = max(naive,[], 'all', 'linear');
[M_s, I_s] = max(super, [],'all', 'linear');