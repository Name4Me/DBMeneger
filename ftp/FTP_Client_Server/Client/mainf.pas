{ $HDR$}

unit mainf;

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Menus,  SysUtils, Classes, IdIntercept, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, IdAntiFreezeBase, IdAntiFreeze, IdLogBase, IdLogDebug, IdGlobal,
  IdLogEvent, IdFTPCommon, IdFTPList, FileCtrl, IdExplicitTLSClientServerBase,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,IdAllFTPListParsers;

type
  TMainForm = class(TForm)
    DirectoryListBox: TListBox;
    IdFTP1: TIdFTP;
    DebugListBox: TListBox;
    StatusBar1: TStatusBar;
    IdAntiFreeze1: TIdAntiFreeze;
    ProgressBar1: TProgressBar;
    IdLogEvent1: TIdLogEvent;
    ConnectButton: TButton;
    DownloadButton: TButton;
    UploadButton: TButton;
    IdIOHandlerStack1: TIdIOHandlerStack;
    HC1: THeaderControl;
    Panel1: TPanel;
    procedure ConnectButtonClick(Sender: TObject);
    procedure UploadButtonClick(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
      const asStatusText: String);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure IdLogEvent1Received(ASender: TComponent; const AText,
      AData: String);
    procedure IdLogEvent1Sent(ASender: TComponent; const AText,
      AData: String);
    procedure DebugListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DirectoryListBoxDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure HC1SectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure FormCreate(Sender: TObject);
    procedure DownloadButtonClick(Sender: TObject);
  private
    { Private declarations }
    AbortTransfer: Boolean;
    TransferrignData: Boolean;
    BytesToTransfer: LongWord;
    STime: TDateTime;
    procedure ChageDir(DirName: string);
    procedure PutToDebugLog(Operation, S1: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  CD:string ='/';
  AverageSpeed: Double=0;
implementation

{$R *.dfm}

procedure TMainForm.ConnectButtonClick(Sender: TObject);
begin
  ConnectButton.Enabled:=false;
  if IdFTP1.Connected then try
    if TransferrignData then IdFTP1.Abort;
    IdFTP1.Quit;
    finally
    DirectoryListBox.Items.Clear;
    ConnectButton.Caption:='Connect';
    ConnectButton.Enabled:=true;
    ConnectButton.Default:=true;
    end else with IdFTP1 do try
    Username:='sd@sline.com.ua';
    Password:='h!:apjBjsm;6';
    Connect;
    finally
    ConnectButton.Enabled:=true;
    if Connected then begin
      ConnectButton.Caption:='Disconnect';
      ConnectButton.Default:=false;
      ChageDir(CD);
      end;
    end;
end;

procedure TMainForm.UploadButtonClick(Sender: TObject);
begin
 if IdFTP1.Connected then begin
    try
      IdFTP1.TransferType:=ftBinary;
      IdFTP1.Put('c:\temp\sklad.rar', 'sklad.rar');
      ChageDir(idftp1.RetrieveCurrentDir);
    finally
    end;
    end;
end;

procedure TMainForm.ChageDir(DirName: string);
var
 LS: TStringList;
begin
 LS:=TStringList.Create;
 cd:=DirName;
 try
  IdFTP1.ChangeDir(DirName);
  IdFTP1.TransferType:=ftASCII;
  DirectoryListBox.Items.Clear;
  IdFTP1.List(LS);
  IdFTP1.DirectoryListing.Delete(0);
  if (cd='/') then IdFTP1.DirectoryListing.Delete(0);
  DirectoryListBox.Items.Text:=LS.Text;
  if DirectoryListBox.Items.Count>0
  then
   if AnsiPos('total', DirectoryListBox.Items[0])>0
   then DirectoryListBox.Items.Delete(0);
 finally
  LS.Free;
 end;
end;

procedure TMainForm.IdFTP1Disconnected(Sender: TObject);
begin
 StatusBar1.Panels[0].Text:='Disconnected.';
end;

procedure TMainForm.IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
  const asStatusText: string);
begin
 DebugListBox.ItemIndex:=DebugListBox.Items.Add(asStatusText);
 StatusBar1.Panels[0].Text:=asStatusText;
end;

procedure TMainForm.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
var
 S: string;
 TotalTime: TDateTime;
 // RemainingTime: TDateTime;
 H, M, Sec, MS: Word;
 DLTime: Double;
begin
 TotalTime:=Now-STime;
 DecodeTime(TotalTime, H, M, Sec, MS);
 Sec:=Sec+M*60+H*3600;
 DLTime:=Sec+MS/1000;
 if DLTime>0
 then AverageSpeed:={(AverageSpeed + }(AWorkCount/1024)/DLTime{)/2};
 if AverageSpeed>0
 then
  begin
   Sec:=Trunc(((ProgressBar1.Max-AWorkCount)/1024/AverageSpeed));
   S:=Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]);
   S:='Time remaining '+S;
  end
 else S:='';
 //
 S:=FormatFloat('0.00 KB/s', AverageSpeed)+'; '+S;
 case AWorkMode of
  wmRead: StatusBar1.Panels[0].Text:='Download speed '+S;
  wmWrite: StatusBar1.Panels[0].Text:='Uploade speed '+S;
 end;
 if AbortTransfer
 then IdFTP1.Abort;
 ProgressBar1.Position:=AWorkCount;
 AbortTransfer:=false;
