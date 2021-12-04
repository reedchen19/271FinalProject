%input upsampled images with first image automatically set to reference
%cross-correlates other images against ref for image alignment
%returns column and row shifts (Xcorr and Ycorr) of max correlation
%index 1 of Xcorr and Ycorr = autocorrelation of reference img
function [Xcorr, Ycorr, max_corr, max_index, imgCorr] = imgCorr(imgs)
    Xcorr = zeros([1 length(imgs)]);
    Ycorr = zeros([1 length(imgs)]);
        
    Xcorr(1) = max(max(xcorr2(cell2mat(imgs(1)))));
    Ycorr(1) = max(max(xcorr2(cell2mat(imgs(1)))));
        
    for i = 2:length(imgs)
        matref = cell2mat(imgs(1));
        matimg = cell2mat(imgs(i));
        imgCorr = xcorr2(matref, matimg);
        imgCorr = imgCorr.*(imgCorr < Xcorr(1));
        [max_corr, max_index] = max(imgCorr,[],'all','linear');
        [ypeak,xpeak] = ind2sub(size(imgCorr),max_index);
        Xcorr(i) = xpeak - size(imgs{1},2);
        Ycorr(i) = ypeak - size(imgs{1},1);
    end
end