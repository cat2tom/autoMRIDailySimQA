%{

The script is used to process multiday Daily QA images in batch mode. 


%}


% load all necessary jar files.

loadJARs;

% specifiy the directory where all daily MRI images are stored.

%dir_name2='C:\aitangResearch\MRISimQA\test images\one day';


% dir_name2='C:\aitangResearch\MRISimQA\test images\multi day'; 

% dir_name2='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\';

%dir_name2='K:\Aitang\2016 laser images\unknown\';

dir_name2='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\'; % new images from 2016.

%dir_multiday='C:\aitangResearch\MRISimQALaser\test images\multi day\';


%dir_name2='K:\Aitang\Bridge_Laser_QA\unknown\MR\unknown\unknown\';

% specify the pdf output directory

pdf_dir='C:\aitangResearch\MRISimQALaser\test images\pdf output\';

% Specify the excel output resutls.

excel_file='C:\aitangResearch\MRISimQALaser\test images\excel output\QA2016.xls';

% specifiy the where the database jar file and location.

javaaddpath('C:\aitangResearch\MRISimQALaser\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRISimQALaser\database\';

db_name='MRISimQADBLaser.db';

%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBaseLaser(abs_path,db_name );

% call main fucntion to write all daily QA resutls into a cell.

   [dic,cell,strct] = dailyQAAnalyzerLaser4(dir_name2);
   
   close all;
   
% specify where the tolerance file is.

tol_file2='C:\aitangResearch\MRISimQALaser\tolerance\tolerance_absolute.xlsx'; % test laser tolerance.

% use cell containing QA resutls to write to an excel
           
 writeDailyQAToExcelFileLaser(excel_file,cell);

 
 % write to database
 
  %% ceate daily QA table if it does not exist.
             
  db_connection= createDailyQATableLaser(db_connection );
            
 %% write QA results into a database.
            
 db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);
             
  
 % generate all pdf report. 

 generateMultiDailyQAReportTolDirLaser(cell,tol_file2,'Val',pdf_dir); % for laser support only 'val' type.
 
 close all