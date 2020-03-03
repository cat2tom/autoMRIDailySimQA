 function [centered_slice,non_centered_slice,centered_im,non_centered_im]=findCenterSlice2(same_day_file_list)

%{
This funciton goes through all the images contained in dir_name to find the
center slice position. 

Methodology: define a square at the center of FOV with the side of 10 pixels
long for each slice. Then sum up the pixel values. The maximum and minimum
value correspond to the central slide and slide without crossline. 

Input: dir_name--the directory where *.IMA files sits.
 
output: 
 
      centered_slice-the slice where cross line were seen most clearly
 
      non_centered_slice-the slice where no crossline can be seen.
 
      centered_im: the image matrix for centered slice
 
      non_centered_im: the image matrix for non centered slice.

%}

%1. list all *.IMA files
% dir_name='C:\aitangResearch\MRI daily QA program\sample images\';
tmp_value=[];
% create a map to hold the file name and mean Pixel value
dict=containers.Map();
% list all file name.
tmp1=same_day_file_list;

%2. go through all *.IMA files

for i=1:length(tmp1)
    
        
    full_file_name=tmp1{i};
    
    im=dicomread(full_file_name);
    
    %summed_pixel_value  = getAveragedFOVCenterPixel(im);
    
    summed_pixel_value=sum(im(:));
   
    tmp_values(i)=summed_pixel_value;
        
    dict(num2str( summed_pixel_value))=full_file_name;
    
   
    
end 



max_tmp=max(tmp_values);

min_tmp=min(tmp_values);

% dict(num2str(max_tmp))
% 
% dict(num2str(min_tmp))
centered_slice=dict(num2str(max_tmp));

non_centered_slice=dict(num2str(min_tmp));

centered_im=dicomread(centered_slice);

non_centered_im=dicomread(non_centered_slice);

end
