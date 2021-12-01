function [shifted, averaged] = shiftavg(MR_images, xcorr, ycorr)
    for i = 2:5
        if xcorr(i) < 0
            sz = size(MR_images{1});
            MR_images{i} = uint8([MR_images{i} zeros(sz(1), -xcorr(i))]);
        end
        if xcorr(i) > 0
            sz = size(MR_images{1});
            MR_images(i) = uint8([zeros(sz(1), xcorr(i)) MR_images{i}]);
        end
    end
    for i = 2:5
        if ycorr(i) < 0
            sz = size(transpose(MR_images{i}));
            MR_images{i} = uint8(transpose([transpose(MR_images{i}) zeros(sz(1), -ycorr(i))]));
        end
        if ycorr(i) > 0
            sz = size(transpose(MR_images{1}));
            MR_images{i} = uint8(transpose([zeros(sz(1), ycorr(i)) transpose(MR_images{i})]));
        end
    end
    shifted = {};
    for i = 1:5
        shifted{i} = MR_images{i};
    end
    averaged = {};
end