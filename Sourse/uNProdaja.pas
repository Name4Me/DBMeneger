unit uNProdaja;

interface

uses
  SysUtils,  Windows,Graphics,
  Forms, Math, ScktComp, ExtCtrls, DB, DBTables, DBGrids, Grids, Spin,
  StdCtrls, Controls, Classes,Dialogs, ComCtrls,printers,StrUtils,Messages;

type
  TFNP = class(TForm)
    Edit1: TEdit;
    Panel1: TPanel;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    Panel2: TPanel;
    SE4: TSpinEdit;
    Label4: TLabel;
    Timer1: TTimer;
    IPN: TEdit;
    Edit3: TEdit;
    SpinButton1: TSpinButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    Edit4: TEdit;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    Panel3: TPanel;
    Memo1: TMemo;
    Button3: TButton;
    Label11: TLabel;
    Button5: TButton;
    Panel6: TPanel;
    CheckBox1: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit9: TEdit;
    Button6: TButton;
    SGrid1: TStringGrid;
    SGrid2: TStringGrid;
    Button7: TButton;
    ListBox1: TListBox;
    CheckBox2: TCheckBox;
    Splitter1: TSplitter;
    ListBox2: TListBox;
    ListBox3: TListBox;
    Edit10: TEdit;
    Label16: TLabel;
    ListBox4: TListBox;
    ListBox5: TListBox;
    ComboBox1: TComboBox;
    

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Timer1Timer(Sender: TObject);

    procedure Edit1Change(Sender: TObject);

    procedure IPNKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure ListBox2KeyPress(Sender: TObject; var Key: Char);

    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);

    procedure ListBox3Click(Sender: TObject);
    procedure Calc;
    procedure GridRefresh;
    procedure MyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyChange(Sender: TObject);

    protected Procedure isGetFocus(var msg : TWMActivate) ; message  WM_ACTIVATE;
  private
  public
    { Public declarations }
  end;

var
  FNP: TFNP;
  hComm:THANDLE;
  tid:string;
implementation

Uses uMainForm,uData,uCommPort;

{$R *.dfm}
procedure TFNP.MyChange(Sender: TObject);
begin
  if sender is TEdit then With TEdit(Sender) do Begin
    if (Sender=Edit6) or (Sender=Edit7) Then Begin
      if Text='' then Text:='0';
      Calc;
      End;
    if (Sender=Edit10)Then if StrToFloat(Text)>0 then Color:=ClRed Else Color:=ClGreen;
    if (Sender=Edit9)or(Sender=Edit8) Then if pos('-',Text)<>0 then Color:=ClRed Else Color:=ClGreen;
    End;
  if Sender is TSpinEdit then With TSpinEdit(Sender) do Begin
    if Sender=SpinEdit1 Then Begin
      if Text <> '' Then if Value>StrToInt(SGrid1.Cells[6,1]) then Value:=StrToInt(SGrid1.Cells[6,1]);
      if MaxValue = 1 then Text:='1';
      if Text <> '' Then Edit3.Text:=FloatToStrF((Value*StrToFloat(Label2.Caption)),ffFixed,7,2);
      End;
    End;
end;
procedure TFNP.Edit1Change(Sender: TObject);
Var
  s:string;
