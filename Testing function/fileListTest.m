
dir_name=pwd;
dir_content =dir(dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames1 =fileList_last;

filenames2=fileList_last;

ab=[filenames1;filenames2]
