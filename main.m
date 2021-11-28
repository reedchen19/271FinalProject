clear

%import data
HR_image = rgb2gray(imread('./stars/Full Res Star.png')); % High-res/ground truth image
LR_images = {}; % low-res images
for i = 1:5
    file = sprintf('./stars/Low Res Star %d.png', i)
    LR_images{i} = rgb2gray(imread(file));
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
MR_images = resize(LR_images, x_LR*scale, x_LR, y_LR);
figure(1)
for i = 1:5
    subplot(5,1,i)
    imshow(LR_images{i})
end
figure(2)
for i = 1:5
    subplot(5,1,i)
    imshow(MR_images{i})
end