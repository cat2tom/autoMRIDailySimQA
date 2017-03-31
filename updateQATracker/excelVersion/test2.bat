Set WshShell=CreateObject("WScript.Shell")

WshShell.Run chr(34) & "C:\aitangResearch\MRISimQALaserNoImageClinicQATrackOperator\updateQATracker\excelVersion\test.bat" & chr(34),0

#WshShell.Run chr(34) & "C:\aitangResearch\MRISimQALaserNoImageClinicQATrackOperator\updateQATracker\excelVersion\dist\updateQATrack4.exe" & chr(34),0

pause(2)

set WshShell=Nothing

C:\aitangResearch\MRISimQALaserNoImageClinicQATrackOperator\updateQATracker\excelVersion\dist\updateQATrack4.exe &