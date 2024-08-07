dir_name='C:\aitangResearch\MRI daily QA program\sample images\';

dir_name2='\\ctcphapp01\DCM_RESEARCH_DATA\zzzz_bridge_laser_QA\'; 

dir_name3='K:\temp2\';

dir_oneday='C:\aitangResearch\MRISimQALaser\test images\one day\';

[center,non_centered,centered_im,non_centered_im]=findCenterSlice(dir_oneday);

pdf_dir='C:\aitangResearch\MRISimQALaser\test images\pdf output\';



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

   [dic,cell,strct] = dailyQAAnalyzerLaser4(dir_oneday);
%  
%  excel_file_name = writeDailyQAToExcelFile('test11.xls',cell );

% cell={'2_12_15',1.2809,92.1358,0.70,0.0179,96.1712,90.5352,6.2614};
% cell_tol={1.3809,96.1358,0.8434,0.0178,92.1712,91.5352,6.7614};

 
% pdf_report_file_name=generateDailyQAReport(cell,cell_tol);

%tol_file1='tolerance_percentage.xlsx';
tol_file2='C:\aitangResearch\MRISimQALaser\tolerance\tolerance_absolute.xlsx'; % test laser tolerance.

email_list={'aitang.xing@gmail.com','Aitang.Xing@sswahs.nsw.gov.au'};

emailMonitorDailyQATolDirLaser(cell,tol_file2,'Val',email_list);
pdf_report_file_name=generateDailyQAReportTolDirLaser(cell,tol_file2,'Val', pdf_dir);

% generateMultiDailyQAReport(cell,tol_file)
 
 close all