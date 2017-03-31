    function autoMRISimQACallbackDir(src, eventdata, dirName, dirLength,fileList_last,pdf_dir)
%{

This is the call back function by timer object where main QA function is
performed.

%}


persistent my_dirLength;

persistent my_beginFlag;

 
if isempty(my_beginFlag)

      my_dirLength = dirLength;

      my_beginFlag = 0;

end

if length(dir(dirName)) > my_dirLength
    
    disp('A new file is available')
    
    my_dirLength = length(dir(dirName));
    
    
    % get current file list
    
    dirData_current = dir(dirName);
    dirIndex_current = [dirData_current.isdir];
    fileList_current= {dirData_current(~dirIndex_current).name}' ;
    
    % get new file list
    
    new_files = setdiff(fileList_current,fileList_last);
    
    new_files=fullfile(dirName,new_files)
    
    if ~isempty(new_files) % first to see if the new file list is empty or not.
        
       disp([num2str(length(new_files)) 'new file are  available']) 
       
       
       if rem(length(new_files),10)==0 % as 10 images for each QA, then to see if all 10 images arrived.
                      
           % the key part for auto processing the images and auto report
           % generation.
           
           [dic,cell,strct] = dailyQAAnalyzerFileList(new_files); % cell is a dict containing all
           
           
           % specifify where is the tolerace file.
           
           tol_file1='C:\aitangResearch\MRISimQA\tolerance\tolerance_percentage.xlsx';
           tol_file2='C:\aitangResearch\MRISimQA\tolerance\tolerance_absolute.xlsx';
           
           
           generateMultiDailyQAReportTolDir(cell,tol_file2,'Per',pdf_dir);
           
           close all
           
       end 
       
    end 
        
    
else
    
    disp('No new files')
    
end
