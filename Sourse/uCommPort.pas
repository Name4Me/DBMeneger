unit uCommPort;

interface
  procedure PortInit;
  Procedure ReadCommStr(var S: String);
  procedure CloseComm;
  Var
    Com: THandle;
    ComName:string;
    busi:boolean=false;
    Ready:boolean=false;
implementation
Uses Windows,dialogs,SysUtils;
procedure PortInit;
  var
    ct: TCommTimeouts;
    dcb: TDCB;
begin
   //ShowMessage('PortInit'+inttostr(com));
   if not Ready and (not busi) and (com=0) then Begin
   busi:=True;
   com := CreateFile(PChar(ComName),GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE,nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);    //FILE_ATTRIBUTE_NORMAL
   if com <> INVALID_HANDLE_VALUE then Ready:=True;
   SetupComm(com, 2048, 2048);
   GetCommState(com, dcb);
   dcb.BaudRate := CBR_19200;
   dcb.StopBits := 0;
   dcb.Parity := 0;
   dcb.ByteSize := 8;
   SetCommState(com, dcb);
   GetCommTimeouts(com, ct);
   ct.ReadTotalTimeoutConstant := 10;
   ct.ReadIntervalTimeout := 10;
   ct.ReadTotalTimeoutMultiplier := 1;
   ct.WriteTotalTimeoutMultiplier := 10;
   ct.WriteTotalTimeoutConstant := 10;
   SetCommTimeouts(com, ct);
   busi:=False;
   End;

end;

Procedure ReadCommStr(var S: String);
  var
    Buf : array[1..255] of Byte;
    Count, RX_Count : DWord;
begin
  if Ready and (not busi) and (com<>0) then Begin
    busi:=True;
    RX_Count:=0;
    S := '';
    ReadFile(Com,Buf,255,RX_Count,nil);
    for Count := 1 to RX_Count do S := S + Chr(Buf[Count]);
    busi:=False;
    End;
end;

procedure CloseComm;
begin
  if Com <> 0 then CloseHandle(Com);
end;
end.
