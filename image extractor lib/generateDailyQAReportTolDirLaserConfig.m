function  pdf_report_file_name=generateDailyQAReportTolDirLaserConfig(daily_qa_cell,tol_file,tol_type,pdf_dir)
%{
 To generate pdf report for MRIsim daily QA. 
The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

Input: daily_QA_cell-Cell structure holding daily qa resutls. (only for one
       day).
       tol_file-the excel file name holding tolerance. 
       tol_type-the type of tolerance. 'Per'or 'Val'

Output: pdf_report_file_name: the name of pdf report. 

notice Dir version is to save pdf report to a directory.
       This version has no images added to the pdf report.

       on 19/02/2016, use standard deviation as threshold.

       On 07/03/2016, the jar files was saved on N drive project folder.

       on 21/04/2016, added config file.

%}


% loading the java package. 
import java.io.FileOutputStream

import java.io.IOException

% In order to make compiled version work, the dynamic path has to be added
% here. 

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/sqlite-jdbc-3.8.11.2.jar')% for compiling.

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itextpdf-5.5.7.jar')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itext-pdfa-5.5.7.jar')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itext-xtra-5.5.7.jar')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itext-xtra-5.5.7.jar')

import com.itextpdf.text.*

import com.itextpdf.text.Document.*

import com.itextpdf.text.DocumentException
import com.itextpdf.text.PageSize.*
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfWriter

import com.itextpdf.text.pdf.PdfPTable

import com.itextpdf.text.pdf.PdfPCell

import com.itextpdf.text.pdf.BaseFont

import com.itextpdf.text.BaseColor

import com.itextpdf.text.Image


% Start of practice of codes. 


% file name
  
f_cb=BaseFont.createFont('c:\\windows\\fonts\\arial.ttf',BaseFont.WINANSI,BaseFont.EMBEDDED);



% document obj

document =Document(PageSize.A4);% set landscape to portrait.

% get page size width and hight

width=PageSize.A4.getWidth();

height=PageSize.A4.getHeight();

% file name using datetiem 

file_name=strcat('MRISim_DailyQA_report_performed on_',daily_qa_cell{1},'.pdf');

file_name=fullfile(pdf_dir,file_name);

% file obj


file_obj=FileOutputStream(file_name);

% associate pdf writer obj with document obj

writer=PdfWriter.getInstance(document,file_obj);
 
 % open the document 
document.open();
  
% get DC object.

cb=writer.getDirectContent(); % establish a direct content.
 
% write head and footer information.

cb.saveState();
color=BaseColor.BLUE;
generateHeadFooterDailyQA(writer,cb,f_cb,width,height,color);
 
cb.restoreState();


document.add(Paragraph(' '));


% table head.

cb.beginText()

cb.setFontAndSize(f_cb,15);
 
 
cb.setTextMatrix(width/2-100,height-200);% left and top (x,y) is the position where to write the text. 
 
cb.showText('MRI simulator daily performance');


cb.endText()


% establish QA table.
a=uint8(11);

table=PdfPTable(a);


table.setWidthPercentage(110);
% 
table.setSpacingBefore(200);


% 
%  table.setSpacingAfter(100);
%  



% table.setWidths([1  1  1 1 1 1 1 1])

%% fill the table head.

cell_font=Font(f_cb,10); % set font size for cell

head1=Paragraph('Date/Time',cell_font);

head2=Paragraph('SNR',cell_font);

head3=Paragraph('Uniformity',cell_font);

head4=Paragraph('Contrast',cell_font);

head5=Paragraph('Ghosting',cell_font);

head6=Paragraph('D45(mm)',cell_font);

head7=Paragraph('D135(mm)',cell_font);

head8=Paragraph('Output',cell_font);

head9=Paragraph('Laser X(mm)',cell_font); % added laser coordinates.

head10=Paragraph('Laser Y(mm)',cell_font);

head11=Paragraph('Laser Z(mm)',cell_font);



% row height

row_height=40;

