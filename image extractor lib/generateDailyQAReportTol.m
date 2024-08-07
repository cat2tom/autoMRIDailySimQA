function  pdf_report_file_name=generateDailyQAReportTol(daily_qa_cell,tol_file,tol_type)
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

%}


% loading the java package. 
import java.io.FileOutputStream

import java.io.IOException


import com.itextpdf.text.*

import com.itextpdf.text.Document

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

document =Document(PageSize.A4);

% get page size width and hight

width=PageSize.A4.getWidth();

height=PageSize.A4.getHeight();

% file name using datetiem 

file_name=strcat('MRISim_DailyQA_report_performed on_',daily_qa_cell{1},'.pdf');

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
a=uint8(8);

table=PdfPTable(a);

table.setWidthPercentage(100);
% 
table.setSpacingBefore(200);
% 
% table.setSpacingAfter(100);


% table.setWidths([1  1  1 1 1 1 1 1])

%% fill the table head.
head1=Paragraph('Date/Time');

head2=Paragraph('SNR');

head3=Paragraph('Uniformity');

head4=Paragraph('Contrast');

head5=Paragraph('Ghosting');

head6=Paragraph('D45(mm)');

head7=Paragraph('D135(mm)');

head8=Paragraph('Output');

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


head_cell1.setFixedHeight(row_height);
head_cell2.setFixedHeight(row_height);

head_cell3.setFixedHeight(row_height);

head_cell4.setFixedHeight(row_height);

head_cell5.setFixedHeight(row_height);

head_cell6.setFixedHeight(row_height);

head_cell7.setFixedHeight(row_height);

head_cell8.setFixedHeight(row_height);
 
% cell3.setBackgroundColor(BaseColor.YELLOW); % change the backgroud color for table cell.


table.addCell(head_cell1);
table.addCell(head_cell2);
table.addCell(head_cell3);
table.addCell(head_cell4);
table.addCell(head_cell5);
table.addCell(head_cell6);
table.addCell(head_cell7);

table.addCell(head_cell8);

% add the resutls

date_r2c1=Phrase(daily_qa_cell{1});

snr_r2c2=Phrase(num2str(daily_qa_cell{2})); % convert to string
uniform_r2c3=Phrase(num2str(daily_qa_cell{3}));
contrast_r2c4=Phrase(num2str(daily_qa_cell{4}));
ghosting_r2c5=Phrase(num2str(daily_qa_cell{5}));
d45_r2c6=Phrase(num2str(daily_qa_cell{6}));
d45_r2c7=Phrase(num2str(daily_qa_cell{7}));
output_r2c8=Phrase(num2str(daily_qa_cell{8}));


r2c1=PdfPCell(date_r2c1);
r2c2=PdfPCell(snr_r2c2);
r2c3=PdfPCell(uniform_r2c3);
r2c4=PdfPCell(contrast_r2c4);
r2c5=PdfPCell(ghosting_r2c5);
r2c6=PdfPCell(d45_r2c6);
r2c7=PdfPCell(d45_r2c7);
r2c8=PdfPCell(output_r2c8);

r2c1.setFixedHeight(row_height)
r2c2.setFixedHeight(row_height)
r2c3.setFixedHeight(row_height);
r2c4.setFixedHeight(row_height);
r2c5.setFixedHeight(row_height);
r2c6.setFixedHeight(row_height);
r2c7.setFixedHeight(row_height);
r2c8.setFixedHeight(row_height);

% set color according to tolerace

 %% read tolerance and reference from file 
 
 tolerance=xlsread(tol_file);
 
 
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
 
 % read the qa results.
 
 snr=daily_qa_cell{2};
 
 uniformity=daily_qa_cell{3};
 
 contrast=daily_qa_cell{4};
 
 ghosting=daily_qa_cell{5};
 
 d45=daily_qa_cell{6};
 
 d135=daily_qa_cell{7};
 
 output=daily_qa_cell{8};

