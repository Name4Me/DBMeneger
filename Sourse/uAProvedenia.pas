unit uAProvedenia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, Grids,StrUtils;

type
  TAutoForm = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Button3: TButton;
    DP: TMonthCalendar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DPClick(Sender: TObject);
  private
    procedure SG1Refresh;
    procedure SG3Refresh;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AutoForm: TAutoForm;

implementation

uses uMainForm,udata;

{$R *.dfm}

procedure TAutoForm.Button1Click(Sender: TObject);
  Var i:integer;
  sql:string;
begin
  with StringGrid1 do
    for i := Selection.Top to Selection.Bottom do begin
      if Cells[1,i]='Продажа' then
        sql:='Call prodaja('''+Cells[3,i]+''','''+Cells[4,i]+''','+Cells[5,i]+','+
          FloatSTSQL(Cells[6,i])+','+Cells[9,i]+','''+Cells[10,i]+''','''+Cells[7,i]+
          ''','''+Cells[8,i]+''',1)';
      if Cells[1,i]='Видача' then
        sql:='Call Vidacha('''+Cells[3,i]+''','''+Cells[4,i]+''','+Cells[5,i]+
          ','+Cells[9,i]+','''+Cells[7,i]+''','''+Cells[8,i]+''',1)';
      if Cells[1,i]='Повернення' then
        sql:='Call Vidacha('''+Cells[3,i]+''','''+Cells[4,i]+''','+Cells[5,i]+
          ','+Cells[9,i]+','''+Cells[7,i]+''','''+Cells[8,i]+''',2)';
      if Cells[1,i]='Переміщення' then
        sql:='Call permischenia('''+Cells[2,i]+''','''+Cells[3,i]+''','''+Cells[4,i]+''','+Cells[5,i]+
          ','+Cells[9,i]+','''+Cells[7,i]+''','''+Cells[8,i]+''',1)';
      if MC.MyEx(sql) then MC.MyEx('Update toper set proveden=1 where cod='+Cells[12,i]);
    end;
    SG1Refresh;
    SG3Refresh;
end;

procedure TAutoForm.Button3Click(Sender: TObject);
  Var i,n:integer;
  sql,sql1:string;
begin
  if StringGrid2.RowCount<=1 then Exit;

  with StringGrid2 do Begin
    sql1:='INSERT IGNORE INTO TOper ('+Cells[1,0];
    for n := 2 to ColCount-1 do sql1:=sql1+','+Cells[n,0];
    sql1:=sql1+') VALUES (';
    for i := 1 to RowCount-1 do begin
      sql:='';
      for n := 1 to ColCount-1 do
        if n=1 then sql:=sql+'"'+AnsiReplaceStr(Cells[n,i], ',', '.')+'"'
          else if (n in [8,9,10,14,18,19]) then sql:=sql+','+AnsiReplaceStr(Cells[n,i], ',', '.')
            else sql:=sql+',"'+AnsiReplaceStr(Cells[n,i], ',', '.')+'"';
      MC.MyEx(sql1+sql+')');
      end;
      //Memo1.Lines.Add(sql);


    End;

  SG1Refresh;
end;

procedure TAutoForm.DPClick(Sender: TObject);
begin
  SG1Refresh;
  MrC.mySQLg(StringGrid2,'Select * from oper where data ='''+
    FormatDateTime('yyyy.mm.dd',DP.Date)+''' and oper not like ''Відміна%'' and (misce = '''+DefMisce+''' or zvidk = '''+DefMisce+''') order by data');
  SG3Refresh;
end;

procedure TAutoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TAutoForm.FormCreate(Sender: TObject);
begin
  DP.Date:=Now;
end;
procedure TAutoForm.SG1Refresh;
begin
  MC.mySQLg(StringGrid1,'Select Oper,Zvidk,Misce,ID,Kilkist,Cina,User,Data,IP,Inf,Proveden,Cod from toper where data ='''+
    FormatDateTime('yyyy.mm.dd',DP.Date)+''' and oper not like ''Відміна%'' and proveden=0');
end;
procedure TAutoForm.SG3Refresh;
begin
  MC.mySQLg(StringGrid3,'Select * from oper where data ='''+
    FormatDateTime('yyyy.mm.dd',DP.Date)+''' and oper not like ''Відміна%'' and (misce = '''+DefMisce+''' or zvidk = '''+DefMisce+''') order by data');
end;

end.
