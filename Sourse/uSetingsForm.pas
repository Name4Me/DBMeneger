unit uSetingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, ComCtrls,StrUtils;

type
  TSetingsForm = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    Panel1: TPanel;
    ComboBox2: TComboBox;
    Button2: TButton;
    Button3: TButton;
    DTP: TDateTimePicker;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetingsForm: TSetingsForm;
  f : array [0..10] of boolean;
implementation

uses uMainForm,registry,uCommPort,uData;

{$R *.dfm}

procedure TSetingsForm.Button1Click(Sender: TObject);
  Var
  Reg: TRegistry;
  
begin
  Reg := TRegistry.Create;
  With Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\Software\SLine\Meneger', True);
    if f[0] and (ComboBox1.Text<>'') Then Begin
      WriteString('Comm',ComboBox1.Text);
      ComName:=ComboBox1.Text;
      f[0]:=False;
      End;

    CloseKey;
    Free;
    end;
end;

procedure TSetingsForm.Button2Click(Sender: TObject);
Var
  buf:String;
  i:integer;
begin
  buf:='000000000';
  for i:= 1 to length(buf) do if CheckListBox1.Checked[i-1] then buf[i]:='1';
  MC.MyEx('Update users set Dostup='''+buf+''' Where User = '''+ComboBox2.Text+'''');
  buf:='';
  for i:= 1 to CheckListBox2.Count do if CheckListBox2.Checked[i-1] then buf:=buf+'1' else buf:=buf+'0' ;
  MC.MyEx('Update users set Misce='''+buf+''' Where User = '''+ComboBox2.Text+'''');
end;

procedure TSetingsForm.Button3Click(Sender: TObject);
Var s:string;
begin

  if DTP.Date<>date then s:=FormatDateTime('mmdd_', DTP.Date)+FormatDateTime('mmdd', Date)
    else s:=FormatDateTime('mmdd', DTP.Date);
  SaveDialog1.InitialDir:=MyIni.ReadString('Main','SD',CurrentPatch);
  SaveDialog1.FileName:=s+'.sav';
  SaveDialog1.Filter:='*.sav';
  SaveDialog1.Execute(SetingsForm.Handle);
  ShowMessage(SaveDialog1.FileName);
  MyIni.WriteString('Main','SD',GetCurrentDir);
  s:=AnsiReplaceStr(SaveDialog1.FileName, '\', '/');

  //SaveDialog1.GetNamePath
  if s<>'' then
  
  MC.MyEx('select * into outfile '''+s+''' Fields Terminated by '','' '+
    ' optionally enclosed by ''"'' lines Terminated by ''\n'' from oper where data>='''+
    FormatDateTime('yyyy.mm.dd', DTP.Date)+'''');

end;

procedure TSetingsForm.ComboBox1Change(Sender: TObject);
begin
  f[0]:=true;
end;

procedure TSetingsForm.ComboBox2Change(Sender: TObject);
  Var
  buf:String;
  i:integer;
begin
  buf:=MC.mySQLs('Select Dostup From Users Where User = '''+ComboBox2.Text+'''');
  for i:= 1 to CheckListBox1.Count do if buf[i] ='1' Then CheckListBox1.Checked[i-1]:=true Else CheckListBox1.Checked[i-1]:=false;
  buf:=MC.mySQLs('Select Misce From Users Where User = '''+ComboBox2.Text+'''');
  for i:= 1 to CheckListBox2.Count do if buf[i] ='1' Then CheckListBox2.Checked[i-1]:=true Else CheckListBox2.Checked[i-1]:=false;
end;

procedure TSetingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TSetingsForm.FormCreate(Sender: TObject);
var
  hnd:THandle;
  i,n: integer;
  ml:^TStrings;
begin {опрос существующих портов}
  DTP.Date:=MD;
  ComboBox1.Items.Add('None');
  for i := 0 to 31 do {цикл опроса}
  begin {пробуем получить дескриптор порта}
    hnd := CreateFile(PChar('COM' + IntToStr(i + 1)),
      GENERIC_READ,
      0,
      nil,
      OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
    if hnd <> INVALID_HANDLE_VALUE then {если порт есть то добавить в список}
      ComboBox1.Items.Add('COM' + IntToStr(i + 1));
    CloseHandle(hnd); {закрыть дескриптор}
  end;
  if ComboBox1.Items.IndexOf(ComName)<>-1 then ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(ComName);
  New(ml);
  ml^:=TStringList.Create;
  n:=MC.mySQLi('Select max(id) From Misce');
  ml^.Text:=MC.mySQLf('Select ID,Misce From Misce order by ID',1);

  ComboBox2.Items.Text:=MC.mySQLf('Select User From Users Order by Misce',1);
  for i := 0 to n do Begin
    CheckListBox2.Items.Add(ml^.Values[Copy('00',1,2-length(inttostr(i)))+inttostr(i)]);
    End;


  Dispose(ml);
end;

end.
