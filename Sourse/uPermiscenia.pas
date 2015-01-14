unit uPermiscenia;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
   ScktComp, StdCtrls, Spin, ComCtrls, ExtCtrls, DB, DBTables, Grids,
  DBGrids,dialogs;

type
  TFPM = class(TForm)
    ListBox3: TListBox;
    ListBox5: TListBox;
    ListBox6: TListBox;
    Edit1: TSpinEdit;
    Button1: TButton;
    Label0: TLabel;
    Label1: TLabel;
    HC1: THeaderControl;
    HC2: THeaderControl;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ListBox1: TComboBox;
    ListBox2: TComboBox;
    HC3: THeaderControl;
    SpinEdit1: TSpinEdit;
    CheckBox1: TCheckBox;
    ListBox4: TListBox;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Edit2: TEdit;
    ListBox7: TListBox;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    procedure Cls (const Comp,Flag,Hed: string);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ListBox5Click(Sender: TObject);
    procedure ListBox6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Exit(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridRefresh;
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox7Click(Sender: TObject);

  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FPM: TFPM;
  i:integer = 5;

implementation
uses udata, uMainForm;


{$R *.dfm}

procedure TFPM.Cls (const Comp,Flag,Hed: string);
Var    m:integer;
  ID:string;
begin
  For m:= 1 to length(Comp) do if Comp[m] = '1' then
    Case m of
      1: ListBox4.Clear;
      2: ListBox5.Clear;
      3: ListBox6.Clear;
      4: Label1.Caption:= '';
      end;

  For m:= 1 to length(Flag) do if Flag[m] = '1' then
    Case m of
      1: ListBox4.Enabled:=false;
      2: ListBox5.Enabled:=false;
      3: ListBox6.Enabled:=false;
      4: Button1.Enabled:=False;
      6: ListBox3.Enabled:=false;
      end
    Else Case m of
      1: ListBox4.Enabled:=true;
      2: ListBox5.Enabled:=true;
      3: ListBox6.Enabled:=true;
      4: Begin
        //if Edit1.MaxValue>0 Then
        Button1.Enabled:=true;
        ID:=MC.mySQLs('select GetTID('''+HC2.Sections[0].Text+','+HC2.Sections[1].Text+','+
          HC2.Sections[2].Text+','+HC2.Sections[3].Text+''')');
        //ShowMessage(id);
        MC.mySQLg(StringGrid2,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Data,time,cod From Oper Where Oper=''Переміщення''and( Misce ='''+HC3.Sections[1].Text+''' and Zvidk = '''+HC1.Sections[1].Text+''') and id='''+ID+''' and data ='''
          +mds+''' Order By Data,time DESC');
        End;
      6: ListBox3.Enabled:=true;
      end;

  For m:= 2 to length(Hed) do if Hed[m] = '1' then HC2.Sections[m-1].Text:='';
  //Edit1.MaxValue:=1;
  EDit1.Text:='1';
end;

procedure TFPM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TFPM.FormCreate(Sender: TObject);
begin
  ListBox1.Items.Text:=MC.mySQLf('Select Distinct Misce From Склад',1);
  ListBox2.Items.Text:=MC.mySQLf('Select Distinct Misce From misce where misce <>'''+DefMisce+'''',1);
  ListBox1.Text:=DefMisce;
end;

procedure TFPM.GridRefresh;
begin
  GroupBox1.Caption:='['+MC.mySQLs('Select Sum(kilkist) From Oper Where Oper=''Переміщення''and( Misce ='''+HC3.Sections[1].Text+''' and Zvidk = '''+HC1.Sections[1].Text+''') and ip='+SpinEdit1.Text+' and data ='''+mds+'''')+']';
  if CheckBox1.Checked then
    MC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Data,time,cod From Oper Where Oper=''Переміщення''and( Misce ='''+HC3.Sections[1].Text+''' and Zvidk = '''+HC1.Sections[1].Text+''') and ip='+SpinEdit1.Text+' and data ='''
      +mds+''' Order By Data,time DESC');
end;

procedure TFPM.ListBox1Click(Sender: TObject);
begin
  HC1.Sections[1].Text:=ListBox1.Items.Strings[ListBox1.ItemIndex];
  if (HC1.Sections[1].Text <> '') and (HC1.Sections[1].Text <> HC2.Sections[1].Text) Then CLS('1111','111110','11111')
    Else CLS('1111','111111','1111');
  ListBox2.Items.Text:=MC.mySQLf('Select Misce from Misce where misce <> '''+HC1.Sections[1].Text+'''',1);
  ListBox3.Items.Text:=MC.mySQLf('Select Distinct Nazva from Склад Where  Misce = '+chr(39)+HC1.Sections[1].Text+chr(39),1);
  if ListBox1.Text <> DefMisce Then Begin
    Listbox2.Text:=DefMisce;
    HC3.Sections[1].Text:=DefMisce;
    LIstBox3.Enabled:=True;
    SpinEdit1Change(Sender);
    End;
end;

procedure TFPM.ListBox2Click(Sender: TObject);
begin
  CLS('1111','111110','1111');
  HC3.Sections[1].Text:=ListBox2.Items.Strings[ListBox2.ItemIndex];
  if ListBox2.Text <> DefMisce Then Begin
    Listbox1.Text:=DefMisce;
    HC1.Sections[1].Text:=DefMisce;
    ListBox3.Items.Text:=MC.mySQLf('Select Distinct Nazva from Склад Where  Misce = '+chr(39)+HC1.Sections[1].Text+chr(39),1);
    SpinEdit1Change(Sender);
    End;
end;

procedure TFPM.ListBox2Exit(Sender: TObject);
Var m,n:integer;
begin
  n:=0;
  For m:= 0 to ListBox2.Items.Count Do if ListBox2.Text = ListBox2.Items[m]  Then n:=1;;
  If (n=1) And (ListBox2.Text<>'') Then CLS('1111','111110','1111')
    Else CLS('1111','111111','1111');
end;

procedure TFPM.ListBox3Click(Sender: TObject);
begin
  if ListBox3.ItemIndex=-1 then exit;
  CLS('0111','01111','0111');
  HC2.Sections[0].Text:=ListBox3.Items.Strings[ListBox3.ItemIndex];
  ListBox4.Items.Text:=MC.mySQLf('Select Distinct Tip from Склад Where Nazva = '''+HC2.Sections[0].Text+''' and Misce = '''+HC1.Sections[1].Text+''' order by tip',1);
  ListBox7.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Склад Where Nazva = '''+HC2.Sections[0].Text+''' and Misce = '''+HC1.Sections[1].Text+''' order by tip',1);
end;

procedure TFPM.ListBox4Click(Sender: TObject);
Begin
  if ListBox4.ItemIndex=-1 then exit;
  HC2.Sections[1].Text:=ListBox4.Items.Strings[ListBox4.ItemIndex];
  CLS('0011','00111','00011');
  If MC.mySQLs('Select rid From GG Where Nazva ='''+HC2.Sections[0].Text+'''') <> '0'
    Then ListBox5.Items.Text:=MC.mySQLf('Select Distinct Rozmir from Склад Where Nazva = '+chr(39)+HC2.Sections[0].Text+chr(39) +' and Misce = '+chr(39)+HC1.Sections[1].Text+chr(39)+' and Tip= '+chr(39)+HC2.Sections[1].Text+chr(39),1)
    Else Begin
      CLS('0011','00100','00011');
      Edit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '+chr(39)+HC2.Sections[0].Text+chr(39) +' and Misce = '+chr(39)+HC1.Sections[1].Text+chr(39)+' and Tip= '+chr(39)+HC2.Sections[1].Text+chr(39));
      Label1.Caption:=IntToStr(Edit1.MaxValue);
      if Edit1.MaxValue <= 0 Then CLS('1111','01111','01111');
      Edit1.SetFocus;
      End;
end;

procedure TFPM.ListBox5Click(Sender: TObject);
begin
  if ListBox5.ItemIndex=-1 then exit;
  HC2.Sections[2].Text:=ListBox5.Items.Strings[ListBox5.ItemIndex];
  CLS('0001','00011','00001');
  If MC.mySQLs('Select rtid From GG Where Nazva ='''+HC2.Sections[0].Text+'''') <> '0'
    Then ListBox6.Items.Text:=MC.mySQLf('Select Distinct Rist from Склад Where Nazva = '+chr(39)+HC2.Sections[0].Text+chr(39) +' and Misce = '+chr(39)+HC1.Sections[1].Text+chr(39)+' and Tip= '+chr(39)+HC2.Sections[1].Text+chr(39)+' And Rozmir = '+HC2.Sections[2].Text,1)
    Else Begin
      CLS('0001','00000','00001');
      Edit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '+chr(39)+HC2.Sections[0].Text+chr(39) +' and Misce = '+chr(39)+HC1.Sections[1].Text+chr(39)+' and Tip= '+chr(39)+HC2.Sections[1].Text+chr(39)+' And Rozmir = '+HC2.Sections[2].Text);
      Label1.Caption:=IntToStr(Edit1.MaxValue);
      if Edit1.MaxValue <= 0 Then CLS('0111','00011','00001');
      Edit1.SetFocus;
      End;
end;

procedure TFPM.ListBox6Click(Sender: TObject);
begin
  if ListBox6.ItemIndex=-1 then exit;
  HC2.Sections[3].Text:=ListBox6.Items.Strings[ListBox6.ItemIndex];
  Edit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '''+HC2.Sections[0].Text+''' and Misce = '''+HC1.Sections[1].Text+''' and Tip= '''+HC2.Sections[1].Text+''' And Rozmir = '+HC2.Sections[2].Text+' And Rist = '+HC2.Sections[3].Text);
  Label1.Caption:=IntToStr(Edit1.MaxValue);
  CLS('0000','00000','00000');
  if Edit1.MaxValue <= 0 Then CLS('0011','00011','00000');
  Edit1.SetFocus;
end;

procedure TFPM.ListBox7Click(Sender: TObject);
begin
  With sender as TListBox do
  ListBox4.Items.Text:=MC.mySQLf('Select Distinct Tip from Склад Where Nazva = '''+HC2.Sections[0].Text+''' and Misce = '''+HC1.Sections[1].Text+''' and tip like '''+Items[ItemIndex]+'%'' order by tip',1);
end;

procedure TFPM.Button1Click(Sender: TObject);
Var ID:string;
begin
  if (HC1.Sections[1].Text<>'') and (HC2.Sections[1].Text<>'') Then begin
    ID:=MC.mySQLs('select GetTID('''+HC2.Sections[0].Text+','+HC2.Sections[1].Text+','+
      HC2.Sections[2].Text+','+HC2.Sections[3].Text+''')');
    
    MC.MyEx('call permischenia('''+HC1.Sections[1].Text+''','''+HC3.Sections[1].Text+''','''+ID+''','+Edit1.Text+','+SpinEdit1.Text+','''+User+''','''+MDs+''',1)');
    //Edit2.Text:=MC.LastSQL;
    if Edit2.Text<>'' then Edit2.Visible:=True;

    end;
  Edit1.Text:='1';
  CLS('0011','00110','00011');
  GridRefresh;
end;

procedure TFPM.Edit1Change(Sender: TObject);
begin
  if Edit1.MaxValue=1 Then Edit1.Value:=1;
  if strtointdef(Edit1.text,0)>Edit1.MaxValue then Edit1.Text:='1';

end;

procedure TFPM.SpinEdit1Change(Sender: TObject);
begin
  GridRefresh;
end;

procedure TFPM.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i,n:integer;
begin
  if Key = 46 Then with StringGrid1 do begin
    n:=0;
    for i := 1 to ColCount-1 do if lowercase(Cells[i,0])='cod' then n:=i;
    if n<>0 then for i := Selection.BottomRight.y downto Selection.TopLeft.y do
      MC.MyEx('Call vidmina('+Cells[n,i]+')');
    end;
  GridRefresh;
end;

end.

