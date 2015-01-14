program FTPc;

uses
  Forms,
  uFTP in '..\Sourse\uFTP.pas' {FTPForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFTPForm, FTPForm);
  Application.Run;
end.
