

function autoMRISimQADirImage(dirName,pdf_dir)

% this version is to save pdf report to a directory witho images attached
% to the report.

period = 10; %seconds between directory checks

timeout = 500; %seconds before function termination

dirLength = length(dir(dirName));

dirData_last = dir(dirName);      
dirIndex_last = [dirData_last.isdir];   
fileList_last = {dirData_last(~dirIndex_last).name}'; % get the current list of function. 

t1 = timer('TimerFcn', {@autoMRISimQACallbackDir, dirName, dirLength,fileList_last,pdf_dir}, 'Period', period,'TaskstoExecute', uint8(timeout/period), 'executionmode', 'fixedrate');

start(t1)

