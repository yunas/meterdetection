function varargout = MeterDetectionGui(varargin)
% METERDETECTIONGUI MATLAB code for MeterDetectionGui.fig
%      METERDETECTIONGUI, by itself, creates a new METERDETECTIONGUI or raises the existing
%      singleton*.
%
%      H = METERDETECTIONGUI returns the handle to a new METERDETECTIONGUI or the handle to
%      the existing singleton*.
%
%      METERDETECTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in METERDETECTIONGUI.M with the given input arguments.
%
%      METERDETECTIONGUI('Property','Value',...) creates a new METERDETECTIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MeterDetectionGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MeterDetectionGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MeterDetectionGui

% Last Modified by GUIDE v2.5 10-Oct-2013 13:33:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MeterDetectionGui_OpeningFcn, ...
                   'gui_OutputFcn',  @MeterDetectionGui_OutputFcn, ...
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


% --- Executes just before MeterDetectionGui is made visible.
function MeterDetectionGui_OpeningFcn(hObject, eventdata, handles, varargin)

global imageName;
imageName = 'meter1.JPG';

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MeterDetectionGui (see VARARGIN)

% Choose default command line output for MeterDetectionGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MeterDetectionGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MeterDetectionGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)



global I;
global imageName ;

I = MD_LoadImage (imageName);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global I;
global edgedImage;
edgedImage = MD_ImgByApplyingEdgeDetection(I);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global edgedImage;
global croppedRect;
croppedRect = MD_GetMeterRect(edgedImage);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global croppedRect;
global I;
global meterImg;

meterImg = MD_GetMeterImage (I,croppedRect);
emptyImage = zeros;
figure;
imshow(meterImg);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

list=get(handles.popupmenu1,'String'); 
selectedValue = list{get(handles.popupmenu1,'Value')};

global imageName ;

if (strcmp(selectedValue, 'Meter Image 1'))

    imageName = 'meter1.JPG';
    
elseif (strcmp(selectedValue, 'Meter Image 2'))
    
        imageName = 'meter2.JPG';
    
elseif (strcmp(selectedValue, 'Meter Image 3'))

        imageName = 'meter3.JPG';
        
else
        
        imageName = 'meter4.JPG';

end
    
fprintf('imageName %s\n',imageName);
global I;

I = MD_LoadImage (imageName);

fprintf('%s\n',selectedValue);




% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global meterImg;
% SegmentImage (meterImg);
watershedSegmentation(meterImg);

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
