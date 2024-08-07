function [ output_args ] = writeToExcelFile2(full_file_name,image_quality_data)
%{

Write an one dimentional cell array to an excel file. If the file exist,
read data from  it and add new data. rewrite the data into it. Assume that
the new data cell has same number colum as the data exisitng in excel file.


%}   
  if ~exist(full_file_name,'file')
      
      xlswrite(full_file_name,image_quality_data);
      
  else

    try
		% See if there is an existing instance of Excel running.
		% If Excel is NOT running, this will throw an error and send us to the catch block below.
		Excel = actxGetRunningServer('Excel.Application');
		% If there was no error, then we were able to connect to it.
	catch
		% No instance of Excel is currently running.  Create a new one.
		% Normally you'll get here (because Excel is not usually running when you run this).
		Excel = actxserver('Excel.Application');   
    end
    
    
    % Part 1: CREATE A NEW WORKBOOK AND WRITE STUFF INTO IT.
	Excel.visible = false; % Make Excel appear so we can see it, otherwise it is hidden.

	% Right now, Excel is open but there is no workbook in it. (You'll see this if you maximize Excel.)
	% Add a new workbook.  
	ExcelWorkbook = Excel.workbooks.Add;
	% It will have now have one sheet in it, called Sheet1, which is what Excel calls newly created sheets by default.
	% Let's rename the sheet 'mySheetName'.
	ExcelWorkbook.ActiveSheet.Name = 'MRISimDailyQA';
	% Tell it to not wait and pop up alerts like "This file exists.  Do you want to overwrite it."
	Excel.DisplayAlerts = false;
    
    % use excel built-in fuction to read data
    
    [excel_data,row,col]= readExcelFile(full_file_name);
    
    % get new data size
    
    [row2,col2]=size(image_quality_data);
    
     
   
    [row2,col2]=size(image_quality_data);
    

    
    excel_data(row+1:row2+row,1:8)=image_quality_data;
    
    
    % set new range object
    
    new_range=strcat('A',num2str(row+1),':','H',num2str(row+row2))
    
    Excel.Activesheet.Cells.Clear; % clear all data before write.
    
    active_sheet_range_obj=Excel.Activesheet.get('Range',new_range);
    
 
    
    active_sheet_range_obj.Value=excel_data;
    
    
        
	% Save this workbook we just created to disk.
	ExcelWorkbook.SaveAs(full_file_name);
	% Close the workbook.  This will show you how you can open an existing workbook if Excel is already open.
	
	
	
    
  end 
    
end 