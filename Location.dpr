program Location;

uses
  Forms,
  uLocationForm in 'uLocationForm.pas' {LocationForm},
  uSQL_Func in 'Sourse\uSQL_Func.pas',
  uData in 'Sourse\uData.pas',
  uTreeFunction in 'uTreeFunction.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLocationForm, LocationForm);
  Application.Run;
end.
