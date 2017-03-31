function db_connection = writeDailyDQA2DataBase(db_connection,daily_qa_results_cell)
%{

Write the Daily QA resutls to database. 

Input: db_connection-the connection of database.
      daily_qa_results_cell-database name, eg. *.db


output:connection-connection to the database.
       db_file-full path of db file name.
      

%}   
% establish statement

statement=db_connection.createStatement();



% use daily_QA resutls cell structure to write it to databaase.

for k=1:size(daily_qa_results_cell)% iterate the data row by row.

    row=daily_qa_results_cell(k,:);
    
    % grab the image parameters
    date_time=row{1}
    
      
    SNR=row{2}
    
    uniformity=row{3}
    
    contrast=row{4}
    
    ghosting=row{5}
    
    distance45=row{6}
    
    distance135=row{7}
    
    output=row{8}
    
    % constructing the string
    
    daily_string=strcat('insert into DailyQA ','  values(', date_time, ...
        ',',num2str(SNR),',',num2str(uniformity),',',num2str(contrast),','...
        ,num2str(ghosting),',',num2str(distance45),',',num2str(distance135)...
        ,',',num2str(output),')')
 
        
    %write into daily QA table. 
    
    statement.executeUpdate(daily_string);

    
end 



end

