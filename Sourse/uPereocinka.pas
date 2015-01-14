unit uPereocinka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,Math, ExtCtrls, Grids,IniFiles;

type
  TPereocinkaForm = class(TForm)
    Button1: TButton;
    HeaderControl1: THeaderControl;
    HeaderControl2: THeaderControl;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    ListBox1: TListBox;
    RadioGroup1: TRadioGroup;
    LabeledEdit1: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MyKeyPress(Sender: TObject; var Key: Char);
    procedure ListBox1Click(Sender: TObject);
    procedure LabeledEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioGroup1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PereocinkaForm: TPereocinkaForm;
  ind,ind1,ID: string;

implementation

{$R *.dfm}
uses uData, uMainForm;

procedure TPereocinkaForm.FormCreate(Sender: TObject);
begin
  MyIni:= TIniFile.Create(CurrentPatch+'\option.ini');
  LabeledEdit1.Text:=MyIni.ReadString('Main','MinMj','0,00');
  MyIni.Free;
  ComboBox1.Items.Text:=MC.mySQLf('Select Nazva from gg',1);
  ListBox1.Items.Text:=ComboBox1.Items.Text;
  ComboBox2.Enabled:=False;
  Button1.Enabled:=False;
  RadioGroup1.ItemIndex:=0;
end;


procedure TPereocinkaForm.LabeledEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then Begin
    MyIni:= TIniFile.Create(CurrentPatch+'\option.ini');
    MyIni.WriteString('Main','MinMj',LabeledEdit1.Text);
    MyIni.Free;
    End;
end;

procedure TPereocinkaForm.ListBox1Click(Sender: TObject);
Var GGID:string;
begin
  if ListBox1.ItemIndex<0 then exit;
  
  GGID:=MC.mySQLs('Select ID from gg Where Nazva = '''+ListBox1.Items[ListBox1.ItemIndex]+'''');
  if RadioGroup1.ItemIndex =0 Then
    MC.mySQLg(StringGrid1,'Select Tip,Cina,Ocina,Zcina,(Cina-(ZCina*'+FloatTSQL(Kurs)+')) as Mj From types where ggid='''+GGID+''' order by tip' )
    Else MC.mySQLg(StringGrid1,'Select Tip,Cina,Ocina,Zcina,(Cina-(ZCina*'+FloatTSQL(Kurs)+')) as Mj From types where ggid='''+GGID+''' order by mj' );
end;

procedure TPereocinkaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TPereocinkaForm.ComboBox1Change(Sender: TObject);
Var  m,t,l:integer;
  ml:^TStrings;
begin
  HeaderControl2.Sections[0].Text:=ComboBox1.Items.Strings[ComboBox1.ItemIndex];
  ind:=MC.mySQLs('Select ID from gg Where Nazva = '''+HeaderControl2.Sections[0].Text+'''');
  ComboBox2.Enabled:=true;
  ComboBox2.Items.Text:=MC.mySQLf('Select Tip from types where ggid='''+ind+'''',1);
  if Panel1.ComponentCount = 0 Then Begin
    New(ml);
    ml^:=TStringList.Create;
    ml^.Text:=MC.mySQLf('DESCRIBE types',1);
    l:=0;
    t:=0;
    For m:= 0 to ml^.Count-1 do with TLabeledEdit.Create(Panel1) do begin
      Left := 10+l;
      Top := 20+(t*40);
      Width := 150;
      Height := 17;
      Name := 'LE' + IntToStr(m);
      EditLabel.Caption := ml^.Names[m];
      if pos(ml^.ValueFromIndex[m],'double,float')<>0 Then OnKeyPress:=MyKeyPress;
      Text:='';
      Parent := Panel1;
      if (EditLabel.Caption = 'ID')or (EditLabel.Caption = 'Tip') or (EditLabel.Caption = 'GGID') Then Enabled:=False;
      inc(t);
      if (20+(t*40)+Height)>Panel1.Height then Begin  // 
        t:=0;
        l:=l+170;
        Panel1.Width:=Panel1.Width*2;
        End;
      end;
    Button1.Top:=20+Panel1.Top;
    Button1.Left := 10+l+170;
    ml^.Free;
    Dispose(ml);
    End;
end;

procedure TPereocinkaForm.ComboBox2Change(Sender: TObject);
Var m:integer;
  ml:^TStrings;
begin
  HeaderControl2.Sections[1].Text:=ComboBox2.Items.Strings[ComboBox2.ItemIndex];
  New(ml);
  ml^:=TStringList.Create;
  ml^.Text:=MC.mySQLf('Select * from types where ggid='''+ind+''' and Tip='''+HeaderControl2.Sections[1].Text+'''');
  For m:= 0 to  ml^.Count-1 do TLabeledEdit(Panel1.Components[m]).Text:= ml^.ValueFromIndex[m];
  Button1.Enabled:=True;
  ml^.Free;
  Dispose(ml);
end;

procedure TPereocinkaForm.Button1Click(Sender: TObject);
Var
  m:integer;
  ft: string;
begin
  if HeaderControl2.Sections[1].Text <>'' Then Begin
    ft:='';
    For m:= 0 to Panel1.ComponentCount-1 do with TLabeledEdit(Panel1.Components[m]) do
      if(EditLabel.Caption<>'ID')and(EditLabel.Caption<>'Tip')and(EditLabel.Caption<>'GGID') Then
          ft:=cc(ft)+EditLabel.Caption+'='+FloatSTSQL(Text);
    // ---- Зміна ціни в таблиці типу -------------
    MC.MyEx('update types set '+ft+' Where Tip='''+HeaderControl2.Sections[1].Text+''' and ggid='''+ind+'''');
    // ---- Зміна ціни в таблиці Склад -------------
    MC.MyEx('update '+TSName+' SET cina=getcina(misce,id,'''') Where Tip='''+HeaderControl2.Sections[1].Text+''' and id like '''+ind+'%''');
    StatusBar1.Panels[0].Text:=MC.LastError;
    End;
  // --------------------------------------------

