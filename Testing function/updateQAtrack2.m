%  a='C:\aitangResearch\MRISimQALaserNoImageClinic\updateQATracker\dist\updateQATrack.exe';

a='N:/PROJECTS/MRISimProject/autoMRISimQA/updateQATrackExe/updateQATrack.exe';

b=['10'  '25'  '45' '78' '90' '100'  '9' '89' '23' '34'];

bb=strcat('10',{' '},'20',{' '},'30',{' '},'40',{' '},'50',{'  '}, '60',{' '},'30',{' '},'40',{' '},'50',{' '}, '60',{' '},'test');
    
        


dd=strcat(a,{'  '},bb{1})

[status,cmdout]=system(dd{1})