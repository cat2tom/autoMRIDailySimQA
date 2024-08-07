function [imq_dic,imq_cell,imq_struct]= dailyQAAnalyzer4(image_dir )
%{
Descripttion: Given a directory path containing all daily QA images,
function store the daily QA resutls into three data structures:dictionary,
cell and structrue. only cell structrue was used by other functions. 

Input: image_dir-directory contains all daily QA images.

ouput:
       imag_dic-dictioary to save the resuls. key: accquistion date/time
                                              value: Vector containg QA
                                              prameters.
       imq_cell-cell constainging date/time, and other QA results. This is
       data structure used by other modules and functions. 

%}  


% create a cell 

image_quality_cell={};

% create a struct

image_quality_struct=struct([]);

% create a dict to hold the data

image_quality_dic=containers.Map();

% get file list for all dates.

image_dict = sortImagesIntoDict(image_dir);

% go through dates

dates=keys(image_dict);

for k=1:length(dates)
    
    key_tmp=dates{k};% get the data/time for one day QA resutls.
    
    file_list=image_dict(key_tmp);% get all image file list corresponding to one day accquistion.
        
    [center,non_centered,centered_im,non_centered_im]=findCenterSlice2(file_list); % sortted to find center and non-center slices.
    
    [image_center,distance_mm_45,distance_mm_135]= getImageCenter( non_centered ); % get geometric parameters
    
    output2 = getOutPut2(non_centered ,image_center );% get output parameters.
    
    [uniformity, contrast,output] = getUniformityContrast3(non_centered,image_center); % get uniformity and contrast parameters.

    [SNR, ghosting,output1] = getSNRGhosting3(non_centered,image_center); % get SNR and ghostining, output1 was not used here.
    
    % Assemble the resqults into array[ SNR  uniformity, contrast, ghosting
    % distance_m_45  distance_m_135  output].
    
    im_quality=[SNR  uniformity  contrast ghosting   distance_mm_45  distance_mm_135  output2] 
    
    % get rid of nan resutls for dict
    if ~any(isnan(im_quality))
        
       image_quality_dic(key_tmp)=im_quality;
       
              
    end 

    % fill the cell in same order and this is the main structue used for
    % the whole program. 
    
    if ~any(isnan(im_quality))
        
       image_quality_cell{k,1}=key_tmp;
       image_quality_cell{k,2}=SNR;
       
       image_quality_cell{k,3}=uniformity;
       
       image_quality_cell{k,4}=contrast;
       
       image_quality_cell{k,5}=ghosting;
       
       image_quality_cell{k,6}=distance_mm_45;
       
       image_quality_cell{k,7}=distance_mm_135;
        
       image_quality_cell{k,8}=output2;
       
                 
    end 
    
    % fill the cell in same order
    if ~any(isnan(im_quality))
        
       image_quality_struct{k}.date=key_tmp;
       
       image_quality_struct{k}.SNR=SNR;
       
       image_quality_struct{k}.uniformity=uniformity;
       
       image_quality_struct{k}.contrast=contrast;
       
    else
        
        % remove the empty element
        
        image_quality_struct{k}=[];
              
    end 
    
    % close all the figures after eache QA analysis
    
    close all;
    
end

   % assign the dictionary structure.
   
   imq_dic=image_quality_dic;
   
   % remove nan cell element first and assign the resutls to cell outptu.
   
   
   image_quality_cell=image_quality_cell(~cellfun('isempty',image_quality_cell));
   
   
   image_quality_cell=reshape(image_quality_cell,[],8); % reshape it to have 8 coloumn.
   
   imq_cell=image_quality_cell;
   
   % Assign QA resutls to structure quality. 
   
   imq_struct=image_quality_struct;

end 
