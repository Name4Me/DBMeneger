unit uVidomosti;

interface

uses
  Windows,SysUtils, Variants, Classes, Graphics, Controls, Forms, Grids, DBGrids,
  ExtCtrls, DB,ComCtrls, StdCtrls,printers, FMTBcd, Dialogs,ScktComp, Spin;

type
  TVidomostiForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    CB3: TComboBox;
    CB4: TComboBox;
    CB5: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;

    DTP: TDateTimePicker;
    DTP1: TDateTimePicker;

    CB1: TComboBox;
    CB2: TComboBox;
    CB: TComboBox;
    SB: TStatusBar;
    
    HC1: THeaderControl;
    HC2: THeaderControl;
    CB6: TComboBox;
    StringGrid1: TStringGrid;
    HC: THeaderControl;
    CheckBox3: TCheckBox;
    SpinEdit1: TSpinEdit;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Button1Click(Sender: TObject);
    procedure MyClick(Sender: TObject);
    procedure HCDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure HCDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure StringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure HCEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  VidomostiForm: TVidomostiForm;
  ddtext:string;
  Ft: array[1..10] of String;
implementation
Uses uData, uMainForm;

{$R *.dfm}

Function ac(const f:string):String;
Begin
  Result:='';
  if f<>'' then Result:=f+' and ';
End;

procedure TVidomostiForm.FormCreate(Sender: TObject);
begin
  DTP.Date:=MD;
  DTP1.Date:=MD;
  CB.Items.Text:=MC.mySQLf('Select Distinct Nazva from GG Order By Nazva',1);
  CB2.Items.Text:=MC.mySQLf('Select Misce from Misce',1);
  CB6.Items.Text:=CB2.Items.Text;
  CB4.Items.Text:=MC.mySQLf('Select Distinct Rozmir from Склад Order By Rozmir',1);
  CB4.Items.Delete(0);
  CB5.Items.Text:=MC.mySQLf('Select Distinct Rist from Склад Order By Rist',1);
  HC2.Sections[2].Text:=CB1.Items[5];
  HC2.Sections[3].Text:='5';
  CB1.Text:=CB1.Items[5];
end;

procedure TVidomostiForm.HCDragDrop(Sender, Source: TObject; X, Y: Integer);
Var i,di,si:integer;
  s:string;
begin

  With HC do Begin
    if Source=StringGrid1 then
      for i := 0 to Sections.Count - 1 do
        if HC.Sections[i].Text=ddtext then ddtext:='';
  if ddtext<>'' then Begin
    di:=-1;
    si:=-1;
    for i := 0 to Sections.Count - 1 do Begin
      if (Sections[i].Left<=x) and ((Sections[i].Left+Sections[i].Width>=x)) then di:=i;
      if Sections[i].Text=ddtext then si:=i;
      End;
    if di=0 Then di:=1;
    if (di=-1) and (si=-1) Then di:=Sections.Count;
    if di=-1 Then di:=Sections.Count-1;

    if si<>-1 Then Sections.Delete(si);
    Sections.Insert(di).Text:=ddtext;
    for i := Sections.Count - 1 downto di+1 do Sections[i].Text:=Sections[i-1].Text;
    Sections[di].Text:=ddtext;
    Button1.Click;
    ddtext:='';
    End;
  End;

  //HC.Sections[HC.Sections.Count-1].Text:=ddtext;
end;

procedure TVidomostiForm.HCDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
Var i:integer;
begin
  if ddtext='' then With HC do
  if Sections.Count>1 then
    for i := 1 to Sections.Count - 1 do
      if (Sections[i].Left<=x) and ((Sections[i].Left+Sections[i].Width>=x)) then
        ddtext:=Sections[i].Text;

  Accept := True;// Source is TStringGrid;
end;

procedure TVidomostiForm.HCEndDrag(Sender, Target: TObject; X, Y: Integer);
Var i,n:integer;
begin
  if (ddtext<>'') and (Target<>HC) and (HC.Sections.Count>0) Then With HC do Begin
    for i := 0 to Sections.Count - 1 do
      if Sections[i].Text=ddtext then n:=i;
    Sections.Delete(n);
    ddtext:='';
    End;

end;

procedure TVidomostiForm.Button2Click(Sender: TObject);
var
  w,h,l,c,i:integer;
  sn,st,sc,s:String;