%% percentage tolerance
if strcmp(tol_type,'Per')
    % SNR
    if snr>=snr_ref*(1-snr_tol_low*0.01)
        
        r2c2.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if snr< snr_ref*(1-snr_tol_low*0.01)&& snr>=snr_ref*(1-snr_tol_high*0.01) % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if snr<snr_ref*(1-snr_tol_high*0.01) % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.RED);
        
    end
    
    % uniformity 5% and 10%
    
    if uniformity>=uniformity_ref*(1-uniformity_tol_low*0.01)  % set 3% tolerance
        
        r2c3.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if uniformity< uniformity_ref*(1-uniformity_tol_low*0.01) && uniformity>uniformity_ref*(1-uniformity_tol_high*0.01) %
        
        r2c3.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if uniformity<=uniformity_ref*(1-uniformity_tol_high*0.01) % set 3% as yellow
        
        r2c3.setBackgroundColor(BaseColor.RED);
        
    end
    
    % contrast tolerance 10% and 15 %of baseline.
    
    if contrast>=contrast_ref*(1-contrast_tol_low*0.01)  %
        
        r2c4.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if contrast<contrast_ref*(1-contrast_tol_low*0.01) && constrast>=contrast_ref*(1-contrast_tol_high*0.01)% set 10% tolerance
        
        r2c4.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if contrast<=contrast_ref*(1-contrast_tol_high*0.01) % set 10 %as yellow
        
        r2c4.setBackgroundColor(BaseColor.RED);
        
    end
    
    % ghosting 15% and 20% as threshold
    
        
    if ghosting<=ghosting_ref  %
        
        r2c5.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if ghosting>ghosting_ref && ghosting<=ghosting_ref*(1+ghosting_tol_low*0.01)% set 15% tolerance
        
        r2c5.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if ghosting>ghosting_ref*(1+ghosting_tol_high*0.01) % set 15 %as yellow
        
        r2c5.setBackgroundColor(BaseColor.RED);
        
    end
    
    %d45 tolerance +/-2mm
    
    if d45<=d45_ref+2 && d45>=d45_ref-2 %
        
        r2c6.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d45<=d45_ref+3 && d45>d45_ref+2) || (d45>=d45_ref-3 && d45<d45_ref-2)
        
        r2c6.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d45>d45_ref+3 || d45<d45_ref-3%
        
        r2c6.setBackgroundColor(BaseColor.RED);
        
    end
    
    %d135 tol: +/-2mm
    
    if d135<=d135_ref+2 && d135>=d135_ref-2 %
        
        r2c7.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d135<=d135_ref+3 && d135>d135_ref+2) || (d135>=d135_ref-3 && d135<d135_ref-2)
        
        r2c7.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d135>d135_ref+3 || d135<d135_ref-3%
        
        r2c7.setBackgroundColor(BaseColor.RED);
        
    end
    
    % output tol: 5% and 10%
    
    if output<=output_ref*(1+output_tol_low*0.01) && output>=output_ref*(1-output_tol_low*0.01)% set 5% threshould
        
        r2c8.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if ((output<=output_ref*(1+output_tol_high*0.01) &&  output>output_ref*(1+output_tol_low*0.01)))||((output>=output_ref*(1-output_tol_high*0.01) && output<output_ref*(1-output_tol_low*0.01))) % set 10% for yellow
        
        r2c8.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if output>output_ref*(1+output_tol_high*0.01) || output<output_ref*(1-output_tol_high*0.01) % set 10 %as yellow
        
        r2c8.setBackgroundColor(BaseColor.RED);
        
    end

end 

