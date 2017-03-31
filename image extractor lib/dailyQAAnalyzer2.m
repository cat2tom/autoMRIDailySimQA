function image_quality= dailyQAAnalyzer2(image_dir )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% create a dict to hold the data

image_quality_dic=containers.Map();

% get file list for all dates.

image_dict = sortImagesIntoDict(image_dir);

% go through dates

dates=keys(image_dict);

for k=1:length(dates)
    
    key_tmp=dates{k};
    
    file_list=image_dict(key_tmp);
        
    [center,non_centered,centered_im,non_centered_im]=findCenterSlice2(file_list);
    
    [image_center,distance_mm_45,distance_mm_135]= getImageCenter( non_centered );
    
    
    output=getOutPut2(non_centered,image_center);

    [uniformity, contrast] = getUniformityContrast2(non_centered,image_center);

    [SNR, ghosting] = getSNRGhosting2(non_centered,image_center);
    
    % Assemble the resqults into array[ SNR  uniformity, contrast, ghosting
    % distance_m_45  distance_m_135  output].
    
   im_quality=[SNR  uniformity  contrast ghosting   distance_mm_45  distance_mm_135  output] 
   image_quality_dic(key_tmp)=im_quality;

end

   image_quality=image_quality_dic;

end 
