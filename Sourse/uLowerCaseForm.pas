unit uLowerCaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLowerCaseForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LowerCaseForm: TLowerCaseForm;

implementation

{$R *.dfm}

procedure TLowerCaseForm.Button1Click(Sender: TObject);
begin
  Memo2.Text:=LowerCase(Memo1.Text);
end;

end.
