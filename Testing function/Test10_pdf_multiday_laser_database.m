%{

This script is to test the core function, database, excel and pdf report. Can be used to deterimine the 
tolerance for each parameters using standard deviations.
%}
loadJARs;
dir_name='C:\aitangResearch\MRISimQA\test images\one day';
% dir_name2='C:\aitangResearch\MRISimQA\test images\multi day'; 

% new MRI images

% dir_name2='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\';

%  dir_name2='K:\Aitang\2016 laser images\unknown\';

dir_name2='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\'; % new images from 2016.


dir_name3='K:\temp2\';

dir_multiday='C:\aitangResearch\MRISimQALaser\test images\multi day\';

pdf_dir='C:\aitangResearch\MRISimQALaser\test images\pdf output\';

% excel file 
excel_file='C:\aitangResearch\MRISimQALaser\test images\excel output\QA2016.xls';


% database stuff

javaaddpath('C:\aitangResearch\MRISimQALaser\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRISimQALaser\database\';

db_name='MRISimQADBLaser.db';

%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBaseLaser(abs_path,db_name );


%[center,non_centered,centered_im,non_centered_im]=findCenterSlice(dir_name);

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
   
   close all;
%  excel_file_name = writeDailyQAToExcelFile('test11.xls',cell );

%cell={'2_12_15',1.2809,92.1358,0.70,0.0179,96.1712,90.5352,6.2614};
% cell_tol={1.3809,96.1358,0.8434,0.0178,92.1712,91.5352,6.7614};

 
% pdf_report_file_name=generateDailyQAReport(cell,cell_tol);

% tol_file1='tolerance_percentage.xlsx';
% tol_file2='tolerance_absolute.xlsx';
tol_file2='C:\aitangResearch\MRISimQALaser\tolerance\tolerance_absolute.xlsx'; % test laser tolerance.

% use cell containing QA resutls to write to an excel
           
 writeDailyQAToExcelFileLaser(excel_file,cell);

 %pdf_report_file_name=generateDailyQAReportTol(cell,tol_file2,'Val');
 
 % write to database
 
  %% ceate daily QA table if it does not exist.
             
  db_connection= createDailyQATableLaser(db_connection );
            
 %% write QA results into a database.
            
 db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);
             
  
 % pdf report

 generateMultiDailyQAReportTolDirLaser(cell,tol_file2,'Val',pdf_dir); % for laser support only 'val' type.
 
 close all