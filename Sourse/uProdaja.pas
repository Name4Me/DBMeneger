unit uProdaja;

interface

uses
  Windows,SysUtils, Variants, Classes, Graphics, Controls, Forms,
   ScktComp, StdCtrls, Spin, ComCtrls, ExtCtrls, DB, DBTables, Grids,
  DBGrids;

type
  TProdajaForm = class(TForm)
    ListBox1: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    Label0: TLabel;
    Label1: TLabel;
    HC1: THeaderControl;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    ListBox2: TListBox;
    StringGrid1: TStringGrid;
    ListBox3: TListBox;
    Edit3: TEdit;
    SpinButton1: TSpinButton;
    Label3: TLabel;
    Timer1: TTimer;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GridRefresh;
    procedure SpinEditChange(Sender: TObject);
    procedure SpinEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);

  private
    { Private declarations }
  public
    
    { Public declarations }
  end;

var
  ProdajaForm: TProdajaForm;
  ip:integer;
  id:string;
  pause:dword;
  dis:real;
  ExitFl:boolean =False;
implementation
uses udata, uMainForm,uCommPort;


{$R *.dfm}

procedure TProdajaForm.Button1Click(Sender: TObject);
var suma:real;
begin
  Button1.Enabled:=False;
  With HC1 do Begin
    
    //edit1.Text:=;
    if edit1.Text<>'' then edit1.Visible:=True;

    MC.MyEx('Call prodaja('''+DefMisce+''', '''+id+''' , '+SpinEdit1.Text+' , '+
    FloatSTSQL(Edit3.Text)+
    ' , '+IntToStr(ip)+' ,'''+Sections[5].Text+''', '''+User+''' ,'''+mds+''', 1)');
    if Sections[6].Text<>'' Then Begin
      suma:=MC.mySQLv('Select suma from clients where CardID='''+Sections[5].Text+'''');
      MC.MyEx('Update clients set suma='+FloatSTSQL(FloatToStr(suma+StrToFloat(Edit3.Text)))+' Where CardId='''+Sections[5].Text+'''');
      
      ExitFl:=true;
      End;
    if SpinEdit1.MaxValue=SpinEdit1.Value Then Begin
      if (not ListBox4.Enabled) or (ListBox3.Count=1) or (ListBox4.Count=1) Then ListBoxClick(ListBox1)
        else ListBoxClick(ListBox3);
      End else
        if ListBox4.Enabled Then ListBoxClick(ListBox4) else ListBoxClick(ListBox3);
    pause:=GetTickCount;
    
    End;
  
  GridRefresh;
end;

procedure TProdajaForm.GridRefresh;
begin
  Label2.Caption:=MC.mySQLs('Select Sum(kilkist) From Oper Where Oper=''Продажа''and Misce ='''+
    DefMisce+''' and  data ='''+mds+''' and ip='+IntToStr(ip));
  Label3.Caption:=MC.mySQLs('Select Sum(cina) From Oper Where Oper=''Продажа''and Misce ='''+
    DefMisce+''' and  data ='''+mds+''' and ip='+IntToStr(ip));
  if CheckBox1.Checked then
    MC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,Time,Cod From Oper Where Oper=''Продажа'' and Misce ='''+
      DefMisce+''' and data = '''+mds+''' and ip='+IntToStr(ip)+' Order By Data,time DESC');
end;


procedure TProdajaForm.FormActivate(Sender: TObject);
begin
  GridRefresh;
  Timer1.Enabled:=True;
end;

procedure TProdajaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TProdajaForm.FormCreate(Sender: TObject);
begin
  ListBox1.Items.Text:=MC.mySQLf('Select Distinct Nazva from Склад Where  Misce = '''+DefMisce+'''',1);
  ip:=MC.mySQLi('Select min(ip)-1 From Oper Where Oper=''Продажа''and Misce ='''+DefMisce+''' and data = '''+mds+'''and ip<0');
  Caption:=Caption+' ['+IntToStr(abs(ip))+']';
  ExitFl:=False;
end;



procedure TProdajaForm.FormDeactivate(Sender: TObject);
begin
  Timer1.Enabled:=False;
end;

procedure TProdajaForm.ListBoxClick(Sender: TObject);
var i:integer;
begin
  if Sender is TListBox then with HC1 do with TListBox(Sender) do  Begin
    if ItemIndex=-1 then exit;
    Sections[tag-1].Text:=Items[ItemIndex];
    for i := tag to 4 do Sections[i].Text:='';
    Button1.Enabled:=False;
    SpinEdit1.Enabled:=False;
    Label1.Caption:=' ';
    SpinEdit1.MaxValue:=0;
    Edit3.Text:=FloatSTS('0');
    case tag of
      1:Begin
        
        ListBox2.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Склад Where Nazva = '''+Items[ItemIndex]+''' and Misce = '''+DefMisce+''' order by tip',1);
        ListBox3.Items.Text:=MC.mySQLf('Select Distinct Tip from Склад Where Nazva = '''+Items[ItemIndex]+''' and Misce = '''+DefMisce+''' order by tip',1);
        End;
      2:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ListBox3.Items.Text:=MC.mySQLf('Select Distinct Tip from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and tip like '''+Items[ItemIndex]+'%'' order by tip',1);
        End;
      3:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ListBox4.Items.Text:=MC.mySQLf('Select Distinct Rozmir from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and Tip= '''+Items[ItemIndex]+''' order by Rozmir',1);
        If MC.mySQLs('Select rid From GG Where Nazva ='''+Sections[0].Text+'''') = '0' Then Begin
          SpinEdit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and Tip= '''+Items[ItemIndex]+'''');
          ListBox4.Enabled:=False;
          End else ListBox4.Enabled:=True;
        End;
      4:Begin
        ListBox5.Items.Text:=MC.mySQLf('Select Distinct Rist from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and Tip= '''+Sections[2].Text+''' and Rozmir = '+Sections[3].Text,1);
        if ListBox5.Items.Text<>'' then ListBox5.Enabled:=True else ListBox5.Enabled:=False;
        If MC.mySQLs('Select rtid From GG Where Nazva ='''+Sections[0].Text+'''') = '0' Then Begin
          SpinEdit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and Tip= '''+Sections[2].Text+''' and Rozmir='+Sections[3].Text);
          ListBox5.Enabled:=False;
          End else ListBox5.Enabled:=True;
        End;
      5:SpinEdit1.MaxValue:=MC.mySQLi('Select Kilkist from Склад Where Nazva = '''+Sections[0].Text+''' and Misce = '''+DefMisce+''' and Tip= '''+Sections[2].Text+''' and Rozmir='+Sections[3].Text+' and rist='+Sections[4].Text);
      end;
    if SpinEdit1.MaxValue>0 then Begin
      Label1.Caption:=IntToStr(SpinEdit1.MaxValue);
      Button1.Enabled:=true;
      SpinEdit1.Value:=1;
      SpinEdit1.Enabled:=True;
      SpinEdit1.SetFocus;
      id:=MC.mySQLs('select GetTID('''+Sections[0].Text+','+Sections[2].Text+','+
        Sections[3].Text+','+Sections[4].Text+''')');

      Edit3.Text:=MC.mySQLs('select GetCina('''+DefMisce+''','''+id+''','''')');
      Edit3.Text:=FloatToStrF(StrToFloat(Edit3.Text)*((100-StrToIntDef(Sections[6].Text,0))/100),ffFixed,7,2);

      End;

    End;
