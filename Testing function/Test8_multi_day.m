%{

This test is to test the main functions: generateMultiDailyQAReportTol
which requires output from dailyQAAnalyzer4. 


%}


% have to load the all JARs in a different matlab scripts other wise it
% will not works. These jars for PDF and database java packages.

loadJARs;

% list the directories for imaging process

dir_name='C:\aitangResearch\MRISimQA\test images\one day';
dir_name2='C:\aitangResearch\MRISimQA\test images\multi day'; 

dir_name3='K:\temp2\';

% Analyzer doing the main jobs

[dic,cell,strct] = dailyQAAnalyzer4(dir_name2); % cell is a dict containing all 

 
% specifify where is the tolerace file.

tol_file1='C:\aitangResearch\MRISimQA\tolerance\tolerance_percentage.xlsx';
tol_file2='C:\aitangResearch\MRISimQA\tolerance\tolerance_absolute.xlsx';


generateMultiDailyQAReportTol(cell,tol_file2,'Per');
 
 close all