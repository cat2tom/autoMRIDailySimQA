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

tmp_datetime_cell={}; 

tmp_datetime_array=[];

tmp_file_cell={};

tmp_file_array=[];

% list all IMA file regarding the subfolder 

all_file_list=getFileList(dir_IMA);

all_IMA_file=listEPIDDicomFile(all_file_list);


% loop the file list to get all time stamp

for k=1:length(all_IMA_file)
    
    slice_file=all_IMA_file{k};
    
    time_stamp = getEachSliceTimeStamp(slice_file);
    
    tmp_file_array(k)=slice_file;
    
    tmp_file_cell{k}=slice_file;
    
    tmp_datetime_cell{k}=time_stamp;
    
    tmp_datetime_array(k)=time_stamp;
       
    
end 


% unique the datetime cell 

tmp_datetime_cell2=unique(tmp_datetime_cell);

% go through the uniqued datetime cell

for k=1:length(tmp_datetime_cell2)
    
    % grab each key
    
    key=tmp_datetime_cell{k};
    
    
    % find indices for each key using datetime array
    
    index=find(tmp_datetime_array==key);
    
    
    
    
    
end 


% unique the cell string 

accquistion_datetime_list=unique(tmp_datetime);

file_list=unique(tmp_file);


end

