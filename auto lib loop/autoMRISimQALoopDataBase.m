%{

Description: Use an infinite loop to monitor the change of directory and
call the main function to process the new images and save the resutls into
pdf, an excel sheet and database.

To stop the loop enter Ctrl-C.

Notice: added to write to an excel file and a database.
%}


% loading java packages.

loadJARs;

% specifiy the database stuff

javaaddpath('C:\aitangResearch\MRISimQA\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRISimQA\database\';

db_name='MRISimQADB.db';

%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBase(abs_path,db_name );

% Specifiy where the tolerance files were stored.

tol_file2='C:\aitangResearch\MRISimQA\tolerance\tolerance_absolute.xlsx';

% Specify where all laser QA images are stored.

image_dir='C:\aitangResearch\MRISimQA\test images\testdir';

% specifiy where the pdf report is installed.

pdf_dir='C:\aitangResearch\MRISimQA\test images\pdf output';

% specifiy an excel file where all QA results are to be saved.

excel_file='C:\aitangResearch\MRISimQA\test images\excel output\DailyQAResults.xlsx';


% Call the main function which processing the images, extracting QA
% parameter, writing QA resutls into database and generating PDF report. 


autoImageProcessLoopDatabase(image_dir, db_connection,excel_file,pdf_dir,tol_file2)

