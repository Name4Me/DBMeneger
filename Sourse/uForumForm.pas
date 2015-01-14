unit uForumForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForumForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Memo1: TMemo;
    GroupBox4: TGroupBox;
    Memo2: TMemo;
    procedure GroupBox4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ForumForm: TForumForm;

implementation

{$R *.dfm}

procedure TForumForm.GroupBox4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  if Sender is TGroupBox then with sender as TGroupBox do begin
    if (y in [2..12]) and (height=15) then height:=50 else if y in [2..12] then height:=15;
    if ((width-x) in [10..20]) and (y in [2..12]) then Free;
    end;

end;
procedure TForumForm.GroupBox4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender is TGroupBox then with sender as TGroupBox do begin
    Memo2.Text:=IntTostr(x)+'--'+IntTostr(y);

    end;
//
end;

end.



