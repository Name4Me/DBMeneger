unit uNewZnacenia;

interface

uses
  SysUtils,Forms, StdCtrls, ExtCtrls, ComCtrls,Controls, Classes,
  Dialogs, DB, DBTables;

type
  TNewZnaceniaForm = class(TForm)
    PageControl1: TPageControl;
    P1: TTabSheet;
    P2: TTabSheet;
    P1HC2: THeaderControl;
    P1HC1: THeaderControl;
    Panel3: TPanel;
    tButton2: TButton;
    tButton1: TButton;
    mButton1: TButton;
    mButton2: TButton;
    tButton3: TButton;
    tButton4: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox4: TListBox;
    ListBox3: TListBox;
    Edit1: TEdit;
    tButton5: TButton;
    mButton3: TButton;
    Panel1: TPanel;
    tButton6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonClick(Sender: TObject);
    procedure MyKeyPress(Sender: TObject; var Key: Char);
    procedure ListBoxClick(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
  private
    procedure TC;
  public
    { Public declarations }
  end;

var
  NewZnaceniaForm: TNewZnaceniaForm;
  ggID:string;

implementation

uses  uData, uMainForm;

{$R *.dfm}
procedure TNewZnaceniaForm.TC;
var m,n,l,t:integer;
  ml:^TStrings;
begin
  n:=0;
  l:=0;
  t:=0;
  New(ml);
  ml^:=TStringList.Create;
  ml^.Text:=MC.mySQLf('DESCRIBE Types',1);
  For m:= 0 to ml^.Count-1 do
    with TLabeledEdit.Create(Panel1) do begin
      Left := 10+l;
      Top := 20+(t*40);
      Width := 150;
      Height := 17;
      Name := 'LE' + IntToStr(n);
      EditLabel.Caption := ml^.Names[m];
      if ml^.ValueFromIndex[m] = 'double' Then OnKeyPress:=MyKeyPress;
      Text:='';
      Parent := Panel1;
      if pos(lowercase(EditLabel.Caption),'id,ggid')<>0 Then Enabled:=False;
      inc(n);
      inc(t);
      if (20+(t*40)+Height)>Panel1.Height then Begin
        t:=0;
        l:=170;
        Panel1.Width:=Panel1.Width*2;
        End;

      end;
  ml^.Free;
  Dispose(ml);
end;

procedure TNewZnaceniaForm.FormCreate(Sender: TObject);
var m:integer;
  ml:^TStrings;
begin

  ListBox1.Items.Text:=MC.mySQLf('Select Nazva from GG',1);
  ListBox4.Items.Text:=MC.mySQLf('Select Misce from Misce',1);
  New(ml);
  ml^:=TStringList.Create;
  ml^.Text:=MC.mySQLf('DESCRIBE Misce',1);
  For m:= 0 to ml^.Count-1 do with TLabeledEdit.Create(P2) do begin
    Left := 220;
    Top := 20+(m*40);
    Width := 150;
    Height := 17;
    Name := 'LEM' + IntToStr(m);
    EditLabel.Caption := ml^.Names[m];
    Text:='';
    Parent := P2;
    end;
  ml^.Free;
  Dispose(ml);
end;

procedure TNewZnaceniaForm.Edit1Enter(Sender: TObject);
Var
  n,max:integer;
begin
  max:=Length(MC.mySQLs('Select max(id) from Types Where GGID = '''+ggID+''''));
  n:=0;
  while MC.mySQLs('select id from types where ggid='''+ggID+'''and id='+inttostr(n))<>'' do inc (n);
  Edit1.Text:=copy('000',1,max-length(IntToStr(n)))+IntToStr(n);
end;

procedure TNewZnaceniaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TNewZnaceniaForm.ButtonClick(Sender: TObject);
Var
  i,n,max:integer;
  f,v,id:string;
begin
  if sender is TButton then begin
    //-------------------------------------------------------------Додати тип---
    if (TButton(sender).Name='tButton1') and
      (ListBox3.Items.IndexOf(TLabeledEdit(Panel1.Components[0]).Text)=-1) then Begin
        max:=Length(MC.mySQLs('Select max(id) from Types Where GGID = '''+ggID+''''));
        n:=0;
        while MC.mySQLs('select id from types where ggid='''+ggID+'''and id='+inttostr(n))<>'' do inc (n);
        id:=copy('000',1,max-length(IntToStr(n)))+IntToStr(n);

        for i := 0 to Panel1.ComponentCount - 1 do if Panel1.Components[i] is TLabeledEdit then
          with TLabeledEdit(Panel1.Components[i]) do
          if pos(lowercase(EditLabel.Caption),'tip,id,ggid')<>0 Then begin
            f:=cc(f)+EditLabel.Caption;
            if pos(lowercase(EditLabel.Caption),'id')=1then v:=cc(v)+''''+id+'''';
            if pos(lowercase(EditLabel.Caption),'ggid')=1 then v:=cc(v)+''''+ggid+'''';
            if pos(lowercase(EditLabel.Caption),'tip')=1 then v:=cc(v)+''''+text+'''';
            end else begin
            f:=cc(f)+EditLabel.Caption;
            v:=cc(v)+text;
            end;
      MC.MyEx('Insert into Types ('+f+') values ('+v+')');
      //ShowMessage(mc.LastSQL+#13+Mc.LastError);
      ListBoxClick(ListBox1);
      End;

    //--------------------------------------------------------------------------
    //-----------------------------------------------------------Видалити тип---
    if (TButton(sender).Name='tButton2') and (P1HC2.Sections[1].Text<>'') then Begin
      if MC.mySQLi('select sum(kilkist) from '+TSName+' )then where Tip='''+P1HC2.Sections[1].Text+''' and ggid='''+ggID+'''')=-1 Then
          MC.MyEx('Delete from Types where Tip='''+P1HC2.Sections[1].Text+''' and ggid='''+ggID+'''');
      P1HC2.Sections[1].Text:='';
      ListBoxClick(ListBox1);
      End;
    //--------------------------------------------------------------------------
    //-----------------------------------Видалити типи що не використовуються---
    if TButton(sender).Name='tButton3' then Begin
      With ListBox3 do for i := 0 to items.Count - 1 do
        if MC.mySQLi('select sum(kilkist) from '+TSName+' where Tip='''+Items[i]+''' and id like '''+ggID+'%''')=-1 Then
          MC.MyEx('Delete from Types where Tip='''+Items[i]+''' and ggid='''+ggID+'''');
      ListBoxClick(ListBox1);
      End;
    //--------------------------------------------------------------------------
    //-------------------------------------------------------------Змінити ID---
    if (TButton(sender).Name='tButton4') Then Begin
      if (MC.mySQLs('Select id from types where ggid='''+ggID+''' and id='''+Edit1.Text+'''')<>'') then Begin
        n:=0;
        while MC.mySQLs('select id from types where ggid='''+ggID+'''and id='+inttostr(n))<>'' do inc (n);
        Edit1.Text:=copy('000',1,max-length(IntToStr(n)))+IntToStr(n);
        End;
      if P1HC2.Sections[1].Text<>'' then Begin
        MC.MyEx('update types set id='''+Edit1.Text+''' Where ggid='''+ggid+''' and tip='''+P1HC2.Sections[1].Text+'''');
        //ShowMessage(mc.LastSQL+#13+Mc.LastError);
        MC.MyEx('update '+TSName+' set id=GetID(Nazva,Tip,Rozmir,Rist) Where id like '''+ggid+'%'' and tip='''+P1HC2.Sections[1].Text+'''');
        //ShowMessage(mc.LastSQL+#13+Mc.LastError);
        End;
      End;
    //--------------------------------------------------------------------------
    //------------------------------------------------------------Змінити тип---
    if TButton(sender).Name='tButton5' then with TLabeledEdit(Panel1.Components[0]) do
      if P1HC2.Sections[1].Text<>'' then Begin
        MC.MyEx('update types set tip='''+Text+''' Where ggid='''+ggid+''' and tip='''+P1HC2.Sections[1].Text+'''');
        MC.MyEx('update '+TSName+' set tip='''+Text+''' Where id like '''+ggid+'%'' and tip='''+P1HC2.Sections[1].Text+'''');
        MC.MyEx('update oper set tip='''+Text+''' Where id like '''+ggid+'%'' and tip='''+P1HC2.Sections[1].Text+'''');
        ListBoxClick(ListBox1);
        End;
    //--------------------------------------------------------------------------
    //-------------------------------------------Привести ID до формату [xxx]---
    if (TButton(sender).Name='tButton6') Then 
      for i := 0 to ListBox3.Count - 1 do Begin
      id:=MC.mySQLs('Select id from types where ggid='''+ggID+''' and tip='''+ListBox3.Items[i]+'''');
      if id<>'' then Begin
        id:='0'+id;
        MC.MyEx('update types set id='''+id+''' Where ggid='''+ggid+''' and tip='''+ListBox3.Items[i]+'''');
        //ShowMessage(mc.LastSQL+#13+Mc.LastError);
        MC.MyEx('update '+TSName+' set id=GetID(Nazva,Tip,Rozmir,Rist) Where id like '''+ggid+'%'' and tip='''+ListBox3.Items[i]+'''');
        MC.MyEx('update ope set id=GetID(Nazva,Tip,Rozmir,Rist) Where id like '''+ggid+'%'' and tip='''+ListBox3.Items[i]+'''');
        //ShowMessage(mc.LastSQL+#13+Mc.LastError);
        End;
      End;
    //--------------------------------------------------------------------------
    //-----------------------------------------------------------Додати місце---
    if TButton(sender).Name='mButton1' then Begin
      if ListBox4.ItemIndex=-1 then exit;
      if (ListBox4.Items.IndexOf(TLabeledEdit(P2.Components[0]).Text)=-1) then begin
        n:=0;
        while MC.mySQLs('select id from misce where id='+inttostr(n))<>'' do inc (n);
        for i := 0 to P2.ComponentCount - 1 do with TLabeledEdit(P2.Components[i]) do Begin
          if EditLabel.Caption = 'ID' Then begin
            f:=cc(f)+EditLabel.Caption;
            v:=cc(v)+''''+Copy('00',1,2-length(inttostr(n)))+inttostr(n)+'''';
            end;
          if EditLabel.Caption = 'Misce' Then begin
            f:=cc(f)+EditLabel.Caption;
            v:=cc(v)+''''+text+'''';
            end;
          if pos(EditLabel.Caption,'Misce,ID')=0 Then begin
            f:=cc(f)+EditLabel.Caption;
            v:=cc(v)+text;
            end;
          End;
        MC.MyEx('Insert into misce ('+f+') values ('+v+')');
        ListBox4.Items.Text:=MC.mySQLf('Select Distinct Misce from Misce',1);
        end;
      End;
    //--------------------------------------------------------------------------
    //---------------------------------------------------------Видалити місце---
    if (TButton(sender).Name='mButton2')and(ListBox4.ItemIndex <> -1)and
      (MC.mySQLi('select sum(kilkist) from '+TSName+' where misce ='''+ListBox4.Items[ListBox4.ItemIndex] +'''')=-1) then begin
      MC.MyEx('Delete from misce where misce ='''+ListBox4.Items[ListBox4.ItemIndex]+'''');
      ListBox4.Items.Text:=MC.mySQLf('Select Distinct Misce from Misce',1);
      End;
    //--------------------------------------------------------------------------
    //---------------------------------------------------------Видалити місце---
    if (TButton(sender).Name='mButton3')and(ListBox4.ItemIndex <> -1) then
      with TLabeledEdit(P2.Components[0]) do if ListBox4.Items.IndexOf(Text)=-1 Then begin
        MC.MyEx('Update misce set misce='''+Text+''' where misce ='''+ListBox4.Items[ListBox4.ItemIndex]+'''');
        MC.MyEx('Update '+TSName+' set misce='''+Text+''' where misce ='''+ListBox4.Items[ListBox4.ItemIndex]+'''');
        MC.MyEx('Update oper set misce='''+Text+''' where misce ='''+ListBox4.Items[ListBox4.ItemIndex]+'''');
        MC.MyEx('Update oper set zvidk='''+Text+''' where zvidk ='''+ListBox4.Items[ListBox4.ItemIndex]+'''');

        ListBox4.Items.Text:=MC.mySQLf('Select Distinct Misce from Misce',1);
      End;
    //--------------------------------------------------------------------------
    end;
end;

procedure TNewZnaceniaForm.ListBoxClick(Sender: TObject);
Var
  i:integer;
  ml:^TStrings;
begin
  if sender is TListBox then With TListBox(Sender) do begin
    if ItemIndex=-1 then Exit;
    if Name='ListBox1' then Begin
      if Panel1.ComponentCount=0 then TC;
      
      P1HC2.Sections[0].Text:=Items[ItemIndex];
      ggID:=MC.mySQLs('Select ID from GG Where Nazva ='''+P1HC2.Sections[0].Text+'''');
      ListBox2.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Types Where GGID = '''+ggID+'''',1);
      ListBox3.Items.Text:=MC.mySQLf('Select Distinct Tip from Types Where GGID = '''+ggID+''' order by tip',1);
      End;
    if Name='ListBox2' then Begin
      ListBox3.Items.Text:=MC.mySQLf('Select Distinct Tip from Types Where GGID = '''+ggID+''' and tip like '''+Items[ItemIndex]+'%'' order by tip',1);
      End;
    if Name='ListBox3' then Begin
      P1HC2.Sections[1].Text:=Items[ItemIndex];
      New(ml);
      ml^:=TStringList.Create;
      ml^.Text:=MC.mySQLf('Select * from Types Where GGID = '''+ggID+'''and Tip='''+P1HC2.Sections[1].Text+'''');
      //showMessage(ml.Text);
      tButton4.Caption:='Змінити ID ['+ml.Values['ID']+']';
      For i:= 0 to  Panel1.ComponentCount-1 do if Panel1.Components[i] is TLabeledEdit then
        with TLabeledEdit(Panel1.Components[i]) do
         Text:= ml^.Values[EditLabel.Caption];
      ml^.Free;
      Dispose(ml);
      End;
    if Name='ListBox4' then Begin
      New(ml);
      ml^:=TStringList.Create;
      ml^.Text:=MC.mySQLf('Select * from Misce Where Misce = '''+Items[ItemIndex] +'''');
      For i:= 0 to  ml^.Count-1 do TLabeledEdit(P2.Components[i]).Text:= ml^.ValueFromIndex[i];
      ml^.Free;
      Dispose(ml);
      End;
    end;
end;

procedure TNewZnaceniaForm.MyKeyPress(Sender: TObject; var Key: Char);
var
vrPos,vrLength,vrSelStart : byte;
const
I : byte=1;
begin
   With Sender as TLabeledEdit do begin
      vrLength:=Length(Text);
      vrPos:=Pos(',', Text);
      vrSelStart:=SelStart;
      end;
   Case Key of
      '0'..'9': If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos) then Key:=#0;
      ',','.' : If (vrPos>0)or(vrSelStart=0)or(vrLength=0) then Key:=#0 else Key:=#44;
      #8 :;
      else Key := #0;
   end;
end;

end.
