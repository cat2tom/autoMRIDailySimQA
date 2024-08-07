function  writeDailyQAToTxt2( txtFileName,dailyQACell )
%{ 
Write daily QA resutls to a txt file for later analysis.

Input: 

txtFileName-file name to be written.

dailyQACell-the cell array containing daily QA resutls.

%}

testData=dailyQACell;


tableQA=cell2table(testData,'VariableNames',{'DateTime',	'SNR','Uniformity',...
    'Contrast',	'Ghosting','D45','D135','Output','LaserX',	'LaserY',	'LaserZ'});


writetable(tableQA,txtFileName);

tableQA2=readtable(txtFileName);

if exist(txtFileName,'file')==2
    
   tableQA3=readtable(txtFileName);
   
   tableQASum=[tableQA2;tableQA3];
   
   tableQASum=unique(tableQASum);
   
   writetable(tableQASum,txtFileName);
  
else
    
  writetable(tableQA,txtFileName); 

end 


end

