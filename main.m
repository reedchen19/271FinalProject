clear

%import data
HR_image = abs(255-rgb2gray(imread('./Skeletons/High_Res_Skelly.png'))); % High-res/ground truth image
LR_images = {}; % low-res images

for i = 1:5
    %file = sprintf('./stars/Low Res Star %d.png', i);
    %file = sprintf('./Circles/Low_res Circle %d.png', i);
    %file = sprintf('./Pictures/Img%d_BW_400x300.png', i);
    file = sprintf('./Skeletons/Low_Res Skelly %d.png', i);
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
    subplot(3,3,i);
    imshow(shifted{i});
end
subplot(3,3,6);
imshow(averaged);
subplot(3,3,7);
imshow(final);
%%
% FSC analysis
HR_image_ds = resize({HR_image}, x_MR/x_HR); % resize HR images to same size as super-resolved image to perform FSC
[x_HR_ds, y_HR_ds] = size(HR_image_ds{1});
naive = resize({LR_images{1}}, 2); % naive upsampling of LR images

p=struct;
frc = FSC(double(HR_image_ds{1}), double(naive{1}), p);
figure(4)
hold on
plot(frc.nu, frc.frc, 'DisplayName', 'FRC naive')
plot(frc.nu, frc.T_hbit, 'DisplayName', '1/2 bit Threshold')
plot(frc.nu, frc.T_bit, 'DisplayName', '1 bit Threshold')

frc = FSC(double(HR_image_ds{1}), double(final), p);
plot(frc.nu, frc.frc, 'DisplayName', 'FRC super-resolved')
hold off
legend show

%%
% Cross-corr max
naive = xcorr2(HR_image_ds{1}, naive{1});
super = xcorr2(HR_image_ds{1}, final);

naive = abs(fftshift(fft2(naive)));
super = abs(fftshift(fft2(super)));
final = abs(fftshift(fft2(final)));

[M_n, I_n] = max(naive,[], 'all', 'linear')
[M_s, I_s] = max(super, [],'all', 'linear')