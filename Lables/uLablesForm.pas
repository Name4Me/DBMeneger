unit uLablesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin,  ExtCtrls,  IniFiles,RichEdit;

type
  TETForm = class(TForm)
    Panel2: TPanel;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    FontName: TComboBox;
    Editor: TRichEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure GetFontNames;
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  ETForm: TETForm;
  MyIni:TIniFile;
  PosY:string;
resourcestring
  sColRowInfo = 'Line: %3d   Col: %3d';
implementation
Uses uArgox203;

{$R *.dfm}

//---------------------------------------------------------------Print labels---
procedure TETForm.Button1Click(Sender: TObject);
  Var
    i,x,y,fs,fw:integer;
    ft:string;
begin
  A_CreatePrn(5, 'ppla.txt');
  A_Set_Darkness(12);
  A_Set_ProcessDlg(1);
  A_Set_Backfeed(317);

  for i:= 0 to Editor.Lines.Count - 1 do Begin
    x:=MyIni.ReadInteger('S'+IntToStr(i),'X',100);
    y:=MyIni.ReadInteger('S'+IntToStr(i),'Y',100);
    fs:=MyIni.ReadInteger('S'+IntToStr(i),'FSize',100);
    ft:=MyIni.ReadString('S'+IntToStr(i),'FType','Courier New');
    fw:=MyIni.ReadInteger('S'+IntToStr(i),'FWeight',400);
    A_Prn_Text_TrueType(x, y, fs, pchar(ft), 1, fw, 0, 0, 0, pchar('A'+inttostr(i+1)), PCHAR(Editor.Lines[0]), 1);
    End;

  A_Print_Out(1, 1, SpinEdit5.value, 1);
  A_ClosePrn;
end;

procedure TETForm.Button2Click(Sender: TObject);
begin
  MyIni.WriteInteger('S'+PosY,'X',SpinEdit1.Value);
  MyIni.WriteInteger('S'+PosY,'Y',SpinEdit2.Value);
  MyIni.WriteInteger('S'+PosY,'FSize',SpinEdit3.Value);
  MyIni.WriteString('S'+PosY,'FType',FontName.Text);
  MyIni.WriteInteger('S'+PosY,'FWeight',SpinEdit4.Value);
end;

procedure TETForm.FormClose(Sender: TObject; var Action: TCloseAction);
Var i:integer;
begin
  MyIni.WriteInteger('Main','SCount',Editor.Lines.Count);
  For i:=0 to Editor.Lines.Count-1 do MyIni.WriteString('S'+IntToStr(i),'Text',Editor.Lines[i]);

  if MyIni<>Nil then MyIni.Free;
end;

procedure TETForm.FormCreate(Sender: TObject);
var i:integer;
begin
  MyIni:= TIniFile.Create(GetCurrentDir+'\option.ini');
  Editor.Clear;
  For i:= 0 to MyIni.ReadInteger('Main','SCount',-1)-1 do
    Editor.Lines.Add(MyIni.ReadString('S'+IntToStr(i),'Text',''));
  GetFontNames;
end;
function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;
procedure TETForm.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TETForm.SpinEdit1Change(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------

procedure TETForm.EditorSelectionChange(Sender: TObject);
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
  CharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  PosY := IntToStr(CharPos.Y);
  SpinEdit1.Value:=MyIni.ReadInteger('S'+IntToStr(CharPos.Y),'X',100);
  SpinEdit2.Value:=MyIni.ReadInteger('S'+IntToStr(CharPos.Y),'Y',100);
  SpinEdit3.Value:=MyIni.ReadInteger('S'+IntToStr(CharPos.Y),'FSize',100);
  FontName.Text:=MyIni.ReadString('S'+IntToStr(CharPos.Y),'FType','Courier New');
  SpinEdit4.Value:=MyIni.ReadInteger('S'+IntToStr(CharPos.Y),'FWeight',400);
end;

end.
