function detectFileCallBack(src, eventdata, dirName, dirLength,fileList0)
%{

The call back function for detectFile which is used to check the update of
files in a directory.

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
    
    % list all the files only. 
    dirData = dir(dirName);      
    dirIndex = [dirData.isdir];   
    fileList = {dirData(~dirIndex).name}';  
    
    % new file list
    
    new_file_list=setdiff(fileList,fileList0);
    
    % process for each new files if the new file list is not empty.
    
    for k=1:length(new_file_list)
        
        % get new full file name for each file
        
        full_file_name=fullfile(dirName,new_file_list(k))
        
        % process for each file
        
            
    end 
    
  
     
else
    
    disp('No new files')
    
end
end
