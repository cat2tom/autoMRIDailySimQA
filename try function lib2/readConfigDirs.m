function dirs = readConfigDirs(excel_file_name)
%{
Function: Read dirs for autoMRISimQA from an excel file.

Input: excel_file_name-absolute path to the excel file name containign all
dirs.
output: dirs-containg all the path for configration files.
        database jar file=dir{1}
        database path=dir{2}
        database name=dir{3}
        excel tolerance file=dir{4}
        MRI image directory=dir{5}
        pdf directory=dir{6}
        output excel_file=dir{7}

   

%}


[num,txt,raw]=xlsread(excel_file_name,'dirs');

dirs=txt;



end