head_cell1=PdfPCell(head1);
head_cell2=PdfPCell(head2);

head_cell3=PdfPCell(head3);

head_cell4=PdfPCell(head4);

head_cell5=PdfPCell(head5);

head_cell6=PdfPCell(head6);

head_cell7=PdfPCell(head7);

head_cell8=PdfPCell(head8);

head_cell9=PdfPCell(head9); % added laser support.

head_cell10=PdfPCell(head10);

head_cell11=PdfPCell(head11);

% set table row height.

head_cell1.setFixedHeight(row_height);
head_cell2.setFixedHeight(row_height);

head_cell3.setFixedHeight(row_height);

head_cell4.setFixedHeight(row_height);

head_cell5.setFixedHeight(row_height);

head_cell6.setFixedHeight(row_height);

head_cell7.setFixedHeight(row_height);

head_cell8.setFixedHeight(row_height);

head_cell9.setFixedHeight(row_height);

head_cell10.setFixedHeight(row_height);

head_cell11.setFixedHeight(row_height);
%  
% cell3.setBackgroundColor(BaseColor.YELLOW); % change the backgroud color for table cell.


table.addCell(head_cell1);
table.addCell(head_cell2);
table.addCell(head_cell3);
table.addCell(head_cell4);
table.addCell(head_cell5);
table.addCell(head_cell6);
table.addCell(head_cell7);

table.addCell(head_cell8);

% added laser talbe head
table.addCell(head_cell9);% added laser x, y,z.

table.addCell(head_cell10);

table.addCell(head_cell11);

%add the resutls and cell font size 



date_r2c1=Phrase(daily_qa_cell{1},cell_font); % added cell font.

snr_r2c2=Phrase(num2str(daily_qa_cell{2}),cell_font); % convert to string
uniform_r2c3=Phrase(num2str(daily_qa_cell{3}),cell_font);
contrast_r2c4=Phrase(num2str(daily_qa_cell{4}),cell_font);
ghosting_r2c5=Phrase(num2str(daily_qa_cell{5}),cell_font);
d45_r2c6=Phrase(num2str(daily_qa_cell{6}),cell_font);
d45_r2c7=Phrase(num2str(daily_qa_cell{7}),cell_font);
output_r2c8=Phrase(num2str(daily_qa_cell{8}),cell_font);

laserX_r2c9=Phrase(num2str(daily_qa_cell{9}),cell_font); % added laser position support.

laserY_r2c10=Phrase(num2str(daily_qa_cell{10}),cell_font);

laserZ_r2c11=Phrase(num2str(daily_qa_cell{11}),cell_font);

% addef cell font.
r2c1=PdfPCell(date_r2c1);
r2c2=PdfPCell(snr_r2c2);
r2c3=PdfPCell(uniform_r2c3);
r2c4=PdfPCell(contrast_r2c4);
r2c5=PdfPCell(ghosting_r2c5);
r2c6=PdfPCell(d45_r2c6);
r2c7=PdfPCell(d45_r2c7);
r2c8=PdfPCell(output_r2c8);


r2c9=PdfPCell(laserX_r2c9); % added laser position support.
r2c10=PdfPCell(laserY_r2c10);
r2c11=PdfPCell(laserZ_r2c11);

r2c1.setFixedHeight(row_height)
r2c2.setFixedHeight(row_height)
r2c3.setFixedHeight(row_height);
r2c4.setFixedHeight(row_height);
r2c5.setFixedHeight(row_height);
r2c6.setFixedHeight(row_height);
r2c7.setFixedHeight(row_height);
r2c8.setFixedHeight(row_height);
r2c9.setFixedHeight(row_height);% added laser position support.
r2c10.setFixedHeight(row_height);
r2c11.setFixedHeight(row_height);

