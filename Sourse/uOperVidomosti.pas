unit uOperVidomosti;

interface

uses
  Windows, SysUtils, Graphics,Forms, ExtCtrls, ScktComp, Grids, StdCtrls,
  ComCtrls, Controls, Classes , uMyGrid,
  Dialogs;

type
  TOVForm = class(TForm)
    TV1: TTreeView;
    SB1: TStatusBar;
    Button8: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TV1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    

    procedure Refresh;
    procedure Button8Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
         { Private declarations }
  public
    { Public declarations }
  end;

var
  OVForm: TOVForm;
  lb:integer;
  vb:boolean;
  lsn:String;
  lm:string = '';
  ld:string = '';
implementation

uses printers, uMainForm, udata,uTTP245;

{$R *.dfm}
procedure TOVForm.FormCreate(Sender: TObject);
begin
  //MC.mySQLg(StringGrid1,'Select * From Oper Where (Misce ='''+DefMisce+
  //  ''' or Zvidk = '''+DefMisce+''') and data = '''+MDs+''' Order By Time');
  //Refresh;
end;
procedure TOVForm.FormActivate(Sender: TObject);
begin

  if TV1.SelectionCount=0 then TV1.Select(TV1.Items.GetFirstNode);
  Refresh;

end;

procedure TOVForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TOVForm.TV1Click(Sender: TObject);
Var
  i:integer;
  s,fs,ws,os,sql:string;
