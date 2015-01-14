program test;

uses
  Forms,
  remain in 'remain.pas' {MainForm},
  reinit in 'reinit.pas',
  uArgox203 in 'uArgox203.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Lables Print';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
