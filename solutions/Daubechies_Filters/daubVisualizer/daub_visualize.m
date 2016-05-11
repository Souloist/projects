% Created by Richard Shen
% DSP II

function varargout = daub_visualize(varargin)
% DAUB_VISUALIZE MATLAB code for daub_visualize.fig
%      DAUB_VISUALIZE, by itself, creates a new DAUB_VISUALIZE or raises the existing
%      singleton*.
%
%      H = DAUB_VISUALIZE returns the handle to a new DAUB_VISUALIZE or the handle to
%      the existing singleton*.
%
%      DAUB_VISUALIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAUB_VISUALIZE.M with the given input arguments.
%
%      DAUB_VISUALIZE('Property','Value',...) creates a new DAUB_VISUALIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before daub_visualize_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to daub_visualize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help daub_visualize

% Last Modified by GUIDE v2.5 10-May-2016 17:00:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @daub_visualize_OpeningFcn, ...
                   'gui_OutputFcn',  @daub_visualize_OutputFcn, ...
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


% --- Executes just before daub_visualize is made visible.
function daub_visualize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to daub_visualize (see VARARGIN)

% Choose default command line output for daub_visualize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes daub_visualize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = daub_visualize_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in filter_length.
function filter_length_Callback(hObject, eventdata, handles)
% hObject    handle to filter_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filter_length contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filter_length


% --- Executes during object creation, after setting all properties.
function filter_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.filter_length,'Value',1);
set(handles.graph_type,'Value',1);
set(handles.text4,'String','');
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
set(handles.text5,'String','');
set(handles.text6,'String','');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filterLength = get(handles.filter_length, 'Value');
graphType = get(handles.graph_type,'Value');

% error checking
if  filterLength == 1 && graphType == 1;
        set(handles.text4,'String','Error - Please choose a length and graph');
    elseif filterLength == 1;
        set(handles.text4,'String','Error - Please choose a length');
    elseif graphType == 1;
        set(handles.text4,'String','Error - Please choose a graph');
        
% calculations and graphing

% length four filter
elseif filterLength == 2 && graphType == 2;
    set(handles.text5,'String', 'Impulse Response, HP Length 4');
    set(handles.text6,'String','Impulse Response, LP Length 4');
    
    % low pass
    cla(handles.axes1,'reset');
    [h1, b1, Hf] = low_pass_daub(4);
    axes(handles.axes1);
    stem(handles.axes1,h1);
    
    % high pass
    cla(handles.axes2,'reset');
    [hh, hb, HHf] = high_pass_daub(4);
    axes(handles.axes1);    
    stem(handles.axes2,hh);

elseif filterLength == 2 && graphType == 3;
    set(handles.text5,'String', 'Z Plane, HP Length 4');
    set(handles.text6,'String','Z Plane, LP Length 4');
    
    % low pass
    cla(handles.axes1,'reset');   
    axes(handles.axes1);
    [h1, b1, Hf] = low_pass_daub(4);    
    zplane(handles.axes1,b1,1);
    
    % high pass
    cla(handles.axes2,'reset');   
    axes(handles.axes2);
    [hh, hb, HHf] = high_pass_daub(4);    
    zplane(handles.axes2,hb,1);    
    
elseif filterLength == 2 && graphType == 4;
    set(handles.text5,'String', '|H^f(\omega)|, HP Length 4');
    set(handles.text6,'String','|H^f(\omega)|, LP Length 4');
    
    % low pass
    cla(handles.axes1,'reset');    
    [h1, b1, Hf] = low_pass_daub(4);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes1);
    plot(handles.axes1,om/(2*pi), abs(Hf));
    xlabel('\omega/(2\pi)');
    
    % high pass
    cla(handles.axes2,'reset');    
    [hh, hb, HHf] = high_pass_daub(4);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes2);
    plot(handles.axes2,om/(2*pi), abs(HHf));
    xlabel('\omega/(2\pi)');    

