unit uLocationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TLocationForm = class(TForm)
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox3: TComboBox;
    ListBox1: TListBox;
    HC: THeaderControl;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button3: TButton;
    TV: TTreeView;
    TV1: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure HCDrawSection(HeaderControl: THeaderControl;
      Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
    procedure PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure TVClick(Sender: TObject);
    procedure TV1CustomDraw(Sender: TCustomTreeView; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure TV1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LocationForm: TLocationForm;
implementation
Uses Data,SQL_Func,uTreeFunction;
{$R *.dfm}

procedure TLocationForm.Button1Click(Sender: TObject);
begin
  if (HC.Sections[2].Text<>'') and (ComboBox1.Items[ComboBox1.ItemIndex]<>'') and (ComboBox2.Items[ComboBox2.ItemIndex]<>'') and (MC.mySQLc('Select ID from Location where Misce='''+DefMisce+''' and TID = '+HC.Sections[2].Text+' and Loc ='''+Edit1.Text+'''')=0) then
    MC.MyEx('Insert into Location (Misce,TID,Loc) Values ('''+DefMisce+''','''+HC.Sections[2].Text+''','''+Edit1.Text+''')');
  MC.mySQLcf(ListBox1.Items,'Select Loc from Location where misce='''+DefMisce+''' and TID ='+HC.Sections[2].Text+' order by Loc');
  MC.mySQLcf(ComboBox3.Items,'Select distinct Loc from Location where misce='''+DefMisce+''' order by Loc');
  Button4Click(nil);
end;

procedure TLocationForm.Button2Click(Sender: TObject);
begin
  if MC.mySQLc('Select ID from Location where Misce='''+DefMisce+''' and TID = '+HC.Sections[2].Text+' and Loc ='''+Edit1.Text+'''')=1 then
    MC.MyEx('Delete from Location where Misce='''+DefMisce+''' and TID = '+HC.Sections[2].Text+' and Loc ='''+Edit1.Text+'''');
  MC.mySQLcf(ListBox1.Items,'Select Loc from Location where misce='''+DefMisce+''' and TID ='+HC.Sections[2].Text+' order by Loc');
  MC.mySQLcf(ComboBox3.Items,'Select distinct Loc from Location where misce='''+DefMisce+''' order by Loc');
end;

procedure TLocationForm.Button3Click(Sender: TObject);
begin
  With ListBox1 do if (Edit1.Text<>'') and (Items.Count>0) and (Edit1.Text<>Items[ItemIndex]) Then
  MC.MyEx('update Location set Loc='''+Edit1.Text+''' where Misce='''+DefMisce+''' and TID = '+HC.Sections[2].Text+' and Loc ='''+Items[ItemIndex]+'''');
  MC.mySQLcf(ListBox1.Items,'Select Loc from Location where misce='''+DefMisce+''' and TID ='+HC.Sections[2].Text+' order by Loc');
  MC.mySQLcf(ComboBox3.Items,'Select distinct Loc from Location where misce='''+DefMisce+''' order by Loc');

end;

procedure TLocationForm.Button4Click(Sender: TObject);
Var m:integer;
  s:string;
  tn:TTreenode;
  ml:TStrings;
begin
  ml:=TstringList.Create;
  ml.Text:=MC.mySQLf('Select distinct Loc from Location where misce='''+DefMisce+''' order by Loc','r','=');
  for m := 0 to ml.Count - 1 do Begin
    tn:=NSearch(TV.Items.GetFirstNode,Copy(ml[m],1,3));
    if (TV.Items.Count=0) or (tn=nil) then tn:=TV.Items.Add(nil,Copy(ml[m],1,3));
    s:=Copy(ml[m],pos('[',ml[m]),pos(']',ml[m]));
    if (NSearch(TV.Items[0],s)=nil) then TV.Items.AddChild(tn,s);
    //TV.FullExpand;
  End;
  ml.Free;
end;

procedure TLocationForm.ComboBox1Click(Sender: TObject);
begin
  With ComboBox1 do Begin
    MC.mySQLcf(ComboBox2.Items,'Select Distinct Tip from Склад where misce='''+DefMisce+''' and Nazva ='''+Items[ItemIndex]+''' order by tip');
    HC.Sections[0].Text:=Items[ItemIndex];
    End;
end;

procedure TLocationForm.ComboBox2Click(Sender: TObject);
begin
  With ComboBox2 do HC.Sections[1].Text:=Items[ItemIndex];


  HC.Sections[2].Text:=MC.mySQLs('Select ID From GG where Nazva ='''+ HC.Sections[0].Text+'''');
  if HC.Sections[2].Text<>'' then
    HC.Sections[2].Text:=HC.Sections[2].Text+MC.mySQLs('Select ID From Types where GGID ='+HC.Sections[2].Text+' and Tip ='''+HC.Sections[1].Text+'''');
  MC.mySQLcf(ListBox1.Items,'Select Loc from Location where misce='''+DefMisce+''' and TID ='+HC.Sections[2].Text+' order by Loc');
end;


procedure TLocationForm.ComboBox3Click(Sender: TObject);
begin
  With ComboBox3 do Edit1.Text:=Items[ItemIndex];
end;

procedure TLocationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MC.Free;
end;

procedure TLocationForm.FormCreate(Sender: TObject);
begin
  MC:=TMyCon.Create;
  MC.SetOptions('192.168.1.1','trp','ozuwsgag','sklad',3306);
  MC.Connect;
  MC.mySQLcf(ComboBox1.Items,'Select Nazva from gg order by Nazva');
  MC.mySQLcf(ComboBox3.Items,'Select distinct Loc from Location where misce='''+DefMisce+''' order by Loc');
  Button4Click(nil);
end;

procedure TLocationForm.HCDrawSection(HeaderControl: THeaderControl;
  Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
begin
  HC.Canvas.Brush.Color:=ClWhite;
end;

procedure TLocationForm.ListBox1Click(Sender: TObject);
begin
  With ListBox1 do Edit1.Text:=Items[ItemIndex];
end;

procedure TLocationForm.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  Caption:=IntTostr(PageControl1.Canvas.Brush.Color);
end;

procedure TLocationForm.TV1Click(Sender: TObject);
begin
  if TV1.Selected.Parent<>nil Then Begin
    HC.Sections[0].Text:=TV1.Selected.Parent.Text;
    HC.Sections[1].Text:=TV1.Selected.Text;
    HC.Sections[2].Text:=MC.mySQLs('Select GetTID ('''+ HC.Sections[0].Text+''','''+HC.Sections[1].Text+''')');
    MC.mySQLcf(ListBox1.Items,'Select Loc from Location where misce='''+DefMisce+''' and TID ='+HC.Sections[2].Text+' order by Loc');
    End;
end;

procedure TLocationForm.TV1CustomDraw(Sender: TCustomTreeView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  {node:=TCustomTreeView(Sender).GetNodeAt(ARect.Top,ARect.Left);
  if Node<>nil then if Node<>nil then TCustomTreeView(Sender).Canvas.Pen.Width:=2 else TCustomTreeView(Sender).Canvas.Pen.Width:=1;
  TCustomTreeView(Sender).Canvas.TextOut(ARect.Top,ARect.Left,Node.Text); }
end;

procedure TLocationForm.TVClick(Sender: TObject);
Var ml:TStrings;
  i:integer;
  nd:TTreenode;
begin
  ml:=TStringList.Create;
  if TV.Selected.Parent<>nil Then
    ml.Text:=MC.mySQLf('SELECT (Select nazva from gg where id =left(TID,2)) as Nazva,(Select tip from `types` where ggid =left(TID,2) and id=SUBSTRING(TID,3)) as Tip FROM location Where Loc = '''+
      TV.Selected.Parent.Text+TV.Selected.Text+''' and misce ='''+DefMisce
      +''' ORDER by Nazva,Tip','r','=')
      Else ml.Text:=MC.mySQLf('SELECT (Select nazva from gg where id =left(TID,2)) as Nazva,(Select tip from `types` where ggid =left(TID,2) and id=SUBSTRING(TID,3)) as Tip FROM location Where Loc Like '''+
      TV.Selected.Text+'%'' and misce ='''+DefMisce
      +''' ORDER by Nazva,Tip','r','=');
  TV1.Items.BeginUpdate;
  TV1.Items.Clear;
  for i := 0 to ml.Count - 1 do Begin
    nd:=NSearch(TV1.Items.GetFirstNode,ml.Names[i]);
    //TV.Font.Style:=[fsBold];
    if (TV.Items.Count=0) or (nd=nil) then nd:=TV1.Items.Add(nil,ml.Names[i]);
    //TV.Font.Style:=[];
    TV1.Items.AddChild(nd,ml.ValueFromIndex[i]);
    End;


  TV1.Items.EndUpdate;
  TV1.FullExpand;
  ml.Free;
end;

end.