% set color according to tolerace.

 %% read tolerance and reference from file. Reference=mean. low=2 std;high=3std.
 
 %tolerance=xlsread(tol_file); % need to modify to add tolerance for lasers.
 
 disp('toldict');
 tolDict=readToleranceFile(tol_file); % use config file
 
 snrTol=tolDict('snrTol');
 
 
 snr_tol_low=snrTol(1);
 snr_tol_high=snrTol(2);
 snr_ref=snrTol(3);
 
 uniformTol=tolDict('uniformityTol');
 
 uniformity_tol_low=uniformTol(1);
 uniformity_tol_high=uniformTol(2);
 uniformity_ref=uniformTol(3);
 
 contrastTol=tolDict('contrastTol');
 
 contrast_tol_low=contrastTol(1);
 contrast_tol_high=contrastTol(2);
 contrast_ref=contrastTol(3);
 
 ghostingTol=tolDict('ghostingTol');
 
 ghosting_tol_low=ghostingTol(1);
 ghosting_tol_high=ghostingTol(2);
 ghosting_ref=ghostingTol(3);
 
 d45Tol=tolDict('d45Tol');
 
 d45_tol_low=d45Tol(1);
 d45_tol_high=d45Tol(2);
 d45_ref=d45Tol(3);
 
 d135Tol=tolDict('d135Tol');
 
 d135_tol_low=d135Tol(1);
 d135_tol_high=d135Tol(2);
 d135_ref=d135Tol(3);
 
 outputTol=tolDict('outputTol');
 
 output_tol_low=outputTol(1);
 output_tol_high=outputTol(2);
 output_ref=outputTol(3);
 
 laserXTol=tolDict('laserXTol');
 
 laser_x_tol_low=laserXTol(1); % added laser support.
 laser_x_tol_high=laserXTol(2);
 laser_x_ref=laserXTol(3);
 
 laserYTol=tolDict('laserYTol');
 
 laser_y_tol_low=laserYTol(1);
 laser_y_tol_high=laserYTol(2);
 laser_y_ref=laserYTol(3);
 
 
 laserZTol=tolDict('laserZTol');
 
 laser_z_tol_low=laserZTol(1);
 laser_z_tol_high=laserZTol(2);
 laser_z_ref=laserZTol(3);
 
 
 
 % read the qa results.
 
 snr=daily_qa_cell{2};
 
 uniformity=daily_qa_cell{3};
 
 contrast=daily_qa_cell{4};
 
 ghosting=daily_qa_cell{5};
 
 d45=daily_qa_cell{6};
 
 d135=daily_qa_cell{7};
 
 output=daily_qa_cell{8};
 
 laser_x=daily_qa_cell{9};% added laser support
 
 laser_y=daily_qa_cell{10};
 
 laser_z=daily_qa_cell{11};



%% The tolerance is threshold type. Only this situation did the laser support. Use standard deviation as threshold.

if strcmp(tol_type,'Val')
    % SNR
    if snr>=abs(snr_ref-snr_tol_low) && snr_ref<=abs(snr_ref+snr_tol_low) 
        
        r2c2.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (snr< abs(snr_ref-snr_tol_low) && snr>=abs(snr_ref-snr_tol_high)) || (snr>abs(snr_ref+snr_tol_low) && snr<=abs(snr_ref+snr_tol_high)) % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if snr<abs(snr_ref-snr_tol_high) || snr>abs(snr_ref+snr_tol_high) % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.RED);
        
    end
    
    % uniformity 5% and 10%
    
    if uniformity>=abs(uniformity_ref-uniformity_tol_low) && uniformity<=abs(uniformity_ref+uniformity_tol_low)  % set 3% tolerance
        
        r2c3.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (uniformity< abs(uniformity_ref-uniformity_tol_low) && uniformity>=abs(uniformity_ref-uniformity_tol_high)) || (uniformity>abs(uniformity_ref+uniformity_tol_low) && uniformity<=abs(uniformity_ref+uniformity_tol_high))%
        
        r2c3.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if (uniformity<abs(uniformity_ref-uniformity_tol_high)) || (uniformity>abs(uniformity_ref+uniformity_tol_high))% set 3% as yellow
        
        r2c3.setBackgroundColor(BaseColor.RED);
        
    end
    
    % contrast tolerance 10% and 15 %of baseline.
    
    if contrast>=abs(contrast_ref-contrast_tol_low) && contrast<=abs(contrast_ref+contrast_tol_low)  %
        
        r2c4.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (contrast<abs(contrast_ref-contrast_tol_low) && contrast>=abs(contrast_ref-contrast_tol_high))|| (contrast>abs(contrast_ref+contrast_tol_low) && contrast<=abs(contrast_ref+contrast_tol_high)) % set 10% tolerance
        
        r2c4.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if contrast<abs(contrast_ref-contrast_tol_high) || contrast>abs(contrast_ref+contrast_tol_high) % set 10 %as yellow
        
        r2c4.setBackgroundColor(BaseColor.RED);
        
    end
    
    % ghosting using 0.03 as tolerance and 0.05 as 
    
        
