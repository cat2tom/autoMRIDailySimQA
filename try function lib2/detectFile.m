function detectFile(dirName)
%{
This function will find the new file added to the directory. 

%}



period = 10; %seconds between directory checks

timeout = 500; %seconds before function termination

dirLength = length(dir(dirName));

% list all the files before timer.
dirData = dir(dirName);
dirIndex = [dirData.isdir];
fileList0 = {dirData(~dirIndex).name}';

t = timer('TimerFcn', {@detectFileCallBack, dirName, dirLength,fileList0}, 'Period', period,'TaskstoExecute', uint8(timeout/period), 'executionmode', 'fixedrate');

start(t)
end 