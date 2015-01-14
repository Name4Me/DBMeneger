program Lables;

uses
  Forms,
  uLablesForm in 'uLablesForm.pas' {ETForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TETForm, ETForm);
  Application.Run;
end.
