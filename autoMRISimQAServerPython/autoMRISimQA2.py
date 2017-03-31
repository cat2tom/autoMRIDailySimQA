
## this function implemented auto-plan checking as window service and used as a callback for planCheckerSeverGUI.


import win32service
import win32serviceutil
import win32api
import win32con
import win32event
import win32evtlogutil
import os, sys, string, time

import subprocess

import getopt


from ConfigParser import SafeConfigParser

# get dirs from configure files 

#parser=SafeConfigParser()

#parser.read('serverConfig.ini')

#autoMRISimQA_exe=parser.get('dirs','autoMRISimQA_exe',raw=True)

#matlab_exe1=parser.get('dirs','matlab_exe')

#autoMRISimQA_Mb1=parser.get('dirs','autoMRISimQA_Mb')

#matlab_exe=str(matlab_exe)

#autoMRISimQA_Mb=str(autoMRISimQA_Mb)


# the maltab exe paht and matlab script has to be put here for some reason and can not placed in configure file.

#matlab_exe='D:\\Program Files\\matlab2015a\\bin\\matlab.exe'

#autoMRISimQA_Mb='C:/aitangResearch/MRISimQALaserNoImage/auto lib loop/autoMRISimQA.m'

#autoMRISimQA_Mb='C:/aitangResearch/MRISimQALaserNoImage/auto lib loop/autoMRISimQA.m'

#autoMRISimQA_exe='N:/PROJECTS/MRI Sim project/autoMRISimQA/compiledEXE/testing/autoMRISimQA_V1.exe'

autoMRISimQA_exe='C:/TEMP/autoMRISim.exe'

class aservice(win32serviceutil.ServiceFramework):
   
   _svc_name_ = "autoMRISimQA"
   _svc_display_name_ = "autoMRISimQA"
   _svc_description_ = "autoMRISimQA is running at Backgroud and automatically analyzing daily MRI images.!"
         
   def __init__(self, args):
           win32serviceutil.ServiceFramework.__init__(self, args)
           self.hWaitStop = win32event.CreateEvent(None, 0, 0, None) 
           
          
                       

   def SvcStop(self):
           self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
           win32event.SetEvent(self.hWaitStop)                    
         
   def SvcDoRun(self):
      import servicemanager    
      
     
      
      servicemanager.LogMsg(servicemanager.EVENTLOG_INFORMATION_TYPE,servicemanager.PYS_SERVICE_STARTED,(self._svc_name_, ''))
     
      #self.timeout = 640000    #640 seconds / 10 minutes (value is in milliseconds)
      self.timeout = 240000     #120 seconds / 2 minutes 60000
      # This is how long the service will wait to run / refresh itself (see script below)

      while 1:
         # Wait for service stop signal, if I timeout, loop again
         rc = win32event.WaitForSingleObject(self.hWaitStop, self.timeout)
         # Check to see if self.hWaitStop happened
         if rc == win32event.WAIT_OBJECT_0:
            # Stop signal encountered
            servicemanager.LogInfoMsg("SomeShortNameVersion - STOPPED!")  #For Event Log
            break
         else:

                 #Ok, here's the real money shot right here.
                 #[actual service code between rests]
                 try:
                    
                                                         
                     subprocess.call([autoMRISimQA_exe])

                
                     
                 except:
                     pass
                 #[actual service code between rests]


def ctrlHandler(ctrlType):
   return True
                 
if __name__ == '__main__':  
   win32api.SetConsoleCtrlHandler(ctrlHandler, True)  
   win32serviceutil.HandleCommandLine(aservice)

   

# Done! Lets go out and get some dinner, bitches!