%% The tolerance is threshold type
if strcmp(tol_type,'Val')
    % SNR
    if snr>=snr_tol_low
        
        r2c2.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if snr< snr_tol_low && snr>snr_tol_high % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if snr<snr_tol_high % set 10% as yellow
        
        r2c2.setBackgroundColor(BaseColor.RED);
        
    end
    
    % uniformity 5% and 10%
    
    if uniformity>=uniformity_tol_low  % set 3% tolerance
        
        r2c3.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if uniformity< uniformity_tol_low && uniformity>uniformity_tol_high %
        
        r2c3.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if uniformity<=uniformity_tol_high % set 3% as yellow
        
        r2c3.setBackgroundColor(BaseColor.RED);
        
    end
    
    % contrast tolerance 10% and 15 %of baseline.
    
    if contrast>=contrast_tol_low  %
        
        r2c4.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if contrast<contrast_tol_low && contrast>=contrast_tol_high% set 10% tolerance
        
        r2c4.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if contrast<=contrast_tol_high % set 10 %as yellow
        
        r2c4.setBackgroundColor(BaseColor.RED);
        
    end
    
    % ghosting 15% and 20% as threshold
    
        
    if ghosting<=ghosting_ref  %
        
        r2c5.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if ghosting>ghosting_ref && ghosting<=ghosting_tol_low% set 15% tolerance
        
        r2c5.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if ghosting>ghosting_tol_high % set 15 %as yellow
        
        r2c5.setBackgroundColor(BaseColor.RED);
        
    end
    
    %d45 tolerance +/-2mm
    
    if d45<=d45_ref+2 && d45>=d45_ref-2 %
        
        r2c6.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d45<=d45_ref+3 && d45>d45_ref+2) || (d45>=d45_ref-3 && d45<d45_ref-2)
        
        r2c6.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d45>d45_ref+3 || d45<d45_ref-3%
        
        r2c6.setBackgroundColor(BaseColor.RED);
        
    end
    
    %d135 tol: +/-2mm
    
    if d135<=d135_ref+2 && d135>=d135_ref-2 %
        
        r2c7.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if (d135<=d135_ref+3 && d135>d135_ref+2) || (d135>=d135_ref-3 && d135<d135_ref-2)
        
        r2c7.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if d135>d135_ref+3 || d135<d135_ref-3%
        
        r2c7.setBackgroundColor(BaseColor.RED);
        
    end
    
    % output tol: 5% and 10%
    
    if output>=output_tol_low % set 5% threshould
        
        r2c8.setBackgroundColor(BaseColor.GREEN);
        
    end
    
    if output<=output_tol_low &&  output>=output_tol_high
        
        r2c8.setBackgroundColor(BaseColor.YELLOW);
        
    end
    
    if output<output_tol_high  % set 10 %as yellow
        
        r2c8.setBackgroundColor(BaseColor.RED);
        
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



% add an image

% image1=Image.getInstance('C:\aitangResearch\MRI daily QA program\sample images\test.jpg');
% 
% image1.setAbsolutePosition(250,500);
% 
% image1.setRotationDegrees(45);
% 
% %image1.scaleAbsolute(50,50);
% 
% document.add(image1);

% document.add(paragraph);

%  document.newPage();


document.add(table);

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
 
ref_cell={'#SNR','#Uniformity','#Constrast','#Ghosting','#45','#D135','#Output'};

image_index={'SNR','Uniformity','Contrast','Ghosting','Distortion','Output'};



