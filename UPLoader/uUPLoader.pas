unit uUPLoader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdFTP, ComCtrls, IdComponent, IdBaseComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase;

type
  TForm9 = class(TForm)
    IdFTP1: TIdFTP;
    Button1: TButton;
    StatusBar1: TStatusBar;
    UploadButton: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    DownLoad: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Button1Click(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure ChageDir(const DirName: string = '..');
    procedure UploadButtonClick(Sender: TObject);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);

    procedure Button2Click(Sender: TObject);
    procedure IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;
  Ofline:Boolean;
  FList:TStrings;
implementation
Uses uFileFunction,   
  IdFTPCommon,IdAllFTPListParsers,idftplist ;

{$R *.dfm}

procedure TForm9.FormCreate(Sender: TObject);
begin
  Ofline:=True;
  FList:=TstringList.Create;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FList.Free;
  IdFTP1.Disconnect;
end;

procedure TForm9.ChageDir(const DirName: string = '..');
var
 LS: TStringList;
 i:integer;
begin
  with IdFTP1 do begin
    if not Connected then exit;
    LS:=TStringList.Create;
    TransferType:=ftASCII;
    List(LS);
    FList.Clear;
    for i := 0 to DirectoryListing.Count - 1 do
      if DirectoryListing.Items[i].ItemType=ditFile then
        FList.Add(DirectoryListing.Items[i].FileName);
    LS.Free;
    end;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  ShowMessage(FList.Text);
end;



procedure TForm9.Button1Click(Sender: TObject);
begin
  if IdFTP1.Connected then exit;

  Ofline:=False;
  with IdFTP1 do try
    Username:='sd@sline.com.ua';
    Password:='h!:apjBjsm;6';
    Connect;
    //if Connected and DirectoryListBox.Visible then ChageDir('..');

    except Ofline:=True;


    end;
  if not Ofline then Begin
    ChageDir;
    StatusBar1.Panels[0].Text:='[On Line]';
    End;

end;



procedure TForm9.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  with StatusBar1 do Begin
    Panels[1].Text:='['+AStatusText+']';
    Panels[1].Width:=StatusBar1.Canvas.TextWidth('['+AStatusText+']')+20;
    End;
end;

procedure TForm9.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
 //if AbortTransfer then IdFTP1.Abort;
 ProgressBar1.Position:=AWorkCount;
 //AbortTransfer:=false;
end;

procedure TForm9.IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  ProgressBar1.Position:=0;
end;

procedure TForm9.UploadButtonClick(Sender: TObject);
Var
  s:string;
  si:StartUpInfo;
  pi:process_information;
begin
  s:=GetFileVersion('nm.exe');
  if (s='') or (OfLine) or (FList.IndexOf('nm'+s+'.rar')<>-1) then exit;
  s:='nm'+s+'.rar';
  if (Exist('rar.exe')) and (not OfLine) then Begin
    zeromemory(@si,sizeof(si));
    si.cb:=sizeof(si);
    
    if Not CreateProcess(nil,
      PChar('rar.exe a -ep -inul '+s+' nm.exe'),
      nil,nil,False,0,nil,nil,si,pi) Then Begin
        ShowMessage('Winrar не обнаружен!');
        Exit;
        End;
    WaitForSingleObject(pi.hProcess,infinite);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    IdFTP1.TransferType:=ftBinary;
    IdFTP1.Put(s,s);
    ProgressBar1.Max:=GetFS(s);
    ChageDir(idftp1.RetrieveCurrentDir);
  End;
end;

end.
