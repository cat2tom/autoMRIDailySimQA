function [file_list,accquistion_datetime_list] = getAccquisitionDateTime(dir_IMA )
%{

This fuction is to get the list of  the accquisition date and study time in
a cell structure and list of all files in another cell structure. 

Input: dir_IMA-the directory where all IMA images were set. 

output: file_list-list of IMA files in the directory

        accquistion_datetime_list-list of acquistion date and time for all
        these file. 

useage:

%}  

% use a cell to hold all file date and files themself.

tmp_datetime={};

tmp_file={};

% list all IMA file regarding the subfolder 

all_file_list=getFileList(dir_IMA);

all_IMA_file=listEPIDDicomFile(all_file_list);


% loop the file list to get all time stamp

for k=1:length(all_IMA_file)
    
    slice_file=all_IMA_file{k};
    
    info=dicominfo(slice_file);

   if isfield(info,'AcquisitionDate') && isfield(info,'StudyTime') % 
    accquisition_date=info.AcquisitionDate;

    study_time=info.StudyTime;
    
    tmp_datetime{k}=strcat( accquisition_date,'_',study_time);
    
    tmp_file{k}=fullfile(slice_file);
   end 
       
    
end 

% unique the cell string 

accquistion_datetime_list=unique(tmp_datetime);

file_list=unique(tmp_file);


end

