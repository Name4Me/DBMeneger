unit uPrintForm;

interface

uses
 Forms,Dialogs, ExtCtrls, Classes,StrUtils,Messages,
 ComCtrls,SysUtils,Printers,Graphics, Controls, StdCtrls, Grids,math;

type
  TPrintForm = class(TForm)
    CB: TComboBox;
    Button3: TButton;
    Button1: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Button2: TButton;
    ListBox1: TListBox;
    Button6: TButton;
    SGrid2: TStringGrid;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure PrintOP(const f:string);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CBChange(Sender: TObject);
    
    protected Procedure isGetFocus(var msg : TWMActivate) ; message  WM_ACTIVATE;
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  PrintForm: TPrintForm;

implementation
Uses uData, uMainForm;

{$R *.dfm}

procedure TPrintForm.FormCreate(Sender: TObject);
begin
  if not MC.Connected Then MC.Connect;
  CB.Items.Text:=MC.mySQLf('Select distinct misce from Склад',1);
  ComboBox2.Items.Text:=MC.mySQLf('Select Nazva from gg order by nazva',1);
  ComboBox2.Text:=ComboBox2.Items[0];
  CB.Text:=DefMisce;
end;

procedure TPrintForm.PrintOP(const f:string);
Var m,w,h,l,c:integer;
  ml:^Tstrings;
begin
  New(ml);
  ml^:=TStringList.Create;
  ml^.Text:=MC.mySQLf(f,1);
  With Printer do With Canvas do Begin
    Printer.Title:='Гуртові ціни';
    BeginDoc;
    l:=2;
    c:=0;
    Font.Size:=9;
    w:=TextWidth('W');
    h:=TextHeight('X');
    TextOut(8*w,h,'Гуртові ціни ['+ComboBox2.Text+']');
    For m:= 0 to ml^.Count-1 Do Begin
      TextOut(8*w+c*22*w,l*h,ml^.Names[m]);
      TextOut(8*w+16*w+c*22*w,l*h,ml^.ValueFromIndex[m]);
      inc(l);
      if l*h>=PageHeight-2*h Then Begin
        inc(c);
        l:=2;
        if c>2 then begin
          NewPage;
          c:=0;
          end;
        End;
      End;
    EndDoc;
    End;
  ml^.Free;
  Dispose(ml);
  Close;
end;

procedure TPrintForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TPrintForm.Button3Click(Sender: TObject);
var
  w,h,l,c,i:integer;
  sn,st,sc,s:String;
