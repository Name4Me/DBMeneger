program Restore;

uses
  FastMM4 in '..\Sourse\FastMM4.pas',
  Forms,
  uRestore in '..\Sourse\uRestore.pas' {RestoreForm},
  uData in '..\Sourse\uData.pas',
  uSQL_Func in '..\Sourse\uSQL_Func.pas',
  uFileFunction in '..\Sourse\uFileFunction.pas',
  uLibMySQL in '..\Sourse\uLibMySQL.pas',
  FastMM4Messages in '..\Sourse\FastMM4Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRestoreForm, RestoreForm);
  Application.Run;
end.