begin
  if length(Edit1.Text)=2 Then Begin
    if Edit1.Text[1]='0'Then s:=Edit1.Text[2] Else s:=Edit1.Text;
    ListBox2.Items.Text:=MC.mySQLf('Select distinct Tip From Склад where ID like'''+Edit1.Text+'%%'' and Misce='''+DefMisce+''' Order By Tip',1);
    MC.mySQLg(SGrid1,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад Where ID Like '''+Edit1.Text+'%%'' And Misce = '''+DefMisce+''' Order By ID limit 30');
    End;
  
  if length(Edit1.Text)>=3 Then Begin
    MC.mySQLg(SGrid1,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад Where ID = '''+Edit1.Text+''' And Misce = '''+DefMisce+'''');
    If SGrid1.RowCount <> 2 Then
      MC.mySQLg(SGrid1,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад Where ID Like '''+Edit1.Text+'%%'' And Misce = '''+DefMisce+''' Order By ID');
    If (SGrid1.RowCount = 2) and (Length(Edit1.Text)<Length(SGrid1.Cells[1,SGrid1.Selection.Top]))
      and  (pos(Edit1.Text,SGrid1.Cells[1,SGrid1.Selection.Top]) = 1) Then Edit1.Text:=SGrid1.Cells[1,SGrid1.Selection.Top];
    If (SGrid1.RowCount = 2) and (SGrid1.Cells[1,SGrid1.Selection.Top] = Edit1.Text) Then Begin
      Edit3.Enabled:=True;
      SpinEdit1.Enabled:=True;
      Button2.Enabled:=True;
      if rb3.Checked=false Then Label2.Caption:=SGrid1.Cells[7,1]
        else Begin
        if rb3.Checked Then Label2.Caption:=MC.mySQLs('select getcina('''+DefMisce+''','''+Edit1.Text+''',''o'')')
          else Label2.Caption:=MC.mySQLs('select getcina('''+DefMisce+''','''+Edit1.Text+''','''')');
        Label2.Caption:=FloatSTS(Label2.Caption);
        Edit3.Text:=Label2.Caption;
        End;

      Edit3.Text:=Label2.Caption;
      SpinEdit1.Text:='1';
      SpinEdit1.MaxValue:=StrToInt(SGrid1.Cells[6,1]);
      if CheckBox1.Checked then Button2.Click;
      End
      Else Begin
        Button2.Enabled:=False;
        Edit3.Text:='0,00';
        Edit4.Text:='0,00';
        Label2.Caption:='';
        Edit3.Enabled:=False;
        SpinEdit1.Enabled:=False;
        End;
    end;
end;

procedure TFNP.Button2Click(Sender: TObject);
 //Var z:zap;