begin
{
    if (CB1.Items.IndexOf(CB1.Text)=0) and (CB1.Text='') then
      MC.mySQLg(StringGrid1,'Select Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,ID From Склад Order By Nazva,Tip,Rozmir,Rist,Misce,Data');
    if (CB1.Items.IndexOf(CB1.Text)=0) and (CB1.Text<>'') then
      MC.mySQLg(StringGrid1,'Select Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,ID From Склад Where misce='' Order By Nazva,Tip,Rozmir,Rist,Misce,Data');
}

if CB1.Items.IndexOf(CB1.Text)=5 then Begin

  With StringGrid1 do With Printer do With Canvas do Begin
    BeginDoc;
    Title:=CB.Text;
    Font.Name:='Times New Roman';
    c:=0;
    Font.Size:=9;
    w:=TextWidth('W');
    //Font.Size:=10;
    h:=TextHeight('X');
    s:=FormatDateTime('yyyy.mm.dd',Date)+' ['+FormatDateTime('hh:nn:ss',Time)+']';
    TextOut(PageWidth-TextWidth(s)-2*w,h,s);
    TextOut(6*w,h,CB1.Text);

    l:=1;
    for i := 1 to RowCount - 1 do Begin
      if sn<>Cells[2,i] then Begin
        inc(l);
        Font.Size:=9;
        Font.Style:=[fsBold,fsUnderline];
        if CB2.Text<>'' then TextOut(w*6+c*w*16,h*l-5,Cells[2,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Misce = '''+
          Cells[1,i]+''' and Nazva='''+Cells[2,i]+'''')+' шт.')
          else TextOut(w*6+c*w*16,h*l-5,Cells[2,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Nazva='''+Cells[2,i]+'''')+' шт.');
        sn:=Cells[2,i];
        st:='';
        inc(l);
        End;
      if st<>Cells[3,i] then Begin
        Font.Size:=9;
        Font.Style:=[fsBold];
        sc:=Copy(Cells[7,i],1,pos(',',Cells[7,i])-1);

        if CB2.Text<>'' then TextOut(w*6+c*w*16,h*l,Cells[3,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Misce = '''+
          Cells[1,i]+''' and Nazva='''+Cells[2,i]+''' and tip='''+Cells[3,i]+'''')+' шт. ('+sc+')')
          else TextOut(w*6+c*w*16,h*l,Cells[3,i]+' - '+MC.mySQLs('Select Sum(Kilkist) From Склад Where Nazva='''+Cells[2,i]+''' and tip='''+Cells[3,i]+'''')+' шт. ('+sc+')');
        st:=Cells[3,i];
        inc(l);
        End;
      Font.Size:=10;
      Font.Style:=[];
      if sc<>Copy(Cells[7,i],1,pos(',',Cells[7,i])-1) then s:=' ('+Copy(Cells[7,i],1,pos(',',Cells[7,i])-1)+')' else s:='';
      TextOut(w*8+c*w*16,h*l,Cells[1,i]);
      if (Cells[4,i]<>'') and (Cells[5,i]<>'') then TextOut(w*6+w*6+c*w*16,h*l,Cells[4,i]+'/'+Cells[5,i]+' - '+Cells[6,i]+s);
      if (Cells[4,i]<>'') and (Cells[5,i]='') then TextOut(w*6+w*6+c*w*16,h*l,Cells[4,i]+' - '+Cells[6,i]+s);
      if (Cells[4,i]='') and (Cells[5,i]='') then dec(l);
      inc(l);
      sn:=Cells[2,i];
      st:=Cells[3,i];
      if l*h>=PageHeight-3*h Then Begin
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
  End else begin
  With StringGrid1 do With Printer do With Canvas do Begin
    BeginDoc;
    Title:=CB.Text;
    Font.Name:='Times New Roman';
    c:=0;
    Font.Size:=9;
    w:=TextWidth('W');
    //Font.Size:=10;
    h:=TextHeight('X');
    s:=FormatDateTime('yyyy.mm.dd',Date)+' ['+FormatDateTime('hh:nn:ss',Time)+']';
    TextOut(PageWidth-TextWidth(s)-2*w,h,s);
    TextOut(6*w,h,CB1.Text);

    l:=1;
    for i := 1 to RowCount - 1 do Begin
      Font.Size:=10;
      Font.Style:=[];
      TextOut(w*8,h*l,Cells[1,i]);
      TextOut(w*18,h*l,Cells[2,i]);
      TextOut(w*28,h*l,Cells[3,i]);

      inc(l);
      sn:=Cells[2,i];
      st:=Cells[3,i];
      if l*h>=PageHeight-3*h Then Begin
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
  end;


end;

procedure TVidomostiForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TVidomostiForm.Button1Click(Sender: TObject);
Var ft,from,os,fs:string;
  n:integer;
  Date1,Date2,Misce1,Misce2:PString;
begin
  Date1:=@HC2.Sections[0].Text;
  Date2:=@HC2.Sections[1].Text;
  Misce1:=@HC2.Sections[4].Text;
  Misce2:=@HC2.Sections[5].Text;

  if HC2.Sections[3].Text <> '' Then n:=StrToInt (HC2.Sections[3].Text)
    Else n:=6;
  Case n of
    0,1,2,3,4,6: Begin
      from:= 'Oper';
      fs:='Oper,Zvidk,Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,BCina,Data,Time,User,User1,ID,IP,Cod';
      if CheckBox4.Checked then fs:=cc(fs)+'GetCina(misce,id,''o'')*Kilkist as OCina';
      if CheckBox5.Checked then Begin
        fs:=cc(fs)+'GetCina(misce,id,''z'')*Kilkist as ZCina';
        fs:=cc(fs)+'(Cina-(GetCina(misce,id,''z'')*'+FloatTSQL(Kurs)+')) as Mj';
        End;
      End;
    5: Begin
      from:= 'Склад';
      fs:='Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina,Data,ID';
      if CheckBox4.Checked then fs:=cc(fs)+'GetCina(misce,id,''o'')*Kilkist as OCina';
      if CheckBox5.Checked then Begin
        fs:=cc(fs)+'GetCina(misce,id,''z'')*Kilkist as ZCina';
        fs:=cc(fs)+'(Cina-(GetCina(Misce,ID,''z'')*'+FloatTSQL(Kurs)+')) as Mj';
        End;
      End;
    end;
  Case n of
    0: Ft:= 'Oper = ''Продажа'' ';
    1: Ft:= 'Oper = ''Видача'' ';
    2: Ft:= 'Oper = ''Повернення'' ';
    3,4: Ft:= 'Oper = ''Переміщення'' ';
    5,6: Ft:= '';
    end;

  if Date2^ <> '' then  ft:=ac(ft)+'Data Between '''+Date1^+'''and'''+Date2^+'''';
  if (Date1^ <> '') and (Date2^ = '') Then ft:=ac(ft)+'Data ='''+Date1^+'''';


  if Misce1^ <> '' Then
    Case n of
      3: Begin
        ft:=ac(ft)+'Zvidk = '''+Misce1^+'''';
        if Misce2^<>'' Then ft:=ac(ft)+'Misce = '''+ Misce2^+'''';
        End;
      4: Begin
        ft:=ac(ft)+'Misce = '''+Misce1^+'''';
        if Misce2^<>'' Then ft:=ac(ft)+'Zvidk = '''+Misce2^+'''';
        End;
      0,1,2,5:ft:=ac(ft)+'Misce = '''+Misce1^+'''';
      6: ft:=ac(ft)+'(Misce = '''+Misce1^+'''or Zvidk = '''+Misce1^+''')';
      end;

  if HC2.Sections[6].Text <> '' Then ft:=ac(ft)+'Nazva = '''+ HC2.Sections[6].Text+'''';
  if HC2.Sections[7].Text <> '' Then ft:=ac(ft)+'Tip = '''+ HC2.Sections[7].Text+'''';
  if HC2.Sections[8].Text <> '' Then ft:=ac(ft)+'Rozmir = '+ HC2.Sections[8].Text;
  if HC2.Sections[9].Text <> '' Then ft:=ac(ft)+'Rist = '+ HC2.Sections[9].Text;

  for n := 1 to HC.Sections.Count - 1 do if pos(HC.Sections[n].Text,fs)<>0 then
    os:=cc(os)+HC.Sections[n].Text;
  os:=' Order By '+os;
  if ft <> '' Then ft:=' Where '+ft;
  if CheckBox3.Checked then os:=os+' limit  '+SpinEdit1.Text;

  MC.mySQLg(StringGrid1,'Select '+fs+' From '+from+ft+os);
  //ShowMessage(MC.LastSQL);
  //Edit1.Text:=MC.LastSQL;
  SB.Panels[3].Text:=MC.LastError;
  SB.Panels[0].Text:=MC.mySQLs('Select Sum(Kilkist) From '+from+ft);
  SB.Panels[1].Text:=MC.mySQLs('Select Sum(Cina) From '+from+ft);
  if pos('bcina',LowerCase(fs))<>0 then
    SB.Panels[2].Text:=MC.mySQLs('Select Sum(BCina) From '+from+ft);
  if CheckBox4.Checked and (ft<>'') then SB.Panels[4].Text:=MC.mySQLs('Select Sum(GetCina(misce,id,''o'')*Kilkist) From '+from+ft);
  if CheckBox5.Checked and (ft<>'') then SB.Panels[5].Text:=MC.mySQLs('Select Sum(GetCina(misce,id,''z'')*Kilkist) From '+from+ft);
end;

procedure TVidomostiForm.MyClick(Sender: TObject);
begin
  if sender is TComboBox then With TComboBox(sender) do Begin
    if Name='CB' then Begin
      HC2.Sections[6].Text:=Items[ItemIndex];
      CB3.Items.Text:=MC.mySQLf('Select Distinct Tip From types where GGID='''+MC.mySQLs('Select ID From gg Where Nazva ='''+HC2.Sections[6].Text+'''')+'''',1);
      End;
    if Name='CB1' then Begin
      HC2.Sections[2].Text:=Items[ItemIndex];
      HC2.Sections[3].Text:=IntToStr(ItemIndex);
      End;
    if Name='CB2' then HC2.Sections[4].Text:=Items[ItemIndex];
    if Name='CB3' then HC2.Sections[7].Text:=Items[ItemIndex];
    if Name='CB4' then HC2.Sections[8].Text:=Items[ItemIndex];
    if Name='CB5' then HC2.Sections[9].Text:=Items[ItemIndex];
    if Name='CB6' then HC2.Sections[5].Text:=Items[ItemIndex];
    End;
  if sender is TDateTimePicker then With TDateTimePicker(sender) do Begin
    if Name='DTP' then HC2.Sections[0].Text:=FormatDateTime('yyyy.mm.dd', DTP.Date);
    if Name='DTP1' then HC2.Sections[1].Text:=FormatDateTime('yyyy.mm.dd', DTP1.Date);
    End;
  if sender is TCheckBox then With TCheckBox(sender) do Begin
    if Name='CheckBox1' then Begin
      if Checked Then begin
        DTP.Enabled:=True;
        MyClick(DTP);
        End Else begin
          DTP.Enabled:=False;
          DTP1.Enabled:=False;
          CheckBox2.Checked:=False;
          HC2.Sections[0].Text:='';
          HC2.Sections[1].Text:='';
          end;
      End;

    if Name='CheckBox2' then Begin
      if Checked Then Begin
        DTP1.Enabled:=True;
        CheckBox1.Checked:=True;
        MyClick(DTP);
        MyClick(DTP1);
        end Else Begin
          DTP1.Enabled:=False;
          HC2.Sections[1].Text:='';
          end;
      End;
    End;


end;

procedure TVidomostiForm.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  with StringGrid1 do
    if (ddtext='') and (RowCount>1) then
     ddtext:= Cells[MouseCoord(x,y).X,0];
  if (Sender=StringGrid1) and (Source=HC) then Accept:=True else Accept:=false;
  StringGrid1.DragMode:=dmManual;
end;

procedure TVidomostiForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    With StringGrid1 do With Canvas do
  if 0=CellRect(0,RowCount-1).Bottom then
            ColWidths[ColCount-1]:=Width-CellRect(ColCount-1,0).Left-22
            else ColWidths[ColCount-1]:=Width-CellRect(ColCount-1,0).Left-5;
end;

procedure TVidomostiForm.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then StringGrid1.DragMode:=dmAutomatic;

end;

procedure TVidomostiForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  StringGrid1.DragMode:=dmManual;
end;

End.
