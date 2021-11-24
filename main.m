clear

%import data
HR_image = rgb2gray(imread('./stars/Full Res Star.png')); % High-res/ground truth image
LR_images = {}; % low-res images
for i = 1:5
    LR_images{i} = rgb2gray(imread('./stars/Low Res Star 1.png'));
end
%imshow(LR_images{1})

%global variables
scale = 2; %scaling factor
num_img = length(LR_images); % number of low-res images
x_HR = length(HR_image(:, 1)); % high res x pixels
y_HR = length(HR_image(1, :)); % high res y pixels
x_LR = length(LR_images{1}(:, 1)); % low res x pixels
y_LR = length(LR_images{1}(1, :)); % low res y pixels

MR_images = {}; % mid-res images @Reed
xcorr = []; %cross corr max location @Andrew
ycorr = [];
avg_MR = []; %averaged mid-res image


