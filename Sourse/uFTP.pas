{ $HDR$}

unit uFTP;

interface

uses
  Windows, Forms, Graphics, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdIntercept, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdFTP, ComCtrls, StdCtrls,
  Controls, ExtCtrls,IdFTPCommon,SysUtils,dialogs,IdFTPList,
  Classes, IdTCPClient, IdExplicitTLSClientServerBase,IdAllFTPListParsers;
type
  TFTPForm = class(TForm)
    DirectoryListBox: TListBox;
    IdFTP1: TIdFTP;
    StatusBar1: TStatusBar;
    IdAntiFreeze1: TIdAntiFreeze;
    ProgressBar1: TProgressBar;
    ConnectButton: TButton;
    DownloadButton: TButton;
    UploadButton: TButton;
    HC1: THeaderControl;
    Panel1: TPanel;
    procedure UploadButtonClick(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
      const asStatusText: String);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);

    procedure DirectoryListBoxDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure HC1SectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure FormCreate(Sender: TObject);
    procedure DownloadButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConnectButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    AbortTransfer: Boolean;
    TransferrignData: Boolean;
    BytesToTransfer: LongWord;
    Ofline:Boolean;
    procedure ChageDir(DirName: string);
  public
    { Public declarations }
  end;

var
  FTPForm: TFTPForm;
  CD:string ='/';
  AverageSpeed: Double=0;
implementation

uses uMainForm,uData;

{$R *.dfm}

procedure TFTPForm.UploadButtonClick(Sender: TObject);
var lds,s:string;
  ld:TDate;
begin
  lds:=MC.mySQLs('Select value from uservar where name=''LST_'+DefMisce+'''');
  ld:=StrToDateTime(lds);

   if ld<>date then s:=FormatDateTime('mmdd_', ld)+FormatDateTime('mmdd', Date)
      else s:=FormatDateTime('mmdd',Date);
    s:=s+'.sav';
    deletefile('c:\temp\'+s);
    MC.MyEx('select * into outfile ''c:/temp/'+s+''' Fields Terminated by '','' '+
      ' optionally enclosed by ''"'' lines Terminated by ''\n'' from oper where data>='''+
      FormatDateTime('yyyy.mm.dd', ld)+''' and misce='''+DefMisce+'''');

      StatusBar1.Panels[0].Text:=MC.LastError;
   if IdFTP1.Connected then begin
      try
        IdFTP1.TransferType:=ftBinary;
        IdFTP1.Put(ExpandFileName('c:\temp\'+s),s);
        ChageDir(idftp1.RetrieveCurrentDir);
      finally
      end;
      end;                               

end;

procedure TFTPForm.Button1Click(Sender: TObject);
begin
  if IdFTP1.Connected and DirectoryListBox.Visible then ChageDir('..')
end;

procedure TFTPForm.ChageDir(DirName: string);
var
 LS: TStringList;
begin
  with IdFTP1 do begin
    if not Connected then exit;
    LS:=TStringList.Create;
    cd:=DirName;
    ChangeDir(DirName);
    TransferType:=ftASCII;
    DirectoryListBox.Items.Clear;
    List(LS);
    while pos('.',DirectoryListing.Items[0].FileName)=1 do Begin
      LS.Delete(0);
      DirectoryListing.Delete(0);
      End;
    DirectoryListBox.Items.Text:=LS.Text;
    LS.Free;
    end;
end;

procedure TFTPForm.IdFTP1Disconnected(Sender: TObject);
begin
 StatusBar1.Panels[0].Text:='Disconnected.';
end;

procedure TFTPForm.IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
  const asStatusText: string);
begin
 StatusBar1.Panels[0].Text:=asStatusText;
end;

procedure TFTPForm.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin

 if AbortTransfer then IdFTP1.Abort;
 ProgressBar1.Position:=AWorkCount;
 AbortTransfer:=false;
end;

procedure TFTPForm.IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
 TransferrignData:=true;
 AbortTransfer:=false;
 if AWorkCountMax>0 then ProgressBar1.Max:=AWorkCountMax
  else ProgressBar1.Max:=BytesToTransfer;
 AverageSpeed:=0;
end;

procedure TFTPForm.IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
 StatusBar1.Panels[0].Text:='Transfer complete.';
 BytesToTransfer:=0;
 TransferrignData:=false;
 ProgressBar1.Position:=0;
 AverageSpeed:=0;
end;

procedure TFTPForm.ConnectButtonClick(Sender: TObject);
begin
  Ofline:=False;
  with IdFTP1 do try
    Username:='sd@sline.com.ua';
    Password:='h!:apjBjsm;6';
    Connect;
    if Connected and DirectoryListBox.Visible then ChageDir('..');

    except Ofline:=True;
    

    end;
end;

procedure TFTPForm.DirectoryListBoxDrawItem(Control: TWinControl;
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


        if ItemType=ditDirectory
        then DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, '[D] '+IntToStr(round(Size/1024)))
        else DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, '[F] '+IntToStr(round(Size/1024)));

        R.Left:=R.Right;
        R.Right:=R.Left+HC1.Sections.Items[2].Width;
        DirectoryListBox.Canvas.FillRect(R);
        DirectoryListBox.Canvas.TextOut(R.Left, Rect.Top, FormatDateTime('dd.mm.yyyy hh:mm', ModifiedDate));

   

       end;
     end;

end;

procedure TFTPForm.DownloadButtonClick(Sender: TObject);
begin
 if not IdFTP1.Connected then Exit;
 IdFTP1.TransferType:=ftBinary;
 BytesToTransfer:=IdFTP1.Size('sklad.rar');
 IdFTP1.Get('sklad.rar', 'c:\temp\sklad.rar', true);
end;

procedure TFTPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if IdFTP1.Connected then try
    if TransferrignData then IdFTP1.Abort;
    IdFTP1.Quit;
  except;
  end;
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TFTPForm.FormCreate(Sender: TObject);
begin
  With HC1.Sections[HC1.Sections.Count-1] do Width:=HC1.Width-left;
  PostMessage(ProgressBar1.Handle, $0409, 0, clBlue);
  AutoSize:=True;
end;

procedure TFTPForm.FormShow(Sender: TObject);
begin
  //ConnectButton.Click;
end;

procedure TFTPForm.HC1SectionResize(HeaderControl: THeaderControl; Section: THeaderSection);
begin
  With HC1.Sections[HC1.Sections.Count-1] do Width:=HC1.Width-left;
  DirectoryListBox.Repaint;
end;

end.
