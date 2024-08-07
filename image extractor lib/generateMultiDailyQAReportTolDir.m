function  generateMultiDailyQAReportTolDir(daily_qa_cell_multi,tol_file,tol_type,pdf_dir)
%{
 To generate pdf report for MRIsim daily QA. 
The basic usage of Java Itext package were illustrated in this file. It can
be used as a basis for adding pdf functionality to matlab for many other
project. 

%}


[row,col]=size(daily_qa_cell_multi);

for k=1:row
 
    daily_qa_cell=daily_qa_cell_multi(k,:);
    pdf_report_file_name=generateDailyQAReportTolDir(daily_qa_cell,tol_file,tol_type,pdf_dir)
    
       
    
end 

end 