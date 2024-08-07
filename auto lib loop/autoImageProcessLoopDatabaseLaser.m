
function autoImageProcessLoopDatabaseLaser(image_dir_name, db_connection,excel_file,pdf_dir,tol_file2)

%{
Description: this is the main fucntion which processes the images, extract
QA parameters and generate PDF report.

Input: image_dir_name-directory where all MRI images are stored. 

       pdf_dir-direcory where the pdf reports are stored.

       exel_file-excel file name with full path where QA resutls were saved.

       tol_file2-the tolerance file


Notice: this version has no images added to the pdf report. 
        added write to excel file function. 

        added database connection.
        added laser support.

%}

% 


% get the file list before loop starts.

dir_content =dir(image_dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;


current_files = filenames;

% use an infinite loop to keep the things always going. 


while true
    
    % set the weitting period before starting the automatic processing.
    pause(60)% pause 10s to slow down the process and may be longer or 30 minutes.
    
    dir_content = dir(image_dir_name);
    dirIndex_last = [dir_content.isdir];   
    fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
    filenames =fileList_last;

      
    new_files = setdiff(filenames,current_files);
    if ~isempty(new_files)
        
        % process the new files.
        
               
       disp( [ 'total: '  num2str(length(new_files)) ' :new file were found.']) 
       
       % Set the number of new imags to be 11 as each QA images contains 11
       % images. 
       if rem(length(new_files),11)==0 % as 11images for each QA, then to see if all 10 images arrived.
                      
           % the key part for auto processing the images and auto report
           % generation.
           
           % full path to the file which are required by 
           
           new_files=fullfile(image_dir_name,new_files);
           
           % do the job.
           [dic,cell,strct] = dailyQAAnalyzerFileListLaser(new_files); % cell is a dict containing all
           
           %close all figures after all analysis
           
           close all;
           
           % use cell containing QA resutls to write to an excel
           
           writeDailyQAToExcelFileLaser(excel_file,cell);
           
           % use the cell containing QA resutls to generate pdf report. 
           
           generateMultiDailyQAReportTolDirLaser(cell,tol_file2,'Val',pdf_dir); % changed to val for laser support.
           
           % write resutls into an database.
           
             %% ceate daily QA table if it does not exist.
             
            db_connection= createDailyQATableLaser(db_connection );
            
             %% write QA results into a database.
            
            db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);
             
                   
           close all
           
       end 
       
     
        
        % assign the current file to new current files.
        
        current_files = filenames;
        
    else
        
        fprintf('no new files\n')
        
    end
    
    
    pause(60)% pause 10s to slow down the process and may be longer or 30 minutes.
    
    
end