
function autoImageProcessLoopDatabaseLaserTrackFileWinTask(image_dir_name, qatrack_exe, db_connection,excel_file,pdf_dir,tol_file2)

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
        added file list support. Save a file list into a .mat file. Then 
        Next time when the server restarts, it will pick up whatever was
        left last time. 

        This version  is intenede to be used along with window task to run the program. 

        changed to use excel file to record the number of patients
        analysed.
        

%}

% Read file from the matfile to get the file list last time 

previousFileList={}; % holding the file list before the loop start

% mat file is located in N drive.

mat_file='N:/PROJECTS/MRISimProject/autoMRISimQA/matFile/imageListCell.mat';

if exist(mat_file,'file')==2
    
    mat_obj=matfile(mat_file,'Writable',true);
    
    previousFileList=mat_obj.previousFileList;
    
    
else   
    
     save(mat_file,'previousFileList');
    
end 



% get the file list before loop starts.

dir_content =dir(image_dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;


current_files = filenames;


% pre process the file list before loop starts.

pNewFileList=setdiff(current_files,previousFileList);


%pNewFileList=fullfile(image_dir_name,pNewFileList);

if ~isempty(pNewFileList)
        
        % process the new files.
        
               
       disp( [ 'total: '  num2str(length(pNewFileList)) ' :new file were found before the loop starts.']) 
       
       % Set the number of new imags to be 11 as each QA images contains 11
       % images. 
       if rem(length(pNewFileList),11)==0 % as 11images for each QA, then to see if all 10 images arrived.
                      
           % the key part for auto processing the images and auto report
           % generation.
           
           % full path to the file which are required by 
           
            pNewFileList2=fullfile(image_dir_name,pNewFileList);
           
           % do the job.
            [dic,cell,op_cell,strct] = dailyQAAnalyzerFileListLaserOperator(pNewFileList2); % cell is a dict containing all
           
           % added function to update QA track.
           
            pause(60);
           
            updateQAtrackOperator(qatrack_exe,cell,op_cell);
           
           
            pause(60);
            
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
       
end 

% after finished write the differnce to file


previousFileList=[ previousFileList; pNewFileList(:) ]; % flatten the file and concatenate two files. 


save(mat_file,'previousFileList');

% use an infinite loop to keep the things always going. 


% while true
%     
%     % set the weitting period before starting the automatic processing.
%     pause(60)% pause 10s to slow down the process and may be longer or 30 minutes.
%     
%     dir_content = dir(image_dir_name);
%     dirIndex_last = [dir_content.isdir];   
%     fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
%     filenames =fileList_last;
% 
%       
%     new_files = setdiff(filenames,current_files);
%     
%     if ~isempty(new_files)
%         
%         % write the difference to file list
%         
%         previousFileList=[ previousFileList ; new_files(:)  ];
%         
%         save(mat_file,'previousFileList');
%         
%         % process the new files.
%                        
%        disp( [ 'total: '  num2str(length(new_files)) ' :new file were found.']) 
%        
%        % Set the number of new imags to be 11 as each QA images contains 11
%        % images. 
%        if rem(length(new_files),11)==0 % as 11images for each QA, then to see if all 10 images arrived.
%                       
%            % the key part for auto processing the images and auto report
%            % generation.
%            
%            % full path to the file which are required by 
%            
%            new_files=fullfile(image_dir_name,new_files);
%            
%            % do the job.
%            [dic,cell,op_cell,strct] = dailyQAAnalyzerFileListLaserOperator(new_files); % cell is a dict containing all
%            
%            % added function to update QA track.
%            
%            updateQAtrackOperator(qatrack_exe,cell,op_cell);
%            
%            
%            %close all figures after all analysis
%            
%            close all;
%            
%            % use cell containing QA resutls to write to an excel
%            
%            writeDailyQAToExcelFileLaser(excel_file,cell);
%            
%            % use the cell containing QA resutls to generate pdf report. 
%            
%            generateMultiDailyQAReportTolDirLaser(cell,tol_file2,'Val',pdf_dir); % changed to val for laser support.
%            
%            % write resutls into an database.
%            
%              %% ceate daily QA table if it does not exist.
%              
%             db_connection= createDailyQATableLaser(db_connection );
%             
%              %% write QA results into a database.
%             
%             db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);
%              
%             
%            close all
%            
%        end 
%        
%             
%         % assign the current file to new current files.
%         
%         current_files = filenames;
%         
%     else
%         
%         fprintf('no new files\n')
%         
%     end
%     
%     
%     pause(60)% pause 10s to slow down the process and may be longer or 30 minutes.
%     
%     
 end