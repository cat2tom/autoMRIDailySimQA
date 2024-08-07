function email_list = readEmailList(excel_file_name)
%{
Function: Read list of emails to notify the receipients if the QA is out of
tolerance.

Input: excel_file_name-absolute path to the excel file name containign all
e-mails.

output: dirs-cell structure containing list of e-mails.
        
  

%}


[num,txt,raw]=xlsread(excel_file_name,'email_list');

email_list=txt;



end

