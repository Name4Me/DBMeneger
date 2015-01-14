unit uOptCalculate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids,StrUtils;

type
  TOptCalculateForm = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptCalculateForm: TOptCalculateForm;

implementation

uses uMainForm,uData;

{$R *.dfm}

procedure TOptCalculateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TOptCalculateForm.FormCreate(Sender: TObject);
Var sum:real;
  k:integer;
begin
  MC.mySQLg(StringGrid1,'SELECT Oper,Nazva,Tip,Rozmir,Rist,Kilkist,'+
  '@p:=(Getcina(Misce,id,''o'')*Kilkist) as OCina,@p*'+AnsiReplaceStr(FloatToStr(kurs), ',', '.')+' as HCina,id from oper where oper=''Продажа'''+
  ' and  FIND_IN_SET(left(id,2),''02,09,13'')=0 and ip<=0 and `Data`='''+MDs+
  ''' AND misce='''+DefMisce+''' order by Data,Time');
  sum:=MC.mySQLv('SELECT sum(Getcina(Misce,id,''o'')*Kilkist) as OCina'+
  ' from oper where oper=''Продажа'''+
  ' and  FIND_IN_SET(left(id,2),''02,09,13'')=0 and ip<=0 and `Data`='''+MDs+
  ''' AND misce='''+DefMisce+'''');
  k:=MC.mySQLi('SELECT sum(Kilkist)'+
  ' from oper where oper=''Продажа'''+
  ' and  FIND_IN_SET(left(id,2),''02,09,13'')=0 and ip<=0 and `Data`='''+MDs+
  ''' AND misce='''+DefMisce+'''');
  Label1.Caption:=IntToStr(k)+'шт. '+FloatToStr(sum)+'$ ('+FloatToStr(sum*kurs)+'грн.)'
  //Edit1.Text:=MC.LastSQL;
end;

end.
