unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,SvcMgr,winsvc;
const  MY_MESSAGE = WM_USER + 1;
type
  TForm9 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
var
  h_manager,h_service:SC_Handle;
  service_status: TServiceStatus;
begin
  h_manager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if h_manager > 0 then Begin
    h_service:= OpenService(h_manager,'MyService',SERVICE_ALL_ACCESS);
    if h_service > 0 then Begin
      ControlService(h_service,150,service_status);
      CloseServiceHandle(h_service);
      End;
    CloseServiceHandle(h_manager);
    End;

end;

end.
