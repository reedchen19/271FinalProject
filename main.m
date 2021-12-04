clear

%import data
HR_image = abs(255-rgb2gray(imread('./Circles/High_res Circle.png'))); % High-res/ground truth image
LR_images = {}; % low-res images

for i = 1:5
    %file = sprintf('./stars/Low Res Star %d.png', i);
    file = sprintf('./Circles/Low_res Circle %d.png', i);
    %file = sprintf('./Pictures/Img%d_BW_400x300.png', i);
    LR_images{i} = abs(255-rgb2gray(imread(file)));
end
%imshow(LR_images{1})

%global variables
scale = 2; %scaling factor
num_img = length(LR_images); % number of low-res images
[x_HR, y_HR] = size(HR_image); % high res x pixels
[x_LR, y_LR] = size(LR_images{1}); % low res x pixels

MR_images = {}; % mid-res images @Reed
xcorr = []; %cross corr max location @Andrew
ycorr = [];
avg_MR = []; %averaged mid-res image @Advaita

%Upsampling
MR_images = resize(LR_images, scale);
[x_MR, y_MR] = size(MR_images{1});
figure(1)
for i = 1:num_img
    subplot(num_img,1,i)
    imshow(LR_images{i})
end
figure(2)
for i = 1:num_img
    subplot(num_img,1,i)
    imshow(MR_images{i})
end

[xcorr, ycorr, max_corr, max_index] = imgCorr(MR_images);

[shifted, averaged, final] = shiftavg(MR_images, xcorr, ycorr);

figure(3);
for i = 1:5
    subplot(7,1,i);
    imshow(shifted{i});
end
subplot(7,1,6);
imshow(averaged);
subplot(7,1,7);
imshow(final);