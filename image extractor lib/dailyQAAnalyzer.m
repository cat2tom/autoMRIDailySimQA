function test = dailyQAAnalyzer(image_dir )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


% get file list for all dates.

image_dict = sortImagesIntoDict(image_dir);

% go through dates

dates=keys(image_dict);

for k=1:length(dates)
    
    key_tmp=dates{k}
    
    file_list=image_dict(key_tmp);
        
    [center,non_centered,centered_im,non_centered_im]=findCenterSlice2(file_list);
    
    output=getOutPut(non_centered)

    [uniformity, constrast] = getUniformityContrast(non_centered)

    [SNR, ghosting] = getSNRGhosting(non_centered)

%     distance=getGeometry(non_centered)

end

test='ok';

end 
