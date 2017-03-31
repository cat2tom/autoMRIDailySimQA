javaaddpath('C:\aitangResearch\MRI daily QA program\database\sqlite-jdbc-3.8.11.2.jar')
d = org.sqlite.JDBC
p = java.util.Properties()
c = d.createConnection('jdbc:sqlite:sample.db',p) % named file
 
% optional connections
 c = d.createConnection('jdbc:sqlite:C:\aitangResearch\MRI daily QA program\database\sample.db',p) % full path
% c = d.createConnection('jdbc:sqlite::memory:',p) % memory db
% c = d.createConnection('jdbc:sqlite:',p) % default
s = c.createStatement() % create a statement
 
% create a table, insert rows, etc.
s.executeUpdate('create table person2 (id real, name string)');
s.executeUpdate('insert into person values(1.0, "leo")');
s.executeUpdate('insert into person values(2.0, "yui")');
 
% execute query, get id and name
rs = s.executeQuery('select * from person')
while rs.next
    rs.getString('id')
    rs.getString('name')
end
c.close % close connection
c.isClosed
 
