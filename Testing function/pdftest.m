
%{

The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

%}




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

test='java_matlab3.pdf';

% set fond 


% document obj

document =Document(PageSize.A4);

% get page size width and hight

width=PageSize.A4.getWidth();

height=PageSize.A4.getHeight();


% file obj

file_obj=FileOutputStream(test);

% associate pdf writer obj with document obj

 witer=PdfWriter.getInstance(document,file_obj);
 
 
 % open the document 
 
 document.open();
 
 % write the text to direct content.
 
 
 cb=witer.getDirectContent(); % establish a direct content.
 
 cb.setFontAndSize(f_cb,16);
 
 cb.beginText()
 
 cb.setTextMatrix(250,810);% left and top (x,y) is the position where to write the text. 
 
 cb.showText('Hellow,DirectContent');
 
 % draw a line
 
  
 cb.endText()
 
 % Direclty draw a line on PDFContentByte. 
 
 
 cb.setLineWidth(2);
 
 cb.moveTo(30,650);
 
 cb.lineTo(570,650);
 
 cb.stroke();
 
 % Direclty draw a circle on PDFContentByte
 
 cb.saveState()
 cb.setColorFill(BaseColor.YELLOW)% BaseColor.BLUE,RED,GREEN,YELLOW
 cb.circle(250,500,50);
 
 %cb.stroke()% just draw stroke.
 cb.fillStroke(); % fill the stroke
 cb.restoreState();
% simple paragraph using high-level object to add the text content into
% pdf.

paragraph=Paragraph('This is itext from matlab');

% pactice the template. The template is a resuable XObject like image and
% can be used at anywhere in a pdf file. 



tmp_template=cb.createTemplate(500,70); % create a tempalte area by specifiying length and width.

tmp_template.moveTo(100,100); % move the the point where the drawing starts. 

% you can create any thing on template. 
tmp_template.rectangle(20,20,300,30);% create a rectangle in a template

tmp_template.stroke(); % actually rendering the stroke. 


cb.addTemplate(tmp_template,200,50);% add the template to the pdf content. 



% added chunk to paragraph

for k=1:10
    
    tmp2=strcat('this is a sentence:',+num2str(k));
    chunk_tmp=Chunk(tmp2);
    
    paragraph.add(chunk_tmp);
    
    
end 
% add table


a=uint8(3);


table=PdfPTable(a);

table.setWidthPercentage(100);

table.setSpacingBefore(100);

table.setSpacingAfter(100);

column_width=[1.0,1.0,1.0];

table.setWidths([2  1  1 ])

pc1=Paragraph('cell');

pc2=Paragraph('cell');

pc3=Paragraph('cell');

 cell1=PdfPCell(pc1);
 cell2=PdfPCell(pc2);

 cell3=PdfPCell(pc3);
 
 cell3.setBackgroundColor(BaseColor.YELLOW); % change the backgroud color for table cell.

table.addCell(cell1);
table.addCell(cell2);

table.addCell(cell3);


% add an image

image1=Image.getInstance('C:\aitangResearch\MRI daily QA program\sample images\test.jpg');

image1.setAbsolutePosition(250,500);

image1.setRotationDegrees(45);

% image1.scaleAbsolute(50,50);

document.add(image1);

document.add(paragraph);


document.add(table);



% add the text


document.add(Chunk.NEWLINE);
% close document.

document.close();




 
 

