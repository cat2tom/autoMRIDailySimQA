function  emailMonitorDailyQAMatrix(daily_qa_cell,tol_file,tol_type,email_list)
%{
 To generate pdf report for MRIsim daily QA. 
The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

Input: daily_QA_cell-2D matrix holding daily qa resutls. (only for one
       day).
       tol_file-the excel file name holding tolerance. 
       tol_type-the type of tolerance. 'Per'or 'Val'

Output: pdf_report_file_name: the name of pdf report. 

notice Dir version is to save pdf report to a directory.
       This version has no images added to the pdf report.

%}

 % cell holding the parameters being out of tolerance.
 
 out_tolerance_parameters='The following parameters: ';
 
 out_tolerance_parameters1=out_tolerance_parameters; % hold a copy for judgement. 
 

 %% read tolerance and reference from file 
 
 tolerance=xlsread(tol_file); % need to modify to add tolerance for lasers.
 
%% The tolerance is threshold type. Only this situation did the laser support.
 snr_tol_low=tolerance(1,1);
 snr_tol_high=tolerance(2,1);
 snr_ref=tolerance(3,1);
 
 uniformity_tol_low=tolerance(1,2);
 uniformity_tol_high=tolerance(2,2);
 uniformity_ref=tolerance(3,2);
 
 contrast_tol_low=tolerance(1,3);
 contrast_tol_high=tolerance(2,3);
 contrast_ref=tolerance(3,3);
 
 
 ghosting_tol_low=tolerance(1,4);
 ghosting_tol_high=tolerance(2,4);
 ghosting_ref=tolerance(3,4);
 
 d45_tol_low=tolerance(1,5);
 d45_tol_high=tolerance(2,5);
 d45_ref=tolerance(3,5);
 
 
 d135_tol_low=tolerance(1,6);
 d135_tol_high=tolerance(2,6);
 d135_ref=tolerance(3,6);
 
 output_tol_low=tolerance(1,7);
 output_tol_high=tolerance(2,7);
 output_ref=tolerance(3,7);
 
 laser_x_tol_low=tolerance(1,8); % added laser support.
 laser_x_tol_high=tolerance(2,8);
 laser_x_ref=tolerance(3,8);
 
 laser_y_tol_low=tolerance(1,9);
 laser_y_tol_high=tolerance(2,9);
 laser_y_ref=tolerance(3,9);
 
 laser_z_tol_low=tolerance(1,10);
 laser_z_tol_high=tolerance(2,10);
 laser_z_ref=tolerance(3,10);
 
 
 
 % read the qa results from a structure.
 
 day_time=daily_qa_cell(1);
 
 day_time=num2str(day_time);
 
 snr=daily_qa_cell(2);
 
 uniformity=daily_qa_cell(3);
 
 contrast=daily_qa_cell(4);
 
 ghosting=daily_qa_cell(5);
 
 d45=daily_qa_cell(6);
 
 d135=daily_qa_cell(7);
 
 output=daily_qa_cell(8);
 
 laser_x=daily_qa_cell(9);% added laser support
 
 laser_y=daily_qa_cell(10);
 
 laser_z=daily_qa_cell(11);

%% correct criteria.

