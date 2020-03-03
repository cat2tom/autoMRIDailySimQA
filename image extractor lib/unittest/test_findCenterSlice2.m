
% test dir

 test_dir='C:\autoMRISimDailyQA\test images\one day';
 
 image_dir_name=test_dir;
 
 % get file list into cell
 
dir_content =dir(image_dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;

file_list={};

for k=1:length(filenames)
    
    file_list{k}=fullfile(test_dir,filenames{k});
    
    
end 


[centered_slice,non_centered_slice,centered_im,non_centered_im]=findCenterSlice2(file_list);

%imshow(non_centered_im);

slice_file_name=non_centered_slice;

[image_center,distance_mm_45,distance_mm_135]= getImageCenter( slice_file_name );

[PIU,contrast,output] = getUniformityContrast3(slice_file_name,image_center )

    
    