%     if ghosting>=abs(ghosting_ref-ghosting_tol_low) && ghosting <=abs(ghosting_ref+ghosting_tol_low) %
%         
%         r2c5.setBackgroundColor(BaseColor.GREEN);
%         
%     end
%     
%     if (ghosting<abs(ghosting_ref-ghosting_tol_low) && ghosting>=abs(ghosting_ref-ghosting_tol_high)) || (ghosting>abs(ghosting_ref+ghosting_tol_low) && ghosting<=abs(ghosting_ref+ghosting_tol_high))% set 15% tolerance
%         
%         r2c5.setBackgroundColor(BaseColor.YELLOW);
%         
%     end
%     
%     if (ghosting<abs(ghosting_ref-ghosting_tol_high)) ||(ghosting>abs(ghosting_ref+ghosting_tol_high))  % set 15 %as yellow
%         
%         r2c5.setBackgroundColor(BaseColor.RED);
%         
%     end
    
    % use different criteria for ghosting instead using std.
    
    if ghosting<=ghosting_tol_low  %
        
        r2c5.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if ghosting>ghosting_tol_low && ghosting<=ghosting_tol_high 
        
        r2c5.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if ghosting>ghosting_tol_high 
        
        r2c5.setBackgroundColor(BaseColor.RED);
        
    end
    
        
    
    
    %d45 tolerance +/-2mm
    
    if d45>=abs(d45_ref-d45_tol_low) && d45<=abs(d45_ref+d45_tol_low) %
        
        r2c6.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d45<abs(d45_ref-d45_tol_low) && d45>=abs(d45_ref-d45_tol_high)) ||(d45>abs(d45_ref+d45_tol_low) && d45<=abs(d45_ref+d45_tol_high)) 
        
        r2c6.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d45<abs(d45_ref-d45_tol_high) || d45>abs(d45_ref+d45_tol_high);%
        
        r2c6.setBackgroundColor(BaseColor.RED);
        
    end
    
    %d135 tol: +/-2mm
    
    if d135>=abs(d135_ref-d45_tol_low) && d135<=(d135_ref+d45_tol_low) %
        
        r2c7.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d135<abs(d135_ref-d135_tol_low) && d135>=abs(d135_ref-d135_tol_high)) || (d135>abs(d135_ref+d135_tol_low) && d135<=abs(d135_ref+d135_tol_high))
        
        r2c7.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d135<abs(d135_ref-d135_tol_high) || d135>abs(d135_ref+d135_tol_high)%
        
        r2c7.setBackgroundColor(BaseColor.RED);
        
    end
    
    % output tol: 5% and 10%
    
    if output>=abs(output_ref-output_tol_low) || output<=abs(output_ref+output_tol_low) % set 5% threshould
        
        r2c8.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (output<abs(output_ref-output_tol_low) &&  output>=abs(output_ref-output_tol_high)) ||(output>abs(output_ref+output_tol_low) &&  output<=abs(output_ref+output_tol_high))
        
        r2c8.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if output<abs(output_ref-output_tol_high) ||output>abs(output_ref+output_tol_high)   % set 10 %as yellow
        
        r2c8.setBackgroundColor(BaseColor.RED);
        
    end
    
    % laser x, y, z