begin
  Button2.Enabled:=False;
  MC.MyEx('Call prodaja('''+DefMisce+''', '''+Edit1.Text+''' , '+SpinEdit1.Text+' , '+
    AnsiReplaceStr(FloatToStrF(kurs*StrToFloat(Edit3.Text),ffFixed,7,2), ',', '.')+
    ' , '+IPN.Text+' ,'''+ComboBox1.Text+''', '''+User+''','''+mds+''' , 3)');
  //Edit10.Text:='Call mypr('''+DefMisce+''', '''+Edit1.Text+''' , '+SpinEdit1.Text+' , '+AnsiReplaceStr(Edit5.Text, ',', '.')+' , '+IPN.Text+' , '''+User+''' , 3)';

  Edit1.Text:= Copy (Edit1.Text,1,Length(Edit1.Text)-3);
  Edit1.SetFocus;
  keybd_event(vk_End,0,KEYEVENTF_EXTENDEDKEY,0);

  Edit3.Text:='0,00';
  Label2.Caption:='';
  Edit3.Enabled:=False;
  SpinEdit1.Enabled:=False;
  if CheckBox1.Checked then Edit1.Text:='';
  Edit1.OnChange(Sender);
  GridRefresh;

end;



procedure TFNP.FormShow(Sender: TObject);
begin
  Edit4.Text:='0,00';
  Edit1.SetFocus;
end;

procedure TFNP.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    '0'..'9':;
    '/':Begin Key := #0; ListBox2.SetFocus;end;
    #8 :;
    else Key := #0;
    end;
end;

procedure TFNP.Calc;
Var
  sum:real;
begin
  sum:=(StrToFloat(Edit7.Text)+(StrToFloat(Edit6.Text)/kurs))-StrToFloat(Label8.Caption)-StrToFloat(Edit10.Text);
  Edit8.Text:=floatToStrF(sum*kurs,ffFixed,7,2);
  Edit9.Text:=floatToStrF(sum,ffFixed,7,2);
end;

procedure TFNP.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '+')and (Button2.Enabled) then Begin Key:=#0; Button2.Click;End;
end;

 procedure TFNP.Button7Click(Sender: TObject);
var
s,sm,s1:string;
l,l1,l2,l3,t,h,w,n,m,y,pi:integer;
begin
  //if printer then
  
  With Printer do begin
    pi:=PrinterIndex;
    if (Printers.IndexOf('W150')=-1)and(Printers.IndexOf('UNS-SP')=-1) then exit;

    MC.mySQLg(SGrid2,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,time From Oper Where (IP ='+IPN.Text+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') and data='''+mds+''' order by Nazva,Tip,Rozmir,Rist');
    sm:= MC.mySQLs('Select suma from opt where inf ='''+ComboBox1.Text+'''');
    if sm='' then sm:='0';



        if Printers.IndexOf('W150')<>-1 then Begin
              PrinterIndex:=Printers.IndexOf('W150');

    
  
    With Printer do with Canvas do begin
      Copies:=SE4.Value;
      BeginDoc;
      Font.Name:='MS Sans Serif';
      Font.Style := [fsBold];
      Font.Size:=8;
      t:= TextHeight('X');
      l:= TextWidth('MMMMMM');
      l1:= TextWidth('Р-м ');
      l2:= TextWidth('Р-м Р-т ');
      l3:= TextWidth('Р-м Р-т К-ть');
  
      TextOut(0,0,'>> "Стильна лінія"');

      TextOut(l*2+l2,0,FormatDateTime('dd.mm.yyyy [hh:nn]', Now)+'{'+IPN.Text+'}');
      TextOut(0,t,'>> '+ComboBox1.Text);



      s:='';
      For n:=1 to 73 do s:=s+'-';
      Printer.Canvas.TextOut(0,2*t,s);
      y:=3*t;
      s1:='';
      for n := 1 to SGrid2.RowCount - 1 do with Canvas do Begin
        if s1 <> SGrid2.Cells[2,n] Then Begin
          Font.Style := [fsBold];
          TextOut(0,y,SGrid2.Cells[2,n]);
          s1:=SGrid2.Cells[2,n];
          inc(y,t);
          End;
        Font.Style := [];
        TextOut(0,y,SGrid2.Cells[3,n]);
        TextOut(l*2,y,SGrid2.Cells[4,n]);
        TextOut(l*2+l1,y,SGrid2.Cells[5,n]);
        TextOut(l*2+l2,y,SGrid2.Cells[6,n]);
  
        TextOut(l*2+l3,y,FloatToStrF(RoundTo(StrToFloat(SGrid2.Cells[7,n])/kurs,-2),ffFixed,12,2)+'$ ('+SGrid2.Cells[7,n]+'грн.)');
        inc(y,t);
        End;

      Font.Style := [fsBold];
      s:='';
      For n:=1 to 73 do s:=s+'-';
      Printer.Canvas.TextOut(0,y,s);

      inc(y,t);

      TextOut(0,y,'['+Label5.Caption+']');
      TextOut(l,y,'Курс: '+FloatToStrF(kurs,ffFixed,7,2));
      s1:=FloatToStrF(RoundTo(StrToFloat(Label6.Caption)/Kurs,-2),ffFixed,12,2)+'$ ('+FloatToStrF(StrToFloat(Label6.Caption),ffFixed,12,2)+'грн.)';
      TextOut(TextWidth(s)-TextWidth(s1),y,s1);
      inc(y,t);
      if strToFloat(sm)<>0 Then  Begin
        Printer.Canvas.TextOut(l,y,'Попередній борг: ');
        s1:=FloatSTS(sm)+'$ ('+FloatToStrF(RoundTo(StrToFloat(sm)*kurs,-2),ffFixed,12,2)+')';
        TextOut(TextWidth(s)-TextWidth(s1),y,s1);
        inc(y,t);

        Printer.Canvas.TextOut(l,y,'Всього: ');
        s1:=FloatToStrF(StrToFloat(Label6.Caption)/Kurs+strTofloat(sm),ffFixed,12,1)+'$ ('+FloatToStrF(RoundTo((StrToFloat(Label6.Caption)+strTofloat(sm)*Kurs),-2),ffFixed,12,2)+'грн.)';
        TextOut(TextWidth(s)-TextWidth(s1),y,s1);
        inc(y,t);
        End;
      if CheckBox2.Checked then Begin
  
        Font.Style := [];
        TextOut(0,y+2*t,'т. (8 0382) 743952');
        TextOut(0,y+3*t,'т. (8 067) 7133464');
        TextOut(0,y+5*t,'Підпис покупця______________');
        Font.Size:=7;
        TextOut(0,y+7*t,'УВАГА!!! Притензії стосовно не відповідності кількості');
        TextOut(0,y+8*t,'та комплектності, що були виявлені за межами магазину');
        TextOut(0,y+9*t,'не приймаються.');
        End;
  
    EndDoc;
    Copies:=1;
    end;
      End;



        if Printers.IndexOf('UNS-SP')<>-1 then Begin
          PrinterIndex:=Printers.IndexOf('UNS-SP');


    with SGrid2 do  With Printer do with Canvas do begin
    Copies:=SE4.Value;
    BeginDoc;
    Font.Name:='MS Sans Serif';
    Font.Style := [fsBold];
    Font.Size:=8;
    h:= TextHeight('X');
    w:= TextWidth('W');

    TextOut(0,0,'>> "Стильна лінія"');
    s:=FormatDateTime('dd.mm.yyyy [hh:nn]', Now)+'{'+IPN.Text+'}';
    TextOut(0,h,'>> '+ComboBox1.Text);
    Font.Size:=7;
    s:='--------------- '+s+' ----------';
    Printer.Canvas.TextOut(0,2*h,s);
    l:=3;
    s1:='';
    for n := 1 to SGrid2.RowCount - 1 do with Canvas do Begin
      if s1 <> SGrid2.Cells[2,n] Then Begin
        Font.Style := [fsBold];
        TextOut(0,l*h,SGrid2.Cells[2,n]);
        s1:=SGrid2.Cells[2,n];
        inc(l);
        End;
      Font.Size:=7;
      Font.Style := [];
      TextOut(0,l*h,SGrid2.Cells[3,n]);
      TextOut(w*10,l*h,SGrid2.Cells[4,n]);
      if Cells[5,n]='' then TextOut(w*10,l*h,Cells[4,n]+' -'+Cells[6,n])
      else TextOut(w*10,l*h,SGrid2.Cells[4,n]+'/'+Cells[5,n]+'-'+Cells[6,n]);

      TextOut(w*13,l*h,FloatToStrF(RoundTo(StrToFloat(SGrid2.Cells[7,n])/kurs,-2),ffFixed,12,1)+'$('+Copy(SGrid2.Cells[7,n],1,Length(SGrid2.Cells[7,n])-3)+')');
      inc(l);
      End;

    Font.Style := [fsBold];
    TextOut(0,l*h,'-------------------------------------------------------');
    inc(l);


      TextOut(0,l*h,'['+Label5.Caption+']');
      TextOut(2*w,l*h,'Курс: '+FloatToStrF(kurs,ffFixed,7,2));
      s1:=FloatToStrF(RoundTo(StrToFloat(Label6.Caption)/Kurs,-2),ffFixed,12,2)+'$('+FloatToStrF(StrToFloat(Label6.Caption),ffFixed,12,2)+' грн.'+')';
      TextOut(8*w,l*h,s1);
      inc(l);
      if strToFloat(sm)<>0 Then  Begin
        Printer.Canvas.TextOut(0,l*h,'Попередній борг: ');
        s1:=FloatSTS(sm)+'$ ('+FloatToStrF(RoundTo(StrToFloat(sm)*kurs,-2),ffFixed,12,2)+' грн.)';
        TextOut(9*w,l*h,s1);
        inc(l);
  
        Printer.Canvas.TextOut(0,l*h,'Всього: ');
        s1:=FloatToStrF(StrToFloat(Label6.Caption)/Kurs+strTofloat(sm),ffFixed,12,2)+'$('+FloatToStrF(RoundTo((StrToFloat(Label6.Caption)+strTofloat(sm)*Kurs),-2),ffFixed,12,2)+' грн.'+')';
        TextOut(9*w,l*h,s1);
        inc(l);
        End;
      if CheckBox2.Checked then Begin
        inc(l);
        Font.Style := [];
        TextOut(0,(l)*h,'т. (8 0382) 743952');
        TextOut(0,(l+1)*h,'т. (8 067) 7133464');
        inc(l);
        TextOut(0,(l+2)*h,'Підпис покупця______________');
        inc(l);
        Font.Size:=7;
        TextOut(0,(l+3)*h,'УВАГА!!! Притензії стосовно не');
        TextOut(0,(l+4)*h,'відповідності кількості та комплектності,');
        TextOut(0,(l+5)*h,'що були виявлені за межами магазину');
        TextOut(0,(l+6)*h,'не приймаються.');
        inc(l,6)
        End;
      Font.Style := [fsBold];
      Font.Size:=7;
      TextOut(0,(l+3)*h,'-------------------------------------------------------');

  EndDoc;
  Copies:=1;
  end;
  End;
  PrinterIndex:=pi;
  end;


end;

procedure TFNP.FormActivate(Sender: TObject);
begin
  Timer1.Enabled:=True;
end;


procedure TFNP.SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  Label4.Caption:=IntToStr(ARow);

end;

procedure TFNP.Timer1Timer(Sender: TObject);
var s:string;
begin
  ReadCommStr(s);
  if s<> '' Then Edit1.text:=Copy(s,1,Length(s)-1);
end;

procedure TFNP.FormDeactivate(Sender: TObject);
begin
  Timer1.Enabled:=false;

end;

procedure TFNP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do
    Delete(IndexOf('Гурт ['+IPN.Text+'] '+ComboBox1.Text));
  Free;
  MainMForm.SetFocus;
end;

procedure TFNP.FormCreate(Sender: TObject);
begin
  ListBox3.Items.Text:=MC.mySQLf('Select Nazva from gg Order by nazva',1);
End;

procedure TFNP.IPNKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 Then Begin
    ComboBox1.Text:=MC.mySQLs('Select inf from oper Where (IP ='+IPN.Text+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') order by time');
    GridRefresh;
    Edit10.Text:=MC.mySQLs('Select suma from opt Where inf='''+ComboBox1.Text+'''');
    Edit6.Text:='0';
    Edit7.Text:='0';
    end;
End;

procedure TFNP.isGetFocus(var msg: TWMActivate);
begin
  if (Msg.Active = 1) or (Msg.Active = 2)then Begin
    ListBox1.Items.Text:=MC.mySQLf('Select distinct IP From Oper where Oper=''Продажа'' and data='''+MDs+''' and  Misce='''+DefMisce+''' and ip>0 Order by IP desc',1);
    if (IPN.Text<>'') and (ListBox1.Items.IndexOf(IPN.Text)=-1) Then ListBox1.Items.Add(IPN.Text);
    End;
     Inherited;
end;

procedure TFNP.MyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  i,n:integer;
begin
  //----------------------------------------------------------------SpinEdit1---
  if Sender=SpinEdit1 then begin
    CASE Key OF
      13: Edit3.SetFocus;
      37: Edit1.SetFocus;
      End;
    Key:=0;
    end;
  //--------------------------------------------------------------------Edit3---
  if (Sender=Edit3) and (KEY=37) then SpinEdit1.SetFocus;
  if (Sender=Edit1) and (key=13) and (SGrid1.RowCount = 2) Then Begin
    Key := 0;
    Edit1.Text:=SGrid1.Cells[1,1];
    SpinEdit1.SetFocus;
    SpinEdit1.MaxValue:=StrToInt(SGrid1.Cells[6,1]);
    End;
    

  if (Sender=SGrid2) and (Key = 46) Then with SGrid2 do begin
    n:=0;
    for i := 1 to ColCount-1 do if LowerCase(Cells[i,0])='cod' then n:=i;
    if n<>0 then for i := Selection.Top to Selection.Bottom do
      MC.MyEx('Call vidmina('+Cells[n,i]+')');
    GridRefresh;
    end;
end;

procedure TFNP.ListBox2KeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=13 Then Begin
    Edit1.Text:=Copy(Edit1.Text,1,2)+MC.mySQLs('Select ID from Types where GGID='''+copy(Edit1.Text,1,2)+''' and tip='''+ListBox2.Items[ListBox2.ItemIndex]+'''');
    Edit1.SetFocus;
    keybd_event(vk_End,0,KEYEVENTF_EXTENDEDKEY,0);
    End;
end;

procedure TFNP.ListBox3Click(Sender: TObject);
begin
  if Sender is TListBox then With TListBox(Sender) do Begin
    if ItemIndex<0 then Exit;
    case tag of
      1:Begin
        Edit1.Text:=MC.mySQLs('Select id from gg where nazva='''+Items[ItemIndex]+'''');
        ListBox4.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Склад Where Nazva = '''+Items[ItemIndex]+''' and Misce = '''+DefMisce+''' order by tip',1);
        End;
      2:ListBox2.Items.Text:=MC.mySQLf('Select Distinct Tip from Склад Where Nazva = '''+
        ListBox3.Items[ListBox3.ItemIndex]+''' and Misce = '''+DefMisce+''' and tip like '''+
        Items[ItemIndex]+'%'' order by tip',1);
      3:Begin
        Edit1.Text:=Copy(Edit1.Text,1,2)+MC.mySQLs('Select ID from Types where GGID='''+copy(Edit1.Text,1,2)+''' and tip='''+Items[ItemIndex]+'''');
        if ListBox3.ItemIndex>=0 then
          ListBox5.Items.Text:=MC.mySQLf('Select distinct rozmir from '+TSName+' where Nazva = '''+ListBox3.Items[ListBox3.ItemIndex]+''' and Misce = '''+DefMisce+''' and tip='''+Items[ItemIndex]+''' order by rozmir',1)
          Else ListBox5.Items.Text:=MC.mySQLf('Select distinct rozmir from '+TSName+' where id like '''+Edit1.Text+'%'' and Misce = '''+DefMisce+''' and tip='''+Items[ItemIndex]+''' order by rozmir',1);
        Tid:=Edit1.Text;
        End;
      4: if SGrid1.RowCount>2 Then Edit1.Text:=tid+Items[ItemIndex];
      5: Begin
        IPN.Text:=Items[ItemIndex];
        ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(MC.mySQLs('Select inf from oper Where (IP ='+IPN.Text+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') order by time'));
        Edit10.Text:=MC.mySQLs('Select suma from opt Where inf='''+ComboBox1.Text+'''');
        Edit6.Text:='0';
        Edit7.Text:='0';
        GridRefresh;
        End;
      End;
    End;  
  if Sender = SGrid1 then Edit1.Text:=SGrid1.Cells[1,SGrid1.Selection.Top];
  if Sender = SGrid2 then Edit1.Text:=SGrid2.Cells[1,SGrid2.Selection.Top];
  if Sender = ComboBox1 then Begin
    IPN.Text:=IntToStr(MC.mySQLi('Select max(IP) From Oper Where oper = ''Продажа''')+1);
    Label10.Caption:='Попередній борг: '+MC.mySQLs('Select suma from opt Where inf='''+ComboBox1.Text+'''')+'$';
    GridRefresh;
    End;

end;

procedure TFNP.SpinButton1UpClick(Sender: TObject);
begin
  Edit3.Text:=FloatToStrF((StrToFloat(Edit3.Text)+1),ffFixed,7,2);
end;

procedure TFNP.SpinButton1DownClick(Sender: TObject);
begin
  Edit3.Text:=FloatToStrF((StrToFloat(Edit3.Text)-1),ffFixed,7,2);
end;




procedure TFNP.Edit3KeyPress(Sender: TObject; var Key: Char);
var
  vrPos,vrLength,vrSelStart : byte;
const
  I : byte=1;
begin
  With Sender as TEdit do begin
    vrLength:=Length(Text);
    vrPos:=Pos(',', Text);
    vrSelStart:=SelStart;
    end;
  Case Key of
    '0'..'9': If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos)then Key:=#0;
    ',','.' : If (vrPos>0)or(vrSelStart=0)or(vrLength=0) then Key:=#0 else Key:=#44;
    #8 :;
    else Key := #0;
    end;
end;

procedure TFNP.Button3Click(Sender: TObject);
{
  Var
     nChar:DWORD;
     szRead:array[1..128]of byte;
     cRet:byte;
     i, dwTime,k:integer;
     f,f1:bool;
     DCB:TDCB;
     ct:TCommTimeOuts;
     s:string;
}
Begin
  {f:=true;
  f1:=true;
  memo1.Clear;
  hComm:=OpenIrCom (1, 115200);
  WriteFile(hComm,'READ'+chr(13),5,nChar,nil);
  Sleep (400);
  WriteFile(hComm,'ACK'+chr(13),4,nChar,nil);
  Sleep (100);
  k:=0;
  while f do begin
	  dwTime:= GetTickCount ();
    cRet:=0;

    WHILE (cRet<>13) and f do begin
      if ((GetTickCount() - dwTime > 3000)) then Begin f:=false; f1:=false; end;
      ReadFile (hComm, szRead, 100, nChar, NiL);
      
      s:='';
      for i:= 1 to nChar do begin
      //Memo2.Lines.Add(Char(szRead[i])+' - '+inttostr(szRead[i]));
      if (szRead[i]>=48)or(szRead[i]=44) then s:=s+chr(szRead[i]);
      if (szRead[i]=32) and (s<>'') and (pos(',',s)<>0) then Begin
        Memo1.Lines.Add(s);
        k:=k+StrToInt(Copy(s,pos(',',s)+1,length(s)-pos(',',s)));
        s:='';
      End;
      if s='OVER' Then f:=false;
      if (szRead[i]=13) then s:='';
      cRet:=szRead[i];
      end;
    end;
    WriteFile(hComm,'ACK'+chr(13),4,nChar,nil);
    Sleep (100);
    End;
CloseIrCom ();
Label2.Caption:=inttostr(memo1.Lines.Count)+'/'+IntToStr(k);
if not f1 then if MessageDlg('Читання данних з пристрою не виконано, спробувати ще раз?',
  mtConfirmation, [mbYes, mbNo], 0) = mrYes then button4.Click;
    }
end;

procedure TFNP.Button5Click(Sender: TObject);
{
  Var
    m:integer;
    s:string;
}
begin
   {For m:= 1 to Memo1.Lines.Count do begin
    s:=Memo1.Lines.Strings[0];
    if pos(',',s)=0 then Memo1.Lines.Delete(0)
    else begin
    Edit1.Text:=Copy(s,1,pos(',',s)-1);
    if Button2.Enabled Then Begin
    Caption:=Copy(s,pos(',',s)+1,length(s)-pos(',',s));
    if Q.FieldByName('Kilkist').AsInteger >= StrToInt(Copy(s,pos(',',s)+1,length(s)-pos(',',s))) then SpinEdit1.Value:=StrToInt(Copy(s,pos(',',s)+1,length(s)-pos(',',s)))
      Else Begin
      ShowMessage('Кількість більша наявної!!!');
      Break;

      End;
    if Button2.Enabled Then Button2.Click;
    Memo1.Lines.Delete(0);
    End else Begin
      ShowMessage('Товару з данним кодом не має!!!');
      Break;

      End;
      End;
end;  }
end;




procedure TFNP.Button6Click(Sender: TObject);
var
  sum:real;
  ID:string;
  s:string;
begin
  if StrToFloat(Edit10.Text)<0 Then sum:=StrToFloat(Edit9.Text)+StrToFloat(Edit10.Text)
    else sum:=StrToFloat(Edit10.Text)+StrToFloat(Edit9.Text);

  //
  MC.MyEx('UPDATE opt SET Suma='+FloatSTSQL(floatToStrF(-StrToFloat(Edit9.Text),ffFixed,7,2))+' WHERE inf ='''+ComboBox1.Text+'''');
  ID:=MC.mySQLs('Select id from opt where inf='''+ComboBox1.Text+'''');
  if StrToFloat(Edit9.Text)<-StrToFloat(Edit10.Text) then s:='Заборгованість'
    else s:='Погашення боргу';

  MC.MyEx('INSERT INTO foper (oper,Inf,Suma,Data,Time,User,Misce,ID) VALUES ('''+s+''', '' '+
    ComboBox1.Text+''', '+FloatSTSQL(floatToStrF(sum*kurs,ffFixed,7,2))+', '''+
    mds+''', '''+FormatDateTime('hh:nn:ss',Time)+''','''+User+''','''+DefMisce+''','''+ID+''')');