if strcmp(tol_type,'Val')
    % SNR
    if snr>=abs(snr_ref-snr_tol_low) && snr_ref<=abs(snr_ref+snr_tol_low) 
        
        %green
        
    end
    
    if (snr< abs(snr_ref-snr_tol_low) && snr>=abs(snr_ref-snr_tol_high)) || (snr>abs(snr_ref+snr_tol_low) && snr<=abs(snr_ref+snr_tol_high)) % set 10% as yellow
        
        %yellow.
        
    end
    
    if snr<abs(snr_ref-snr_tol_high) || snr>abs(snr_ref+snr_tol_high) % set 10% as yellow
        
         out_tolerance_parameters=strcat(out_tolerance_parameters,',SNR '); 
        
    end
    
    % uniformity 5% and 10%
    
    if uniformity>=abs(uniformity_ref-uniformity_tol_low) && uniformity<=abs(uniformity_ref+uniformity_tol_low)  % set 3% tolerance
        
        %green
        
    end
    
    if (uniformity< abs(uniformity_ref-uniformity_tol_low) && uniformity>=abs(uniformity_ref-uniformity_tol_high)) || (uniformity>abs(uniformity_ref+uniformity_tol_low) && uniformity<=abs(uniformity_ref+uniformity_tol_high))%
        
       %yellow
        
    end
    
    if (uniformity<abs(uniformity_ref-uniformity_tol_high)) || (uniformity>abs(uniformity_ref+uniformity_tol_high))% set 3% as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', Uniformity ');
        
    end
    
    % contrast tolerance 10% and 15 %of baseline.
    
    if contrast>=abs(contrast_ref-contrast_tol_low) && contrast<=abs(contrast_ref+contrast_tol_low)  %
        
      %green
        
    end
    
    if (contrast<abs(contrast_ref-contrast_tol_low) && contrast>=abs(contrast_ref-contrast_tol_high))|| (contrast>abs(contrast_ref+contrast_tol_low) && contrast<=abs(contrast_ref+contrast_tol_high)) % set 10% tolerance
        
      %yellow
        
    end
    
    if contrast<abs(contrast_ref-contrast_tol_high) || contrast>abs(contrast_ref+contrast_tol_high) % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', Contrast ');
        
    end
    
  
    
    % use different criteria for ghosting instead using std.
    
    if ghosting<=ghosting_tol_low  %
        
       %green 
        
    end
    
    if ghosting>ghosting_tol_low && ghosting<=ghosting_tol_high 
        
       %yellow
        
    end
    
    if ghosting>ghosting_tol_high 
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', Ghosting');;
        
    end
    
        
    
    
    %d45 tolerance +/-2mm
    
    if d45>=abs(d45_ref-d45_tol_low) && d45<=abs(d45_ref+d45_tol_low) %
        
       %green
        
    end
    
    if (d45<abs(d45_ref-d45_tol_low) && d45>=abs(d45_ref-d45_tol_high)) ||(d45>abs(d45_ref+d45_tol_low) && d45<=abs(d45_ref+d45_tol_high)) 
        
        %yellow.
        
    end
    
    if d45<abs(d45_ref-d45_tol_high) || d45>abs(d45_ref+d45_tol_high);%
        
         out_tolerance_parameters=strcat(out_tolerance_parameters,', D45 ');
        
    end
    
    %d135 tol: +/-2mm
    
    if d135>=abs(d135_ref-d45_tol_low) && d135<=(d135_ref+d45_tol_low) %
        
       %green
        
    end
    
    if (d135<abs(d135_ref-d135_tol_low) && d135>=abs(d135_ref-d135_tol_high)) || (d135>abs(d135_ref+d135_tol_low) && d135<=abs(d135_ref+d135_tol_high))
        
       %yellow.
        
    end
    
    if d135<abs(d135_ref-d135_tol_high) || d135>abs(d135_ref+d135_tol_high)%
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', D135 ');
        
    end
    
    % output tol: 5% and 10%
    
    if output>=abs(output_ref-output_tol_low) || output<=abs(output_ref+output_tol_low) % set 5% threshould
        
       %green
        
    end
    
    if (output<abs(output_ref-output_tol_low) &&  output>=abs(output_ref-output_tol_high)) ||(output>abs(output_ref+output_tol_low) &&  output<=abs(output_ref+output_tol_high))
        
       %yellow.
        
    end
    
    if output<abs(output_ref-output_tol_high) ||output>abs(output_ref+output_tol_high)   % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', Output ');
        
    end
    
    % laser x, y, z
