unit uInputClients;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls,Dialogs, ComCtrls;

type
  TInputDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit2: TComboBox;
    Button5: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    RadioButton1: TRadioButton;
    LabeledEdit4: TLabeledEdit;
    RadioButton2: TRadioButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    Button1: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Timer1: TTimer;
    LabeledEdit8: TLabeledEdit;
    procedure Button5Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure LabeledEdit8KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit8Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InputDlg: TInputDlg;

implementation

uses uSQL_Func,uData, uNProdaja,uMainForm,uCommPort;

{$R *.dfm}

procedure TInputDlg.Button1Click(Sender: TObject);
begin
  if ComboBox1.Text<>'' Then Begin
    if MC.mySQLs('Select CardID from clients where CardID='''+ComboBox1.Text+'''')='' then
    MC.MyEx('Insert into clients (PIP,ld,CardID,Tel,email,dr,adres,Inf,suma) values ('''+
      LabeledEdit5.text+''',Now(),'''+ComboBox1.Text+''','''+LabeledEdit7.text+''','''+
      LabeledEdit9.text+''','''+FormatDateTime('yyyy.mm.dd',DateTimePicker1.Date)+''','''+
      LabeledEdit10.text+''','''+LabeledEdit6.text+''','+FloatSTSQL(LabeledEdit8.text)+')') else
    MC.MyEx('Update clients set PIP='''+LabeledEdit5.text+''', Tel ='''+LabeledEdit7.text+''',email='''+
      LabeledEdit9.text+''',adres='''+LabeledEdit10.text+''',dr='''+FormatDateTime('yyyy.mm.dd',DateTimePicker1.Date)+
      ''',inf='''+LabeledEdit6.text+''' ,suma='+FloatSTSQL(LabeledEdit8.text)+' Where CardId='''+ComboBox1.Text+'''');
  End;
end;
procedure TInputDlg.ComboBox1Change(Sender: TObject);
Var s:string;
begin
  LabeledEdit5.text:=MC.mySQLs('Select pip from clients where CardID='''+ComboBox1.Text+'''');
  LabeledEdit7.text:=MC.mySQLs('Select tel from clients where CardID='''+ComboBox1.Text+'''');
  LabeledEdit9.text:=MC.mySQLs('Select email from clients where CardID='''+ComboBox1.Text+'''');
  s:=MC.mySQLs('Select DATE_FORMAT(dr,''%d.%m.%Y'') from clients where CardID='''+ComboBox1.Text+'''');
  if s<>'' Then DateTimePicker1.Date:=StrToDate(s) else DateTimePicker1.Date:=Now;
  LabeledEdit10.text:=MC.mySQLs('Select adres from clients where CardID='''+ComboBox1.Text+'''');
  LabeledEdit6.text:=MC.mySQLs('Select inf from clients where CardID='''+ComboBox1.Text+'''');
  LabeledEdit8.text:=MC.mySQLs('Select suma from clients where CardID='''+ComboBox1.Text+'''');
end;
procedure TInputDlg.Button5Click(Sender: TObject);
begin
  if (Edit2.Text<>'') Then Begin
    MC.MyEx('INSERT INTO opt (id,Inf,PIP) values('+MC.mySQLs('SELECT MAX(id)+1 from opt')+','''+Edit2.Text+''','''+LabeledEdit1.text +''')');
    ShowMessage(MC.LastError);
  End;
End;

procedure TInputDlg.FormActivate(Sender: TObject);
begin
  If (ComName<>'') and (ComName<>'None') Then Timer1.Enabled:=True;
end;

procedure TInputDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Free;
  MainMForm.SetFocus;
end;

procedure TInputDlg.FormCreate(Sender: TObject);
begin
  Edit2.Items.Text:=MC.mySQLf('Select inf From opt',Row_s);
  Edit2.Text:=Edit2.Items[0];
  ComboBox1.Items.Text:=MC.mySQLf('Select CardId From clients',Row_s);
end;

procedure TInputDlg.FormDeactivate(Sender: TObject);
begin
  Timer1.Enabled:=False;
end;

procedure TInputDlg.LabeledEdit8Exit(Sender: TObject);
begin
  LabeledEdit8.text:=FloatSTS(LabeledEdit8.text);
end;

procedure TInputDlg.LabeledEdit8KeyPress(Sender: TObject; var Key: Char);
var                                          //цифрова€ маска
  vrPos,vrLength,vrSelStart : byte;
const
  I : byte=1; //I+1 = количество знаков после зап€той (в данном случае - 2 знака)
begin
  With Sender as TLabeledEdit do begin
    vrLength:=Length(Text); //определ€ем длину текста
    vrPos:=Pos(',', Text); //провер€ем наличие зап€той
    vrSelStart:=SelStart; //определ€ем положение курсора
    end;
  Case Key of
    '0'..'9' : begin //провер€ем положение курсора и количество знаков после зап€той
      If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos) then Key:=#0; //"погасить" клавишу
      end;
    ',','.' : begin //если зап€та€ уже есть или зап€тую пытаютс€ поставить перед числом или никаких цифр в поле ввода еще нет
      If (vrPos>0)or(vrSelStart=0)or(vrLength=0)then Key:=#0 //"погасить" клавишу
        else Key:=#44; //всегда замен€ть точку на зап€тую
      end;
    #8 : ; //позволить удаление знаков клавишей 'Back Space'
    else Key := #0; //"погасить" все остальные клавиши
  end;
end;

procedure TInputDlg.OKBtnClick(Sender: TObject);
Var
  tmp:^string;
begin
  New(tmp);
  tmp^:=MC.mySQLs('Select inf from opt Where inf='''+Edit2.Text+'''');
  if (Edit2.Text='') or (tmp^='') Then ShowMessage('¬вед≥ть оптовика') else Begin
    FNP:=TFNP.Create(Application);
    FNP.ComboBox1.Items.Text:=MC.mySQLf('Select inf From opt',Row_s);
    FNP.ComboBox1.ItemIndex:=FNP.ComboBox1.Items.IndexOf(tmp^);
    FNP.ComboBox1.Text:=tmp^;
    FNP.Edit10.Text:=MC.mySQLs('Select suma from opt Where inf='''+tmp^+'''');
    tmp^:=MC.mySQLs('Select suma from opt Where inf='''+ComboBox1.Text+'''');
    if (tmp^<>'0')
      and (tmp^<>'')
      Then FNP.Label10.Caption:='ѕопередн≥й борг: '+tmp^+'$'
      else FNP.Label10.Caption:='';
    With FNP do begin
      IPN.Visible:=True;
      IPN.Text:=IntToStr(MC.mySQLi('Select max(IP) From Oper Where oper = ''ѕродажа''')+1);
      rb3.Checked:=True;
      Caption:='√урт ['+IPN.Text+'] '+Edit2.Text;
      MainMForm.TabSet.Tabs.Add(Caption);
      MainMForm.TabSet.TabIndex:=MainMForm.TabSet.Tabs.IndexOf(Caption);
    end;
    Free;
  end;
  Dispose(tmp);
end;
procedure TInputDlg.Timer1Timer(Sender: TObject);
var s:string;
begin
  ReadCommStr(s);
  if s<> '' Then Begin
  if s[Length(s)]=#13 then s:=Copy(s,1,Length(s)-1);
  ComboBox1.Text:=s;
  ComboBox1Change(ComboBox1);
  end;
end;

procedure TInputDlg.CancelBtnClick(Sender: TObject);
begin
  Free;
end;



end.