end;

procedure TMainForm.IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
 TransferrignData:=true;
 AbortTransfer:=false;
 STime:=Now;
 if AWorkCountMax>0 then ProgressBar1.Max:=AWorkCountMax
  else ProgressBar1.Max:=BytesToTransfer;
 AverageSpeed:=0;
end;

procedure TMainForm.IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
 StatusBar1.Panels[0].Text:='Transfer complete.';
 BytesToTransfer:=0;
 TransferrignData:=false;
 ProgressBar1.Position:=0;
 AverageSpeed:=0;
end;

procedure TMainForm.PutToDebugLog(Operation, S1: String);
var
 S: string;
begin
  while Length(S1)>0 do begin
    if Pos(#13, S1)>0 then begin
      S:=Copy(S1, 1, Pos(#13, S1)-1);
      Delete(S1, 1, Pos(#13, S1));
      if S1[1]=#10 then Delete(S1, 1, 1);
      end else S := S1;
    DebugListBox.ItemIndex := DebugListBox.Items.Add(Operation + S);
    end;
end;

procedure TMainForm.IdLogEvent1Received(ASender: TComponent; const AText,
  AData: string);
begin
  PutToDebugLog('<<- ', AData);
end;

procedure TMainForm.IdLogEvent1Sent(ASender: TComponent; const AText,
  AData: string);
begin
  PutToDebugLog('->> ', AData);
end;


procedure TMainForm.DebugListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
 if Pos('>>', DebugListBox.Items[index])>1
 then DebugListBox.Canvas.Font.Color:=clRed
 else DebugListBox.Canvas.Font.Color:=clBlue;
 if odSelected in State
 then
  begin
   DebugListBox.Canvas.Brush.Color:=$00895F0A;
   DebugListBox.Canvas.Font.Color:=clWhite;
  end
 else DebugListBox.Canvas.Brush.Color := clWindow;
 DebugListBox.Canvas.FillRect(Rect);
 DebugListBox.Canvas.TextOut(Rect.Left, Rect.Top, DebugListBox.Items[index]);
end;

procedure TMainForm.DirectoryListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
 R: TRect;
begin

   if odSelected in State
    then
     begin
      DirectoryListBox.Canvas.Brush.Color:=$00895F0A;
      DirectoryListBox.Canvas.Font.Color:=clWhite;
     end
    else DirectoryListBox.Canvas.Brush.Color:=clWindow;
    //
    if Assigned(IdFTP1.DirectoryListing) and (IdFTP1.DirectoryListing.Count>Index)
    then
     begin
      DirectoryListBox.Canvas.FillRect(Rect);
      with IdFTP1.DirectoryListing.Items[Index] do
       begin

        DirectoryListBox.Canvas.TextOut(Rect.Left, Rect.Top, FileName);
        R:=Rect;

        R.Left:=Rect.Left+HC1.Sections.Items[0].Width;
        R.Right:=R.Left+HC1.Sections.Items[1].Width;
        DirectoryListBox.Canvas.FillRect(R);
        DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, IntToStr(Size));
   
        R.Left:=R.Right;
        R.Right:=R.Left+HC1.Sections.Items[2].Width;
        DirectoryListBox.Canvas.FillRect(R);

        if ItemType=ditDirectory
        then DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, 'D')
        else DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, 'F');
   
        R.Left:=R.Right;
        R.Right:=R.Left+HC1.Sections.Items[3].Width;
        DirectoryListBox.Canvas.FillRect(R);
        DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, FormatDateTime('mm.dd.yyyy hh:mm', ModifiedDate));

        R.Left:=R.Right;
        R.Right:=R.Left+HC1.Sections.Items[4].Width;
        DirectoryListBox.Canvas.FillRect(R);
        DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, PermissionDisplay);
   

       end;
     end;

end;

procedure TMainForm.DownloadButtonClick(Sender: TObject);
begin
 if not IdFTP1.Connected then Exit;
 IdFTP1.TransferType:=ftBinary;
 BytesToTransfer:=IdFTP1.Size('sklad.rar');
 IdFTP1.Get('sklad.rar', 'c:\temp\sklad.rar', true);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  With HC1.Sections[HC1.Sections.Count-1] do Width:=HC1.Width-left;
  PostMessage(ProgressBar1.Handle, $0409, 0, clGreen);
  AutoSize:=True;
end;

procedure TMainForm.HC1SectionResize(HeaderControl: THeaderControl; Section: THeaderSection);
begin
  With HC1.Sections[HC1.Sections.Count-1] do Width:=HC1.Width-left;
  DirectoryListBox.Repaint;
end;

end.
