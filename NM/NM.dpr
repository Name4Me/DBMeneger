program NM;

uses
  Forms,
  Windows,
  uNProdaja in '..\Sourse\uNProdaja.pas' {FNP},
  uData in '..\Sourse\uData.pas',
  uSQL_Func in '..\Sourse\uSQL_Func.pas',
  uInputClients in '..\Sourse\uInputClients.pas' {InputDlg},
  uSearchForm in '..\Sourse\uSearchForm.pas' {SearchForm},
  uOrdersForm in '..\Sourse\uOrdersForm.pas' {OrdersForm},
  uMainForm in '..\Sourse\uMainForm.pas' {MainMForm},
  uAZamovlenia in '..\Sourse\uAZamovlenia.pas' {AZamovleniaForm},
  uOrderForm in '..\Sourse\uOrderForm.pas' {OrderForm},
  uDataST in '..\Sourse\uDataST.pas',
  uLowerCaseForm in '..\Sourse\uLowerCaseForm.pas' {LowerCaseForm},
  uForumForm in '..\Sourse\uForumForm.pas' {ForumForm},
  uProdaja in '..\Sourse\uProdaja.pas' {ProdajaForm},
  uPermiscenia in '..\Sourse\uPermiscenia.pas' {FPM},
  uSMenegerForm in '..\Sourse\uSMenegerForm.pas' {SMForm},
  uOperVidomosti in '..\Sourse\uOperVidomosti.pas' {OVForm},
  uCommPort in '..\Sourse\uCommPort.pas',
  uSetingsForm in '..\Sourse\uSetingsForm.pas' {SetingsForm},
  uVidacha in '..\Sourse\uVidacha.pas' {VidachaForm},
  uAProvedenia in '..\Sourse\uAProvedenia.pas' {AutoForm},
  uOptCalculate in '..\Sourse\uOptCalculate.pas' {OptCalculateForm},
  uLibMySQL in '..\Sourse\uLibMySQL.pas',
  uVidomosti in '..\Sourse\uVidomosti.pas' {VidomostiForm},
  uFOper in '..\Sourse\uFOper.pas' {FOperForm},
  uLablesForm in '..\Lables\uLablesForm.pas' {ETForm},
  uFVidomosti in '..\Sourse\uFVidomosti.pas' {FVidomostiForm},
  uStruct in '..\Sourse\uStruct.pas' {StructForm},
  uPrintForm in '..\Sourse\uPrintForm.pas' {PrintForm},
  uPereocinka in '..\Sourse\uPereocinka.pas' {PereocinkaForm},
  uNewZnacenia in '..\Sourse\uNewZnacenia.pas' {NewZnaceniaForm},
  uFTP in '..\Sourse\uFTP.pas' {FTPForm},
  uTTP245 in '..\Sourse\uTTP245.pas',
  uLog in '..\Sourse\uLog.pas' {LogForm},
  uMyGrid in '..\Sourse\uMyGrid.pas',
  uDC in '..\Sourse\uDC.pas',
  uArgox203 in '..\Sourse\uArgox203.pas';

{$R *.res}
Var HWnd:THandle;
begin

  HWnd:=FindWindow('TMainMForm', nil);
  if HWnd = 0 Then Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := 'Meneger';
    Application.CreateForm(TMainMForm, MainMForm);
  Application.Run;
    End Else Begin
      SetForeGroundWindow(HWnd);
      ShowWindow(HWnd, SW_RESTORE);
      SetActiveWindow(HWnd);
      End;
end.

