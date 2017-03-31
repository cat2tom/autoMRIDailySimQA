function [laser_x,laser_y,laser_z]= getLaserCoordinates_laserReferenceAdjustbefore( slice_file_name )
%{

Description: To get the laser coordinates (x,y,z). Y is logintudinal, x is
from left to right and Z is point up. 

Input: slice_file_nanme-the center-slice file name
Output: laser coordinates for (x,y,z) in mm.
       

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

if ~isempty(region_prop) && length(region_prop)==4 % added equal conditions if the four high constrast regions not found.
   
       % in some case then non-centered slice is not as normal before.

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
    
     

   % visual show

   imH=figure();
   imshow(opened_bw);

   hold('on');


   for k=1:length(region_prop)
    
       plot(region_prop(k).Centroid(1),region_prop(k).Centroid(2),'r*');
    
    
   end 

   plot(x_pixel,y_pixel,'g*');
   
   hold('off');
   
   close(imH);

else
    
    image_center=[size(I,2)/2, size(I,1)/2];% using FOV center instead.
    
   
    
end

    x_mm=image_center(1)*pxl_sz(2,1); % changed pixel coordinate to mm for x
    
    z_mm=image_center(2)*pxl_sz(1,1); % changed pixel coordinate to mm for z
    
    % get y coordinates
    
    info=dicominfo(slice_file_name); % get dicom header information
    
    y_location=info.SliceLocation*info.SliceThickness; % get y coordinates.

    
    laser_x=x_mm;
    
%     laser_y=y_location;
    
    laser_y=abs(y_location); % get absolute value of Y.
    
    laser_z=z_mm;

end

