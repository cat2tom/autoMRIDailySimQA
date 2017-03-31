function daily_qa_table=generateDailyQATable(daily_qa_results )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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



end

