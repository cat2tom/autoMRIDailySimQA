function dirs = readConfig(conFigFileName )
%{
Wrapped up functions to read readConfFigle in order to read into a cell.
%}



[imDir,dbPath,dbName,pdfDir,qaTrackExe,matFile,jarPath,dbJarFile,tolFile,qaExcel] = readConfigFile(conFigFileName );


dirs{1}=dbJarFile;

dirs{2}=dbPath;

dirs{3}=dbName;

dirs{4}=tolFile;

dirs{5}=imDir;

dirs{6}=pdfDir;

dirs{7}=qaExcel;

dirs{8}=qaTrackExe;

dirs{9}=matFile;

end

