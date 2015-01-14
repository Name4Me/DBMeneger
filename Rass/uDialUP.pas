unit uDialUP;

interface
Uses RasUnit,SysUtils;
Type
  TMyDialParam = Record
    AMsg:Integer;
    AState:TRasConnState;
    AError:Integer;
    End;
  Function ConnCount:integer;
  Function AConnCount:integer;
  Procedure Dial;
  Procedure DialHU;

  Function GetStatusString(State: TRasConnState; Error: Integer): String;

  Var
  MyDialParam:TMyDialParam;
  hRas: ThRASConn;
  Conn: TRasConn;
  Status:string;
  ConnName:string;
implementation

Function ConnCount:integer;
var
  BuffSize: Integer;
  Entry: Array[1..MaxEntries] of TRasEntryName;
  Entri: Array[1..MaxEntries] of LPRasConn;
begin
  Entry[1].dwSize:=SizeOf(TRasEntryName);
  BuffSize:=SizeOf(TRasEntryName)*MaxEntries;
  RasEnumEntries(nil, nil, @Entry[1], BuffSize, Result);
    for BuffSize:= 1 to Result do
      if Entry[BuffSize].szEntryName='dic' then ConnName:='dic';
end;

Function AConnCount:integer;
var
  BuffSize: longint;
begin
  Conn.dwSize:= SizeOf(TRasConn);
  BuffSize:= SizeOf(TRasConn);
  RasEnumConnections(@Conn, BuffSize, Result);
end;

Procedure RCallback(msg: Integer; state: TRasConnState;
  error: Integer); stdcall;
Begin
  MyDialParam.AMsg:=msg;
  MyDialParam.AState:=state;
  MyDialParam.AError:=error;
  Status:=GetStatusString(MyDialParam.AState,MyDialParam.AError);
End;

Procedure Dial;
Var
  DialParams: TRasDialParams;
  Fp: LongBool;
Begin
  if (ConnCount=0) or (AConnCount>0) then exit;

  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  With DialParams Do Begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, ConnName);
    End;
  RasGetEntryDialParams(nil, DialParams, Fp);
  RasDial(Nil, Nil, DialParams, 0, @RCallback, hRAS);
End;

Procedure DialHU;
Begin
  if (ConnCount=0) or (AConnCount=0) then exit;
  RasHangUp(Conn.hrasconn);

End;

Function GetStatusString(State: TRasConnState; Error: Integer): String;
Var
  C: Array[0..100] of Char;
Begin
  If Error<>0 then Begin
    RasGetErrorString(Error, C, 100);
    Result:=C;
    End
  Else Begin
    Result:='';
    Case State Of
      RASCS_OpenPort:
        Result:='Opening port';
      RASCS_PortOpened:
        Result:='Port opened';
      RASCS_ConnectDevice:
        Result:='Connecting device';
      RASCS_DeviceConnected:
        Result:='Device connected';
      RASCS_AllDevicesConnected:
        Result:='All devices connected';
      RASCS_Authenticate:
        Result:='Start authenticating';
      RASCS_AuthNotify:
        Result:='Authentication: notify';
      RASCS_AuthRetry:
        Result:='Authentication: retry';
      RASCS_AuthCallback:
        Result:='Authentication: callback';
      RASCS_AuthChangePassword:
        Result:='Authentication: change password';
      RASCS_AuthProject:
        Result:='Authentication: projecting';
      RASCS_AuthLinkSpeed:
        Result:='Authentication: link speed';
      RASCS_AuthAck:
        Result:='Authentication: acknowledge';
      RASCS_ReAuthenticate:
        Result:='Authentication: reauthenticate';
      RASCS_Authenticated:
        Result:='Authenticated';
      RASCS_PrepareForCallback:
        Result:='Preparing for callback';
      RASCS_WaitForModemReset:
        Result:='Waiting for modem reset';
      RASCS_WaitForCallback:
        Result:='Waiting for callback';
      RASCS_Projected:
        Result:='Projected';
      RASCS_StartAuthentication:
        Result:='Start authentication';
      RASCS_CallbackComplete:
        Result:='Callback complete';
      RASCS_LogonNetwork:
        Result:='Logging on network';

      RASCS_Interactive:
        Result:='Interactive';
      RASCS_RetryAuthentication:
        Result:='Retry Authentication';
      RASCS_CallbackSetByCaller:
        Result:='Callback set by caller';
      RASCS_PasswordExpired:
        Result:='Password expired';

      RASCS_Connected: Begin
        Result:='Connected';
        //
        End;
      RASCS_Disconnected:
        Result:='Disconnected';
      End;
    End;
End;


end.