begin
  if (TV1.SelectionCount=0) or (TV1.Selections[0].SelectedIndex=-1) then exit;
  lsn:=TV1.Selections[0].Text;
  for i := 0 to SB1.Panels.Count - 1 do SB1.Panels[i].Text:='';
  lb:=TV1.Selections[0].SelectedIndex;

  StringGrid1.Visible:=True;
  ws:='';
  os:='';                                                       //(getcina(misce,id,''o'')*kilkist) as GCina,
  fs:='Oper,Zvidk,Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,BCina,Data,Time,User,User1,ID,IP,Cod';
  case lb of
    //----------------------------------------------------------------Продажа---
    1,8,9,21,22: Begin
      case lb of
        1: s:='';
        8: s:='and ip <= 0';
        9: s:='and ip > 0';
        21: s:='and ip = -'+copy(TV1.Selections[0].text,2,Length(TV1.Selections[0].text)-2);
        22: s:='and ip = '+copy(TV1.Selections[0].text,2,Length(TV1.Selections[0].text)-2);
        end;
      ws:='Where Oper=''Продажа'' '+s+' and Misce='''+DefMisce+''' and data='''+MDs+'''';
      os:='Order By Time';
      End;
    //--------------------------------------------------------------------------
    //------------------------------------------------------------Переміщення---
    2,23,24: Begin
      case lb of
        23: s:=' and concat(''['',zvidk,'' >> '',misce,'']'') ='''+TV1.Selections[0].text+'''';
        24: s:=' and concat(''['',zvidk,'' >> '',misce,'']'') ='''+TV1.Selections[0].Parent.text+
          ''' and ip = '+copy(TV1.Selections[0].text,2,Length(TV1.Selections[0].text)-2);
        2:  s:='and( Misce ='''+DefMisce+''' or Zvidk = '''+DefMisce+''')';
        end;
      ws:='Where Oper=''Переміщення'''+s+' and data = '''+MDs+'''';
      os:='Order By Zvidk, Misce,Data,time';
      End;
    //--------------------------------------------------------------------------
    //-----------------------------------------------------------Всі операції---
    3:Begin
      ws:='Where (Misce='''+DefMisce+''' or Zvidk='''+DefMisce+''') and data='''+MDs+'''';
      os:='Order By Time';
      End;
    //--------------------------------------------------------------------------
    //-----------------------------------------------------------------Видача---
    4,19:Begin
      case lb of
        19: s:='and ip = '+copy(TV1.Selections[0].text,2,Length(TV1.Selections[0].text)-2);
        4: s:='';
        end;
      ws:='Where Oper = ''Видача'''+s+' and Misce = '''+DefMisce+''' and data = '''+MDs+'''';
      if vb then os:='Order By Time'
        else os:='Order By Nazva,Tip,Rozmir,Rist';
      vb:= not vb;
      End;
    //--------------------------------------------------------------------------
    //---------------------------------------------------Вчорашні переміщення---
    5:Begin
      ws:='Where Oper=''Переміщення''and(Misce='''+DefMisce+''' or Zvidk='''+
        DefMisce+''') and data='''+FormatDateTime('yyyy.mm.dd', MD-1)+'''';
      os:='Order By Zvidk,Misce';
      End;
    //--------------------------------------------------------------------------
    //-------------------------------------------------------------Повернення---
    10:Begin
      ws:='Where Oper = ''Повернення'' and Misce = '''+DefMisce+''' and data = '''+MDs+'''';
      if vb then os:='Order By Time'
        else os:='Order By Nazva,Tip,Rozmir,Rist';
      vb:= not vb;
      End;
    //--------------------------------------------------------------------------
    //-----------------------------------------------------Фінансові операції---
    14:sql:='Select * from FOper Where Misce ='''+DefMisce+''' and DATE_FORMAT(Data, ''%Y.%m.%d'') = '''+MDs+'''';
    //--------------------------------------------------------------------------
    //-------------------------------------------------------------------Каса---
    15:sql:='Select GetKasa('''+DefMisce+''','''+MDs+''') as Kasa';
    //--------------------------------------------------------------------------
    End;
  if not (lb in[14,15]) then Begin
    SB1.Panels[1].Text:='Кількість:'+MC.mySQLs('Select Sum(Kilkist) From Oper '+ws);
    SB1.Panels[2].Text:='Ціна:'+MC.mySQLs('Select Sum(Cina) From Oper '+ws);
    if pos('bcina',LowerCase(fs))<>0 then
      SB1.Panels[3].Text:='ВЦіна:'+MC.mySQLs('Select Sum(BCina) From Oper '+ws);
    SB1.Panels[4].Text:=MC.mySQLs('Select COUNT(*) From Oper '+ws);
    //SB1.Panels[6].Text:=MC.mySQLs('Select sum((getcina(misce,id,''o'')*kilkist)) as GCina From Oper '+ws);
    End;
  case lb of
    14,15:MC.mySQLg(StringGrid1,sql+' '+ws+' '+os);
    else MC.mySQLg(StringGrid1,'select '+fs+' from oper '+ws+' '+os);
  end;

  StringGrid1.SetFocus;

end;

//------------------------------------------------------------------------------




procedure TOVForm.Button1Click(Sender: TObject);
Var
  i,n,t,rm,rt,c,k,id:integer;
  s:string;
begin
  if LabelPrinter = 'Argox OS-203DT' Then exit;
  with StringGrid1 do with Canvas do begin
    for i := 1 to ColCount-1 do Begin
      if LowerCase(Cells[i,0])='id' then id:=i;
      if LowerCase(Cells[i,0])='nazva' then n:=i;
      if LowerCase(Cells[i,0])='tip' then t:=i;
      if LowerCase(Cells[i,0])='rozmir' then rm:=i;
      if LowerCase(Cells[i,0])='rist' then rt:=i;
      if LowerCase(Cells[i,0])='kilkist' then k:=i;
      if LowerCase(Cells[i,0])='cina' then c:=i;
      End;
    openport('TTP-245');
    for i := Selection.Top to Selection.Bottom do Begin
      clearbuffer;
      windowsfont(300,20,20,0,2,0,'Courier New',PCHAR(Cells[n,i]));
      windowsfont(50,55,35,0,2,0,'Courier New',PCHAR(Cells[t,i]));
      barcode('50','200','CODA','40','0','0','2','4',PCHAR('A'+Cells[id,i]+'B'));
      if Cells[rm,i]<>''Then s:=Cells[rm,i] Else s:='';
      if Cells[rt,i]<>''Then s:=s+'/'+Cells[rt,i];
      windowsfont(150,110,60,0,2,0,'Courier New',PCHAR(s));
      windowsfont(270,200,40,0,2,0,'Courier New',PCHAR(FloatToStr(StrToFloat(Cells[c,i]))+'грн.'));
      printlabel('1',PCHAR(Cells[k,i]));;
      End;
    closeport;
  end;
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

procedure TOVForm.Button6Click(Sender: TObject);
var
  w,h,l,i:integer;
    op,buf,ks,sm:string;
begin
  if lb in [14,15] then exit;

  if StringGrid1.RowCount > 1 Then
    with StringGrid1 do with Printer do with Canvas do Begin
      BeginDoc;
      Font.Size:=10;
      Font.Style := [];
      w:=TextWidth('W');
      h:=TextHeight('X');

      buf:='[ ';
      if (TV1.Selections[0].Text<>'Всі операції') and (TV1.Selections[0].Parent.Text<>'Всі операції') Then
      if TV1.Selections[0].Parent.Parent.Text<>'Всі операції' Then
      buf:=buf+TV1.Selections[0].Parent.Parent.Text + ' / '+TV1.Selections[0].Parent.Text+' / ' else buf:=buf+TV1.Selections[0].Parent.Text+' / ';
      buf:=buf+TV1.Selections[0].Text+' / '+DefMisce+' / '+FormatDateTime('dd/mm/yyyy hh:nn:ss', Now)+' ]';

      TextOut(PageWidth-8*w-Printer.Canvas.TextWidth(buf+'['+IntTostr(Printer.PageNumber)+']'),h,buf+'['+IntTostr(Printer.PageNumber)+']');

      if TV1.Selections[0].Text = 'Всі операції' Then Begin
        ks:=MC.mySQLs('Select Sum(Cina) From Oper Where Oper=''Продажа'' and( Misce ='''+DefMisce+''' or Zvidk = '''+DefMisce+''') and data = '''+MDs+'''');
        if ks <>'' Then
          TextOut(w*8,h*2,'Каса: '+FloatToStrF(StrToFloat(ks),ffFixed,7,2)) else ks:='0,00';
        sm:=MC.mySQLs('Select sum(suma) from FOper Where Misce ='''+DefMisce+''' and data = '''+MDs+'''');
        if sm <>'' Then
          TextOut(w*8,h*3,'Сума: '+FloatToStrF(StrToFloat(ks)+StrToFloat(sm),ffFixed,7,2));
        End;

      Font.Size:=12;
      Font.Style := [fsBold,fsUnderline];
      TextOut(w*8,h*4,'О    Звідки           Місце            Н. Тип                         Рм.Р Кл        Ціна ');

      l:=6;
      for i:= 1 to RowCount-1 do begin
        if Cells[1,i] = 'Продажа' Then op:='1';
        if Cells[1,i] = 'Переміщення' Then op:='2';
        if Cells[1,i] = 'Видача' Then op:='3';
        if Cells[1,i] = 'Повернення' Then op:='4';
        if pos('Відміна',Cells[1,i])<>0 then op:='5'+Copy(Cells[1,i],Length(Cells[1,i])-3,4);

        Font.Size:=10;
        Font.Style := [];
        TextOut(w*8,h*l,op);
        TextOut(w*12,h*l,Cells[2,i]);
        TextOut(w*22,h*l,Cells[3,i]);
        TextOut(w*32,h*l,MC.mySQLs('Select id From gg Where Nazva ='''+Cells[4,i]+''''));
        TextOut(w*34,h*l,Cells[5,i]);
        TextOut(w*49,h*l,Cells[6,i]);
        TextOut(w*51,h*l,Cells[7,i]);
        TextOut(w*53,h*l,Cells[8,i]);
        if op= '1' Then TextOut(w*62-TextWidth(Cells[9,i]),h*l,Cells[9,i]);
        //TextOut(w*62-TextWidth(Cells[11,i]),h*l,Cells[11,i]);

        if Printer.PageHeight<=h*(l+2) Then Begin
          NewPage;
          Font.Size:=10;
          Font.Style := [];
          TextOut(Printer.PageWidth-w*8-Printer.Canvas.TextWidth(buf+'['+IntTostr(Printer.PageNumber)+']'),h,buf+'['+IntTostr(Printer.PageNumber)+']');
          Font.Size:=12;
          Font.Style := [fsBold,fsUnderline];
          TextOut(w*8,h*2,'О    Звідки           Місце            Н. Тип                         Рм.Р Кл        Ціна ');
          l:=4;
          End
          else inc(l);
        end;
      Font.Size:=12;
      Font.Style := [];
      MoveTo(w*8,h*l);
      LineTo(w*62,h*l+2);
      TextOut(w*53,h*l+10,SB1.Panels[1].Text);
      if lb in [1,8,9,21,22] Then TextOut(w*62-TextWidth(SB1.Panels[2].Text),h*l+10,SB1.Panels[2].Text);
      EndDoc;
      end;
end;

procedure TOVForm.Button8Click(Sender: TObject);
begin
  Refresh;
end;

procedure TOVForm.Refresh;
Var m,m1:integer;
  ml,ml1:^TStrings;
  node:TTreeNode;
  f:Boolean;
begin
  New(ml);
  f:=false;
  ml^:=TStringList.Create;
  node:=TV1.Items.GetFirstNode;
  while node<>nil do Begin
    if node.Text='Роздріб' then Begin
      node.DeleteChildren;
      ml^.Text:=MC.mySQLf('Select distinct ip From Oper Where Oper=''Продажа'' and ip <0 and Misce ='''
       +DefMisce+''' and data = '''+MDs+'''',1);
      for m:= 0 to ml^.Count-1 do Begin
        TV1.Items.AddChild(node,'['+IntToStr(abs(StrToInt(ml^[m])))+']');
        node.Item[m].SelectedIndex:=21;
        End;
      End;
    if node.Text='Гурт' then Begin
      node.DeleteChildren;
      ml^.Text:=MC.mySQLf('Select distinct ip From Oper Where Oper=''Продажа'' and ip >0 and Misce ='''
       +DefMisce+''' and data = '''+MDs+'''',1);
      for m:= 0 to ml^.Count-1 do Begin
        TV1.Items.AddChild(node,'['+ml^[m]+']');
        node.Item[m].SelectedIndex:=22;
        End;
      End;
    if node.Text='Видача' then Begin
      node.DeleteChildren;
      ml^.Text:=MC.mySQLf('Select distinct ip From Oper Where Oper=''Видача'' and ip <>0 and Misce ='''
       +DefMisce+''' and data = '''+MDs+'''',1);
      for m:= 0 to ml^.Count-1 do Begin
        TV1.Items.AddChild(node,'['+ml^[m]+']');
        node.Item[m].SelectedIndex:=19;
        End;
      End;
    if node.Text='Переміщення' then Begin
      node.DeleteChildren;
      New(ml1);
      ml1^:=TStringList.Create;
      ml^.Text:=MC.mySQLf('Select distinct concat(zvidk,'' >> '',misce) From Oper Where Oper=''Переміщення'' and (Misce ='''
       +DefMisce+''' or Zvidk = '''+DefMisce+''') and data = '''+MDs+'''',1);
      for m:= 0 to ml^.Count-1 do Begin
        TV1.Items.AddChild(node,'['+ml^[m]+']');
        node.Item[m].SelectedIndex:=23;
        ml1^.Text:=MC.mySQLf('Select distinct ip From Oper Where concat(zvidk,'' >> '',misce) ='''+ml^[m]+'''  and data = '''+MDs+''' Order By ip',1);
        for m1:= 0 to ml1^.Count-1 do Begin
          TV1.Items.AddChild(node.Item[m],'['+ml1^[m1]+']');
          node.Item[m].Item[m1].SelectedIndex:=24;
          end;
        End;
      Dispose(ml1);
      End;
    if (lsn<>'') and (node.Text=lsn) then Begin
      TV1.Select(node);
      f:=True;
      End;
    node:=node.GetNext;
    End;
    Dispose(ml);
    if not f then TV1.Select(TV1.Items.GetFirstNode);
    
    TV1Click(TV1);
end;

procedure TOVForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
Var i,o,u1:integer;
begin
  with StringGrid1 do with Canvas do begin
    u1:=0;
    o:=0;
    for i := 1 to ColCount-1 do Begin
      if Cells[i,0]='Oper' then o:=i;
      if Cells[i,0]='User1' then u1:=i;
      End;
  if (Selection.Top<=ARow) and (ARow<=Selection.Bottom) Then Font.Color := ClAqua;
  if (Cells[o,ARow] = 'Переміщення')
    and (Cells[u1,ARow] = '') then Canvas.Font.Color := clRed;
    //clSkyBlue;
    FillRect(Rect);
    TextOut(Rect.Left+5,Rect.Top+5,Cells[ACol,ARow]);
    end;
end;

procedure TOVForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var i,o,u,u1,k,id,cod:integer;
begin
  with StringGrid1 do with Canvas do begin
    u1:=0;
    for i := 1 to ColCount-1 do Begin
      if LowerCase(Cells[i,0])='oper' then o:=i;
      if LowerCase(Cells[i,0])='user' then u:=i;
      if LowerCase(Cells[i,0])='user1' then u1:=i;
      if LowerCase(Cells[i,0])='kilkist' then k:=i;
      if LowerCase(Cells[i,0])='id' then id:=i;
      if LowerCase(Cells[i,0])='cod' then cod:=i;
      End;
    if (Key in [48..57,96..105]) and  (ssCtrl in Shift) Then Begin
      //ShowMessage('Ctrl+'+Chr(Key));
      for i := Selection.Top to Selection.Bottom do
        if (Cells[o,i] = 'Переміщення') or (Cells[o,i] = 'Видача')  Then
          MC.MyEx('update oper set ip='''+Chr(Key)+''' where cod ='+Cells[cod,i]);
      i:=Selection.Bottom;
      TV1Click(TV1);
      if RowCount-1>i then Row:=i+1 else if RowCount-1>1 then Row:=i;
      End;
    //--------------------------------------------------------------------'+'---
    //SB1.Panels[0].Text:=intTostr(Key);
    if (Key = 187) or (Key = 107) Then Begin
      for i := Selection.Top to Selection.Bottom do
        if (Cells[o,i] = 'Переміщення') and (Cells[u1,i] = '') and (Cells[u,i] <> User) Then
          MC.MyEx('update oper set User1='''+User+''' where cod ='+Cells[cod,i]);
      i:=Selection.Bottom;
      TV1Click(TV1);
      if RowCount-1>i then Row:=i+1 else if RowCount-1>1 then Row:=i;
      End;
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------'-'---
    if (Key = 189) or (Key = 109) Then Begin
      for i := Selection.Top to Selection.Bottom do
        if (Cells[o,i] = 'Переміщення') and (Cells[u1,i] = User) Then
          MC.MyEx('update oper set User1='''' where cod ='+Cells[cod,i]);
      TV1Click(TV1);
      if RowCount-1>Selection.Bottom then Row:=Selection.Bottom+1 else if RowCount-1>1 then Row:=Selection.Bottom;
      End;
    //--------------------------------------------------------------------------
    if Key=VK_DELETE Then if (Cells[o,Selection.Top] <> '')
      and(Copy(Cells[o,Selection.Top],1,7)<>'Відміна') Then Begin


      if TV1.Selections[0].SelectedIndex = 14 Then
        if ((Cells[o,Selection.Top] <> 'Погашення боргу')
          and (Cells[o,Selection.Top] <> 'Заборгованість')) Then MC.MyEx('delete from FOper where cod ='+Cells[cod,Selection.Top]);
        //ShowMessage('lb-'+IntToStr(lb)+'\u1-'+Cells[u1,Selection.Top]+'\u-'+Cells[u,Selection.Top]);
        if (not (lb in [5,14,15])) and (((Cells[u1,Selection.Top]='')  and (Cells[u,Selection.Top]=User))
          or (User='Dreamer')) Then Begin
            MC.MyEx('Call Vidmina('+Cells[cod,Selection.Top]+')');
            //ShowMessage(MC.LastError);
            End;
        i:=Selection.Top;
        if lb in [4,10,19] then vb:= not vb;

        TV1Click(TV1);
        if RowCount-1>i then Row:=i;
        End;
    //--------------------------------------------------------------------------
    if Key=69 Then for i := Selection.Top to Selection.Bottom do
      MC.MyEx('Call AddLable('''+Cells[id,i]+''','+Cells[k,i]+')');
    //--------------------------------------------------------------------------
    end;
    
    SB1.Panels[0].Text:=IntToStr(key);
end;

procedure TOVForm.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  i,k,sumk:integer;
begin
  k:=0;
  sumk:=0;
  With StringGrid1 do begin
    for i := 1 to ColCount-1 do if LowerCase(Cells[i,0])='kilkist' then k:=i;
    if k<>0 then
      for i := Selection.Top to Selection.Bottom do
        sumk:=Sumk+StrToIntDef(Cells[k,i],0);
    end;


  sb1.Panels[5].Text:='Виділено: '+IntToStr(StringGrid1.Selection.Bottom-StringGrid1.Selection.Top+1)+' ['+inttostr(sumk)+']';
end;

end.
