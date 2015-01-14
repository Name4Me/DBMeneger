unit uRestore;

interface

uses
  Windows,SysUtils,Controls, Forms,Dialogs,Registry, CheckLst, StdCtrls,
  ComCtrls, Classes;

type
  TRestoreForm = class(TForm)
    Button1: TButton;
    OD: TOpenDialog;
    CLB: TCheckListBox;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RestoreForm: TRestoreForm;

implementation
Uses uData,uFileFunction,IniFiles;

{$R *.dfm}

procedure TRestoreForm.FormCreate(Sender: TObject);
begin
  if not PingResult Then Exit;
  Caption:=Caption+' ['+MC.FOptions.Host+']';
  if MC.Connect Then
    CLB.Items.Text:=MC.mySQLf ('SHOW TABLES FROM '+MC.FOptions.DB,1)
    Else Caption:=Caption+' [DB Error]';
end;

procedure TRestoreForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MC.Free;
  MrC.Free;
  MyIni:= TIniFile.Create(CurrentPatch+'\option.ini');
  MyIni.WriteString('Main','RestorePath',RestorePath);
  MyIni.Free;
end;

procedure TRestoreForm.Button1Click(Sender: TObject);
var
  Reg: TRegistry;
  m:integer;
  si:StartUpInfo;
  pi:process_information;
  RPath:string;
  cf:boolean;
begin
  if not PingResult Then Exit;
  cf:=False;
  For m:= 0 to CLB.Count-1 do With CLB do if Checked[m] then cf:=True;
  if not cf then Exit;
  OD.InitialDir:=RestorePath;
  OD.Execute;
  if OD.FileName='' Then Exit;

  zeromemory(@si,sizeof(si));
  si.cb:=sizeof(si);

  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\SLine\Meneger', True);
  if not Reg.ValueExists('RPath') Then
    Reg.WriteString('RPath','c:\temp');
  RPath:=Reg.ReadString('RPath');
  Reg.CloseKey;
  Reg.Free;


  RestorePath:=GetCurrentDir;
  if OD.FileName<>'' Then Begin
    if Not CreateProcess(nil,
      PChar('c:\Program files\winrar\winrar.exe x -o+'+OD.FileName+' *.* c:\temp\'),
      nil,nil,False,0,nil,nil,si,pi) Then Begin
        ShowMessage('Winrar не обнаружен!');
        Exit;
        End;
    WaitForSingleObject(pi.hProcess,infinite);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    //ShellExecute(application.MainForm.Handle,nil,'winrar',PChar(' x '+s+' *.* '+Reg.ReadString('RPath')),'', SW_SHOWNORMAL);

    For m:= 0 to CLB.Count-1 do With CLB do if Checked[m] then Begin
      MC.MyEx('TRUNCATE '+Items[m]);
      if (Items[m] ='склад') and (FileExists('c:\temp\sklad.sav')) Then
        MC.MyEx('load data local infile ''c:/temp/sklad.sav'' into Table '+Items[m]+' Fields Terminated by '','' enclosed by ''"'' lines Terminated by ''\n''')
        Else if FileExists('c:\temp\'+Items[m]+'.sav') then
          MC.MyEx('load data local infile ''c:/temp/'+Items[m]+'.sav'' into Table '+Items[m]+' Fields Terminated by '','' enclosed by ''"'' lines Terminated by ''\n''');
      if (Items[m] ='oper') or (Items[m] ='foper') or (Items[m] ='склад') Then Begin
        MC.MyEx('ALTER TABLE '+Items[m]+' Drop Cod');
        MC.MyEx('ALTER TABLE '+Items[m]+' Add Cod BigINT not null auto_increment, add primary key(Cod)');
        end;
      End;
    End;

  DelAll('c:\temp\','*.sav');
  StatusBar1.Panels[0].Text:=MC.LastError;
  //Close;
end;

end.