begin
  if ComboBox1.Text='' then MC.mySQLg(SGrid2,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад Where Misce = '''+CB.Text+''' '+Edit1.Text+' order by Nazva,Tip,Rozmir,Rist')
    else MC.mySQLg(SGrid2,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Cina From Склад Where Misce = '''+CB.Text+''' and nazva='''+ComboBox1.Text+''' '+Edit1.Text+' order by Nazva,Tip,Rozmir,Rist');

  With SGrid2 do With Printer do With Canvas do Begin
    BeginDoc;
    Title:=CB.Text;
    Font.Name:='Times New Roman';
    c:=0;
    Font.Size:=9;
    w:=TextWidth('W');
    //Font.Size:=10;
    h:=TextHeight('X');
    TextOut(8*w,h,FormatDateTime('yyyy.mm.dd',Date)+' ['+FormatDateTime('hh:nn:ss',Time)+']');
    Printer.Canvas.Font.Size:=12;
    Printer.Canvas.Font.Style:=[fsBold];
    TextOut(8*w,2*h,'[ '+CB.Text+' ]');
    l:=3;
    for i := 1 to RowCount - 1 do Begin
      if sn<>Cells[1,i] then Begin
        inc(l);
        Font.Size:=9;
        Font.Style:=[fsBold,fsUnderline];
        TextOut(w*8+c*w*16,h*l-5,Cells[1,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Misce = '''+
        CB.Text+''' and Nazva='''+Cells[1,i]+'''')+' шт.');
        inc(l);
        End;
      if st<>Cells[2,i] then Begin
        Font.Size:=9;
        Font.Style:=[fsBold];
        sc:=Copy(Cells[6,i],1,pos(',',Cells[6,i])-1);
        TextOut(w*8+c*w*16,h*l,Cells[2,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Misce = '''+
          CB.Text+''' and Nazva='''+Cells[1,i]+''' and tip='''+Cells[2,i]+'''')+' шт. ('+sc+')');
        inc(l);
        End;
      Font.Size:=10;
      Font.Style:=[];
      if sc<>Copy(Cells[6,i],1,pos(',',Cells[6,i])-1) then s:=' ('+Copy(Cells[6,i],1,pos(',',Cells[6,i])-1)+')' else s:='';
      if (Cells[3,i]<>'') and (Cells[4,i]<>'') then TextOut(w*8+w*4+c*w*16,h*l,Cells[3,i]+'/'+Cells[4,i]+' - '+Cells[5,i]+s);
      if (Cells[3,i]<>'') and (Cells[4,i]='') then TextOut(w*8+w*4+c*w*16,h*l,Cells[3,i]+' - '+Cells[5,i]+s);
      if (Cells[3,i]='') and (Cells[4,i]='') then dec(l);
      inc(l);
      sn:=Cells[1,i];
      st:=Cells[2,i];
      if l*h>=PageHeight-2*h Then Begin
        inc(c);
        l:=2;
        if c>3 then begin
          NewPage;
          c:=0;
          end;
        End;
      End;
    Enddoc;
    End;
  Close;
End;

procedure TPrintForm.Button1Click(Sender: TObject); //Настройка принтера
begin
  PrinterSetupDialog1.Execute;
end;
//---------------------------------------Друк гуртових цін на дорослі костюми---
procedure TPrintForm.Button2Click(Sender: TObject);
Var s:string;
Begin
  s:=MC.mySQLs('Select id from gg where nazva = '''+ComboBox2.Text+'''');
  if (ComboBox2.Text<>'') and (s<>'') then
    PrintOP('Select Tip,OCina From types where ggid='''+s+''' order by Tip');
end;
//------------------------------------------------------------------------------

//----------------------------------------Друк гуртових цін на дитячі костюми---
procedure TPrintForm.Button5Click(Sender: TObject);
begin

end;
//------------------------------------------------------------------------------
//-----------------------------------------------------------------Друк гурта---
procedure TPrintForm.Button6Click(Sender: TObject);
var
s,sm,s1,sg,ip,name:string;
l,l1,l2,l3,t,n,y,pi:integer;

begin
  if ListBox1.ItemIndex=-1 then exit;
  pi:=Printer.PrinterIndex;
  with ListBox1 do
    MC.mySQLg(SGrid2,'Select ID,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,time From Oper Where concat(ip,''-'',inf) ='''+Items[ItemIndex]+''' and Oper=''Продажа''  order by Nazva,Tip,Rozmir,Rist');
  if (Printer.Printers.IndexOf('W150')>=0) and (ListBox1.ItemIndex>=0) then
    Printer.PrinterIndex:=Printer.Printers.IndexOf('W150')
    else exit;
  name:=MC.mySQLs('Select distinct inf from oper where concat(ip,''-'',inf) ='''+ListBox1.Items[ListBox1.ItemIndex]+'''');
  ip:=MC.mySQLs('Select distinct ip from oper where concat(ip,''-'',inf) ='''+ListBox1.Items[ListBox1.ItemIndex]+'''');
  sm:= MC.mySQLs('Select suma from opt where inf='''+name+'''');

  With Printer do with Canvas do begin
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

    TextOut(l*2+l2,0,FormatDateTime('dd.mm.yyyy [hh:nn]', Now)+'{'+ip+'}');
    TextOut(0,t,'>> '+Name);

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

      TextOut(l*2+l3,y,FloatToStrF(RoundTo(StrToFloat(AnsiReplaceStr(SGrid2.Cells[7,n], '.', ','))/kurs,-2),ffFixed,12,2)+'$ ('+SGrid2.Cells[7,n]+' грн.)');
      inc(y,t);
      End;

    Font.Style := [fsBold];
    s:='';
    For n:=1 to 73 do s:=s+'-';
    Printer.Canvas.TextOut(0,y,s);

    inc(y,t);

    TextOut(0,y,'['+MC.mySQLs('Select sum(kilkist) from oper where concat(ip,''-'',inf) ='''+ListBox1.Items[ListBox1.ItemIndex]+''' and Oper=''Продажа''')+']');
    TextOut(l,y,'Курс: '+FloatToStrF(kurs,ffFixed,7,2));
    sg:=MC.mySQLs('Select sum(cina)from oper where concat(ip,''-'',inf) ='''+ListBox1.Items[ListBox1.ItemIndex]+''' and Oper=''Продажа''');
    s1:=FloatToStrF(RoundTo(StrToFloat(AnsiReplaceStr(sg, '.', ','))/Kurs,-2),ffFixed,12,2)+'$ ('+FloatToStrF(StrToFloat(AnsiReplaceStr(sg, '.', ',')),ffFixed,12,2)+' грн.'+')';
    TextOut(TextWidth(s)-TextWidth(s1),y,s1);
    inc(y,t);
    if sm<>'' then
    
    if strToFloat(sm)<>0 Then  Begin
      Printer.Canvas.TextOut(l,y,'Попередній борг: ');
      s1:=FloatSTS(sm)+'$ ('+FloatToStrF(RoundTo(StrToFloat(sm)*kurs,-2),ffFixed,12,2)+' грн.)';
      TextOut(TextWidth(s)-TextWidth(s1),y,s1);
      inc(y,t);

      Printer.Canvas.TextOut(l,y,'Всього: ');
      s1:=FloatToStrF(StrToFloat(sg)/Kurs+strTofloat(sm),ffFixed,12,2)+'$ ('+FloatToStrF(RoundTo((StrToFloat(sg)+strTofloat(sm)*Kurs),-2),ffFixed,12,2)+' грн.'+')';
      TextOut(TextWidth(s)-TextWidth(s1),y,s1);
      inc(y,t);
      End;


      Font.Style := [];
      TextOut(0,y+2*t,'т. (8 0382) 743952');
      TextOut(0,y+3*t,'т. (8 067) 7133464');
      TextOut(0,y+5*t,'Підпис покупця______________');
      Font.Size:=7;
      TextOut(0,y+7*t,'УВАГА!!! Притензії стосовно не відповідності кількості');
      TextOut(0,y+8*t,'та комплектності, що були виявлені за межами магазину');
      TextOut(0,y+9*t,'не приймаються.');


  EndDoc;
  end;
   Printer.PrinterIndex:=pi;
end;
procedure TPrintForm.CBChange(Sender: TObject);
begin
  ComboBox1.Items.Text:=MC.mySQLf('Select distinct Nazva from '+TSName+' where misce='''+CB.Text+''' order by nazva',1);
end;

//------------------------------------------------------------------------------

procedure TPrintForm.isGetFocus(var Msg: TWMActivate);
begin
  if (Msg.Active = 1) or (Msg.Active = 2)then
     ListBox1.Items.Text:=MC.mySQLf('Select distinct concat(ip,''-'',inf) as rt from Oper Where Oper=''Продажа'' and ip>0 and data ='''+FormatDateTime('yyyy.mm.dd',Now)+''' order by rt desc',1);
     Inherited;
end;

end.