end;

procedure TProdajaForm.SpinButton1DownClick(Sender: TObject);
begin
  Edit3.Text:=FloatToStrF((StrToFloat(Edit3.Text)-1),ffFixed,7,2);
end;

procedure TProdajaForm.SpinButton1UpClick(Sender: TObject);
begin
  Edit3.Text:=FloatToStrF((StrToFloat(Edit3.Text)+1),ffFixed,7,2);
end;

procedure TProdajaForm.SpinEdit1Exit(Sender: TObject);
begin
  With TSpinEdit(Sender) do Begin
    if Text='' then Value:=1;
    if Value>MaxValue then Value:=MaxValue;
    if Value<MinValue then Value:=MinValue;
    End;
end;

procedure TProdajaForm.SpinEditChange(Sender: TObject);
begin
  With TSpinEdit(Sender) do  if Text<>'' then Begin
    if Value>MaxValue then Value:=MaxValue;
    if Value<MinValue then Value:=MinValue;
    Edit3.Text:=FloatSTS(FloatToStr(StrToFloat(MC.mySQLs('select GetCina('''+DefMisce+''','''+id+''','''')'))*Value));
    Edit3.Text:=FloatToStrF(StrToFloat(Edit3.Text)*((100-StrToIntDef(HC1.Sections[6].Text,0))/100),ffFixed,7,2);
    End;

end;

procedure TProdajaForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i,n:integer;
begin
  if Key = 46 Then with StringGrid1 do begin
    n:=0;
    for i := 1 to ColCount-1 do if Cells[i,0]='Cod' then n:=i;
    if n<>0 then for i := Selection.BottomRight.y downto Selection.TopLeft.y do
      MC.MyEx('Call vidmina('+Cells[n,i]+')');
    end;
  
  GridRefresh;
end;

procedure TProdajaForm.Timer1Timer(Sender: TObject);
var s,s1:string;
begin
  if (ExitFl) and ((GetTickCount-pause)>120000) then close;
  If (ComName<>'') and (ComName<>'None') Then ReadCommStr(s);
  if s<> '' Then Begin
    if s[Length(s)]=#13 then s:=Copy(s,1,Length(s)-1);
    HC1.Sections[5].Text:=s;
    if MC.mySQLs('Select cardid from clients where cardid='''+s+'''')<>'' then Begin
      s:=MC.mySQLs('Select suma from clients where cardid='''+s+'''');
      HC1.Sections[6].Text:=MC.mySQLs('Select max(value) from uservar where name=''discount'' and vid<='+FloatSTSQL(s));
      End;
    s1:=MC.mySQLs('Select Nazva from '+TSName+' where id='''+s+''' and misce='''+DefMisce+'''');
    if s1<>'' then Begin
      if ListBox1.Items.IndexOf(s1)<>-1 then ListBox1.ItemIndex:=ListBox1.Items.IndexOf(s1);
      ListBoxClick(ListBox1);
      s1:=MC.mySQLs('Select Tip from '+TSName+' where id='''+s+''' and misce='''+DefMisce+'''');
      if ListBox3.Items.IndexOf(s1)<>-1 then ListBox3.ItemIndex:=ListBox3.Items.IndexOf(s1);
      ListBoxClick(ListBox3);
      s1:=MC.mySQLs('Select Rozmir from '+TSName+' where id='''+s+''' and misce='''+DefMisce+'''');
      if ListBox4.Items.IndexOf(s1)<>-1 then ListBox4.ItemIndex:=ListBox4.Items.IndexOf(s1);
      ListBoxClick(ListBox4);
      s1:=MC.mySQLs('Select Rist from '+TSName+' where id='''+s+''' and misce='''+DefMisce+'''');
      if ListBox5.Items.IndexOf(s1)<>-1 then ListBox5.ItemIndex:=ListBox5.Items.IndexOf(s1);
      ListBoxClick(ListBox5);
      End;


    End;
end;

end.

