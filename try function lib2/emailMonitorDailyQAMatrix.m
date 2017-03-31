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



if strcmp(tol_type,'Val')
    % SNR
    if snr>=snr_tol_low
        
       % green
        
    end
    
    if snr< snr_tol_low && snr>snr_tol_high % set 10% as yellow
        
        % yellow
    end
    
    if snr<snr_tol_high % set 10% as red.
        
       out_tolerance_parameters=strcat(out_tolerance_parameters,',SNR ');    
                
        
    end
    
    % uniformity 5% and 10%
    
    if uniformity>=uniformity_tol_low  % set 3% tolerance
        
        % green
        
    end
    
    if uniformity< uniformity_tol_low && uniformity>uniformity_tol_high %
        
        %yellow
        
    end
    
    if uniformity<=uniformity_tol_high % set 3% as yellow
        
        % out of tolerance
         out_tolerance_parameters=strcat(out_tolerance_parameters,',Uniformity ');  
         %out_tolerance_parameters{end+1}='Uniformity  ';  
         
    end
    
    % contrast tolerance 10% and 15 %of baseline.
    
    if contrast>=contrast_tol_low  %
        
        % green
    end
    
    if contrast<contrast_tol_low && contrast>=contrast_tol_high% set 10% tolerance
        
        % yellow
        
    end
    
    if contrast<=contrast_tol_high % set 10 %as yellow
        
       out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Contrast ');  
%        out_tolerance_parameters{end+1}='Contrast ';   
        
    end
    
    % ghosting 15% and 20% as threshold
    
        
    if ghosting<=ghosting_ref  %
        
        % green
        
    end
    
    if ghosting>ghosting_ref && ghosting<=ghosting_tol_low% set 15% tolerance
        
      % yellow
        
    end
    
    if ghosting>ghosting_tol_high % set 15 %as yellow
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Ghosting ');  
        %out_tolerance_parameters{end+1}='Ghosting  ';  
        
    end
    
    %d45 tolerance +/-2mm
    
    if d45<=d45_ref+2 && d45>=d45_ref-2 %
        
       % green
        
    end
    
    if (d45<=d45_ref+3 && d45>d45_ref+2) || (d45>=d45_ref-3 && d45<d45_ref-2)
        
        % yellow
        
    end
    
    if d45>d45_ref+3 || d45<d45_ref-3%
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,D45 ');  
        %out_tolerance_parameters{end+1}='D45  ';  
        
    end
    
    %d135 tol: +/-2mm
    
    if d135<=d135_ref+2 && d135>=d135_ref-2 %
        
       %green
        
    end
    
    if (d135<=d135_ref+3 && d135>d135_ref+2) || (d135>=d135_ref-3 && d135<d135_ref-2)
        
        %yellow
        
    end
    
    if d135>d135_ref+3 || d135<d135_ref-3%
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,D145 ');  
        %out_tolerance_parameters{end+1}='D135 ';  
        
    end
    
    % output tol: 5% and 10%
    
    if output>=output_tol_low % set 5% threshould
        
     %green
        
    end
    
    if output<=output_tol_low &&  output>=output_tol_high
        
       %yellow
        
    end
    
    if output<output_tol_high  % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Output');  
        %out_tolerance_parameters{end+1}='Output ';  
        
    end
    
    % laser x, y, z
%     %% for x
%     
    if laser_x>=laser_x_tol_low % set 5% threshould
        
       %green
        
    end
    
    if laser_x<=laser_x_tol_low &&  laser_x>=laser_x_tol_high
        
        %yellow
        
    end
    
    if laser_x<laser_x_tol_high  % set 10 %as yellow
        
       %red
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Laser X ');  
%         out_tolerance_parameters{end+1}='Laser X ';  
        
    end
%     
%     % for y 
%     
     if laser_y>=laser_y_tol_low % set 5% threshould
        
       %green
        
    end
    
    if laser_y<=laser_y_tol_low &&  laser_y>=laser_y_tol_high
        
       %yellow
        
    end
    
    if laser_y<laser_y_tol_high  % set 10 %as yellow
        
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Laser Y ');  
        %out_tolerance_parameters{end+1}='Laser Y ';   
        
    end
    
%     % for z
%     
   
     if laser_z>=laser_z_tol_low % set 5% threshould
        
        %green
        
    end
    
    if laser_z<=laser_z_tol_low &&  laser_z>=laser_z_tol_high
        
       %yellow
        
    end
    
    if laser_z<laser_z_tol_high  % set 10 %as yellow
        
       %red
        out_tolerance_parameters=strcat(out_tolerance_parameters,' ,Laser Z ');  
        %out_tolerance_parameters{end+1}='Laser Z ';  
        
    end

end 


 out_tolerance_parameters=strcat(out_tolerance_parameters,' : are out of tolerance for day: ');
 
 out_tolerance_parameters=strcat(out_tolerance_parameters,' ',day_time,'.','','\n  Auto email inform. Please do not reply.');  
 
 

 % send an-email
 
   %% e-mail subject
 
   subject=strcat('The MRISimQA is out of tolernce for day:','  ', day_time,'.');
   
   bodytext=out_tolerance_parameters;
   
   sendEmailWithOutlook(email_list,subject,bodytext, 0)

end 

   
 
 

