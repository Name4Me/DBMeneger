unit uSMenegerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Tabs, StdCtrls, DockTabSet, ButtonGroup,CategoryButtons,
  ActnList;

type
  TSMForm = class(TForm)
    TabSet: TTabSet;
    Button1: TButton;
    ButtonGroup: TButtonGroup;
    LabeledEdit1: TLabeledEdit;
    Button2: TButton;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button3: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSetOnClick(Sender: TObject);
    procedure ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SMForm: TSMForm;

implementation
Uses uData,uSQL_Func, uMainForm;
{$R *.dfm}

procedure TSMForm.TabSetOnClick(Sender: TObject);
Var
  ml:TStrings;
  i:integer;
begin

  if TabSet.Tabs.Count<0 then exit;
  ml:=TStringList.Create;
  case TabSet.TabIndex of
    0: ml.Text:=MrC.mySQLf('Select login from users order by login',1);
    1: ml.Text:=MrC.mySQLf('Select login from users Where active=0 order by login',1);
  end;

  With ButtonGroup Do Begin
    Items.BeginUpdate;
    Items.Clear;
    for i := 0 to ml.Count - 1 do Items.Add.Caption:=ml[i];
    Items.EndUpdate;
    ml.Free;
    if Items.Count<=0 then Begin
      LabeledEdit1.Clear;
      LabeledEdit2.Clear;
      LabeledEdit3.Clear;
      exit;
      End;
      ItemIndex:=0;
      ButtonGroupButtonClicked(Sender,0);
    End;
end;

procedure TSMForm.Button1Click(Sender: TObject);
begin
   With ButtonGroup do if ItemIndex>=0 then
    MrC.MyEx('update users set pip='''+LabeledEdit1.Text+''',login='''+LabeledEdit2.Text+''',email='''+LabeledEdit3.Text+''' where login='''+Items[ItemIndex].Caption+'''');
end;

procedure TSMForm.Button2Click(Sender: TObject);
begin
  With ButtonGroup do if ItemIndex>=0 then Begin
    MrC.MyEx('Delete from users where login='''+Items[ItemIndex].Caption+'''');
    Items.Delete(ItemIndex);
    if Items.Count>0 then Begin
      ButtonGroupButtonClicked(Sender,0);
      ItemIndex:=0;
      End;
    End;
end;

procedure TSMForm.Button3Click(Sender: TObject);
begin
   With ButtonGroup do if ItemIndex>=0 then Begin
    MrC.MyEx('update users set active=1 where login='''+Items[ItemIndex].Caption+'''');
    {Items.Delete(ItemIndex);
    if Items.Count>0 then Begin
      ButtonGroupButtonClicked(Sender,0);
      ItemIndex:=0;
      End;}
    End;
end;

procedure TSMForm.ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
Var ml:Tstrings;
begin
  if index>=0 then Begin
    ml:=TStringList.Create;
    ml.Text:=MrC.mySQLf('Select pip,login,email,active from users where login='''+ButtonGroup.Items[Index].Caption+'''order by login');
    LabeledEdit1.Text:=ml.ValueFromIndex[0];
    LabeledEdit2.Text:=ml.ValueFromIndex[1];
    LabeledEdit3.Text:=ml.ValueFromIndex[2];
    if ml.ValueFromIndex[3]='0' then Button3.Enabled:=True
      else Button3.Enabled:=False;
    ml.Free;
    End;
end;

procedure TSMForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TSMForm.FormCreate(Sender: TObject);
begin
  //SMForm.Repaint;

  TabSet.Tabs.Add('Всі ['+IntTostr(MrC.mySQLc('Select id from users'))+']');
  TabSet.TabIndex:=0;
  TabSet.Tabs.Add('Не активовані ['+IntTostr(MrC.mySQLc('Select id from users where active=0'))+']');
  TabSetOnClick(Sender);


end;

end.
