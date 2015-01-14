program Sinhronaze;

uses
  Forms,
  uSinhronaze in '..\Sourse\uSinhronaze.pas' {Form3},
  uData in '..\Sourse\uData.pas',
  uSQL_Func in '..\Sourse\uSQL_Func.pas',
  uLibMySQL in '..\Sourse\uLibMySQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
