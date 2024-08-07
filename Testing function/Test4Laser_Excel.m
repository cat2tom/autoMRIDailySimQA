dir_name='C:\aitangResearch\MRI daily QA program\sample images\';

dir_name2='C:\aitangResearch\MRISimQALaser\test images\multi day\'; 

%dir_name2='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\'; % new images from 2016.

dir_name3='K:\temp2\';
[center,non_centered,centered_im,non_centered_im]=findCenterSlice(dir_name2);

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

 [dic,cell,strct] = dailyQAAnalyzerLaser4(dir_name2);
 
 excel_file_name = writeDailyQAToExcelFileLaser('test12.xls',cell );
 
% pdf_report_file_name=generateDailyQAReport(cell,'testax.pdf')

 
 close all