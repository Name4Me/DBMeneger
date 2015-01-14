unit uOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin,uDataST, Grids;

type
  TOrderForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    Button1: TButton;
    CheckBox: TCheckBox;
    SpinEdit: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ListBox4: TListBox;
    SGrid: TStringGrid;
    Button2: TButton;
    Button3: TButton;
    Label12: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button4: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure LRefresh;
    procedure GridRefresh;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrderForm: TOrderForm;
  Order:TTovar;
implementation
uses udata, uMainForm;
{$R *.dfm}

procedure TOrderForm.Button1Click(Sender: TObject);
  Var s:string;
  i:integer;
begin
  With Order do Begin
    if (rtid<>'0') and (rid<>'0') then
      s:='INSERT INTO orders (TID, Nazva, Tip, Rozmir, Rist, Kilkist,Cina,user_id, order_no) '+
      'VALUES('''+ID+''', '''+Nazva+''', '''+Tip+''', '+Rozmir+', '+Rist+', '+SpinEdit.Text+', '+Cina+', '+UserID+', 0)';
    if (rtid='0') and (rid<>'0') then
      s:='INSERT INTO orders (TID, Nazva, Tip, Rozmir, Kilkist,Cina,user_id, order_no) '+
      'VALUES('''+ID+''', '''+Nazva+''', '''+Tip+''', '+Rozmir+', '+SpinEdit.Text+', '+Cina+', '+UserID+', 0)';
    if (rtid='0') and (rid='0') then
      s:='INSERT INTO orders (TID, Nazva, Tip, Kilkist,Cina,user_id, order_no) '+
      'VALUES('''+ID+''', '''+Nazva+''', '''+Tip+''', '+SpinEdit.Text+', '+Cina+', '+UserID+', 0)';
  i:=MrC.mySQLi('select kilkist from orders where user_id='+UserID+' and order_no=0 and tid = '+id);
  if i=-1 then MrC.MyEx(s)
    else MrC.MyEx('Update orders set kilkist='+IntTostr(i+SpinEdit.Value)+' where user_id='+UserID+' and order_no=0 and tid = '+ID);

  GridRefresh;
  End;
end;

procedure TOrderForm.Button2Click(Sender: TObject);
begin
  MrC.MyEx('Delete from orders where user_id='+UserID+' and order_no=0');
  GridRefresh;
end;

procedure TOrderForm.Button3Click(Sender: TObject);
var mn,i:integer;
begin

  mn:=MrC.mySQLi('Select max(order_no) from  orders where user_id='+UserID);
  if SGrid.RowCount>1 then for I := 1 to SGrid.RowCount - 1 do
    MrC.MyEx('Update orders set order_no='+Inttostr(mn+1)+' where user_id='+UserID+' and order_no=0 and id='+SGrid.Cells[8,i]);


end;

procedure TOrderForm.Button4Click(Sender: TObject);
var i:integer;
begin
  for i := SGrid.Selection.BottomRight.y downto SGrid.Selection.TopLeft.y do
      MrC.MyEx('Delete from orders where user_id='+UserID+' and order_no=0 and id='+SGrid.Cells[8,i]);
  GridRefresh;
end;

procedure TOrderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TOrderForm.FormCreate(Sender: TObject);
begin
  if not MrC.Connected then Begin
    //MrC.SetOptions('LocalHost','trp','ozuwsgag','sklad',3306);
    MrC.SetOptions('sline.com.ua','slinecom_test','test','slinecom_sklad',3306);
    MrC.Connect;
    End;
  ListBox1.Items.Text:=MrC.mySQLf('Select nazva from gg',1);
  Label14.Caption:=MrC.mySQLs('select value from uservar where name=''kurs''');
end;

procedure TOrderForm.FormPaint(Sender: TObject);
begin
  SGrid.ColWidths[SGrid.ColCount-1]:=SGrid.Width-SGrid.CellRect(SGrid.ColCount-1,0).Left-5;
end;

procedure TOrderForm.FormShow(Sender: TObject);
begin
  GridRefresh;
end;

procedure TOrderForm.GridRefresh;
var kt,sc:string;
begin
  MrC.mySQLg(SGrid,'select TID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,ID from orders where user_id='+UserID+' and order_no=0');
  kt:=MrC.mySQLs('select sum(Kilkist) from orders where user_id='+UserID+' and order_no=0');
  sc:=MrC.mySQLs('select sum(Cina) from orders where user_id='+UserID+' and order_no=0');
  Label17.Caption:='['+kt+'רע. ('+sc+'$)]'
end;

