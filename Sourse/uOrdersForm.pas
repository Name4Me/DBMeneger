unit uOrdersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ButtonGroup, ComCtrls, Menus, Tabs, ExtCtrls,Printers;

type
  TOrdersForm = class(TForm)
    SGrid: TStringGrid;
    ButtonGroup: TButtonGroup;
    SBar: TStatusBar;
    PopupMenu1: TPopupMenu;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    TabSet: TTabSet;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Panel2: TPanel;
    Button3: TButton;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure PopupClick(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure SGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Refresh (const s:string);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrdersForm: TOrdersForm;

implementation

uses uMainForm,uData,uSQL_Func;

{$R *.dfm}



procedure TOrdersForm.Button1Click(Sender: TObject);
var i:integer;
begin
  for I := 0 to ListBox2.Count - 1 do
    MrC.MyEx('Update orders set state=''Відібрано''  where user_id='+ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+' and tid='+ListBox2.Items[i]);
      ButtonGroupButtonClicked(ButtonGroup, ButtonGroup.ItemIndex);
end;

procedure TOrdersForm.Button2Click(Sender: TObject);
var
  s,s1,s2:string;
  l,t,n,y:integer;
begin
  With Printer do with Canvas do begin
    BeginDoc;
    Font.Name:='Times New Roman';
    Font.Style := [fsBold];
    Font.Size:=10;
    t:= TextHeight('X');
    l:= TextWidth('W');
    TextOut(7*l,t,'Замовлення ['+ButtonGroup.Items[ButtonGroup.ItemIndex].Caption+'] ['
      +ListBox1.Items[ListBox1.ItemIndex]+'] '
      +FormatDateTime('dd.mm.yyyy [hh:nn]', Now));
    s:='';
    for n := 1 to 40 do s:=s+'_';

    s1:='';
    s2:='';
    y:=3*t;
    for n := 1 to StringGrid1.RowCount - 1 do with Canvas do Begin
      if s2 <> StringGrid1.Cells[1,n] Then Begin
        if s2<>'' then inc(y,t);
        Font.Style := [fsBold];
        TextOut(7*l,y,StringGrid1.Cells[1,n]);
        s2:=StringGrid1.Cells[1,n];
        inc(y,t);
        End;
      if s1 <> StringGrid1.Cells[2,n] Then Begin
        Font.Style := [];
        TextOut(7*l,y,StringGrid1.Cells[2,n]);
        MoveTo(7*l,y-1);
        LineTo(7*l+TextWidth(s),y-1);
        s1:=StringGrid1.Cells[2,n];
        End;
      Font.Style := [];
      TextOut(20*l,y,StringGrid1.Cells[3,n]);
      TextOut(23*l,y,StringGrid1.Cells[4,n]);
      TextOut(25*l,y,StringGrid1.Cells[5,n]);
      TextOut(27*l,y,StringGrid1.Cells[6,n]);
      inc(y,t);
      if y+t>PageHeight then Begin
        NewPage;
        y:=t;
        End;
      End;

  EndDoc;
  end;
end;

procedure TOrdersForm.Button3Click(Sender: TObject);
var
  s,s1,s2,s3:string;
  l,t,n,y,p:integer;
begin
  MrC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,kilkist,(kilkistbyid('''',tid)-kilkist) as zk,GetMisceFromTID(tid) as misce from orders where user_id='+
    ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+' and state=''Замовлено'' order by Nazva,Tip,Rozmir,Rist');
  //exit;
  With Printer do with Canvas do begin
    BeginDoc;
    Pen.Color:=ClRed;
    Font.Name:='Times New Roman';
    Font.Style := [fsBold];
    Font.Size:=10;
    t:= TextHeight('X');
    l:= TextWidth('W');
    TextOut(7*l,t,'Замовлення ['+ButtonGroup.Items[ButtonGroup.ItemIndex].Caption+'] '
      +FormatDateTime('dd.mm.yyyy [hh:nn]', Now));
    s:='';
    for n := 1 to 42 do s:=s+'_';

    s1:='';
    s2:='';
    y:=3*t;
    for n := 1 to StringGrid1.RowCount - 1 do with Canvas do Begin
      if s2 <> StringGrid1.Cells[1,n] Then Begin
        if s2<>'' then inc(y,t);
        Font.Style := [fsBold];
        TextOut(7*l,y,StringGrid1.Cells[1,n]);
        s2:=StringGrid1.Cells[1,n];
        inc(y,t);
        End;
      if s1 <> StringGrid1.Cells[2,n] Then Begin
        Font.Style := [];
        TextOut(7*l,y,StringGrid1.Cells[2,n]);
        MoveTo(7*l,y-1);
        LineTo(7*l+TextWidth(s),y-1);
        s1:=StringGrid1.Cells[2,n];
        End;
      Font.Style := [];
      TextOut(20*l,y,StringGrid1.Cells[3,n]);
      TextOut(23*l,y,StringGrid1.Cells[4,n]);
      TextOut(25*l,y,StringGrid1.Cells[5,n]);
      TextOut(27*l,y,StringGrid1.Cells[6,n]);
      //TextOut(29*l,y,StringGrid1.Cells[7,n]);
      s3:=StringGrid1.Cells[7,n];
      //ShowMessage(inttostr(length(s3))+' -- '+s3);
      if length(s3)>60 then Begin
        p := LastDelimiter(',', copy(s3,1,60));
        TextOut(29*l,y,copy(s3,1,p));
        //ShowMessage(copy(s3,1,p));
        inc(y,t);
        TextOut(29*l,y,copy(s3,p+1,length(s3)-p));
        //ShowMessage(copy(s3,p+1,length(s3)-p));
        End else TextOut(29*l,y,StringGrid1.Cells[7,n]);


      inc(y,t);
      if y+t>PageHeight then Begin
        NewPage;
        y:=t;
        End;

      End;



  EndDoc;
  end;
end;

procedure TOrdersForm.ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
Var i:Integer;
  ml:Tstrings;
begin
  //MrC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,kilkist,((select sum(kilkist) from '+TrSName+' where id=orders.tid)) as zk,GetMisceFromTID(tid),tid,state as Status from orders where user_id='+ButtonGroup.Items[Index].Hint+' order by Nazva,Tip,Rozmir,Rist');
  //MrC.mySQLg(SGrid,'Select Nazva,Tip,Rozmir,Rist,kilkist,((select sum(kilkist) from '+TrSName+' where id=orders.tid)) as zk,tid,state as Status,id from orders where user_id='+ButtonGroup.Items[Index].Hint+' order by Nazva,Tip,Rozmir,Rist');

  TabSet.Tabs.Clear;

  ml:=TStringList.Create;
  ml.Text:=MrC.mySQLf('select distinct state as st,(Select sum(kilkist) from orders where state = st and user_id='+ButtonGroup.Items[Index].Hint+
    ') from orders where user_id='+ButtonGroup.Items[Index].Hint+'',Row_s);
  for i := 0 to ml.Count - 1 do
    TabSet.Tabs.Values[ml.Names[i]]:=ml.ValueFromIndex[i];
  ml.Free;
  SBar.Panels[0].Text:=MrC.LastError;
  ButtonGroup.ItemIndex:=Index;
  if TabSet.Tabs.Count>0 then TabSet.TabIndex:=0;
end;

procedure TOrdersForm.ComboBox1Change(Sender: TObject);
begin
  ListBox2.Items.Text:=MC.mySQLf('Select id from oper where misce='''+ComboBox1.Text+''' and oper=''Переміщення'' and data='''+MDs+'''',Row_s);
end;

procedure TOrdersForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;;
end;

procedure TOrdersForm.FormCreate(Sender: TObject);
var ml:TStrings;
  i:integer;
begin
  if not MrC.Connected then Begin
    //MrC.SetOptions('LocalHost','trp','ozuwsgag','sklad',3306);
    MrC.SetOptions('sline.com.ua','slinecom_test','test','slinecom_sklad',3306);
    MrC.Connect;
    End;
  ComboBox1.Items.Text:=MC.mySQLf('Select distinct misce from oper where oper=''Переміщення'' and data='''+MDs+'''',1);
  ListBox1.Items.Text:=MC.mySQLf('Select distinct misce from misce',1);

  ml:=TStringList.Create;
  ml.Text:=MrC.mySQLf('Select distinct user_id  as uid,(Select login from users where id=uid) as name from orders order by name',1);

  With ButtonGroup Do Begin
    Items.BeginUpdate;
    Items.Clear;
    for i := 0 to ml.Count - 1 do With Items.Add do Begin
      Hint:=ml.Names[i];
      Caption:=ml.ValueFromIndex[i];
      End;
    Items.EndUpdate;
    
    if Items.Count<=0 then Begin
      exit;
      End;
      ItemIndex:=0;
      ButtonGroupButtonClicked(Sender,0);
    End;





  ml.Text:=MrC.mySQLf('Select value from uservar where name=''order_status'' order by vid',1);
  SBar.Panels[0].Text:=MrC.LastError;
  for I := 0 to ml.Count - 1 do Begin
    PopupMenu1.Items.Add(TMenuItem.Create(PopupMenu1));
    with PopupMenu1.Items[PopupMenu1.Items.Count-1] do begin
      Caption:=ml[i];
      OnClick:=PopupClick;
      end;
    End;
  ml.Free;
  if ButtonGroup.Items.Count>0 then ButtonGroup.ItemIndex:=0;


end;

procedure TOrdersForm.FormPaint(Sender: TObject);
begin
  with SGrid do if RowCount*Canvas.TextHeight('H')>Height then
    ColWidths[ColCount-1]:=Width-CellRect(ColCount-1,0).Left-20
    else ColWidths[ColCount-1]:=Width-CellRect(ColCount-1,0).Left-5;
end;

procedure TOrdersForm.ListBox1Click(Sender: TObject);
begin
  MrC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,kilkist from orders where state=''Замовлено'' and GetMisceFromTID(tid) like''%'+
    ListBox1.Items[ListBox1.ItemIndex]+'%'' order by Nazva,Tip,Rozmir,Rist');
end;

procedure TOrdersForm.PopupClick(Sender: TObject);
Var i:integer;
begin
  with sender as TMenuItem do
    for i := SGrid.Selection.BottomRight.y downto SGrid.Selection.TopLeft.y do
      if MrC.MyEx('Update orders set state='''+Caption+'''  where user_id='+ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+' and id='+SGrid.Cells[SGrid.ColCount-1,i]) Then
        SGrid.Cells[SGrid.ColCount-2,i]:=Caption;
  ButtonGroupButtonClicked(ButtonGroup, ButtonGroup.ItemIndex);
end;

procedure TOrdersForm.Refresh;
begin
    //ShowMessage(ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+'--'+TabSet.Tabs.Names[TabSet.TabIndex]);
    MrC.mySQLg(SGrid,'Select Nazva,Tip,Rozmir,Rist,kilkist,(kilkistbyid('''',tid)-kilkist) as zk,state as Status,data,id from orders where user_id='+
    ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+' and state='''+TabSet.Tabs.Names[TabSet.TabIndex]+
    ''' order by '+ s);
end;

procedure TOrdersForm.SGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i:integer;
begin
  if Key = 46 Then Begin
    for i := SGrid.Selection.BottomRight.y downto SGrid.Selection.TopLeft.y do
      MrC.MyEx('Delete from orders where user_id='+ButtonGroup.Items[ButtonGroup.ItemIndex].Hint+
      ' and id='+SGrid.Cells[SGrid.ColCount-1,i]);
    ButtonGroupButtonClicked(ButtonGroup, ButtonGroup.ItemIndex);
    End;
end;

procedure TOrdersForm.SGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  With SGrid.MouseCoord(x,y) do if (y=0) and (x>0) Then Refresh(SGrid.Cells[x,y]);
  //GroupBox2.Caption:=IntToStr(X)+':'+IntToStr(Y)+'-'+;
end;

procedure TOrdersForm.TabSetClick(Sender: TObject);
begin
  Refresh('Nazva,Tip,Rozmir,Rist');
end;

end.
