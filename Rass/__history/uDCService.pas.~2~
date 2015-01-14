unit uDCService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ImgList, ExtCtrls;

type
  
  TDialUPControl_svc = class(TService)
    procedure ServiceStop(sender: tservice; var stopped: boolean);
    procedure ServiceStart(sender: tservice; var started: boolean);
    function DoCustomControl(CtrlCode: DWord): Boolean;override;
  private

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;
TMyThread = class(TThread)
  f,a,ina:boolean;
  procedure Report;
  protected
    procedure Execute; override;
  end;
var
  DialUPControl_svc: TDialUPControl_svc;
  
  NewThread: TMyThread;
implementation
uses RASUnit;
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DialUPControl_svc.Controller(CtrlCode);
end;

function TDialUPControl_svc.DoCustomControl(CtrlCode: DWord): Boolean;
begin
  if (NewThread<>nil) and (CtrlCode=150) then NewThread.a:=True;
  if (NewThread<>nil) and (CtrlCode=151) then NewThread.a:=False;
end;

function TDialUPControl_svc.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;



procedure TDialUPControl_svc.ServiceStart(sender: tservice; var started: boolean);
begin
  Started:=true;
  NewThread:=TMyThread.Create(true);
  with NewThread do begin
    a:=true;
    f:=True;
    FreeOnTerminate:=true;
    Priority:=tpLower;
    Resume;
    end;
end;

procedure TDialUPControl_svc.ServiceStop(sender: tservice; var stopped: boolean);
begin
  if NewThread<>nil then With NewThread do Begin
    f:=False;
    Terminate;
    End;
  Stopped:=true
end;


{ TMyThread }

procedure TMyThread.Execute;
Var
  ls:TTime;
  Conn: TRasConn;
 Code: DWORD;
 Size,ConnectionsCount: longint;
 lt:DWord;
begin
  lt:=GetTickCount;
  Conn.dwSize := SizeOf(TRasConn);
  Size:= SizeOf(Conn);
  while f do if ((GetTickCount-lt)>30000) and a and (not ina) Then Begin
    a:=not a;
    try
      Code := RasEnumConnections(@Conn, Size, ConnectionsCount);
      if (ConnectionsCount =1) and (Code = 0) then RasHangUp(Conn.hrasconn);
      except;
      end;
    lt:=GetTickCount;
    Synchronize(Report);
    a:=not a;
    End;

  //Terminate;


  inherited;

end;

procedure TMyThread.Report;
begin
  DialUPControl_svc.ReportStatus;
end;

end.