%noise
 noise_anchor=Anchor('Go to noise image page');

 noise_anchor.setReference('#SNR');
 
 noise_anchor.setName('Sumary page');
 
 noise_par=Paragraph();
 
 noise_par.add(noise_anchor);
 
 noise_par.setSpacingBefore(100);
 
 noise_par.setIndentationLeft(10);
 
 % uniformity
 uniformity_anchor=Anchor('Go to uniformity image page');

 uniformity_anchor.setReference('#Uniformity');
 
 uniformity_anchor.setName('Sumary page');
 
 uniformity_par=Paragraph();
 
 uniformity_par.add(uniformity_anchor);
 
 uniformity_par.setSpacingBefore(5);
 uniformity_par.setSpacingAfter(5);
 
 uniformity_par.setIndentationLeft(10);
 
 % constrast
 contrast_anchor=Anchor('Go to contrast image page');

 contrast_anchor.setReference('#Contrast');
 
 contrast_anchor.setName('Sumary page');
 
 contrast_par=Paragraph();
 
 contrast_par.add(contrast_anchor);
 
 contrast_par.setSpacingBefore(5);
 contrast_par.setSpacingAfter(5);
 
 contrast_par.setIndentationLeft(10);
 
 % ghosting
 ghosting_anchor=Anchor('Go to ghosting image page');

 ghosting_anchor.setReference('#Ghosting');
 
 ghosting_anchor.setName('Sumary page');
 
 ghosting_par=Paragraph();
 
 ghosting_par.add(ghosting_anchor);
 
 ghosting_par.setSpacingBefore(5);
 ghosting_par.setSpacingAfter(5);
 
 ghosting_par.setIndentationLeft(10);
 
 % geometric distortion
 distortion_anchor=Anchor('Go to geometric distortion image page');

 distortion_anchor.setReference('#Distortion');
 
 distortion_anchor.setName('Sumary page');
 
 distortion_par=Paragraph();
 
 distortion_par.add(distortion_anchor);
 
 distortion_par.setSpacingBefore(5);
 distortion_par.setSpacingAfter(5);
 
 distortion_par.setIndentationLeft(10);
 
 % output 
 output_anchor=Anchor('Go to output image page');

 output_anchor.setReference('#Output');
 
 output_anchor.setName('Sumary page');
 
 output_par=Paragraph();
 
 output_par.add(output_anchor);
 
 output_par.setSpacingBefore(5);
 output_par.setSpacingAfter(5);
 
 output_par.setIndentationLeft(10);
 
 
 
  
% paragraph.setIndentationLeft(50);
% paragraph.setIndentationRight(50);
%  paragraph.setAlignment(Element.ALIGN_LEFT);
% paragraph.setAlignment(Element.ALIGN_CENTER);
% paragraph.setAlignment(Element.ALIGN_RIGHT);
% paragraph.setSpacingAfter(50);
% paragraph.setSpacingBefore(50);

  
 document.add(noise_par);
 document.add(uniformity_par);
 document.add(contrast_par);
 document.add(ghosting_par);
 document.add(distortion_par);
 document.add(output_par);
 
 
 
% cell to hold the image quality index


for k=1:length(image_index)
    
    document.newPage();
    
    padding=Paragraph(Phrase(' '));
    
    document.add(padding);
    
    label_image_par=Paragraph();
    
    image_label=strcat(image_index{k},' image');
    
        
    label_image_par.add(Phrase(image_label));
    
    label_image_par.setSpacingBefore(200);
    
    label_image_par.setAlignment(Element.ALIGN_CENTER);
    
    document.add(label_image_par);
    
    image_par=Paragraph();
    
    % set anchor on image page
    %
    target=Anchor('Go to daily QA result page');
    
    target.setReference('#Sumary page')
    
    target.setName(image_index{k});
    
    image_par.add(target);
    
    image_par.setSpacingBefore(150);
    
    image_par.setAlignment(Element.ALIGN_CENTER);
    
    document.add(image_par);
    
       
    % add head and footer
    cb.saveState();
    color=BaseColor.BLUE;
    generateHeadFooterDailyQA(writer,cb,f_cb,width,height,color); 
    cb.restoreState();

    % add images.
    
    image1=Image.getInstance('C:\aitangResearch\MRI daily QA program\sample images\test.jpg');
    
    image1.setAbsolutePosition(250,450);
    
%     image1.setRotationDegrees(45);
    
    %image1.scaleAbsolute(50,50);
    
    document.add(image1);
    
        
    
    
end 


%%

% add the text


% document.add(Chunk.NEWLINE);
% close document.

document.close();

pdf_report_file_name=file_name;
end 

   
 
 

