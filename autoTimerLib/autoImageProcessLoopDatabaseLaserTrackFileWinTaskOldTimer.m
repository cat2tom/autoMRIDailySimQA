
function autoImageProcessLoopDatabaseLaserTrackFileWinTaskOldTimer(image_dir_name, qatrack_exe, db_connection,excel_file,pdf_dir,tol_file2,mat_file)

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
        

%}

% loadJARs;

% java package has to be added locally. Otherwise it will not works.

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itextpdf-5.5.7.jar','-end')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itext-pdfa-5.5.7.jar','-end')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/itext-xtra-5.5.7.jar','-end')

javaaddpath('C:/autoMRISimQAResource/javaJarFiles/sqlite-jdbc-3.8.11.2.jar','-end')


javaaddpath('C:/autoMRISimQAResource/javaJarFiles')



% Read file from the matfile to get the file list last time 

previousFileList={}; % holding the file list before the loop start

% mat file is located in N drive.

% mat_file='N:/PROJECTS/MRISimProject/autoMRISimQA/matFile/imageListCellTest.mat';

if exist(mat_file,'file')==2
    
    mat_obj=matfile(mat_file,'Writable',true);
    
    previousFileList=mat_obj.previousFileList;
    
    
else   
    
     save(mat_file,'previousFileList');
    
end 

% copy the images file to a writable directory 

% get the file list before loop starts.

dir_content =dir(image_dir_name);

dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;


current_files = filenames;


% pre process the file list before loop starts.

pNewFileList=setdiff(current_files,previousFileList);

% copy the new file list to writable temporay directory

% pNewFileList3=fullfile(image_dir_name,pNewFileList); % get full list;
% if ~isempty(pNewFileList)
%     
%    for j=1:length(pNewFileList)
%     
%     pNewFileList3=fullfile(image_dir_name,pNewFileList); % get full list;
%     
%     if ~(exist('C:\autoMRItmp','dir')==7)
%         mkdir('C:\autoMRItmp');
%     end 
%     
%     copyfile(pNewFileList3{j},'C:\autoMRItmp'); % to avoid not updating the qa track due to the write permission.
%     
%    end 
% 
% end 


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
            
            %pNewFileList2=fullfile('C:\autoMRItmp',pNewFileList);
           
           % do the job.
            [dic,cell,op_cell,strct] = dailyQAAnalyzerFileListLaserOperator(pNewFileList2); % cell is a dict containing all
           
            % write resutls to tmp.txt.
            
            cell2=[cell op_cell'];
            tmpResult2=cell2table(cell2);
            
            tmpFileName='C:\autoMRISimQAResource\tmpResult\tmp.txt';
            
            %writetable(tmpResult2,tmpFileName);
            
            writeDailyQAToTxt(tmpFileName,cell2);
            
            % call updateQATRack5 to read from txt files. Disable the QA
            % tracdk update in Matlab.
            
            %[status,cmdout]=system('start C:\autoMRISimQAResource\updateQATrackExe\updateQATrack5.exe')
            
%            % added function to update QA track.
%            
%             cell_track=cell;
%             
%             op_cell_track=op_cell;          
%                                 
%             updateQAtrackOperator(qatrack_exe,cell_track,op_cell_track);    
%              
                 
           
           %close all figures after all analysis
           
            %close all;
           
           % use cell containing QA resutls to write to an excel
           
            % disable excel function for server version 
           
            %writeDailyQAToExcelFileLaser(excel_file,cell); 
            
           % write the daily QA resutls to text file for analysis and
           % recored.
           
           writeDailyQAToTxt(excel_file,cell2);
           
           % use the cell containing QA resutls to generate pdf report. 
           
        
           
            pdf_cell=cell;
            
            generateMultiDailyQAReportTolDirLaserConfig(pdf_cell,tol_file2,'Val',pdf_dir); % changed to val for laser support.
           
           % write resutls into an database.
           
             %% ceate daily QA table if it does not exist.
             
            db_connection= createDailyQATableLaser(db_connection );
            
             %% write QA results into a database.
            
            db_connection = writeDailyDQA2DataBaseLaser(db_connection,cell);
             
             
%            % added function to update QA track.
%            
%             cell_track=cell;
%             
%             op_cell_track=op_cell;
%                       
%             updateQAtrackOperator(qatrack_exe,cell_track,op_cell_track);    
%              
            
            
           close all
           
       end
       
end 

% after finished write the differnce to file


previousFileList=[ previousFileList; pNewFileList(:) ]; % flatten the file and concatenate two files. 


save(mat_file,'previousFileList');

% cleanup to delete temp files.
%delete('C:\autoMRItmp\*.*');
%     
 end