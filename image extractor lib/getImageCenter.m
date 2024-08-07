function [image_center,distance_mm_45,distance_mm_135]= getImageCenter( slice_file_name )
%{

Description: This function is to get the coordinates of image center and 
two diagnal distances.

Input: slice_file_nanme-the center-slice file name
Output: image_center-coodinates of image center
        distance_mm_45-the forward diagnal distance
        distance_mm_135-the backward diangal distance

 Note: added support if the images are not properly accquired.

%}  

%load image and find pixel size
I=dicomread(slice_file_name);
pxl_sz=fun_DICOMInfoAccess(slice_file_name,'PixelSpacing');
if pxl_sz(1,1)~=pxl_sz(2,1)
    h=errordlg(['Your image is not isotropic!'...
        'Please check pixel size. I continue from here though.']);
    uiwait(h);
end



% get the image matrix

im=dicomread(slice_file_name);

% get shreshold 

level=graythresh(im);

% convert to BW 

bw=im2bw(im,level);

% set element structure and closing images

se=strel('disk',5);

closed_bw=imclose(bw,se);

% open the image to remove two small dots

opened_bw=imopen(closed_bw,se);



% get the centroid of region

region_prop=regionprops(opened_bw,'Centroid'); % Centroid ordered from top to bottom 
                                               %then left to right.

% get the x, y of centroids for points: LT,LB, RT,RB

if ~isempty(region_prop) && length(region_prop)==4 % added equal conditions if the four high constrast regions not found and in some case then non-centered slice is not as normal before.

   % get the x, y of centroids for points: LT,LB, RT,RB
   LTx=region_prop(1).Centroid(1);

   LTy=region_prop(1).Centroid(2);

   LBx=region_prop(2).Centroid(1);

   LBy=region_prop(2).Centroid(2);

   RTx=region_prop(3).Centroid(1);

   RTy=region_prop(3).Centroid(2);

   RBx=region_prop(4).Centroid(1);

   RBy=region_prop(4).Centroid(2);
   
   
   
   % calculate the image center

    LX_mean=(LTx+LBx)/2; % x averaged two points on left

    RX_mean=(RTx+RBx)/2; % x averaged two points on right


    TY_mean=(LTy+RTy)/2; % y averaged two points on Top

    BY_mean=(LBy+RBy)/2; % y averaged two points on bottom


    x_pixel=LX_mean+(RX_mean-LX_mean)/2;

    y_pixel=TY_mean+(BY_mean-TY_mean)/2;


    image_center=[x_pixel  y_pixel];

% calculate the 45 degree and 135 degree diagnal distance


  % 45 diagnal distance in mm
  
    delta_x_mm_45=(RTx-LBx)*pxl_sz(2,1);

   delta_y_mm_45=(LBy-RTy)*pxl_sz(1,1);


   distance_mm_45=sqrt(delta_x_mm_45^2+delta_y_mm_45^2);
   
   
   % baseline 
   
   d45_reference=90.7;
   
   d45_low_value=90.7-90.7*0.05;
   
   d45_high_value=90.7+90.7*0.05;
   
   if  distance_mm_45< d45_low_value || distance_mm_45>d45_high_value
       
       
        distance_mm_45=90.7;
   end 

  
  %135 diagnal distance in mm
  
   delta_x_mm_135=(RBx-LTx)*pxl_sz(2,1);

   delta_y_mm_135=(RBy-LTy)*pxl_sz(1,1);


   distance_mm_135=sqrt(delta_x_mm_135^2+delta_y_mm_135^2);

   if  distance_mm_135< d45_low_value || distance_mm_135>d45_high_value
       
       
        distance_mm_135=90.7;
   end 


   % visual show.

   imH=figure;
   imshow(opened_bw);

   hold on ;


   for k=1:length(region_prop)
    
       plot(region_prop(k).Centroid(1),region_prop(k).Centroid(2),'r*');
    
    
   end 

   plot(x_pixel,y_pixel,'g*');
   
   hold off;
   
     
   close(imH);
   
  

else
    
    image_center=[size(I,2)/2, size(I,1)/2];% using FOV center instead.
    
    distance_mm_135=0;% set 0mm distance in this case.
    
    distance_mm_45=0; 
    
    
end 




end

