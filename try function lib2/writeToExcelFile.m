function [ output_args ] = writeToExcelFile(excel_file_name,new_data_cell )
%{

Write an one dimentional cell array to an excel file. If the file exist,
read data from  it and add new data. rewrite the data into it. Assume that
the new data cell has same number colum as the data exisitng in excel file.


%}   


if exist(excel_file_name,'file')
    
    % read the data
    
    [num, txt,raw]=xlsread(excel_file_name);
    
    raw
    
    % the size of orignal data
    
    [row,col]=size(raw);
    
    % Add the data to new one data
    
       
    new_raw={raw;new_data_cell};
    
    fclose('all');
    % write back to the original excelf file
    xlswrite(excel_file_name,new_raw);
    
else
    
    xlswrite(excel_file_name,new_raw);
    
    
end 



end

