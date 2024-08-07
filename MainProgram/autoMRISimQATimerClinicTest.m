
%{
This is the timer verson of autoMRISimQA. Using timer saved a lot of
computer resource. 

On 15/04/2016, this is the clinically workable version. It is much stable
to update the QA track automatically. use timer object to do asychronised
process to make sure the external command works well. It the one of model
regarding how Matlab interacts with other language-made program.

This is the main fucntion for automMRISimQATimer version.

%}

% read dirs configurations. When the program was compiled, the excel file
% has to be added as resource file into file list. 

loadJARs;

dirs=readConfig('C:\autoMRISimQAResource\dirsConfigFile\dirConfig.ini'); % This is only for clinical use.


% establish the object to make sure using fixedSpacing option.
t=timer('ExecutionMode','fixedSpacing','Period',60);

% start dely in seconds
t.StartDelay=1; % In order to make compiled exe to work, the dely has to be zero or one.

% set the callback.
t.TimerFcn={@autoMRISimQATrackOperatorFileWinTaskOldTimerCallback,dirs};

% set stop function used by stop command.

t.StopFcn=@(x,y) delete(timerfindall);

% start the timer object but no stop. 

start(t);




