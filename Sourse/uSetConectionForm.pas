unit uSetConectionForm;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls,
  uSQL_Func;

type
  
  TForm2 = class(TForm)
    RGroup1: TRadioGroup;
    LEdit1: TLabeledEdit;
    LEdit2: TLabeledEdit;
    LEdit3: TLabeledEdit;
    LEdit4: TLabeledEdit;
    GB1: TGroupBox;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    LEdit5: TLabeledEdit;
    LEdit6: TLabeledEdit;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure RGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LEdit5Exit(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Function GetCon:TConnectionOption_ST;
var
  
  Cl:TOptionList;
  tmp:TConnectionOption_ST;
  rt:TConnectionOption_ST;
implementation
Function GetCon:TConnectionOption_ST;
Var
  Form2: TForm2;
Begin
  rt.Description:='';
  Application.CreateForm(TForm2, Form2);
  Form2.ShowModal;
  Result := rt;
  Form2.Free;
End;
{$R *.dfm}


procedure TForm2.Button1Click(Sender: TObject);
begin
  if (Cl.DbOpen) then Cl.AddRec(tmp);
  RGroup1.Items.Add(CL.ReadRec(Cl.RcCount-1).Description);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  with RGroup1 do
  if (ItemIndex>=0) and (Cl.DbOpen) and (ItemIndex<=Cl.RcCount) then Begin
    Cl.ModifyRecN(ItemIndex,tmp);
    Items[ItemIndex]:=tmp.Description;
    End;
end;

procedure TForm2.Button3Click(Sender: TObject);
Var i:integer;
begin
  if (RGroup1.ItemIndex>=0) and (Cl.DbOpen) and (RGroup1.ItemIndex<=Cl.RcCount-1) then Begin
    for I := RGroup1.ItemIndex to Cl.RcCount - 2 do Cl.ModifyRecN(i,Cl.ReadRec(i+1));
    Cl.TruncateDB(Cl.RcCount-1);
    RGroup1.Items.Delete(RGroup1.ItemIndex);
    RGroup1.ItemIndex:=0;
    End;

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  rt:=tmp;
  Close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Cl.DbOpen then Cl.CloseDB;

  Cl.Free;
end;

procedure TForm2.FormShow(Sender: TObject);
Var i:integer;
begin
  Cl:=TOptionList.Create;
  if not Cl.OpenDB('Connection.dat') Then Cl.CreateDB('Connection.dat');
  for i := 0 to Cl.RcCount - 1 do Begin
    RGroup1.Items.Add(CL.ReadRec(i).Description);
    RGroup1.ItemIndex:=0;
    End;
  LEdit5Exit(Sender);

end;

procedure TForm2.LEdit5Exit(Sender: TObject);
begin
  tmp.Description:=LEdit6.Text;
  tmp.Host:=LEdit1.Text;
  tmp.User:=LEdit2.Text;
  tmp.Pass:=LEdit3.Text;
  tmp.DB:=LEdit4.Text;
  tmp.Port:=StrToIntDef(LEdit5.Text,3306);
end;

procedure TForm2.RGroup1Click(Sender: TObject);
begin
  if (RGroup1.ItemIndex>=0) and (Cl.DbOpen) and (RGroup1.ItemIndex<=Cl.RcCount) then
  tmp:=CL.ReadRec(RGroup1.ItemIndex);
  LEdit6.Text:=tmp.Description;
  LEdit1.Text:=tmp.Host;
  LEdit2.Text:=tmp.User;
  LEdit3.Text:=tmp.Pass;
  LEdit4.Text:=tmp.DB;
  LEdit5.Text:=IntToStr(tmp.Port);
end;

end.
