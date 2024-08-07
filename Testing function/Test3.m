dir_name='C:\aitangResearch\MRI daily QA program\sample images\';

dir_name2='\\ctcphapp01\DCM_RESEARCH_DATA\zzzz_bridge_laser_QA\'; 

dir_name3='K:\temp2\';
[center,non_centered,centered_im,non_centered_im]=findCenterSlice(dir_name);

% imagesc(centered_im);

% figure
% 
% 
% imagesc(centered_im);
% 
% figure
% 
% imagesc(non_centered_im);
% 
% 
% output=getOutPut(non_centered);
% 
% [uniformity, constrast] = getUniformityContrast(non_centered);
% 
% [SNR, ghosting] = getSNRGhosting(non_centered);
% 
% distance=getGeometry(non_centered);
% 
% 
% 
% % [files,accquistion_datetime] = getAccquisitionDateTime(dir_name2 )
% 

% sorted_images =sortDicomImages(dir_name2 )
% tic
% image_dict = sortImagesIntoDict(dir_name2 )
% 
% toc

 test = dailyQAAnalyzer2(dir_name2)