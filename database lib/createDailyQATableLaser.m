function db_connect= createDailyQATableLaser(db_connection )
%{

Create a table in database and return connection. Create the only if the
table does not exist.

%}   
% create a statement
statement = db_connection.createStatement(); % create a statement

% create a table

table_string1='create table if not exists DailyQA (date string, SNR real, Uniformity real,';

table_string2='Contrast real, Ghosting real,Distance45 real,Distance135 real,Output real,';

table_string3='LaserX real,LaserY real,LaserZ real)';


table_string=strcat(table_string1,table_string2,table_string3);

statement.executeUpdate(table_string);

db_connect=db_connection;


end
