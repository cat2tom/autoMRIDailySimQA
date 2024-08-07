%{

Description: Use an infinite loop to monitor the change of directory and
call the main function to process the new images and save the resutls into
pdf, an excel sheet and database.

To stop the loop enter Ctrl-C.

Notice: added to write to an excel file and a database.

        added laser support.
%}


% loading java packages.

loadJARs;

% specifiy the database stuff

javaaddpath('C:\aitangResearch\MRISimQALaser\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRISimQALaser\database\';

db_name='MRISimQADBLaser.db';

%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBaseLaser(abs_path,db_name );

% Specifiy where the tolerance files were stored.

tol_file2='C:\aitangResearch\MRISimQALaser\tolerance\tolerance_absolute.xlsx';

% Specify where all laser QA images are stored.

% image_dir='C:\aitangResearch\MRISimQALaser\test images\testdir';

  image_dir='L:\Bridge_Laser_QA\unknown\MR\unknown\unknown\'; % This is the
  
  
% real directory where laser images comes in.

% image_dir='K:\Aitang\2016 laser images\unknown\'; % Test if it works if new images were added.

% specifiy where the pdf report is installed.

pdf_dir='C:\aitangResearch\MRISimQALaser\test images\pdf output';

% specifiy an excel file where all QA results are to be saved.

excel_file='C:\aitangResearch\MRISimQALaser\test images\excel output\DailyQAResultsLaser.xlsx';


% Call the main function which processing the images, extracting QA
% parameter, writing QA resutls into database and generating PDF report. 


autoImageProcessLoopDatabaseLaser(image_dir, db_connection,excel_file,pdf_dir,tol_file2)

