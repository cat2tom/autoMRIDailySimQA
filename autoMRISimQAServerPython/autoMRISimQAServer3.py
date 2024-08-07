import wx
import wx

import wx.grid as gridlib

import wx.lib.scrolledpanel as scrolled

import sys

import os

import imp

import shutil

import sys
import subprocess

import thread


from  ConfigParser import SafeConfigParser



# get the dirs from serverConfig.ini

parser=SafeConfigParser()

parser.read('serverConfig.ini')

autoMRISimQA_Py=parser.get('dirs',"autoMRISimQA_Py")

python_exe=parser.get('dirs','python_exe')

iconFile=parser.get('dirs','iconFile')

#autoMRISimQA_exe=parser.get('dirs','autoMRISimQA_exe',raw=True)

#autoMRISimQA_exe='N:/PROJECTS/MRI Sim project/autoMRISimQA/compiledEXE/testing/autoMRISimQA_V1.exe'

autoMRISimQA_exe='C:/TEMP/autoMRISim.exe'

class ServerFrame(wx.Frame):
    
    def __init__(self, parent, id, title):
        
        
    
        wx.Frame.__init__(self, parent, id, title, (-1, -1), wx.Size(600, 300),\
        style=wx.MINIMIZE_BOX | wx.MAXIMIZE_BOX | wx.SYSTEM_MENU | wx.CAPTION | wx.CLOSE_BOX | wx.CLIP_CHILDREN )
        
        # hold the grouped GUI components into a small panel.
        
        panel = wx.Panel(self, -1)
        
        # make button
        
        
        self.install_button=wx.Button(panel, -1, 'Install')
        self.start_button=wx.Button(panel, -1, 'Start')
        self.stop_button=wx.Button(panel, -1, 'Stop')
        
               
        self.install_button.Bind(wx.EVT_BUTTON,self.OnInstall)
        
        self.start_button.Bind(wx.EVT_BUTTON,self.OnStart)
        
        self.stop_button.Bind(wx.EVT_BUTTON,self.OnStop)
        
        self.status_bar=self.CreateStatusBar()
        
        self.status_bar.SetStatusText('                               ')
        
        # pack the button into a hbox. 
        hbox = wx.BoxSizer(wx.HORIZONTAL)
        
        hbox.AddSpacer(100)
        
        hbox.Add(self.install_button )
        hbox.AddSpacer(60)
        hbox.Add(self.start_button)
        hbox.AddSpacer(60)
        hbox.Add(self.stop_button)
        
        # make an unistall button for main vertical box and second hbox.
        
        self.uninstall_button=wx.Button(panel, -1,'Uninstall')
        
        self.exit_button=wx.Button(panel,-1,'Exit')
        
        self.uninstall_button.Bind(wx.EVT_BUTTON,self.OnUninstall) # connect the events.
        
        self.exit_button.Bind(wx.EVT_BUTTON,self.OnExit)
        
        # create a BoxSizer to pack up the unistall and exit button. 
        hbox2=wx.BoxSizer(wx.HORIZONTAL)
        
        hbox2.AddSpacer(100)
        
        hbox2.Add(self.uninstall_button)
        
        hbox2.AddSpacer(208)
        
        hbox2.Add(self.exit_button)
        
        
        # the main vertical box
        
        vbox=wx.BoxSizer(wx.VERTICAL)
        vbox.AddSpacer(50)
        
        vbox.AddSpacer(hbox)
        
        vbox.AddSpacer(10)
        
        vbox.Add(hbox2)
        
    
        self.SetSizer(vbox)
        
        self.createIcon()
        
        self.Centre()
        
       
    
    def OnUninstall(self,event):
        
        '''
        Callback for uninstall button.
        
        '''
        
        
        
        
        b=subprocess.call([python_exe,autoMRISimQA_Py, '''remove'''])
        
    
        
        
        if b:
            
            self.status_bar.SetStatusText('UnInstalling autoMRISimQA Server failed. Please try again.')
            
        else:
            
            self.status_bar.SetStatusText('The autoMRiSimQA Sever was sucesfully unistalled.')
        
    
    def OnInstall(self,event):
                   
            '''
            Callback for install button.
            
            '''
            
        
                       
            b=subprocess.call([python_exe,autoMRISimQA_Py, '''install'''])
            
            print b
            
            
            if b:
                
                self.status_bar.SetStatusText('Installing autoMRISimQA Server failed. Please try again.')
                
            else:
                
                self.status_bar.SetStatusText('The autoMRiSimQA Sever was sucesfully installed')


    
    def OnStart(self,event):
        
        '''
        Call back for start button.
        '''
                         
        a=subprocess.call([python_exe,autoMRISimQA_Py,'''start'''])
        
        #a=subprocess.call([autoMRISimQA_exe])
        
        if a:
            
            self.status_bar.SetStatusText('Starting autoMRISimQA Server failed. Please try again.')
            
        else:
            
            self.status_bar.SetStatusText('The autoMRISimQA Sever was sucesfully Started.')
        
       
        
    def OnStop(self,event):
        
        '''
        Callback for stop button.
        '''
        
                   
        c=subprocess.call([python_exe,autoMRISimQA_Py,'''stop'''])
        
        #c=subprocess.call(['C:\Windows\System32\Taskkill.exe','/F', '/IM', 'autoMRISim.exe','/T'])
        
        
        if c:
            
            self.status_bar.SetStatusText('Stopping autoMRISimQA Server failed. Please try again.')
            
        else:
            
            self.status_bar.SetStatusText('The autoMRISimQA Sever was sucesfully stopped.')
            
            
    def OnExit(self,event):
        
        '''
        Callback button for exit button. 
             
        '''
        self.Destroy()
        
        
        
    def createIcon(self):
        

        
        icon1 = wx.Icon(iconFile, wx.BITMAP_TYPE_ICO)
        self.SetIcon(icon1)
      

class ServerApp(wx.App):
    
     def OnInit(self):
        
        
        
         frame = ServerFrame(None, -1, 'autoMRISimQA Server V1.0')
         frame.Show(True)
         return True

app = ServerApp(0)

app.MainLoop()