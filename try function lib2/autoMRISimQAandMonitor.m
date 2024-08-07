%{

Description: Use an infinite loop to monitor the change of directory and
call the main function to process the new images and save the resutls into
pdf, an excel sheet and database.

To stop the loop enter Ctrl-C.

Notice: added to write to an excel file and a database.

        added laser support.

        New version reads the dirs file from an excel file saved in
        network. 
        This is the main function of the program to autoAnalyze the daily
        QA resutls and monitor the results. 
        
        The program can be run on single computer.
%}

% read dirs from excel configure files

dirs=readConfigDirs('N:\PROJECTS\MRI Sim project\autoMRISimQA\dirsConfigFile\dirsConfigFile.xlsx');

database_jar_file=dirs{1};

database_path=dirs{2};

database_name=dirs{3};

excel_tolerance_file=dirs{4};

MRI_image_dir=dirs{5};

pdf_report_output_dir=dirs{6};

excel_output_file=dirs{7};

% read an email list from an excel file.

email_list=readEmailList('N:\PROJECTS\MRI Sim project\autoMRISimQA\emailListConfigFile\emailListConfigFile.xlsx');

% loading java packages.

loadJARs;

% specifiy the database stuff

javaaddpath(database_jar_file);


%create a conection and create the database if it does not exist.

[db_connection,file] = createSQLDataBaseLaser(database_path,database_name);


% Call the main function which processing the images, extracting QA
% parameter, writing QA resutls into database and generating PDF report. 


autoImageProcessLoopDatabaseLaser(MRI_image_dir, db_connection,excel_output_file,pdf_report_output_dir,excel_tolerance_file);

pause(10);

% start auto monitoring program.

autoMonitorMRISimDailyQAFunction(dirs,email_list);



