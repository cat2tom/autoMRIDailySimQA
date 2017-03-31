function autoMonitorMRISimDailyQAFunction(dirs,email_list)

%{
This the function version of monitor daily QA results uing e-mail.

Input: dirs-cell structure read from dirconfig files.
       e-mail_list-cell structure containing email list.



%}


database_jar_file=dirs{1};

database_path=dirs{2};

database_name=dirs{3};

excel_tolerance_file=dirs{4};

MRI_image_dir=dirs{5};

pdf_report_output_dir=dirs{6};

excel_output_file=dirs{7};



% start the loop.


[daily_qa_array,txt,raw]= readDailyQAFromExcel( excel_output_file );

current_QA_results=daily_qa_array;

[row1,col1]=size(current_QA_results); % before matrix size

fclose all;

while true
  
  pause(10);  % pause for 30 seconds before loop start.
 
  [QA_results,txt,raw]=readDailyQAFromExcel( excel_output_file );
  
  [row2,col2]=size(QA_results); % Current matrix size.
  
  new_results = setdiff(QA_results,current_QA_results);
  
  fclose all;
  
  if row2>row1
      
      % new resutls added.
      
      new_results=QA_results(row1+1:row2,:);% get new resutls for all added Daily QA.
      
      % go through all new added QA results to send e-mail if it is out of
      % tolerance.
      
      [row_new,col_new]=size(new_results);
      
      new_qa=strcat('Total: ',num2str(row_new),'  ',': new QA resutls were added.\n');
      
      fprintf(new_qa)
      
      for k=1:row_new
          
          emailMonitorDailyQAMatrix(new_results,excel_tolerance_file,'Val',email_list);
          
      end 
      
      
      %update the new col1 and row1
      
      row1=row2;
      col1=col2;
            
  else
      
       fprintf('no new QA results.\n')
            
  end 
    
  pause(10); % pause another 30s after loop ended.
  
end

end 