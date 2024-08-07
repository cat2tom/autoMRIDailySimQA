javaaddpath('C:\aitangResearch\MRI daily QA program\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRI daily QA program\database\';

db_name='MRISimQADB.db';

dir_name='C:\aitangResearch\MRI daily QA program\sample images\';

dir_name2='\\ctcphapp01\DCM_RESEARCH_DATA\zzzz_bridge_laser_QA\'; 


[connection,file] = createSQLDataBase(abs_path,db_name );

[dic,cell,strct] = dailyQAAnalyzer4(dir_name);


db_connection= createDailyQATable(connection );


db_connection = writeDailyDQA2DataBase(db_connection,cell);

% get the resutls.