End;


procedure TPereocinkaForm.MyKeyPress(Sender: TObject; var Key: Char);
var                                          
  vrPos,vrLength,vrSelStart : byte;//цифровая маска
const
  I : byte=1; //I+1 = количество знаков после запятой (в данном случае - 2 знака)
begin

  With Sender as TLabeledEdit do begin
    vrLength:=Length(Text); //определяем длину текста
    vrPos:=Pos(',', Text); //проверяем наличие запятой
    vrSelStart:=SelStart; //определяем положение курсора
    end;

  Case Key of
    '0'..'9' ://проверяем положение курсора и количество знаков после запятой
      If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos)then Key:=#0; //"погасить" клавишу
    ',','.' ://если запятая уже есть или запятую пытаются поставить перед числом или никаких цифр в поле ввода еще нет
      If (vrPos>0)or(vrSelStart=0)or(vrLength=0)then Key:=#0 //"погасить" клавишу
        else Key:=#44; //всегда заменять точку на запятую
    #8 : ; //позволить удаление знаков клавишей 'Back Space'
    else Key := #0; //"погасить" все остальные клавиши
    end;
end;
procedure TPereocinkaForm.RadioGroup1Click(Sender: TObject);
begin
  ListBox1Click(ListBox1);
end;

procedure TPereocinkaForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  With StringGrid1 do With Canvas do
    if (ACol=5) and (ARow>0) and (Cells[ACol,ARow]<>'') and (StrToFloat(Cells[ACol,ARow])<StrToFloat(LabeledEdit1.Text))then Begin //
    Canvas.Font.Color := clRed;
    //clSkyBlue;
    FillRect(Rect);
    TextOut(Rect.Left+5,Rect.Top+5,Cells[ACol,ARow]);
  End;
  
end;

end.

