function summed_pixel_value  = getAveragedFOVCenterPixel(im)
%{
Summary: To calculate the summed pixel value over a 10 pixel long sqare
located at FOV. The FOV is supposed to be square with even number
dimensiont such as 192x192.
Input: im-image matrix of each slice.
output: 
       summed_pixel_value
%}  

[row_len,col_len]=size(im);




row_center_pixel=uint16(row_len/2);

col_center_pixel=uint16(col_len/2);

square_im=im(row_center_pixel-5:row_center_pixel+5, ......
    col_center_pixel-5: col_center_pixel+5);

summed_pixel_value=sum(square_im(:)); % using 10 pixel length to avoid the changes caused by evapouration.


end

