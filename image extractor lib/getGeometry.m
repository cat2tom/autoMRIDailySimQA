function distance = getGeometry(slice_file_name )
%{ 

This function is to calculate the distance between two physical points on
non-centered slice. The physics distance is 12cm. 

Input: slice_file_name-the full file path name containing the non-centered
slice.

output: distance-distance in mm. 
%}


%1.load image and find pixel size
I=dicomread(slice_file_name);
pxl_sz=fun_DICOMInfoAccess(slice_file_name,'PixelSpacing');
if pxl_sz(1,1)~=pxl_sz(2,1)
    h=errordlg(['Your image is not isotropic!'...
        'Please check pixel size. I continue from here though.']);
    uiwait(h);
end

%2. find the center of FOV in pixel

% lenght and with of square and separations


[row,col]=size(I);

x_center_px=uint16(col/2);

y_center_px=uint16(row/2);

% 3.  set a rectagular parameters 

xmin=1;
xmax=col;%
width_pxl=20;% 20 pixels wide

ymin=y_center_px-width_pxl/2-4;% shifted up by 4 pixel.
ymax=y_center_px+width_pxl/2;


%4. create centered rectangle

sqx1=[xmin xmin xmax xmax xmin];
sqy1=[ymin ymax ymax ymin ymin];
BW_1=roipoly(I,sqx1,sqy1);
ROI_1=fun_apply_mask(I,BW_1);
%figure 


%5.define circle intensity range for distribution fitness

I2=ROI_1;
intensity_high=max(max(I2));
intensity_low=intensity_high/2.5;%HW:low Int range is 1/2.5 of max Int (or 1/3)
mu=fun_MagIQ_FindCircleMean(I2,intensity_low,intensity_high,'Rician',0);
I_thres=add_threshold(I2,mu/2);

%6.identify the centroids
I_p=bwmorph(I_thres,'shrink',Inf);
s=regionprops(I_p,'centroid');%result starts left & from top to bottom

%7.re-order pts coordinate

p_coord=zeros(4,2); % order is : first left point(y,x) to the rigght last point.
for i=1:size(s,1)
    p_coord(i,1)=s(i).Centroid(1);
    p_coord(i,2)=s(i).Centroid(2);
end

%8. calculated the distance two inner point in pixel and mm

distance_pxl=sqrt((p_coord(2,1)-p_coord(3,1))^2+(p_coord(2,2)-p_coord(3,2))^2);


delta_x_mm=(p_coord(2,1)-p_coord(3,1))*pxl_sz(2,1);

delta_y_mm=(p_coord(2,2)-p_coord(3,2))*pxl_sz(1,1);


distance_mm=sqrt(delta_x_mm^2+delta_y_mm^2);

distance=distance_mm;


%4. Plot images for visulization.


imH=figure;

imshow(I,[]);
hold on;

plot(p_coord(:,1), p_coord(:,2),'r');

hold off;

close(imH);

end