% length six filter
elseif filterLength == 3 && graphType == 2;
    set(handles.text5,'String', 'Impulse Response, HP Length 6');
    set(handles.text6,'String','Impulse Response, LP Length 6');
    
    % low pass
    cla(handles.axes1,'reset');
    [h1, b1, Hf] = low_pass_daub(6);
    axes(handles.axes1);
    stem(handles.axes1,h1);
    
    % high pass
    cla(handles.axes2,'reset');
    [hh, hb, HHf] = high_pass_daub(6);
    axes(handles.axes1);    
    stem(handles.axes2,hh);

elseif filterLength == 3 && graphType == 3;
    set(handles.text5,'String', 'Z Plane, HP Length 6');
    set(handles.text6,'String','Z Plane, LP Length 6');
    
    % low pass
    cla(handles.axes1,'reset');   
    axes(handles.axes1);
    [h1, b1, Hf] = low_pass_daub(6);    
    zplane(handles.axes1,b1,1);
    
    % high pass
    cla(handles.axes2,'reset');   
    axes(handles.axes2);
    [hh, hb, HHf] = high_pass_daub(6);    
    zplane(handles.axes2,hb,1);    
    
elseif filterLength == 3 && graphType == 4;
    set(handles.text5,'String', '|H^f(\omega)|, HP Length 6');
    set(handles.text6,'String','|H^f(\omega)|, LP Length 6');
    
    % low pass
    cla(handles.axes1,'reset');    
    [h1, b1, Hf] = low_pass_daub(6);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes1);
    plot(handles.axes1,om/(2*pi), abs(Hf));
    xlabel('\omega/(2\pi)');
    
    % high pass
    cla(handles.axes2,'reset');    
    [hh, hb, HHf] = high_pass_daub(6);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes2);
    plot(handles.axes2,om/(2*pi), abs(HHf));
    xlabel('\omega/(2\pi)');  
    
% length eight filter
elseif filterLength == 4 && graphType == 2;
    set(handles.text5,'String', 'Impulse Response, HP Length 8');
    set(handles.text6,'String','Impulse Response, LP Length 8');
    
    % low pass
    cla(handles.axes1,'reset');
    [h1, b1, Hf] = low_pass_daub(8);
    axes(handles.axes1);
    stem(handles.axes1,h1);
    
    % high pass
    cla(handles.axes2,'reset');
    [hh, hb, HHf] = high_pass_daub(8);
    axes(handles.axes1);    
    stem(handles.axes2,hh);

elseif filterLength == 4 && graphType == 3;
    set(handles.text5,'String', 'Z Plane, HP Length 8');
    set(handles.text6,'String','Z Plane, LP Length 8');
    
    % low pass
    cla(handles.axes1,'reset');   
    axes(handles.axes1);
    [h1, b1, Hf] = low_pass_daub(8);    
    zplane(handles.axes1,b1,1);
    
    % high pass
    cla(handles.axes2,'reset');   
    axes(handles.axes2);
    [hh, hb, HHf] = high_pass_daub(8);    
    zplane(handles.axes2,hb,1);    
    
elseif filterLength == 4 && graphType == 4;
    set(handles.text5,'String', '|H^f(\omega)|, HP Length 8');
    set(handles.text6,'String','|H^f(\omega)|, LP Length 8');
    
    % low pass
    cla(handles.axes1,'reset');    
    [h1, b1, Hf] = low_pass_daub(8);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes1);
    plot(handles.axes1,om/(2*pi), abs(Hf));
    xlabel('\omega/(2\pi)');
    
    % high pass
    cla(handles.axes2,'reset');    
    [hh, hb, HHf] = high_pass_daub(8);    
    om = linspace(-pi, pi, 201);   
    axes(handles.axes2);
    plot(handles.axes2,om/(2*pi), abs(HHf));
    xlabel('\omega/(2\pi)');    
end


% --- Executes on selection change in graph_type.
function graph_type_Callback(hObject, eventdata, handles)
% hObject    handle to graph_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns graph_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from graph_type


% --- Executes during object creation, after setting all properties.
function graph_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
