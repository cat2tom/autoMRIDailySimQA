function  writeDailyQAToTxt( txtFileName,dailyQACell )
%{ 
Write daily QA resutls to a txt file for later analysis.

Input: 

txtFileName-file name to be written.

dailyQACell-the cell array containing daily QA resutls.

%}

testData=dailyQACell;


newTableQA=cell2table(testData,'VariableNames',{'DateTime',	'SNR','Uniformity',...
    'Contrast',	'Ghosting','D45','D135','Output','LaserX',	'LaserY',	'LaserZ','Operator'});




if exist(txtFileName,'file')==2
    
   oldTableQA=readtable(txtFileName,'Format','%s%f%f%f%f%f%f%f%f%f%f%s');
   
   tableQASum=[oldTableQA;newTableQA];
   
   tableQASum=unique(tableQASum);
   
   writetable(tableQASum,txtFileName);
  
else
    
  writetable(newTableQA,txtFileName); 

end 


end

