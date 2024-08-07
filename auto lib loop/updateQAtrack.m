function  updateQAtrack(update_exe_path,img_cell1)

%{
 To update the QA track record using python exe. 

 Input: update_exe-the path to python exe
        img_cell-the cell containing QA results.

%}

%if the img_cell is 2D then going through each row.

[row,col]=size(img_cell1);

for k=1:row

    pause(60);
    img_cell=img_cell1(k,:);
  
    % concatenate all the resutls into a string.

    bb=strcat(num2str(img_cell{2}),{' '},num2str(img_cell{3}),{' '}, ...
        num2str(img_cell{4}),{' '},num2str(img_cell{5}),{' '},...
        num2str(img_cell{6}),{'  '}, num2str(img_cell{7}),{' '},...
        num2str(img_cell{8}),{' '},num2str(img_cell{9}),{' '},...
        num2str(img_cell{10}),{' '}, num2str(img_cell{11}));
    
    %Assemble the command line for system command.

    dd=strcat(update_exe_path,{'  '},bb{1});


    [status,cmdout]=system(dd{1});
    
    pause(60);

end 
end 