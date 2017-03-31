function db_connect= createDailyQATable(db_connection )
%{

Create a table in database and return connection.

%}   
% create a statement
statement = db_connection.createStatement(); % create a statement

% create a table

table_string1='create table DailyQA (date string, SNR real, Uniformity real,';

table_string2='Contrast real, Ghosting real,Distance45 real,Distance135 real,Output real)';


table_string=strcat(table_string1,table_string2);

statement.executeUpdate(table_string);

db_connect=db_connection;


end

