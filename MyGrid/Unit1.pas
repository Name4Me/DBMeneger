unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, uMyGrid, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MyGrid1: TMyGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
Caption:=IntToSTr(MyGrid1.Stretch);
end;

end.