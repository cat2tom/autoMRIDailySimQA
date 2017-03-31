t=timer('ExecutionMode','fixedSpacing','Period',120);

t.StartDelay=1;

t.TimerFcn=@autoMRISimQATrackOperatorFileWinTaskOldFunction;

t.StopFcn=@(x,y) delete(timerfindall);

start(t)

