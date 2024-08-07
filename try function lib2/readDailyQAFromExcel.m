function [daily_qa_array,txt,raw]= readDailyQAFromExcel( daily_QA_file_name )
%{
Function: To read daily QA results into a 2D cell. 

Input: daily_QA_file_name-the name of daily QA cell.

output: daily_qa_cell-cell structrue containing all daily QA parameters.



%}

[daily_qa_array,txt,raw]= xlsread( daily_QA_file_name );


end

