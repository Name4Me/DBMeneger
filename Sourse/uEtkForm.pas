unit uEtkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, Grids, ExtCtrls;

type
  TETForm = class(TForm)
    Splitter1: TSplitter;
    Panel1: TPanel;
    Memo1: TMemo;
    SG: TStringGrid;
    Button6: TButton;
    Panel3: TPanel;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Button3: TButton;
    Button2: TButton;
    Panel2: TPanel;
    ListBox1: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    HC2: THeaderControl;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button4: TButton;
    Button7: TButton;
    SpinEdit2: TSpinEdit;
    CkB1: TCheckBox;
    ListBox2: TListBox;
    Button5: TButton;
    procedure ListBoxClick(Sender: TObject);

    procedure Button1Click(Sender: TObject);

    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SGKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  ETForm: TETForm;
  ggid,id,rid,rtid:string;
implementation
Uses uData,uMainForm,uTTP245,uArgox203;

{$R *.dfm}

procedure TETForm.FormActivate(Sender: TObject);
begin
  ComboBox1.Items.Text:=MC.mySQLf('Select distinct Nazva from Склад where misce ='''+DefMisce+'''',1);
  ListBox1.Items.Text:=MC.mySQLf('Select Nazva from gg',1);
  Edit3.Text:='Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Cod From et Order by Nazva,Tip,Rozmir,rist';
  Button2.Click;
end;

procedure TETForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TETForm.ListBoxClick(Sender: TObject);
Var i:integer;
begin
  with HC2 do with TListBox(Sender) do begin
    if ItemIndex=-1 then exit;
    Sections[tag-1].Text:=Items[ItemIndex];
    for i := tag to 4 do Sections[i].Text:='';
    Button1.Enabled:=False;
    SpinEdit1.Enabled:=False;
    case tag of
      1:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ggid:=MC.mySQLs('Select id from gg where Nazva = '''+Items[ItemIndex]+'''');
        rid:=MC.mySQLs('Select rid from gg where Nazva = '''+Items[ItemIndex]+'''');
        rtid:=MC.mySQLs('Select rtid from gg where Nazva = '''+Items[ItemIndex]+'''');
        ListBox2.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Types Where GGID = '''+ggid+'''',1);
        ListBox3.Items.Text:=MC.mySQLf('Select Tip from Types Where ggid = '''+ggid+'''order by tip',1);

        End;
      2:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ListBox3.Items.Text:=MC.mySQLf('Select Tip from Types Where ggid = '''+ggid+''' and tip like '''+Items[ItemIndex]+'%'' order by tip',1);
        End;
      3:Begin
        ListBox5.Clear;
        if rid <> '0' Then
          ListBox4.Items.Text:=MC.mySQLf('Select Rozmir from rozmir Where  rid= '''+rid+''' order by Rozmir',1)
          else SpinEdit1.Enabled:=True;
        if ListBox4.Items.Text<>'' then ListBox4.Enabled:=True else ListBox4.Enabled:=False;

        End;
      4:Begin
        if rtid <> '0' Then
          ListBox5.Items.Text:=MC.mySQLf('Select Rozmir from rozmir Where  rid= 0 order by Rozmir',1)
          else SpinEdit1.Enabled:=True;
        if ListBox5.Items.Text<>'' then ListBox5.Enabled:=True else ListBox5.Enabled:=False;
        End;
      5:SpinEdit1.Enabled:=True;
      end;
    if SpinEdit1.Enabled then Begin
      Button1.Enabled:=true;
      SpinEdit1.Value:=1;
      SpinEdit1.SetFocus;
      id:=MC.mySQLs('select GetTID('''+Sections[0].Text+','+Sections[2].Text+','+
        Sections[3].Text+','+Sections[4].Text+''')');
      End;
  end;
end;






procedure TETForm.Button1Click(Sender: TObject);
begin
  MC.MyEx('Call AddLable('''+id+''','+SpinEdit1.Text+')');
  if (memo1.Lines.Count<>0) and (copy(memo1.Lines[memo1.Lines.Count-1],1,1)='/') Then
    memo1.Lines.Delete(memo1.Lines.Count-1);
  memo1.Lines.Add(id+','+SpinEdit1.Text);
  SpinEdit1.Value:=1;
  if memo1.Lines.Count<>0 Then memo1.Lines.Add('/---'+MC.mySQLs('Select sum(kilkist) from et'));
  Edit3.Text:='Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,cod From et Order by Nazva,Tip,Rozmir,rist';
  Button2.Click;
end;



procedure TETForm.SGKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
Var i,n:integer;
begin
  with SG do begin
    n:=0;
    for i := 1 to ColCount-1 do if lowercase(Cells[i,0])='cod' then n:=i;
    if n<>0 then for i := Selection.BottomRight.y downto Selection.TopLeft.y do
      MC.MyEx('delete from et where cod ='+Cells[n,i]);
    Button2.Click;
    end;
end;

procedure TETForm.Button6Click(Sender: TObject);
begin
  Memo1.Clear;
  MC.MyEx('TRUNCATE ET');
  Button2.Click;
end;
//------------------------------------------------------------------------SQL---
procedure TETForm.Button2Click(Sender: TObject);
var n,k:integer;
begin
  MC.mySQLg(SG,Edit3.Text);
  k:=0;
  if SG.RowCount>1 then
    FOR n:= 1 to SG.RowCount-1 do k:=k+StrToIntDef(SG.Cells[6,n],0);
  Button6.Caption:='Очистити список ['+IntToStr(k)+']';
end;
//------------------------------------------------------------------------------
procedure TETForm.Button3Click(Sender: TObject);
begin
  if LabelPrinter = 'Argox OS-203DT' Then exit;
  openport('TTP-245');
  clearbuffer;
  windowsfont(40,30,25,0,2,0,'Times New Roman',PCHAR(Edit1.Text));
  barcode('40','60','CODA','40','0','0','2','4',PCHAR('A'+Edit2.Text+'B'));
  printlabel('1','1');
  closeport();
end;

procedure TETForm.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Items.Text:=MC.mySQLf('Select distinct Tip from Склад where misce ='''+DefMisce+''' and nazva='''+ComboBox1.Text+'''',1);
end;

procedure TETForm.ComboBox2Change(Sender: TObject);
begin
  Edit3.Text:='Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад where misce ='''+DefMisce+''' and nazva='''+ComboBox1.Text+'''and tip='''+ComboBox2.Text+''' Order by Nazva,Tip,Rozmir,rist';
  Button2.Click;
end;


//----------------------------------------------------------------Reset 30*58---
procedure TETForm.Button4Click(Sender: TObject);
begin
  if LabelPrinter = 'Argox OS-203DT' Then exit;
  openport('TTP-245');
  setup('58','30','5','7','0','3','0');
  formfeed;
  closeport;
end;
procedure TETForm.Button5Click(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
//---------------------------------------------------------------Print labels---
procedure TETForm.Button7Click(Sender: TObject);
  Var
    n,k,f:integer;
    s:string;
begin
  if TButton(sender).Name='Button7' then f:=1 else f:=0;

  if SG.RowCount>1 then Begin
    if LabelPrinter = 'Argox OS-203DT' Then Begin
      A_CreatePrn(5, 'ppla.txt');
      A_Set_Darkness(12);
      A_Set_ProcessDlg(1);
      A_Set_Backfeed(317);
      FOR n:= 1 to SG.RowCount-1 do Begin

        A_Prn_Text_TrueType(110, 100, 23, pchar('Courier New'), 1, 400, 0, 0, 0, pchar('A1'), PCHAR(SG.Cells[2,n]), 1);

        A_Prn_Text_TrueType(30, 70, 35, pchar('Courier New'), 1, 700, 0, 0, 0, pchar('A2'), PCHAR(SG.Cells[3,n]), 1);
        //barcode('50','200','CODA','40','0','0','2','4',PCHAR('A'+SG.Cells[1,n]+'B'));
        if SG.Cells[4,n]<>''Then s:=SG.Cells[4,n] Else s:='';
        if SG.Cells[5,n]<>''Then s:=s+'/'+SG.Cells[5,n];
        //A_Prn_Text_TrueType(90, 30, 60, pchar('Courier New'), 1, 800, 0, 0, 0, pchar('A3'), PCHAR(S), 1);
        A_Prn_Text(95, 35, 1, 9, 6, 1, 1, 'n', 2, pchar(s));
        if CkB1.Checked then
          A_Prn_Text_TrueType(150, 10, 40, pchar('Courier New'), 1, 700, 0, 0, 0, pchar('A4'), PCHAR(PCHAR(FloatToStr(StrToFloat(SG.Cells[7,n])+SpinEdit2.Value)+'грн.')), 1);

        k:=StrToInt(SG.Cells[6,n]);
        if f=0 then Begin
        if k mod 2 = 0 then A_Print_Out(1, 1, (k div 2), 1)
          else A_Print_Out(1, 1, (k div 2)+1, 1);
          End else A_Print_Out(1, 1, StrToInt(SG.Cells[6,n]), 1);
        End;

      A_ClosePrn;

    End Else Begin
    openport('TTP-245');
    FOR n:= 1 to SG.RowCount-1 do Begin
      clearbuffer;
      windowsfont(300,20,20,0,2,0,'Courier New',PCHAR(SG.Cells[2,n]));
      windowsfont(50,55,35,0,2,0,'Courier New',PCHAR(SG.Cells[3,n]));
      barcode('50','200','CODA','40','0','0','2','4',PCHAR('A'+SG.Cells[1,n]+'B'));
      if SG.Cells[4,n]<>''Then s:=SG.Cells[4,n] Else s:='';
      if SG.Cells[5,n]<>''Then s:=s+'/'+SG.Cells[5,n];
      windowsfont(150,110,60,0,2,0,'Courier New',PCHAR(s));
      if CkB1.Checked then windowsfont(270,200,40,0,2,0,'Courier New',PCHAR(FloatToStr(StrToFloat(SG.Cells[7,n])+SpinEdit2.Value)+'грн.'));
      k:=StrToInt(SG.Cells[6,n]);
      if f=0 then Begin

      if k mod 2 = 0 then printlabel('1',PCHAR(intToStr(k div 2)))
        else printlabel('1',PCHAR(intToStr((k div 2)+1)));

      End else printlabel('1',PCHAR(SG.Cells[6,n]));;
      End;
    closeport;
    End;
  End;
    {
     SG.Cells[1,n] --- ID
     SG.Cells[2,n] --- Nazva
     SG.Cells[3,n] --- Tip
     SG.Cells[4,n] --- Rozmir
     SG.Cells[5,n] --- Rist
     SG.Cells[6,n] --- Kilkist
     SG.Cells[7,n] --- Cina
    }
end;
//------------------------------------------------------------------------------

end.
