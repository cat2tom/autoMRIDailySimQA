function  pdf_report_file_name=generateDailyQAReport(daily_qa_cell,tolerance_cell)
%{
 To generate pdf report for MRIsim daily QA. 
The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

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

witer=PdfWriter.getInstance(document,file_obj);
 
 % open the document 
  document.open();
  
% get DC object.

cb=witer.getDirectContent(); % establish a direct content.
 
% write head and footer information.

cb.saveState();
color=BaseColor.BLUE;
generateHeadFooterDailyQA(cb,f_cb,width,height,color);
 
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

snr_tol=tolerance_cell{1};

snr=daily_qa_cell{2};

uniformity_tol=tolerance_cell{2};

uniformity=daily_qa_cell{3};

contrast_tol=tolerance_cell{3};

contrast=daily_qa_cell{4};

ghosting_tol=tolerance_cell{4};

ghosting=daily_qa_cell{5};

d45_tol=tolerance_cell{5};

d45=daily_qa_cell{6};

d135_tol=tolerance_cell{6};

d135=daily_qa_cell{7};

output_tol=tolerance_cell{7};

output=daily_qa_cell{8};


% SNR 
if snr>=snr_tol

     r2c2.setBackgroundColor(BaseColor.GREEN);

end 

if snr<snr_tol && snr>snr_tol*0.9 % set 10% as yellow

     r2c2.setBackgroundColor(BaseColor.YELLOW);

end 

if snr<snr_tol*0.9 % set 10% as yellow

     r2c2.setBackgroundColor(BaseColor.RED);

end 

% uniformity

if uniformity>=uniformity_tol  % set 3% tolerance

     r2c3.setBackgroundColor(BaseColor.GREEN);

end 

if uniformity<uniformity_tol && uniformity>uniformity_tol*0.97 % 

     r2c3.setBackgroundColor(BaseColor.YELLOW);

end 

if uniformity<=uniformity_tol*0.97 % set 3% as yellow

     r2c3.setBackgroundColor(BaseColor.RED);

end 

% contrast tolerance 10% of baseline.

if contrast>=contrast_tol  % 

     r2c4.setBackgroundColor(BaseColor.GREEN);

end 

if contrast<contrast_tol && constrast>contrast_tol*0.90 % set 10% tolerance

     r2c4.setBackgroundColor(BaseColor.YELLOW);

end 

if contrast<=contrast_tol*0.90 % set 10 %as yellow

     r2c4.setBackgroundColor(BaseColor.RED);

end 

% ghosting 15% as threshold

if ghosting<=ghosting_tol  % 

     r2c5.setBackgroundColor(BaseColor.GREEN);

end 

if ghosting>ghosting_tol && ghosting<=ghosting_tol*1.15% set 15% tolerance

     r2c5.setBackgroundColor(BaseColor.YELLOW);

end 

if ghosting>ghosting_tol*1.15 % set 15 %as yellow

     r2c5.setBackgroundColor(BaseColor.RED);

end 

%d45 tolerance +/-2mm

if d45<=d45_tol+2 && d45>=d45_tol-2 % 

     r2c6.setBackgroundColor(BaseColor.GREEN);

end 

if (d45<=d45_tol+3 && d45>d45_tol+2) || (d45>=d45_tol-3 && d45<d45_tol-2)

     r2c6.setBackgroundColor(BaseColor.YELLOW);

end 

if d45>d45_tol+3 || d45<d45_tol-3% 

     r2c6.setBackgroundColor(BaseColor.RED);

end 

%d135 tol: +/-2mm

if d135<=d135_tol+2 && d135>=d135_tol-2 % 

     r2c7.setBackgroundColor(BaseColor.GREEN);

end 

if (d135<=d135_tol+3 && d135>d135_tol+2) || (d135>=d135_tol-3 && d135<d135_tol-2)

     r2c7.setBackgroundColor(BaseColor.YELLOW);

end 

if d135>d135_tol+3 || d135<d135_tol-3% 

     r2c7.setBackgroundColor(BaseColor.RED);

end 

% output tol: 5% and 10%

if output<=output_tol*1.05 && output>=output_tol*0.95 % set 5% threshould

     r2c8.setBackgroundColor(BaseColor.GREEN);

end 

if (output<=output_tol*1.1 &&  output>output_tol*1.05) ||(output>=output_tol*0.9 && output<output_tol*0.95) % set 10% for yellow

     r2c8.setBackgroundColor(BaseColor.YELLOW);

end 

if output>output_tol*1.1 || output<output_tol*0.9 % set 10 %as yellow

     r2c8.setBackgroundColor(BaseColor.RED);

end 


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
 
 
cb.beginText()

cb.setFontAndSize(f_cb,12);
 
 
cb.setTextMatrix(70,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Within tolerance');

cb.setTextMatrix(220,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Acceptable');

cb.setTextMatrix(370,445);% left and top (x,y) is the position where to write the text. 
 
cb.showText('Out of tolerance');


cb.endText()



% add the text


% document.add(Chunk.NEWLINE);
% close document.

document.close();

pdf_report_file_name=file_name;
end 


 
 

