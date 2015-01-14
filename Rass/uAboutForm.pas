unit uAboutForm;

interface

uses
  windows, messages, sysutils, variants, classes, graphics, controls, forms,
dialogs, menus, shellapi, buttons, stdctrls, ImgList,WinSvc;
const WM_NOTIFYTRAYICON = WM_USER + 1;

type
  TFAbout = class(TForm)
    PopupMenu1: TPopupMenu;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    Close1: TMenuItem;
    Properties1: TMenuItem;
    Button2: TButton;
    Button3: TButton;
    procedure AddIcon;
    procedure DeleteIcon;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    

  private
    fhi: boolean;
    fClosing: boolean;
    fIconData: TNotifyIconData;
    TrayIcon: TIcon;
    procedure WMTRAYICONNOTIFY(var Msg: TMessage);
    message WM_NOTIFYTRAYICON;
  public
    { Public declarations }
  FromService: boolean;
  end;

var
  FAbout: TFAbout;
  

implementation
Uses uDCService;
{$R *.dfm}
function ServiceStart(aMachine, aServiceName: string ): boolean;
// aMachine ��� UNC ����, ���� ��������� ��������� ���� �����
var
  h_manager,h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName),
    SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,temp)) then
        if (QueryServiceStatus(h_svc,svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if (not QueryServiceStatus(h_svc,svc_status)) then
              break;
            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus �� ����������� dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;

function ServiceStop(aMachine,aServiceName: string ): boolean;
// aMachine ��� UNC ����, ���� ��������� ��������� ���� �����
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  dwCheckPoint: DWord;
begin
  h_manager:=OpenSCManager(PChar(aMachine),nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName),
    SERVICE_STOP or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if(not QueryServiceStatus(h_svc,svc_status))then
            begin
              // couldn't check status
              break;
            end;
            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;
          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;


function ServiceGetStatus(sMachine, sService: string ): string;
var
  h_manager, h_service: SC_Handle;
  service_status: TServiceStatus;
  hStat: DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_service := OpenService(h_manager,PChar(sService), SERVICE_QUERY_STATUS);
    if h_service > 0 then
    begin
      if(QueryServiceStatus(h_service, service_status)) then
        hStat := service_status.dwCurrentState;
      CloseServiceHandle(h_service);
    end;
    CloseServiceHandle(h_manager);
  end;
  case hStat of
    1:Result := 'SERVICE_STOPPED';
    2:Result := 'SERVICE_RUNNING';
    3:Result := 'SERVICE_PAUSED';
    4:Result := 'SERVICE_START_PENDING';
    5:Result := 'SERVICE_STOP_PENDING';
    6:Result := 'SERVICE_CONTINUE_PENDING';
    7:Result := 'SERVICE_PAUSE_PENDING';
    end;


  
end;

procedure TFAbout.AddIcon;
begin
  if not fhi then begin
    TrayIcon:=Application.Icon;
    with ficondata do begin
      cbsize := sizeof(ficondata);
      wnd:=handle;
      uid:=$dedb;
      uflags:=nif_message or nif_icon or nif_tip;
      hicon:=TrayIcon.Handle;
      ucallbackmessage:=WM_NOTIFYTRAYICON;
      strcopy(sztip, pchar('DialUPControl'));
      end;
    fhi:=shell_notifyicon(nim_add, @ficondata);
    end;
end;
procedure TFAbout.Button2Click(Sender: TObject);
begin
  ServiceStart('','DialUPControl_svc');
  Caption:='DialUPC ['+ServiceGetStatus('','DialUPControl_svc')+']';
end;

procedure TFAbout.Button3Click(Sender: TObject);
begin
  ServiceStop('','DialUPControl_svc');
  Caption:='DialUPC ['+ServiceGetStatus('','DialUPControl_svc')+']';
end;

procedure TFAbout.Close1Click(Sender: TObject);
begin
  fClosing:=true;
  Close;
end;

procedure TFAbout.DeleteIcon;
begin
  if fhi then
    shell_notifyicon(nim_delete, @ficondata);
end;

procedure TFAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if fClosing then Action:=CaFree
    else Action:=caHide;
end;

procedure TFAbout.FormCreate(Sender: TObject);
begin
  Caption:='DialUPC ['+ServiceGetStatus('','DialUPControl_svc')+']';
  AddIcon;
  if fromservice then begin
    Close1.visible:=false;
    //n1.visible:=false;
    end;
  fClosing:=false;
end;

procedure TFAbout.FormDestroy(Sender: TObject);
begin
  DeleteIcon;
end;

procedure TFAbout.Properties1Click(Sender: TObject);
type tgetdesignerinterface = procedure; safecall;
var getfunc: tgetdesignerinterface;
dllhandle: thandle;
const
dllname = 'mysrvcnf.cpl';
funcname = 'editconfiguration';
begin
dllhandle:=loadlibrary(pchar(dllname));
if dllhandle < 32 then
raise exception.create('not found "'+dllname+'" !');
getfunc:=getprocaddress(dllhandle, pchar(funcname));
if not assigned(getfunc) then
begin
freelibrary(dllhandle);
raise exception.create('not fount function "'+funcname+'"');
end;
try
getfunc;
finally
freelibrary(dllhandle);
end;

end;

procedure TFAbout.WMTRAYICONNOTIFY(var Msg: TMessage);
begin
  case Msg.LParam of
    WM_LBUTTONDOWN: Begin
      SetForeGroundWindow(Handle);
      ShowWindow(Handle, SW_RESTORE);
      SetActiveWindow(Handle);
      End;
    //WM_LBUTTONDBLCLK: {��� ��� ��������� ������� �������� ������� �� ����� ������ ����}
    //WM_LBUTTONUP: {��� ��� ��������� ������� ���������� ����� ������ ����}

    WM_RBUTTONDOWN: PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
    //WM_RBUTTONDBLCLK: ShowWindow(MainForm.Handle,SW_Show);
    //WM_RBUTTONUP: {��� ���}

    //WM_MOUSEMOVE: {��� ���}
    end;
end;

end.
