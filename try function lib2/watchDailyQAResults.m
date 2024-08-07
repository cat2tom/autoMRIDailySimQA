
% This program provided another way to check the update of a directory.  

% read the daily QA resutls before the loop



% specifiy the excel file.

daily_QA_file_name='QA2016B.xls';

% specifiy the tolerance and e-mail list.

tol_file2='C:\aitangResearch\MRISimQALaser\tolerance\tolerance_absolute.xlsx'; % test laser tolerance.

email_list={'aitang.xing@gmail.com','Aitang.Xing@sswahs.nsw.gov.au'};


% start the loop.


[daily_qa_array,txt,raw]= readDailyQAFromExcel( daily_QA_file_name );

current_QA_results=daily_qa_array;

[row1,col1]=size(current_QA_results); % before matrix size

fclose all;

while true
  
  pause(10);  % pause for 30 seconds before loop start.
 
  [QA_results,txt,raw]=readDailyQAFromExcel( daily_QA_file_name );
  
  [row2,col2]=size(QA_results); % Current matrix size.
  
  new_results = setdiff(QA_results,current_QA_results);
  
  fclose all;
  
  if row2>row1
      
      % new resutls added.
      
      new_results=QA_results(row1+1:row2,:);% get new resutls for all added Daily QA.
      
      % go through all new added QA results to send e-mail if it is out of
      % tolerance.
      
      [row_new,col_new]=size(new_results);
      
      for k=1:row_new
          
          emailMonitorDailyQAMatrix(new_results,tol_file2,'Val',email_list);
          
      end 
      
      
      %update the new col1 and row1
      
      row1=row2;
      col1=col2;
            
  else
      
       fprintf('no new QA results.\n')
            
  end 
    
  pause(10); % pause another 30s after loop ended.
  
end