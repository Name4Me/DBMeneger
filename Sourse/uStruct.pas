unit uStruct;

interface

uses
  SysUtils, Variants, Classes, Graphics,Forms,StdCtrls, Grids, Controls,
  ExtCtrls;

type
  TStructForm = class(TForm)
    CB1: TComboBox;
    CB: TComboBox;
    SG1: TStringGrid;
    ChB: TCheckBox;
    SG2: TStringGrid;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StructForm: TStructForm;
  ggid:string;
implementation

uses uData, uMainForm;

{$R *.dfm}

procedure TStructForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TStructForm.FormCreate(Sender: TObject);
Var m,m1:integer;
begin
  m1:=98;
  for m:= 0 to 11 do Begin SG2.ColWidths[m]:=35;
    if m<>12 then SG2.Cells[m,0]:=IntTostr(m1);
    inc(m1,6);
    End;
  SG2.ColWidths[12]:=55;
  SG2.Cells[12,0]:='Разом';

  for m := 0 to 13 Do SG1.RowHeights[m]:=25;
  SG1.ColWidths[0]:=20;
  for m:= 1 to 5 do SG1.ColWidths[m]:=35;
  for m:= 1 to 5 do SG1.Cells[m,0]:=IntTostr(m+1);
  m:=44;
  m1:=1;
  While m<=66 Do Begin
    SG1.Cells[0,m1]:=IntTostr(m);
    inc(m1);
    if (m=54)or(m=55) Then inc(m) else  inc(m,2);
    End;
  CB.Items.Text:=MC.mySQLf('Select Nazva From GG',1);
end;

procedure TStructForm.MyClick(Sender: TObject);
Var m,m1:integer;
  s:string;
begin
  if Sender=CB then With CB Do Begin
    CB1.Items.Text:=MC.mySQLf('Select Distinct Tip From '+TSName+' Where Nazva ='''+Text+'''',1);
    ggid:=MC.mySQLs('Select id From gg Where Nazva ='''+Text+'''');
    End;
  if Sender=CB1 then With CB1 Do Begin
    If ChB.Checked Then s:='misce ='''+DefMisce+''' and ' else s:='';
    if pos(ggid,'00,04,07,08')<>0 then Begin
      SG2.Visible:=False;
      SG1.Visible:=True;
      for m1:= 1 to 13 do
        for m:= 1 to 5 do SG1.Cells[m,m1]:='';
      for m1:= 1 to 13 do
        for m:= 1 to 5 do
          if MC.mySQLs('Select Sum(Kilkist) From '+TSName+' Where '+s+'Nazva = '''+CB.Text+''' And Tip = '''+CB1.Text+''' And Rozmir = '+SG1.Cells[0,m1]+' And Rist = '+SG1.Cells[m,0]) <> '' Then
            SG1.Cells[m,m1]:=MC.mySQLs('Select Sum(Kilkist) From '+TSName+' Where '+s+'Nazva = '''+CB.Text+''' And Tip = '''+CB1.Text+''' And Rozmir = '+SG1.Cells[0,m1]+' And Rist = '+SG1.Cells[m,0]);
      End;
    if pos(ggid,'05,10,01')<>0 then Begin
      SG2.Visible:=True;
      SG1.Visible:=False;
      for m1:= 0 to 12 do SG2.Cells[m1,1]:= MC.mySQLs('Select Sum(Kilkist) From '+TSName+' Where '+s+' Nazva = '''+CB.Text+''' And Tip = '''+CB1.Text+''' And Rozmir = '+SG2.Cells[m1,0]);
      SG2.Cells[12,1]:=MC.mySQLs('Select Sum(Kilkist) From '+TSName+' Where '+s+' Nazva = '''+CB.Text+''' And Tip = '''+CB1.Text+'''');
      End;
    End;
end;

end.

