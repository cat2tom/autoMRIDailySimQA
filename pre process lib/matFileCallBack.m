
function matFileCallBack(image_dir_name, qatrack_exe, db_connection,excel_file,pdf_dir,tol_file2)

%{
Description: This function is to establish the matFile for the situaton in
which a lot of pevious QA file exists. 

Input: image_dir_name-directory where all MRI images are stored. 

       pdf_dir-direcory where the pdf reports are stored.

       exel_file-excel file name with full path where QA resutls were saved.

       tol_file2-the tolerance file


Notice: this version has no images added to the pdf report. 
        added write to excel file function. 

        added database connection.
        added laser support.
        added file list support. Save a file list into a .mat file. Then 
        Next time when the server restarts, it will pick up whatever was
        left last time. 
        

%}

% Read file from the matfile to get the file list last time 

previousFileList={}; % holding the file list before the loop start

% mat file is located in N drive.

mat_file='N:/PROJECTS/MRISimProject/autoMRISimQA/matFile/imageListCell.mat';

if exist(mat_file,'file')==2
    
    
   delete(mat_file); % if the file exists, then delete it.
    
    
else   
    
     save(mat_file,'previousFileList');
    
end 



% get the file list before loop starts.

dir_content =dir(image_dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;


current_files = filenames;


% pre process the file list before loop starts.

pNewFileList=setdiff(current_files,previousFileList);


% after finished write the differnce to file


previousFileList=[ previousFileList; pNewFileList(:) ]; % flatten the file and concatenate two files. 


save(mat_file,'previousFileList');

% use an infinite loop to keep the things always going. 

disp('New matFile was established.');

end