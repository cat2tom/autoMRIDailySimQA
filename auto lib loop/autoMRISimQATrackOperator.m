%{

Description: Use an infinite loop to monitor the change of directory and
call the main function to process the new images and save the resutls into
pdf, an excel sheet and database.

To stop the loop enter Ctrl-C.

Notice: added to write to an excel file and a database.

        added laser support.

        New version reads the dirs file from an excel file saved in
        network. 
        This is the main function of the program.
        On 07/03/2016, the jar files for pdf and database was moved to n
        drive. 
%}

% read dirs from excel configure files

dirs=readConfigDirs('N:/PROJECTS/MRISimProject/autoMRISimQA/dirsConfigFile/dirsConfigFileTest.xlsx');

database_jar_file=dirs{1};

database_path=dirs{2};

database_name=dirs{3};

excel_tolerance_file=dirs{4};

MRI_image_dir=dirs{5};

pdf_report_output_dir=dirs{6};

excel_output_file=dirs{7};

qatrack_exe=dirs{8};

% add all java class path  for compilation. 

% loadJARs;


javaaddpath('N:/PROJECTS/MRISimProject/autoMRISimQA/javaJarFiles/itextpdf-5.5.7.jar','-end')

javaaddpath('N:/PROJECTS/MRISimProject/autoMRISimQA/javaJarFiles/itext-pdfa-5.5.7.jar','-end')

javaaddpath('N:/PROJECTS/MRISimProject/autoMRISimQA/javaJarFiles/itext-xtra-5.5.7.jar','-end')

javaaddpath('N:/PROJECTS/MRISimProject/autoMRISimQA/javaJarFiles/sqlite-jdbc-3.8.11.2.jar','-end')


javaaddpath('N:/PROJECTS/MRISimProject/autoMRISimQA/javaJarFiles')

% qatrack_exe='C:\aitangResearch\MRISimQALaserNoImageClinic\updateQATracker\dist\updateQATrack.exe';

% load java packages.
% loadJARs;

%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBaseLaser(database_path,database_name);


% Call the main function which processing the images, extracting QA
% parameter, writing QA resutls into database and generating PDF report. 


autoImageProcessLoopDatabaseLaserTrack(MRI_image_dir, qatrack_exe,db_connection,excel_output_file,pdf_report_output_dir,excel_tolerance_file);

