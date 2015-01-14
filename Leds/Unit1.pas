unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm9 = class(TForm)
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Edit1Change(Sender: TObject);
begin
  PaintBox1.Canvas.TextOut(1,1,Edit1.Text);
end;

end.
