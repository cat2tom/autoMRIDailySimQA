function varargout = autoMRISimQAEmailMonitoring(varargin)
% AUTOMRISIMQAEMAILMONITORING MATLAB code for autoMRISimQAEmailMonitoring.fig
%      AUTOMRISIMQAEMAILMONITORING, by itself, creates a new AUTOMRISIMQAEMAILMONITORING or raises the existing
%      singleton*.
%
%      H = AUTOMRISIMQAEMAILMONITORING returns the handle to a new AUTOMRISIMQAEMAILMONITORING or the handle to
%      the existing singleton*.
%
%      AUTOMRISIMQAEMAILMONITORING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOMRISIMQAEMAILMONITORING.M with the given input arguments.
%
%      AUTOMRISIMQAEMAILMONITORING('Property','Value',...) creates a new AUTOMRISIMQAEMAILMONITORING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autoMRISimQAEmailMonitoring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autoMRISimQAEmailMonitoring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autoMRISimQAEmailMonitoring

% Last Modified by GUIDE v2.5 08-Mar-2016 11:12:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autoMRISimQAEmailMonitoring_OpeningFcn, ...
                   'gui_OutputFcn',  @autoMRISimQAEmailMonitoring_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before autoMRISimQAEmailMonitoring is made visible.
function autoMRISimQAEmailMonitoring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autoMRISimQAEmailMonitoring (see VARARGIN)

% set axis off and ticks off for display imaging




% read program plogo images.


logo1=imread('N:/PROJECTS/MRI Sim project/autoMRISimQA/compiledMonitroEXE/logo/e-mail_logo.png');

axes(handles.plogo);

imagesc(logo1);

set(handles.plogo,'xtick',[],'ytick',[])

% read hospital plogo.

logo_im2=imread('N:/PROJECTS/MRI Sim project/autoMRISimQA/compiledEXE/logo/hospital.jpg');

axes(handles.hospital_logo);

imagesc(logo_im2);
set(handles.hospital_logo,'xtick',[],'ytick',[])


% to charge if the server is runing using tasklist commond.

cmd_string=strcat('TaskList  /fi',{'  '}, '"', 'imagename eq  autoMonitorMRISimDailyQA.exe','"');

[status,cmdout]=system(cmd_string{1}); % to find if the program is runing. 

runing_status=strfind(cmdout,'autoMonitor');

if runing_status
    
    set(handles.status,'String','E-mail Monitoring Server is running.');
    
    % if it is running, killit. 
    
    a=strcat('taskkill /f  /fi  ',{' '},'"','imagename eq autoMonitorMRISimDailyQA.exe','"'); % command string

   [status,cmdout]=system(a{1}); % kill the process
   
   set(handles.status,'String','E-mail Monitoring Server is not running.')% set the status not running.
   
   
    
else
    
     set(handles.status,'String','E-mail Monitoring Server is not running.')
    
end 



% Choose default command line output for autoMRISimQAEmailMonitoring
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes autoMRISimQAEmailMonitoring wait for user response (see UIRESUME)
% uiwait(handles.main_figure);


% --- Outputs from this function are returned to the command line.
function varargout = autoMRISimQAEmailMonitoring_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set the server status 

 set(handles.status,'String','E-mail Monitoring Server is running.')

% exe path to start the sever.

autoMRISimExe='"N:/PROJECTS/MRI Sim project/autoMRISimQA/compiledMonitroEXE/testing/autoMonitorMRISimDailyQA.exe"';

system(autoMRISimExe);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=strcat('taskkill /f  /fi  ',{' '},'"','imagename eq autoMonitorMRISimDailyQA.exe','"'); % command string

[status,cmdout]=system(a{1}); % kill the process

results=strfind(cmdout,'SUCCESS');


if results
    
 set(handles.status,'String','E-mail Monitoring Server was terminated.'); 
    
    
end 


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.main_figure);
