unit uFOper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFOperForm = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOperForm: TFOperForm;

implementation

uses uData, uMainForm;


{$R *.dfm}

procedure TFOperForm.LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
var
  vrPos,vrLength,vrSelStart : byte;
const
  I : byte=1;
begin
  With Sender as TLabeledEdit do
begin
  vrLength:=Length(Text);
  vrPos:=Pos(',', Text);
  vrSelStart:=SelStart;
end;
  Case Key of
    '0'..'9': If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos)then Key:=#0;
    ',','.' : If (vrPos>0)or(vrSelStart=0)or(vrLength=0) then Key:=#0 else Key:=#44;
    #8 :;
    else Key := #0;
  end;
end;

procedure TFOperForm.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Items.Clear;
  if (ComboBox1.Text='Заборгованість')or(ComboBox1.Text='Погашення боргу') Then Begin
    ComboBox2.Enabled:=True;
    Label1.Enabled:=True;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Text:=MC.mySQLf('Select distinct inf from opt order by inf',1);
  End Else Begin
    ComboBox2.Enabled:=False;
    Label1.Enabled:=False;
  End;
end;

procedure TFOperForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Free;
  MainMForm.SetFocus;
end;

procedure TFOperForm.Button1Click(Sender: TObject);
begin
  if StrToFloat(LabeledEdit2.Text)= 0 Then ShowMessage('Сума Дорівнює ''0''')
  Else if (ComboBox1.Text='') Then ShowMessage('Введіть операцію')
  Else if (ComboBox1.Text='Інше') and (LabeledEdit1.Text='') Then ShowMessage('Введіть додаткову інформацію')
  Else if ((ComboBox1.Text='Заборгованість')or(ComboBox1.Text='Погашення боргу')) and (ComboBox2.Text='')Then ShowMessage('Введіть клієнта')
  Else Begin
    if ((ComboBox1.Text='Заборгованість')or(ComboBox1.Text='Погашення боргу')) Then Begin
      if (ComboBox1.Text='Заборгованість') Then
      if RadioButton2.Checked Then
        MC.MyEx('update opt set suma ='+FloatSTSQL(FloatToStrF(StrToFloat(MC.mySQLs('Select suma from opt where inf='''+ComboBox2.Text+''''))+StrToFloat(LabeledEdit2.Text),ffFixed,7,2))+' where inf='''+ComboBox2.Text+'''')
      Else MC.MyEx('update opt set suma ='+FloatSTSQL(FloatToStrF(StrToFloat(MC.mySQLs('Select suma from opt where inf='''+ComboBox2.Text+''''))+StrToFloat(LabeledEdit2.Text)/Kurs,ffFixed,7,2))+' where inf='''+ComboBox2.Text+'''')
      else if RadioButton2.Checked Then
      MC.MyEx('update opt set suma ='+FloatSTSQL(FloatToStrF(StrToFloat(MC.mySQLs('Select suma from opt where inf='''+ComboBox2.Text+''''))-StrToFloat(LabeledEdit2.Text),ffFixed,7,2))+' where inf='''+ComboBox2.Text+'''')
      Else MC.MyEx('update opt set suma ='+FloatSTSQL(FloatToStrF(StrToFloat(MC.mySQLs('Select suma from opt where inf='''+ComboBox2.Text+''''))-StrToFloat(LabeledEdit2.Text)/Kurs,ffFixed,7,2))+' where inf='''+ComboBox2.Text+'''');
      End;
    if ((ComboBox1.Text='Заборгованість')or(ComboBox1.Text='Погашення боргу')) Then LabeledEdit1.Text:=LabeledEdit1.Text+' '+ComboBox2.Text;
    if (RadioButton1.Checked) and (not ((ComboBox1.Text='Погашення боргу')or(ComboBox1.Text='Інші доходи'))) Then LabeledEdit2.Text:='-'+LabeledEdit2.Text;
    if RadioButton2.Checked Then
      if (ComboBox1.Text='Погашення боргу')or(ComboBox1.Text='Інші доходи') Then
        LabeledEdit2.Text:=FloatToStrF((StrToFloat(LabeledEdit2.Text)*Kurs),ffFixed,7,2)
        Else LabeledEdit2.Text:='-'+FloatToStrF((StrToFloat(LabeledEdit2.Text)*Kurs),ffFixed,7,2);
        MC.MyEx('insert into foper (Oper,Inf,Suma,Data,User,Misce,ID) values('''+ComboBox1.Text+''','''+kil2p(LabeledEdit1.Text)+''','
      +FloatSTSQL(LabeledEdit2.Text)+','''+FormatDateTime('yyyy.mm.dd',MD)+' '+FormatDateTime('hh:nn:ss',Time)+''','''+User+''','''+DefMisce+''','''+
      MC.mySQLs('Select id from opt where inf='''+ComboBox2.Text+'''')+''')');
    ComboBox2.Text:='';
    LabeledEdit1.Text:='';
    close;
  End;
end;

procedure TFOperForm.LabeledEdit2Exit(Sender: TObject);
begin
  LabeledEdit2.Text:=FloatToStrF((StrToFloat(LabeledEdit2.Text)),ffFixed,7,2);
end;
end.
