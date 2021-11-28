%input upsampled images with first image automatically set to reference
%cross-correlates other images against ref for image alignment
%returns column and row (Xcorr and Ycorr) of max correlation for each img
%index 1 of Xcorr and Ycorr = autocorrelation of reference img
function [Xcorr, Ycorr] = imgCorr(imgs)
    Xcorr = zeros([1 length(imgs)]);
    Ycorr = zeros([1 length(imgs)]);
        
    Xcorr(1) = max(xcorr2(imgs(1)));
    Ycorr(1) = max(xcorr2(imgs(1)));
    
    imgCorr = zeros([1 length(imgs)]);
    
    for i = 2:length(imgs)
        imgCorr(i) = mag(xcorr2(imgs(i),imgs(1))-Xcorr(1));
        [max_corr, max_index] = min(imgCorr(i));
        [ypeak,xpeak] = ind2sub(size(imgCorr(i)),max_index(1));
        Xcorr(i) = xpeak-size(imgs(1),2);
        Ycorr(i) = ypeak-size(imgs(1),1);
    end
end