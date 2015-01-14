unit uLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TLogForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Procedure RefreshLog;{ Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

uses uMainForm,uData;

{$R *.dfm}
procedure TLogForm.FormCreate(Sender: TObject);
begin
  RefreshLog;
end;

Procedure TLogForm.RefreshLog;
Begin
  if Memo1.Lines.Text<>MC.Log.Text then Memo1.Lines.Text:=MC.Log.Text;
End;
procedure TLogForm.Timer1Timer(Sender: TObject);
begin
  RefreshLog;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

end.
