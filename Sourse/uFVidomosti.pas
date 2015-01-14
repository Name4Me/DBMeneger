unit uFVidomosti;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Grids, StdCtrls,
  ExtCtrls,Printers, Controls, ComCtrls,Dialogs;

type
  TFVidomostiForm = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    MTV1: TTreeView;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SGrid: TStringGrid;
    StringGrid1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MTV1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure MTV1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVidomostiForm: TFVidomostiForm;
implementation
Uses uData, uMainForm;
{$R *.dfm}

procedure TFVidomostiForm.FormShow(Sender: TObject);
var s,s1:string;
  m:integer;
  ml,ml1:^TStrings;
begin
  MTV1.Items.Clear;
  DateTimePicker1.DateTime:=Now;
  New(ml);
  New(ml1);
  ml^:=TStringList.Create;
  ml1^:=TStringList.Create;
  ml^.Text:=MC.mySQLf('select inf,suma from opt where suma <>0 order by inf DESC',1);
  For m:=0 to ml^.Count-1 do
    MTV1.Items.AddFirst(MTV1.Items.GetFirstNode,ml^.Names[m]+' [ '+ml^.ValueFromIndex[m]+' ]').StateIndex:=MC.mySQLi('select id from opt where inf ='''+ml^.Names[m]+'''');



  s:=MC.mySQLs('select sum(suma) from opt where suma >0');
  if s = '' Then s:='0';
  Label1.Caption:='Заборгованість: '+ s;
  s1:=MC.mySQLs('select sum(suma) from opt where suma <0');
  if s1 = '' Then s1:='0';
  Label2.Caption:='Переплата: '+s1;
  Label3.Caption:='Баланс: '+ FloatToStrF((StrToFloat(s1)+StrToFloat(s)),ffFixed,7,2);;
  DateTimePicker1Change(Sender);
  ml^.free;
  ml1^.free;
  Dispose(ml);
  Dispose(ml1);

end;

procedure TFVidomostiForm.DateTimePicker1Change(Sender: TObject);
begin
  if CheckBox1.Checked then MC.mySQLg(StringGrid1,'Select * from foper order by data')
    else  MC.mySQLg(StringGrid1,'Select * from foper Where data ='''+FormatDateTime('yyyy.mm.dd', DateTimePicker1.Date)+''' order by data, time');
end;

procedure TFVidomostiForm.CheckBox1Click(Sender: TObject);
begin
  DateTimePicker1Change(Sender);
end;

procedure TFVidomostiForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TFVidomostiForm.FormCreate(Sender: TObject);
begin
  DateTimePicker1.Date:=MD;
end;

procedure TFVidomostiForm.MTV1Click(Sender: TObject);
begin
  MC.mySQLg(SGrid,'Select oper,suma,data from foper where id='''+IntToStr(MTV1.Selections[0].StateIndex)+''' order by data desc');
end;

procedure TFVidomostiForm.MTV1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if pos('-',Node.Text)=0 then MTV1.Canvas.Font.Color:=clred;
end;

end.