%     %% for x

    if laser_x>=abs(laser_x_ref-laser_x_tol_low ) && laser_x<=abs(laser_x_ref+laser_x_tol_low ) % set 5% threshould
        
        %green
        
    end
    
    if (laser_x<abs(laser_x_ref-laser_x_tol_low) &&  laser_x>=abs(laser_x_ref-laser_x_tol_high))||(laser_x>abs(laser_x_ref+laser_x_tol_low) &&  laser_x<=abs(laser_x_ref+laser_x_tol_high))
        
      %yellow.
        
    end
    
    if laser_x<abs(laser_x_ref-laser_x_tol_high) || laser_x>abs(laser_x_ref+laser_x_tol_high)  % set 10 %as yellow
        
         out_tolerance_parameters=strcat(out_tolerance_parameters,', LaserX ');
        
    end
%     
%     % for y is fixed the range should be 0,4,6 mm.
%     
%      if laser_y>=abs(laser_y_ref-laser_y_tol_low) && laser_y>=abs(laser_y_ref+laser_y_tol_low) % set 5% threshould
%         
%         r2c10.setBackgroundColor(BaseColor.GREEN);
%         
%     end
%     
%     if (laser_y<abs(laser_y_ref-laser_y_tol_low) && laser_y>=abs(laser_y_ref-laser_y_tol_high))||(laser_y>abs(laser_y_ref+laser_y_tol_low) && laser_y<=abs(laser_y_ref+laser_y_tol_high))
%         
%         r2c10.setBackgroundColor(BaseColor.YELLOW);
%         
%     end
%     
%       
%     
%     if laser_y<abs(laser_y_ref-laser_y_tol_high) || laser_y>abs(laser_y_ref+laser_y_tol_high)  % set 10 %as yellow
%         
%         r2c10.setBackgroundColor(BaseColor.RED);
%         
%     end
    
    %% use reference value instead of std.
    
     if laser_y>=-abs(laser_y_tol_low) && laser_y<=abs(laser_y_tol_low) % set 5% threshould
        
        %green
        
     end
    
       
    if (laser_y<-abs(laser_y_tol_low) && laser_y>=-abs(laser_y_tol_high))||(laser_y>abs(laser_y_tol_low) && laser_y<=abs(laser_y_tol_high))
        
       %yellow.
        
    end
    
     
    if (laser_y < -abs(laser_y_tol_high)) || laser_y>abs(laser_y_tol_high)  % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', LaserY ');
        
    end
    
    
%     % for z
%     
   
     if laser_z>=abs(laser_z_ref-laser_z_tol_low) && laser_z<=abs(laser_z_ref+laser_z_tol_low) % set 5% threshould
        
        %green
        
    end
    
    if (laser_z<abs(laser_z_ref-laser_z_tol_low) &&  laser_z>=abs(laser_z_ref-laser_z_tol_high)) || (laser_z>abs(laser_z_ref+laser_z_tol_low) &&  laser_z<=abs(laser_z_ref+laser_z_tol_high))
        
        %yellow;
        
    end
    
    if laser_z<abs(laser_z_ref-laser_z_tol_high) || laser_z>abs(laser_z_ref+laser_z_tol_high)  % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,', LaserZ ');
        
    end

end 









%% 
 
 
% if two string are not equal, it means that some parameters is out of
% tolerance. 

 if ~strcmp(out_tolerance_parameters,out_tolerance_parameters1)

   out_tolerance_parameters2=strcat(out_tolerance_parameters,' : are out of tolerance for day: ');
 
   out_tolerance_parameters3=strcat(out_tolerance_parameters2,' ',day_time,'.','',10, 'See the pdf report for details which was saved at N:\PROJECTS\MRI Sim project\autoMRISimQA\dailyQAPDFReport ', 10,'  Auto email inform. Please do not reply.');  
 
 

 % send an-email
 
   %% e-mail subject
 
   subject=strcat('The MRISimQA is out of tolernce for day:','  ', day_time,'.');
   
   bodytext=out_tolerance_parameters3;
   
   sendEmailWithOutlook(email_list,subject,bodytext, 0)
   
 end 

end 

   
 
 

