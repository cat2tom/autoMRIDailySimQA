javaaddpath('C:\aitangResearch\MRI daily QA program\database\sqlite-jdbc-3.8.11.2.jar');

abs_path='C:\aitangResearch\MRI daily QA program\database\';

db_name='MRISimQADBLaser.db';

dir_name='C:\aitangResearch\MRISimQALaser\test images\multi day\';

dir_name2='\\ctcphapp01\DCM_RESEARCH_DATA\zzzz_bridge_laser_QA\'; 


[connection,file] = createSQLDataBaseLaser(abs_path,db_name );

[dic,cell,strct] = dailyQAAnalyzerLaser4(dir_name);


db_connection= createDailyQATableLaser(connection );


db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);

% get the resutls.