%     %% for x

    if laser_x>=abs(laser_x_ref-laser_x_tol_low ) && laser_x<=abs(laser_x_ref+laser_x_tol_low ) % set 5% threshould
        
        r2c9.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (laser_x<abs(laser_x_ref-laser_x_tol_low) &&  laser_x>=abs(laser_x_ref-laser_x_tol_high))||(laser_x>abs(laser_x_ref+laser_x_tol_low) &&  laser_x<=abs(laser_x_ref+laser_x_tol_high))
        
        r2c9.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if laser_x<abs(laser_x_ref-laser_x_tol_high) || laser_x>abs(laser_x_ref+laser_x_tol_high)  % set 10 %as yellow
        
        r2c9.setBackgroundColor(BaseColor.RED);
        
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
        
        r2c10.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (laser_y<-abs(laser_y_tol_low) && laser_y>=-abs(laser_y_tol_high))||(laser_y>abs(laser_y_tol_low) && laser_y<=abs(laser_y_tol_high))
        
        r2c10.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
      
    
    if laser_y<-abs(laser_y_tol_high) || laser_y>abs(laser_y_tol_high)  % set 10 %as yellow
        
        r2c10.setBackgroundColor(BaseColor.RED);
        
    end
    
    
%     % for z
%     
   
     if laser_z>=abs(laser_z_ref-laser_z_tol_low) && laser_z<=abs(laser_z_ref+laser_z_tol_low) % set 5% threshould
        
        r2c11.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (laser_z<abs(laser_z_ref-laser_z_tol_low) &&  laser_z>=abs(laser_z_ref-laser_z_tol_high)) || (laser_z>abs(laser_z_ref+laser_z_tol_low) &&  laser_z<=abs(laser_z_ref+laser_z_tol_high))
        
        r2c11.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if laser_z<abs(laser_z_ref-laser_z_tol_high) || laser_z>abs(laser_z_ref+laser_z_tol_high)  % set 10 %as yellow
        
        r2c11.setBackgroundColor(BaseColor.RED);
        
    end

end 



%%
% add resutls cell to table


table.addCell(r2c1);
table.addCell(r2c2);
table.addCell(r2c3);
table.addCell(r2c4);
table.addCell(r2c5);
table.addCell(r2c6);
table.addCell(r2c7);
table.addCell(r2c8);

table.addCell(r2c9); % added laser support.
table.addCell(r2c10);
table.addCell(r2c11);






document.add(table); % QA table.

%document.add(table2); % laser table

% draw green circle
 cb.saveState()
 cb.setColorFill(BaseColor.GREEN)% BaseColor.BLUE,RED,GREEN,YELLOW
 cb.circle(50,450,10);
 
 cb.fillStroke(); % fill the stroke
 cb.restoreState();

 % draw yellow circle
 cb.saveState()
 cb.setColorFill(BaseColor.YELLOW)% BaseColor.BLUE,RED,GREEN,YELLOW
 cb.circle(200,450,10);
 
 cb.fillStroke(); % fill the stroke
 cb.restoreState();
 
 % draw red circle
 cb.saveState()
 cb.setColorFill(BaseColor.RED)% BaseColor.BLUE,RED,GREEN,YELLOW
 cb.circle(340,450,10);
 
 cb.fillStroke(); % fill the stroke
 cb.restoreState();
 
cb.saveState()
cb.beginText()

cb.setFontAndSize(f_cb,12);
  
cb.setTextMatrix(70,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Within tolerance');

cb.setTextMatrix(220,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Acceptable');

cb.setTextMatrix(370,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Out of tolerance');


cb.endText()

cb.restoreState();

%%add all anchor on the first page.
 


%%

% add the text


% document.add(Chunk.NEWLINE);
% close document.

document.close();

pdf_report_file_name=file_name;


end 

   
 
 

