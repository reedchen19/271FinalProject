function [shifted, averaged, final] = shiftavg(MR_images, xcorr, ycorr)
    origsz = size(MR_images{1});
    origx = origsz(2);
    origy = origsz(1);

    for i = 2:5
        if xcorr(i) < 0
            sz = size(MR_images{i});
            MR_images{i} = uint8([MR_images{i} zeros(sz(1), -xcorr(i))]);
        end
        if xcorr(i) > 0
            sz = size(MR_images{i});
            MR_images{i} = uint8([zeros(sz(1), xcorr(i)) MR_images{i}]);
        end
    end
    for i = 2:5
        if ycorr(i) < 0
            sz = size(transpose(MR_images{i}));
            MR_images{i} = uint8(transpose([transpose(MR_images{i}) zeros(sz(1), -ycorr(i))]));
        end
        if ycorr(i) > 0
            sz = size(transpose(MR_images{i}));
            MR_images{i} = uint8(transpose([zeros(sz(1), ycorr(i)) transpose(MR_images{i})]));
        end
    end
    
    maxx = 0;
    maxy = 0;
    for i = 1:5
        sz = size(MR_images{i});
        if sz(2) > maxx
            maxx = sz(2);
        end
        if sz(1) > maxy
            maxy = sz(1);
        end
    end
    
    for i = 1:5
        sz = size(MR_images{i});
        if sz(2) < maxx

            MR_images{i} = uint8([zeros(sz(1), floor((maxx-sz(2))/2)) MR_images{i} zeros(sz(1), ceil((maxx-sz(2))/2))]);
        end
        sz = size(MR_images{i});
        if sz(1) < maxy
            MR_images{i} = uint8(transpose([zeros(sz(2), floor((maxy-sz(1))/2)) transpose(MR_images{i}) zeros(sz(2), ceil((maxy-sz(1))/2))]));

        end
    end
    
    shifted = {};
    for i = 1:5
        shifted{i} = MR_images{i};
    end
    
    temp = {};
    for i = 1:5
        temp{i} = uint16(MR_images{i});
    end
    
    averaged = (temp{1}+temp{2}+temp{3}+temp{4}+temp{5})/5;
    averaged = uint8(averaged);
    
    avgsz = size(averaged);
    removex = avgsz(2) - origx;
    removey = avgsz(1) - origy;
    
    final = averaged;

    final = final(:,1+floor(removex/2):end-ceil(removex/2));
    final = final(1+floor(removey/2):end-ceil(removey/2),:);
    
    %final = abs(255-final);
end