end;

procedure TFNP.GridRefresh;
Var mip:string;
Begin;
  IF IPN.Text<>'' Then mip:=IPN.Text
    else if rb2.Checked then mip:='-1' else if rb1.Checked then mip:='0';
  Label5.Caption:=MC.mySQLs('Select Sum(Kilkist) From Oper Where (IP ='+mip+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') and data='''+mds+'''');
  if MC.mySQLs('Select Sum(Cina) From Oper Where (IP ='+mip+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') and data='''+mds+'''')<>'' Then
  Label6.Caption:=MC.mySQLs('Select Sum(Cina) From Oper Where (IP ='+mip+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') and data='''+mds+'''');
  Label7.Left:=Label6.Left+Label6.Width+2;
  if kurs<>0 Then Label8.Caption:=FloatToStrF((StrToFloat(AnsiReplaceStr(Label6.Caption, '.', ','))/Kurs),ffFixed,7,2);
  Label9.Left:=Label8.Left+Label8.Width+2;
  mip:=MC.mySQLs('Select suma from opt Where inf='''+ComboBox1.Text+'''');
    if (mip<>'0') and (mip<>'')
      Then Label10.Caption:='Попередній борг: '+mip+'$'
      else Label10.Caption:='';
  MC.mySQLg(SGrid2,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,time,Cod From Oper Where (IP ='+IPN.Text+') and (Oper=''Продажа'') and (misce = '''+DefMisce+''') and data='''+mds+''' order by Data,time DESC');
  MainMForm.TabSet.Tabs[MainMForm.TabSet.Tabs.IndexOf(Caption)]:='Гурт ['+IPN.Text+'] '+ComboBox1.Text;
  Caption:='Гурт ['+IPN.Text+'] '+ComboBox1.Text;
  Calc;
End;
end.
