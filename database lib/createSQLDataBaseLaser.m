function [connection,db_file] = createSQLDataBaseLaser(abs_path,db_name )
%{

Create a database given the path and database name and return connections. 

Input: abs_path-the absolute path
       db_name-database name, eg. *.db


output:connection-connection to the database.
       db_file-full path of db file name.
      

%}   

% add database jar file into dynamic java class path.

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/sqlite-jdbc-3.8.11.2.jar','-end')

% load the drive 
d = org.sqlite.JDBC;
p = java.util.Properties();

 
% optional connections

 full_name=fullfile(abs_path,db_name);
 
% get combine full nane with drive
   
 jdbc=strcat('jdbc:sqlite:',full_name);
 
% create database and establish connection.
 c = d.createConnection(jdbc,p);
 
% 
 connection=c;
 
 db_file=full_name;

end

