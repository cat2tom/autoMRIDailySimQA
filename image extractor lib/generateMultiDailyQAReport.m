function  generateMultiDailyQAReport(daily_qa_cell_multi,tolerance_cell)
%{
 To generate pdf report for MRIsim daily QA. 
The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

%}


[row,col]=size(daily_qa_cell_multi);

for k=1:row
 
    daily_qa_cell=daily_qa_cell_multi(k,:);
    pdf_report_file_name=generateDailyQAReport(daily_qa_cell,tolerance_cell);
    
    
end 

end 