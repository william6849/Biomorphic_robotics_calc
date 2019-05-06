function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 11-Apr-2019 03:32:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function mySlider_Callback(hObject, eventdata, handles)
% hObject    handle to mySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
position = get(handles.mySlider, 'Value');
set(handles.myText, 'String',num2str(position));
drow(position,handles);


% --- Executes during object creation, after setting all properties.
function mySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function myText_Callback(hObject, eventdata, handles)
% hObject    handle to myText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of myText as text
%        str2double(get(hObject,'String')) returns contents of myText as a double
value = str2double(get(handles.myText, 'String'));
set(handles.mySlider, 'Value', value);
drow(value,handles)

% --- Executes during object creation, after setting all properties.
function myText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function drow(position,handles)
axes(handles.axes);
cla reset;
%param init
a=str2double(get(handles.aa, 'String'));
b=str2double(get(handles.bb, 'String'));
r=str2double(get(handles.rr, 'String'));
h=str2double(get(handles.hh, 'String'));
k=str2double(get(handles.kk, 'String'));
n=str2double(get(handles.nn, 'String'));

    d=sqrt((h+n-a)^2+(b+r-k)^2)-2;
    t= 0:0.1:2*pi+0.2; 
    %axis set
   
    set(gca, 'XLim', [a-r-7,h+n+3]);
    set(gca, 'YLim', [b-r-18,b+r+3]);
    axis equal;
    
    hold on
    
    dx = h+ n*cos(t);dy = k+ n*sin(t);plot(dx,dy);%big circle
    dx = a+ r*cos(t);dy = b+ r*sin(t);plot(dx,dy);%little circle
    %lineoffx = linspace(a,h); lineoffy = linspace(b,kk); plot(lineoffx,lineoffy,'--kk');
    lineoffx = a:0.5:h; lineoffy = b:0.5:k; plot(lineoffx,lineoffy,'--k');%offset line

    %gen angl
    x=h+ n*cos(pi*position/180);
    y=k+ n*sin(pi*position/180);
    
        %caculate c1, c2
    syms z w;
    dist=(x-z)^2+(y-w)^2-d^2;
    big_c=(z-a)^2+(w-b)^2-r^2;
    [z,w]=vpasolve(dist,big_c,z,w);
    if(w(1,1)>w(2,1))
         w([1 2],:) = w([2 1],:);
         z([1 2],:) = z([2 1],:);
    end
    
    c2x = z(1,1);
    c2y = w(1,1);
    c1x = z(2,1);
    c1y = w(2,1);
    
    % c2 > A
    linec2x = c2x:(x-c2x)/2: x; linec2y = c2y:(y-c2y)/2: y; plot(linec2x,linec2y,'g');
    % c1 > A
    linec1x = c1x:(x-c1x)/2: x; linec1y = c1y:(y-c1y)/2: y; plot(linec1x,linec1y,'g');
    % A > B
    lineabx = a:(x-a)/5:x;     linecaby = b:(y-b)/5:y;    plot(lineabx,linecaby,'--k');
    % c2 > B
    linec2bx = c2x:(a-c2x)/2: a;     linec2by = c2y:(b-c2y)/2: b;    plot(linec2bx,linec2by,'g');
    % c1 > B
    linec1bx = c1x:(a-c1x)/2: a;     linec1by = c1y:(b-c1y)/2: b;    plot(linec1bx,linec1by,'g');

    %%%%%%%%%%%%%%%%%%%%
    
    d2=sec(45*pi/180)*sqrt((z(2,1)-a)^2+(w(2,1)-b)^2);

    syms c3x c3y;
    dist=(z(2,1)- c3x)^2+(w(2,1)- c3y)^2-d2^2;
    big_c=(c3x-a)^2+(c3y-b)^2-r^2;
    [c3x,c3y]=vpasolve(dist,big_c,c3x,c3y);
    j=min(c3x(1,1),c3x(2,1));
    if(j==c3x(1,1))
        rj=c3y(1,1);
    else
        rj=c3y(2,1);
    end
    linec1c3x = j:(z(2,1)-j)/2: z(2,1);     linec1c3y = rj:(w(2,1)-rj)/2: w(2,1);    plot(linec1c3x,linec1c3y,'g');
    linec3bx = j:(a-j)/2: a;     linec3by = rj:(b-rj)/2: b;    plot(linec3bx,linec3by,'g');
    
    c3x=j;
    c3y=rj;
    %%%%%%%%%%%%%%%%%
    syms ma mc;
    eq1 = ma*j+mc-c3y;
    eq2 = ma*z(1,1)+mc-w(1,1);
    [ma,mc]=vpasolve(eq1,eq2,ma,mc);
    mb = -1;
    %translation line c3 _ c2 to origin
    dx = -ma*mc/(ma^2+mb^2);
    dy = -mb*mc/(ma^2+mb^2);
    dz = ma^2+mb^2;
    %mirror B by line c3_c2
    c4x = ((a-dx))*((mb^2-ma^2)/(dz)) + ((b-dy) * -1*2*ma*mb/(dz)) +dx;
    c4y = ((a-dx)*(-1*2*ma*mb/(dz)) + (b-dy)*((ma^2-mb^2)/(dz))) + dy;
    
    %drow
    linec3c4x = c3x:(c4x-c3x)/2: c4x;     linec3c4y = c3y:(c4y-c3y)/2: c4y;    plot(linec3c4x,linec3c4y,'g');
    linec2c4x = c2x:(c4x-c2x)/2: c4x;     linec2c4y = c2y:(c4y-c2y)/2: c4y;    plot(linec2c4x,linec2c4y,'g');
    
    %
    d3 = sqrt((c2x-c4x)^2+(c2y-c4y)^2);
    syms c5x c5y;
    eq1 = (c5x-c4x)^2+(c5y-c4y)^2 - (d3*2)^2;
    eq2 = (c5x-c2x)^2+(c5y-c2y)^2 - (d3*1.73)^2;
    [c5x, c5y] = vpasolve(eq1,eq2,c5x,c5y);

    cb=min(c5y(1,1),c5y(2,1));
    if(cb==c5y(1,1))
        ca=c5x(1,1);
    else
        ca=c5x(2,1);
    end 
    
   linec2c5x = c2x:(ca-c2x)/5: ca;     linec2c5y = c2y:(cb-c2y)/5: cb;    plot(linec2c5x,linec2c5y,'r');
   linec4c5x = c4x:(ca-c4x)/5: ca;     linec4c5y = c4y:(cb-c4y)/5: cb;    plot(linec4c5x,linec4c5y,'r'); 
  
    hold off;
   


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes
%drow(180,handles)




function aa_Callback(hObject, eventdata, handles)
% hObject    handle to aa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aa as text
%        str2double(get(hObject,'String')) returns contents of aa as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function aa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hh_Callback(hObject, eventdata, handles)
% hObject    handle to hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hh as text
%        str2double(get(hObject,'String')) returns contents of hh as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function hh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bb_Callback(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bb as text
%        str2double(get(hObject,'String')) returns contents of bb as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function bb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rr_Callback(hObject, eventdata, handles)
% hObject    handle to rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rr as text
%        str2double(get(hObject,'String')) returns contents of rr as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function rr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nn_Callback(hObject, eventdata, handles)
% hObject    handle to nn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nn as text
%        str2double(get(hObject,'String')) returns contents of nn as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function nn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kk_Callback(hObject, eventdata, handles)
% hObject    handle to kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kk as text
%        str2double(get(hObject,'String')) returns contents of kk as a double
drow(str2double(get(handles.myText, 'String')),handles)

% --- Executes during object creation, after setting all properties.
function kk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
