program UPLoader;

uses
  FastMM4 in '..\Sourse\FastMM4.pas',
  Forms,
  uUPLoader in 'uUPLoader.pas' {Form9},
  uFileFunction in '..\Sourse\uFileFunction.pas',
  FastMM4Messages in '..\Sourse\FastMM4Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
