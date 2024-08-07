 function [centered_slice,non_centered_slice,centered_im,non_centered_im]=findCenterSlice(dir_name)

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
 
 Note: added support if the images are not properly accquired.

%}

%1. list all *.IMA files
% dir_name='C:\aitangResearch\MRI daily QA program\sample images\';
tmp_value=[];
% create a map to hold the file name and mean Pixel value
dict=containers.Map();
% list all file name.
tmp1=dir(fullfile(dir_name,'*.IMA'));

%2. go through all *.IMA files

for i=1:length(tmp1)
    
  if ~tmp1(i).isdir
    
    
    full_file_name=fullfile(dir_name,tmp1(i).name);
    
    im=dicomread(full_file_name);
    
    summed_pixel_value  = getAveragedFOVCenterPixel(im);
   
    tmp_values(i)=summed_pixel_value;
        
    dict(num2str( summed_pixel_value))=full_file_name;
    
  end 
    
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