procedure TOrderForm.ListBox1Click(Sender: TObject);
Var ml:Tstrings;
begin
  ListBox3.Clear;
  ListBox4.Clear;
  Button1.Enabled:=False;

  With Order do begin
    Tip:='';
    Rozmir:='';
    Rist:='';
    AllKilkist:=0;
    Cina:='';

    Nazva:=ListBox1.Items[ListBox1.ItemIndex];
    ml:=TstringList.Create;
    ml.Text:=MrC.mySQLf('Select id,rid,rtid from gg where nazva='''+Nazva+'''');
    GID:=ml.Values['id'];
    ID:=GID;
    rid:=ml.Values['rid'];
    rtid:=ml.Values['rtid'];
    ml.Free;
    With ListBox2.Items do if CheckBox.Checked then
      Text:=MrC.mySQLf('Select distinct tip from '+TrSName+' where nazva='''+Nazva+'''',1)
      Else Text:=MrC.mySQLf('Select tip from types where ggid='+GID,1);
    end;

  if Order.rid='0' then ListBox3.Enabled:=false;
  if Order.rtid='0' then ListBox4.Enabled:=false;
  
  LRefresh;
end;

procedure TOrderForm.ListBox2Click(Sender: TObject);
begin
  ListBox3.Clear;
  ListBox4.Clear;
  Button1.Enabled:=False;

  With Order do begin
    Rozmir:='';
    Rist:='';
    AllKilkist:=0;
    Cina:='';
    Tip:=ListBox2.Items[ListBox2.ItemIndex];

    TID:=MrC.mySQLs('Select id from types where ggid='+GID+' and tip='''+Tip+'''');
    ID:=GID+TID;
  if Order.rid<>'0' then Begin
    ListBox3.Enabled:=True;
    if CheckBox.Checked then ListBox3.Items.Text:=MrC.mySQLf('Select distinct rozmir from '+TrSName+' where nazva='''+Order.Nazva+''' and tip='''+Order.Tip+'''',1)
      Else ListBox3.Items.Text:=MrC.mySQLf('Select rozmir from rozmir where rid='''+Order.rid+'''',1);
    End Else Begin
      Order.AllKilkist:=MrC.mySQLi('Select sum(kilkist) from '+TrSName+
        ' where nazva='''+Order.Nazva+''' and tip='''+Order.Tip+'''');

      Cina:=MrC.mySQLs('Select getcina('''','''+GID+TID+''',''o'') as cina');
      Button1.Enabled:=True;
    End;
  end;

  LRefresh;

end;

procedure TOrderForm.ListBox3Click(Sender: TObject);
begin
  ListBox4.Clear;
  Button1.Enabled:=False;
  With Order do begin
    Rist:='';
    AllKilkist:=0;
    Cina:='';
    Rozmir:=ListBox3.Items[ListBox3.ItemIndex];
    ID:=GID+TID+Rozmir;
    if Order.rtid<>'0' then Begin
      ListBox4.Enabled:=True;
      if CheckBox.Checked then
        ListBox4.Items.Text:=MrC.mySQLf('Select distinct rist from '+TrSName+
        ' where nazva='''+Order.Nazva+''' and tip='''+Order.Tip+''' and rozmir='+Order.Rozmir,1)
        Else ListBox4.Items.Text:=MrC.mySQLf('Select rozmir from rozmir where rid=0',1);
        End Else Begin
          Order.AllKilkist:=MrC.mySQLi('Select sum(kilkist) from '+TrSName+
          ' where nazva='''+Order.Nazva+''' and tip='''+Order.Tip+''' and rozmir='+
          Order.Rozmir);
          Cina:=MrC.mySQLs('Select getcina('''','''+id+''',''o'') as cina');
          Button1.Enabled:=True;
          End;
    end;

  LRefresh;
end;

procedure TOrderForm.ListBox4Click(Sender: TObject);
begin
  With Order do begin
    Rist:=ListBox4.Items[ListBox4.ItemIndex];
    ID:=GID+TID+Rozmir+Rist;
    if CheckBox.Checked then
      Order.AllKilkist:=MrC.mySQLi('Select sum(kilkist) from '+TrSName+
        ' where nazva='''+Nazva+''' and tip='''+Tip+''' and rozmir='+
        Rozmir+' and rist='+Rist);
    Cina:=MrC.mySQLs('Select getcina('''','''+ID+''',''o'') as cina');
  end;
  Button1.Enabled:=True;
  LRefresh;
end;

procedure TOrderForm.LRefresh;
begin
  Label5.Caption:=Order.Nazva;
  Label6.Caption:=Order.Tip;
  Label7.Caption:=Order.Rozmir;
  Label8.Caption:=Order.Rist;
  Label10.Caption:=IntToStr(Order.AllKilkist);
  Label12.Caption:=Order.Cina+'$';
  Label16.Caption:=Order.ID;
end;

procedure TOrderForm.SGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i:integer;
begin
  if Key = 46 Then
    for i := SGrid.Selection.BottomRight.y downto SGrid.Selection.TopLeft.y do
      MrC.MyEx('Delete from orders where user_id='+UserID+' and order_no=0 and id='+SGrid.Cells[8,i]);
  GridRefresh;
end;
{        id:= mySQLs('select id from GG Where Nazva = '''+HC2.Sections[0].Text+'''');
        rid:= mySQLs('select rid from GG Where Nazva = '''+HC2.Sections[0].Text+'''');
        rtid:= mySQLs('select rtid from GG Where Nazva = '''+HC2.Sections[0].Text+'''');
        mySQLcf(ListBox2.Items,'Select Tip from Types where GGID='''+id+'''');
        mySQLcf(ListBox3.Items,'Select Rozmir from Rozmir where rid='''+rid+'''');
        if rtid='1' then mySQLcf(ListBox4.Items,'Select Rozmir from Rozmir where rid=0');}
end.

