unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RasUnit, ExtCtrls;

type

{
    TRasConn = record
      Size: DWORD;
      Handle: THandle;
      Name: array[0..20] of AnsiChar;
    end;
  
    TRasEnumConnections = function(var RasConn: TRasConn; var Size: DWORD;
      var Connections: DWORD): DWORD stdcall;
    TRasHangUp = function(Handle: THandle): DWORD stdcall;
}

  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;
TMyDialParam = Record
  AMsg:Integer;
  AState:TRasConnState;
  AError:Integer;
  End;
var
  Form1: TForm1;
  MyDialParam:TMyDialParam;
  hRas: ThRASConn;
implementation
Uses uDialUP;
{$R *.DFM}



procedure TForm1.Button1Click(Sender: TObject);
var
  BuffSize,BufSize1,NumEntries,r          : Integer;
  Entries           : Integer;
  Entry             : Array[1..MaxEntries] of TRasEntryName;
  X,Result_         : Integer;
  AllEntries        : TStrings;
  Entri : Array[1..MaxEntries] of LPRasConn;
begin
  AllEntries:=TStringList.Create;
  ListBox1.Clear;
  Entry[1].dwSize:=SizeOf(TRasEntryName);
  BuffSize:=SizeOf(TRasEntryName)*MaxEntries;
  Result_:=RasEnumEntries(nil, nil, @Entry[1], BuffSize, Entries);
  If (Result_=0) and (Entries>0) then
    For X:=1 To Entries Do Begin
      ListBox1.Items.Add(Entry[x].szEntryName);
      AllEntries.Add(Entry[x].szEntryName);
      
      r:=RasEnumConnections(@Entry[x], BufSize1, NumEntries);
      ShowMessage(inttostr(r)+'//'+inttostr(NumEntries));
      End;
  AllEntries.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FillChar(MyDialParam,SizeOf(MyDialParam),0);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  DialHU;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  //ShowMessage(IntToStr(ConnCount));
  Dial;
end;

procedure TForm1.Button5Click(Sender: TObject);
{
  type
   PRasConn=^TRasConn;
   TRasConn=packed record
    dwSize:DWord;
    hRasConn:THandle;
    szEntryName:array [0..23] of Char;
   end;
   TRasConnStatus=packed record
    dwSize:DWord;
    RasConnState:DWord;
    dwError:DWord;
    szDeviceType:array [0..16] of Char;
    szDeviceName:array [0..128] of Char;
    szPhoneNumber:array [0..129] of Char;
   end;
   TRasHangUp=function(hRasConn:THandle):DWord; stdcall;
   TRasEnumConnections=function(RasConn:PRasConn; var bSize:DWord;
                                var ConnCount:DWord):DWord; stdcall;
   TRasGetConnectStatus=function(hRasConn:THandle; var lpRasConnStatus:TRasConnStatus):DWord; stdcall;
}
var RasApi:Cardinal;
    bSize,ConnCount,j:integer;
    RasConnStatus:TRasConnStatus;
    RasConn:TRasConn;
    ArrRasConn,RasOld:LPRasConn;
begin
  Memo1.Clear;
  try
  GetMem(PChar(ArrRasConn),bSize);
  ArrRasConn^.dwSize:=SizeOf(TRasConn);
  j:=bSize;
  if RasEnumConnections(ArrRasConn,j,ConnCount)=0 then RasHangUp(ArrRasConn.hrasconn);
  FreeMem(PChar(RasOld),bSize);
  except
  end;


  


end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RasHangUp(hRas);
end;

end.
