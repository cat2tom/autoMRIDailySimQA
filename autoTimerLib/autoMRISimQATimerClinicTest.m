
%{
This is the timer verson of autoMRISimQA. Using timer saved a lot of
computer resource. 

On 15/04/2016, this is the clinically workable version. It is much stable
to update the QA track automatically. use timer object to do asychronised
process to make sure the external command works well. It the one of model
regarding how Matlab interacts with other language-made program.

05/02/2024. The timer object was removed. 

This is the main fucntion for automMRISimQATimer version.

%}

% read dirs configurations. When the program was compiled, the excel file
% has to be added as resource file into file list. 

loadJARs;

dirs=readConfig('C:\autoMRISimQAResource\dirsConfigFile\dirConfig.ini'); % This is only for clinical use.


autoMRISimQATrackOperatorFileWinTask(dirs)



