
% This program provided another way to check the update of a directory.  

dir_content = dir;
filenames = {dir_content.name};
current_files = filenames;
while true
  dir_content = dir;
  filenames = {dir_content.name};
  new_files = setdiff(filenames,current_files);
  if ~isempty(new_files)
    % deal with the new files
    
    new_files
    
    current_files = filenames;
  else
    fprintf('no new files\n')
  end
end