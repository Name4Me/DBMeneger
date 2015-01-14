unit uAZamovlenia;

interface

uses
  SysUtils, Forms, DB, DBTables, Controls, StdCtrls, ExtCtrls,
  Grids, DBGrids, Classes, ComCtrls,Types,printers,Graphics, Spin,
  Dialogs;

type
  TAZamovleniaForm = class(TForm)
    HC1: THeaderControl;
    HC2: THeaderControl;
    Panel1: TPanel;
    Button1: TButton;
    CB3: TComboBox;
    CB2: TComboBox;
    Button2: TButton;
    Button4: TButton;
    SE1: TSpinEdit;
    Memo1: TMemo;
    ListBox1: TListBox;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridRefresh;
    procedure MyOnClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AZamovleniaForm: TAZamovleniaForm;

implementation

uses uData, uMainForm;

{$R *.dfm}
procedure TAZamovleniaForm.FormCreate(Sender: TObject);
begin
  ListBox1.Items.Text:=MC.mySQLf('Select Distinct Misce from Misce',1);
  ListBox2.Items.Text:=MC.mySQLf('Select Distinct Misce from Misce',1);
  CB2.Items.Text:=MC.mySQLf('Select Distinct Nazva from GG',1);
  GridRefresh;
end;

procedure TAZamovleniaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TAZamovleniaForm.GridRefresh;
Var i:integer;
begin
  i:=StringGrid1.Selection.Top;
  MC.mySQLg(StringGrid1,'Select Zvidk,Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Zkilkist,Cod from zoper');
  if i>0 Then With StringGrid1 do if RowCount-1>i then Row:=i else Row:=RowCount-1;
end;

procedure TAZamovleniaForm.MyOnClick(Sender: TObject);
var
  i:integer;
  sq:string;
begin
  if sender is TListBox then with TListBox(Sender) do Begin
    if Name='ListBox1' Then Begin
      HC1.Sections[0].Text:='';
      for i := 0 to Items.Count - 1 do if Selected[i] then
        if HC1.Sections[0].Text='' then HC1.Sections[0].Text:=Items[i]
        else HC1.Sections[0].Text:=HC1.Sections[0].Text+','+Items[i];
      End;
    if Name='ListBox2' Then HC1.Sections[1].Text:=Items[ItemIndex];
    End;
  if sender is TButton then with TButton(Sender) do Begin
    if Name='Button2' Then Begin
      MC.MyEx('Truncate zoper');
      GridRefresh;
      End;
    if Name='Button1' Then Begin
      With HC1 do Begin
        sq:='';
        sq:=MC.mySQLs('Select id from gg where nazva='''+Sections[2].Text+'''');
        sq:=sq+MC.mySQLs('Select id from types where tip='''+Sections[3].Text+''' and ggid='+sq);
        MC.MyEx('Call Az('''+Sections[0].Text+''','''+Sections[1].Text+''','''+sq+''','+SE1.Text+')');
        End;
      GridRefresh;
      End;
    End;
  if sender is TComboBox then with TComboBox(Sender) do Begin
    if Name='CB2' Then Begin
      HC1.Sections[2].Text:=Items[ItemIndex];
      CB3.Items.Text:=MC.mySQLf('Select Distinct Tip from Types Where GGID='''+MC.mySQLs('Select ID From GG Where Nazva ='''+HC1.Sections[2].Text+'''')+'''',1);
      End;
    if Name='CB3' Then
      HC1.Sections[3].Text:=Items[ItemIndex];
    End;
end;

procedure TAZamovleniaForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var i,zk:integer;
begin
  with StringGrid1 do with Canvas do begin
    zk:=0;
    if (Selection.Top<=ARow) and (Selection.Bottom>=ARow) Then Font.Color := ClAqua;
    for i := 1 to ColCount-1 do if LowerCase(Cells[i,0])='zkilkist' then zk:=i;
    if (ARow>0) and (zk<>0) and (ACol=zk) Then case StrToIntDef(Cells[ACol,ARow],0) of
      0: Brush.Color := clRed;
      1: Brush.Color := clYellow;
      else Brush.Color := clGreen;
      end;
    FillRect(Rect);
    TextOut(Rect.Left+5,Rect.Top+5,Cells[ACol,ARow]);
    end;
end;

procedure TAZamovleniaForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  i,cod:integer;
begin
  with StringGrid1 do begin
    cod:=0;
    for i := 1 to ColCount-1 do
      if LowerCase(Cells[i,0])='cod' then cod:=i;
    if Key=46 Then Begin
      for i := Selection.Top to Selection.Bottom do
        MC.MyEx('Delete from zoper where cod='+Cells[cod,i]);
      GridRefresh;
      End;
  end;
end;

procedure TAZamovleniaForm.Button4Click(Sender: TObject);
Var m,m1,l,t:integer;
sz,sm,sn,st:string;
Begin
  With StringGrid1 do With Printer do With Canvas do  Begin
    BeginDoc;
    Font.Name:='MS Sans Serif';
    Font.Style := [fsBold];
    Font.Size:=10;
    t:= Printer.Canvas.TextHeight('X');
    l:= Printer.Canvas.TextWidth('M');
    TextOut(Printer.PageWidth-30*l,t,'['+FormatDateTime('dd.mm.yyyy hh:nn', Now)+']');
    //TextOut(l*2,2*t,Q2.Fields[2].AsString);
    Font.Style := [];
    m1:=2;
    for m:= 1 to RowCount-1 do Begin
      if (sz<>Cells[1,m]) or (sm<>Cells[2,m]) Then Begin
        sn:='';
        st:='';
        inc(m1);
        TextOut(l*6,t*m1,Cells[1,m]+' >> '+Cells[2,m]);
        inc(m1);
        End;
      if (sn<>Cells[3,m])Then Begin
        st:='';
        Font.Style := [fsBold];
        TextOut(l*6,t*m1,Cells[3,m]);
        Font.Style := [];
        End;
      if (st<>Cells[4,m])Then Begin
        Printer.Canvas.TextOut(l*20,t*m1,Cells[4,m]);
        Printer.Canvas.MoveTo(l*6,t*m1-1);
        Printer.Canvas.LineTo(Printer.PageWidth-l,t*m1-1);
        End;
      if SE1.Value=1 Then Printer.Canvas.TextOut(l*40,t*m1,Cells[5,m]+' / '+Cells[6,m])
        Else Printer.Canvas.TextOut(l*40,t*m1,Cells[5,m]+' / '+Cells[6,m]+' ['+Cells[7,m]+']');
      inc(m1);
      if 3*t+t*m1>=Printer.PageHeight-2*t then Begin
        Printer.NewPage;
        m1:=1;
        End;
      sz:=Cells[1,m];
      sm:=Cells[2,m];
      sn:=Cells[3,m];
      st:=Cells[4,m];
      End;
    MoveTo(l*6,t*m1-1);
    LineTo(Printer.PageWidth-l,t*m1-1);
    EndDoc;
    End;

end;

end.
