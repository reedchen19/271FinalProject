%input upsampled images with first image automatically set to reference
%cross-correlates other images against ref for image alignment
%returns column and row shifts (Xcorr and Ycorr) of max correlation
%index 1 of Xcorr and Ycorr = autocorrelation of reference img
function [Xcorr, Ycorr, max_corr, max_index, imgCorr] = imgCorr(imgs)
    Xcorr = zeros([1 length(imgs)]); %X shift values (index 1 = autocorr)
    Ycorr = zeros([1 length(imgs)]); %Y shift values (index 1 = autocorr)
        
    Xcorr(1) = max(max(xcorr2(cell2mat(imgs(1))))); %set index 1 = autocorr
    Ycorr(1) = max(max(xcorr2(cell2mat(imgs(1))))); %set index 1 = autocorr
        
    for i = 2:length(imgs)
        matref = cell2mat(imgs(1)); %define reference img as first img
        matimg = cell2mat(imgs(i)); %define test img for correlating
        imgCorr = xcorr2(matref, matimg); %perform 2d correlation
        imgCorr = imgCorr.*(imgCorr < Xcorr(1)); %verify against autocorr
        [max_corr, max_index] = max(imgCorr,[],'all','linear'); %find max correlation in reference
        [ypeak,xpeak] = ind2sub(size(imgCorr),max_index); %locate y row and x column for max correlation
        Xcorr(i) = xpeak - size(imgs{1},2); %convert x column of correlation to x shift in test img
        Ycorr(i) = ypeak - size(imgs{1},1); %convert y row of correlation to y shift in test img
    end
end