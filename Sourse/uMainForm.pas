unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Menus, Tabs, ComCtrls, ExtCtrls, ToolWin,Registry,
  Math,ShellAPI, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient;

type
  TMainMForm = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TabSet: TTabSet;
    MMenu: TMainMenu;
    Menu2: TMenuItem;
    Menu2_1: TMenuItem;
    NS: TMenuItem;
    MyIL: TImageList;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    Timer1: TTimer;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton15: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    Menu1: TMenuItem;
    N2: TMenuItem;
    Menu3: TMenuItem;
    N3: TMenuItem;
    ToolButton22: TToolButton;
    N1: TMenuItem;
    ToolButton5: TToolButton;
    N4: TMenuItem;
    N5: TMenuItem;
    x1: TMenuItem;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    N6: TMenuItem;
    DBSave: TMenuItem;
    ToolButton27: TToolButton;
    N7: TMenuItem;
    N8: TMenuItem;
    ToolButton28: TToolButton;
    Log1: TMenuItem;
    ToolBar2: TToolBar;
    ComboBox1: TComboBox;
    DP: TDateTimePicker;
    ToolBar3: TToolBar;
    Edit1: TEdit;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    Menu4: TMenuItem;
    ToolBar4: TToolBar;
    procedure PassCheck;
    procedure DostupCheck;
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabSetClick(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure EMKPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Timer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure DPChange(Sender: TObject);
    procedure CoolBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainMForm: TMainMForm;
  ls:TTime;
implementation
uses uSQL_Func,uData, uNProdaja, uInputClients, uSearchForm, uOrdersForm,
  uOrderForm, uPermiscenia, uSMenegerForm, uProdaja, uOperVidomosti,
  uSetingsForm,uCommPort, uVidacha, uAProvedenia, uOptCalculate, uAZamovlenia,
  uVidomosti, uFOper, uFVidomosti, uStruct, uPrintForm, uPereocinka,
  uNewZnacenia, uFTP, uLog, uLablesForm;

{$R *.dfm}

procedure TMainMForm.PassCheck;
Var
  sm:^string;
  ml:^TStrings;
  i:integer;
begin
  if MC.mySQLc('Select User from Users Where Pass ='''+Password+'''')=1 then Begin
    New(sm);
    New(ml);
    ml^:=TStringList.Create;
    User:=MC.mySQLs('Select User from Users Where Pass ='''+Password+'''');
    sm^:= MC.mySQLs('Select Misce From Users Where User ='''+User+'''');
    ml^.Text:=MC.mySQLf('Select ID,Misce From Misce order by ID',1);
    ComboBox1.Clear;
    for i:= 0 to length(sm^) do Begin
      if (sm^[i]='1') and (ml^.Values[Copy('00',1,2-length(inttostr(i)))+inttostr(i)]<>'') Then ComboBox1.Items.Add(ml^.Values[Copy('00',1,2-length(inttostr(i)))+inttostr(i)]);
      End;
    if ComboBox1.Items.Count>0 then ComboBox1.Text:=ComboBox1.Items[0];
    if ComboBox1.Items.Count>0 then DefMisce:=ComboBox1.Items[0];

    sm^:=MC.mySQLs('Select dm From Users Where User ='''+User+'''');
    sm^:=MC.mySQLs('Select Misce From Misce Where ID ='''+sm^+'''');
    if ComboBox1.Items.IndexOf(sm^)<>-1 then DefMisce:=sm^;

    //Misce:=ml^.Values[mySQLs('Select dm from Users Where Pass ='''+Password.Text+'''')];
    Caption:='Meneger ['+User+']-['+DefMisce+']';
    //TB2.Visible:=False;
    //TB1.Visible:=True;
    Password:='';
    //TBar3.Width:=10;
    Dispose(ml);
    Dispose(sm);
    DostupCheck;
    End;
end;

procedure TMainMForm.CoolBar1Change(Sender: TObject);
Var i:integer;
begin
  for i := 0 to CoolBar1.Bands.Count - 1 do With CoolBar1.Bands[i] do
    if Control.Width<MinWidth then Width:=Control.Width
      else Width:=MinWidth;//MinWidth;
  CoolBar1.Repaint;
end;

procedure TMainMForm.DostupCheck;
Var
  buf:^string;
  i:integer;
begin
  New(buf);
  buf^:= MC.mySQLs('Select dostup From Users Where User ='''+User+'''');
  For i:= 1 to length(buf^) do case i of
    1: if buf^[i]='1' then Begin
      //ToolButton2.Visible:=True; //----------------------------Є в наявності---
      ToolButton11.Visible:=True;
      ToolButton13.Visible:=True; //------------------------------Переміщення---
      ToolButton18.Visible:=True; //----------------------------------Роздріб---
      ToolButton19.Visible:=True; //---------------------------------Операції---
      ToolButton20.Visible:=True;  //-------------------------------Повернення---
      ToolButton25.Visible:=True;  //----------------------Фінансові операції---
      end else Begin
      //ToolButton2.Visible:=False; //----------------------------Є в наявності---
      ToolButton11.Visible:=False;
      ToolButton13.Visible:=False;//------------------------------Переміщення---
      ToolButton18.Visible:=False;//----------------------------------Роздріб---
      ToolButton19.Visible:=False;//---------------------------------Операції---
      ToolButton20.Visible:=False;//-------------------------------Повернення---
      ToolButton25.Visible:=False;//-----------------------Фінансові операції---
      End;
    2: if buf^[i]='1' then Begin
      ToolButton1.Visible:=True;  //-------------------------------------Гурт---
      end else Begin
      ToolButton1.Visible:=False; //-------------------------------------Гурт---
      End;
    3: if buf^[i]='1' then Begin
      ToolButton5.Visible:=True;  //-----------------------------------Видача---
      end else Begin
      ToolButton5.Visible:=False; //-----------------------------------Видача---
      End;
    5: if buf^[i]='1' then Begin
      ToolButton21.Visible:=True;  //------------------------------------Auto---
      end else Begin
      ToolButton21.Visible:=False; //------------------------------------Auto---
      End;
    6: if buf^[i]='1' then Begin
      ToolButton27.Visible:=True;  //------------------------------------Друк---
      end else Begin
      ToolButton27.Visible:=False; //------------------------------------Друк---
      End;
    7: if buf^[i]='1' then Begin
      ToolButton26.Visible:=True;  //---------------------------Друк етикеток---
      end else Begin
      ToolButton26.Visible:=False; //---------------------------Друк етикеток---
      End;
    8: if buf^[i]='1' then Begin
      ToolButton22.Visible:=True;
      Menu1.Visible:=True;
      Menu2.Visible:=True;
      
      end else Begin
      ToolButton22.Visible:=False;
      Menu1.Visible:=False;
      Menu2.Visible:=False;

      End;
    9: if buf^[i]='1' then Begin
      ToolButton6.Visible:=True;
      ToolButton8.Visible:=True;
      ToolButton9.Visible:=True;
      ToolButton10.Visible:=True; //------------------------------------Опції---
      ToolButton12.Visible:=True;
      ToolButton28.Visible:=True;
      Menu3.Visible:=True;
      end else Begin
      ToolButton6.Visible:=False;
      ToolButton8.Visible:=False;
      ToolButton9.Visible:=False;
      ToolButton10.Visible:=False;//------------------------------------Опції---
      ToolButton12.Visible:=False;
      ToolButton28.Visible:=False;
      Menu3.Visible:=False;
      End;
    End;
  Dispose(buf);
end;

procedure TMainMForm.ComboBox1Change(Sender: TObject);
begin
  With TComboBox(Sender) do Begin
    DefMisce:=Items.Strings[ItemIndex];
    Caption:='Meneger ['+User+']-['+DefMisce+']';
    End;
end;





procedure TMainMForm.DPChange(Sender: TObject);
begin
  MD:=DP.Date;
  MDS:=FormatDateTime('yyyy.mm.dd',MD);  
end;

procedure TMainMForm.Edit1Change(Sender: TObject);
Var
  Reg: TRegistry;
begin
  if length (Edit1.Text)=4 Then Begin
    Kurs:=StrToFloat(Edit1.Text);
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('\Software\SLine\Meneger', True);
    Reg.WriteString('Kurs',Edit1.Text);
    Reg.CloseKey;
    Reg.Free;
    End;
end;

procedure TMainMForm.Edit1DblClick(Sender: TObject);
begin
  Edit1.ReadOnly:=False;
end;

procedure TMainMForm.Edit1Exit(Sender: TObject);
begin
  Edit1.ReadOnly:=True;
end;

procedure TMainMForm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then Edit1.ReadOnly:=True;
end;

procedure TMainMForm.EMKPress(Sender: TObject; var Key: Char);
var                                          //цифровая маска
  vrPos,vrLength,vrSelStart : byte;
const
  I : byte=1; //I+1 = количество знаков после запятой (в данном случае - 2 знака)
begin
  if sender is TEdit then With TEdit(Sender) do begin
    vrLength:=Length(Text); //определяем длину текста
    vrPos:=Pos(',', Text); //проверяем наличие запятой
    vrSelStart:=SelStart; //определяем положение курсора
    Case Key of
      '0'..'9' ://проверяем положение курсора и количество знаков после запятой
        If (vrPos>0)and(vrLength-vrPos>I)and(vrSelStart>=vrPos) then Key:=#0; //"погасить" клавишу
      ',','.' ://если запятая уже есть или запятую пытаются поставить перед числом или никаких цифр в поле ввода еще нет
        If (vrPos>0)or(vrSelStart=0)or(vrLength=0)then Key:=#0 //"погасить" клавишу
          else Key:=#44; //всегда заменять точку на запятую
      #8 : ; //позволить удаление знаков клавишей 'Back Space'
      else Key := #0; //"погасить" все остальные клавиши
      end;
    end;
end;

procedure TMainMForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseMC;
  if Pings<>nil then Pings.Free;

  CloseComm;
end;



procedure TMainMForm.FormCreate(Sender: TObject);
Var
  Reg: TRegistry;
begin
  Width:=screen.Width;

  if PingResult and IsLanConnect then Begin
    ToolButton8.Click;


  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\SLine\Meneger', True);
  if Reg.ValueExists('Kurs') then Edit1.Text:=Reg.ReadString('Kurs')
    else Reg.WriteString('Kurs',Edit1.Text);
  if Reg.ValueExists('Comm') then ComName:=Reg.ReadString('Comm');
  PortInit;
  if reg.ValueExists('Server') then NS.Checked:=Reg.ReadBool('Server');
  Reg.CloseKey;
  Reg.Free;
  //
  Kurs:=StrToFloat(Edit1.Text);
  if (ParamCount > 0) and (UpperCase(ParamStr(1)) = '/L') then local:=True
    Else local:=False;
  DP.Date:=Now;
  MD:=DP.Date;
  MDS:=FormatDateTime('yyyy.mm.dd',MD);
  //Prov('00000000');
  //if Komm<>'0' Then TM1.Enabled:=True;
  Timer1.Enabled:=True;
    End;
end;

procedure TMainMForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  Searchrec:Tsearchrec;
  f: TextFile;
  disc:char;
  s,discname:string;
begin
  if (Key = VK_F1) and (ssCtrl in Shift) and (not mc.Connected) Then Begin
    MC.SetOption(dc);
    //Ping;
    End;

  s:='';
  if (Key = VK_F2) and (MC.Connected) Then
    for disc:='c' to 'z' do begin
      discname:=disc+':';
      if (GetDriveType(pchar(discname))=DRIVE_FIXED) or ( GetDriveType(pchar(discname))=DRIVE_REMOVABLE ) then
        if FindFirst(PChar(discname+'\manager.key'), FaAnyfile, SearchRec)=0 then s:=discname+'\'+SearchRec.Name;
      end;
  if s<>'' Then Begin
    AssignFile (f,PChar(s));
    Reset(f);
    Readln(f,s);
    Password := s;
    Closefile(f);
    PassCheck;
    end;
end;

procedure TMainMForm.MenuClick(Sender: TObject);
Var
  m:integer;
  T:^TStrings;
  Reg: TRegistry;
begin
  With Sender as TMenuItem do Begin
    case tag of
      221: Begin
        Checked:= not Checked;
        Reg := TRegistry.Create;
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.OpenKey('\Software\SLine\Meneger', True);
        Reg.WriteBool('Server',Checked);
        Reg.CloseKey;
        Reg.Free;
        End;
      11: if Application.FindComponent('StructForm') = nil Then Begin
        StructForm:=TStructForm.Create(Application);
        StructForm.Align:=alClient;
        TabSet.Tabs.Add(StructForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(StructForm.Caption);
        end Else Begin
        StructForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(StructForm.Caption);
        End;
      12: if Application.FindComponent('VidomostiForm') = nil Then Begin
        VidomostiForm:=TVidomostiForm.Create(Application);
        VidomostiForm.Align:=alClient;
        TabSet.Tabs.Add(VidomostiForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(VidomostiForm.Caption);
        end Else Begin
        VidomostiForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(VidomostiForm.Caption);
        End;
      13:if MessageDlg('Ви дійсно бажаєте очистити Корзину',mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then MC.MyEx('Delete from '+TSName+' where misce=''x'' or misce=''''');
      14: if Application.FindComponent('FVidomostiForm') = nil Then Begin
        FVidomostiForm:=TFVidomostiForm.Create(Application);
        FVidomostiForm.Align:=alClient;
        TabSet.Tabs.Add(FVidomostiForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FVidomostiForm.Caption);
        end Else Begin
        FVidomostiForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FVidomostiForm.Caption);
        End;
      15: if Application.FindComponent('PereocinkaForm') = nil Then Begin
        PereocinkaForm:=TPereocinkaForm.Create(Application);
        PereocinkaForm.Align:=alClient;
        TabSet.Tabs.Add(PereocinkaForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(PereocinkaForm.Caption);
        end Else Begin
        PereocinkaForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(PereocinkaForm.Caption);
        End;
      16: if Application.FindComponent('NewZnaceniaForm') = nil Then Begin
        NewZnaceniaForm:=TNewZnaceniaForm.Create(Application);
        NewZnaceniaForm.Align:=alClient;
        TabSet.Tabs.Add(NewZnaceniaForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(NewZnaceniaForm.Caption);
        end Else Begin
        NewZnaceniaForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(NewZnaceniaForm.Caption);
        End;
      22:if NS.Checked Then Begin
        New(T);
        T^:=TStringList.Create;
        T^.Text:=MC.mySQLf ('SHOW TABLES FROM '+MC.FOptions.DB,1);
        For m:= 0 to T^.Count-1 do if T^.Strings[m] <>'склад' Then begin
          deletefile('c:\mysql\data\tmp\'+PChar(T^.Strings[m])+'.sav');
          MC.MyEx('select * into outfile ''tmp/'+T^.Strings[m]+'.sav'' Fields Terminated by '','' optionally enclosed by ''"'' lines Terminated by ''\n'' from '+T^.Strings[m]);
          end Else begin
            deletefile('c:\mysql\data\tmp\sklad.sav');
            MC.MyEx('select * into outfile ''tmp/sklad'+'.sav'' Fields Terminated by '','' optionally enclosed by ''"'' lines Terminated by ''\n'' from '+T^.Strings[m]);
            end;
        ShellExecute(application.MainForm.Handle,nil,'winrar',PChar('m -ep -inul c:\mysql\data\tmp\'+PChar(FormatDateTime('ddmmyyhhnn',Now))+'.dat c:\mysql\data\tmp\*.sav'),'',SW_SHOWNORMAL);
        Dispose(T);
        End;
      23: if Application.FindComponent('LogForm') = nil Then Begin
        LogForm:=TLogForm.Create(Application);
        LogForm.Align:=alClient;
        TabSet.Tabs.Add(LogForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(LogForm.Caption);
        end Else Begin
        LogForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(LogForm.Caption);
        End;
      31: if Application.FindComponent('OptCalculateForm') = nil Then Begin
        OptCalculateForm:=TOptCalculateForm.Create(Application);
        OptCalculateForm.Align:=alClient;
        TabSet.Tabs.Add(OptCalculateForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OptCalculateForm.Caption);
        end Else Begin
        OptCalculateForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OptCalculateForm.Caption);
        End;
      32:if Application.FindComponent('AutoForm') = nil Then Begin//---Є в наявності
        AutoForm:=TAutoForm.Create(Application);
        AutoForm.Align:=alClient;
        TabSet.Tabs.Add(AutoForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(AutoForm.Caption);
        end Else Begin
        AutoForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(AutoForm.Caption);
        End;

      33:Begin
        //;
        End;
      end;
    End;

end;

procedure TMainMForm.TabSetClick(Sender: TObject);
Var i:integer;
begin
  if TabSet.TabIndex>=0 then
  for i := 0 to Application.ComponentCount - 1 do
    if (Application.Components[i] is TForm)
      and ((Application.Components[i] as TForm).Caption=TabSet.Tabs[TabSet.TabIndex]) then
        (Application.Components[i] as TForm).SetFocus;
end;

procedure TMainMForm.Timer(Sender: TObject);
var s:string;
Searchrec:Tsearchrec;
begin
  If (ComName<>'') and (ComName<>'None') and (User='') Then ReadCommStr(s);
  if s<>'' Then Begin
    if s[Length(s)]=#13 then s:=Copy(s,1,Length(s)-1);
    Password:=s;
    PassCheck;
    End;
  //if PM1.Checked then MrC.Ping;
  //if PM2.Checked then MC.Ping;
  if NS.Checked and mc.Connected  and (FormatDateTime('hh',Now)>FormatDateTime('hh',ls)) Then Begin
    ls:=now;
    if FindFirst(PChar('C:\MySQL\data\tmp\'+FormatDateTime('ddmmyyhh',Now)+'*.dat'), FaAnyfile, SearchRec)<>0 then
      DBSave.Click;
  End;
end;

procedure TMainMForm.ToolButtonClick(Sender: TObject);

begin

  With Sender as TToolButton Do Begin
    Case tag of
      2,3,4,7,10,18,21,22,27: if not MC.Connected Then exit;
      5,33,34: if not MrC.Connected Then exit;
    End;
  Case tag of
    2: if Application.FindComponent('SearchForm') = nil Then Begin//---Є в наявності
        SearchForm:=TSearchForm.Create(Application);
        SearchForm.Align:=alClient;
        TabSet.Tabs.Add(SearchForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(SearchForm.Caption);
      end Else Begin
        SearchForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(SearchForm.Caption);
        End;
        //------------------------------------------------
    //----------------------------------------------------------------Роздріб---
    3: if Application.FindComponent('ProdajaForm') = nil Then Begin
        ProdajaForm:=TProdajaForm.Create(Application);
        ProdajaForm.Align:=alClient;
        TabSet.Tabs.Add(ProdajaForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(ProdajaForm.Caption);
      end Else Begin
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(ProdajaForm.Caption);
        ProdajaForm.SetFocus;
        End;
    //--------------------------------------------------------------------------
    //------------------------------------------------------------Переміщення---
    4: if Application.FindComponent('FPM') = nil Then Begin
        FPM:=TFPM.Create(Application);
        FPM.Align:=alClient;
        TabSet.Tabs.Add(FPM.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FPM.Caption);
      end Else Begin
        FPM.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FPM.Caption);
        End;
    //--------------------------------------------------------------------------
    //------------------------------------------------------Користувачі сайту---
    5: if Application.FindComponent('SMForm') = nil Then Begin
        SMForm:=TSMForm.Create(Application);
        SMForm.Align:=alClient;
        TabSet.Tabs.Add(SMForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(SMForm.Caption);
      end Else Begin
        FPM.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FPM.Caption);
        End;
    //--------------------------------------------------------------------------
    //---------------------------------------------------------------Операції---
    7: if Application.FindComponent('OVForm') = nil Then Begin
        OVForm:=TOVForm.Create(Application);
        OVForm.Align:=alClient;
        TabSet.Tabs.Add(OVForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OVForm.Caption);
        OVForm.Button1.Visible:=ToolButton26.Visible;
        OVForm.Button2.Visible:=ToolButton27.Visible;

      end Else Begin
        OVForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OVForm.Caption);
        End;
    //--------------------------------------------------------------------------
    //------------------------------------------------------------------Опції---
    8: if Application.FindComponent('SetingsForm') = nil Then Begin
        SetingsForm:=TSetingsForm.Create(Application);
        SetingsForm.Align:=alClient;
        TabSet.Tabs.Add(SetingsForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(SetingsForm.Caption);
      end Else Begin
        SetingsForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(SetingsForm.Caption);
        End;
    //--------------------------------------------------------------------------

    //------------------------------------------------------------------Опції---
    9: if Application.FindComponent('InputDlg') = nil Then Begin
          InputDlg:=TInputDlg.Create(Application);
          InputDlg.PageControl1.Pages[0].Enabled:=False;
          InputDlg.PageControl1.Pages[1].Enabled:=True;
          InputDlg.PageControl1.ActivePageIndex:=1;
        end else InputDlg.SetFocus;
    //--------------------------------------------------------------------------
    //------------------------------------------------------------------Опції---
    10: if Application.FindComponent('VidachaForm') = nil Then Begin
          VidachaForm:=TVidachaForm.Create(Application);
          VidachaForm.Align:=alClient;
          VidachaForm.Caption:=Hint;
          VidachaForm.SpinEdit2.Value:=MC.mySQLi('Select max(ip) From Oper Where Oper='''+VidachaForm.Caption+
            '''and Misce ='''+DefMisce+''' and data ='''+mds+'''');
          TabSet.Tabs.Add(VidachaForm.Caption);
          TabSet.TabIndex:=TabSet.Tabs.IndexOf(VidachaForm.Caption);
        end else Begin
          VidachaForm.SetFocus;
          TabSet.TabIndex:=TabSet.Tabs.IndexOf(VidachaForm.Caption);
          TabSet.Tabs[TabSet.Tabs.IndexOf(VidachaForm.Caption)]:=Hint;
          VidachaForm.Caption:=Hint;
          End;
    //--------------------------------------------------------------------------
    18:Begin
        if Application.FindComponent('InputDlg') = nil Then Begin
          InputDlg:=TInputDlg.Create(Application);
          InputDlg.PageControl1.Pages[1].Enabled:=False;
          InputDlg.PageControl1.Pages[0].Enabled:=True;
          InputDlg.PageControl1.ActivePageIndex:=0;
          end
          else InputDlg.SetFocus;
      end;//--------------------------------------------------------------------
    21: if Application.FindComponent('AZamovleniaForm') = nil Then Begin//---Є в наявності
        AZamovleniaForm:=TAZamovleniaForm.Create(Application);
        AZamovleniaForm.Align:=alClient;
        TabSet.Tabs.Add(AZamovleniaForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(AZamovleniaForm.Caption);
      end Else Begin
        AZamovleniaForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(AZamovleniaForm.Caption);
        End;
        //------------------------------------------------
    22: Begin
      ComboBox1.Visible:=not ComboBox1.Visible;
      DP.Visible:=not DP.Visible;
      //
      //CoolBar1.
      //ToolBar2.Repaint;
      CoolBar1.Bands[1].Width:=CoolBar1.Bands[1].minwidth;
      CoolBar1.Repaint;
      //ToolButton16.Visible:=not ToolButton16.Visible;
      //ToolButton23.Visible:=not ToolButton23.Visible;
      //ToolButton24.Visible:=not ToolButton24.Visible;
      End;
    25:if Application.FindComponent('FOperForm') = nil Then
      FOperForm:=TFOperForm.Create(Application)
      else FOperForm.SetFocus;
    26:if Application.FindComponent('ETForm') = nil Then Begin
      ETForm:=TETForm.Create(Application);
      ETForm.Align:=alClient;
      TabSet.Tabs.Add(ETForm.Caption);
      TabSet.TabIndex:=TabSet.Tabs.IndexOf(ETForm.Caption);
      End else Begin
        ETForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(ETForm.Caption);
        End;
    27:if Application.FindComponent('PrintForm') = nil Then Begin
      PrintForm:=TPrintForm.Create(Application);
      TabSet.Tabs.Add(PrintForm.Caption);
      TabSet.TabIndex:=TabSet.Tabs.IndexOf(PrintForm.Caption);
      End else Begin
        PrintForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(PrintForm.Caption);
        End;
    28:if Application.FindComponent('FTPForm') = nil Then Begin
      FTPForm:=TFTPForm.Create(Application);
      TabSet.Tabs.Add(FTPForm.Caption);
      TabSet.TabIndex:=TabSet.Tabs.IndexOf(FTPForm.Caption);
      End else Begin
        FTPForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(FTPForm.Caption);
        End;
    33: if MrC.Connected then
      if Application.FindComponent('OrdersForm') = nil Then Begin//---Замовлення
        OrdersForm:=TOrdersForm.Create(Application);
        OrdersForm.Align:=alClient;
        TabSet.Tabs.Add(OrdersForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OrdersForm.Caption);
      end Else Begin
        OrdersForm.SetFocus;
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OrdersForm.Caption);
        End;
        //------------------------------------------------
    34: if MrC.Connected then

        if Application.FindComponent('OrderForm') = nil Then Begin//---Поточне Замовлення
        OrderForm:=TOrderForm.Create(Application);
        OrderForm.Align:=alClient;
        TabSet.Tabs.Add(OrderForm.Caption);
        TabSet.TabIndex:=TabSet.Tabs.IndexOf(OrderForm.Caption);
        end Else Begin
          OrderForm.SetFocus;
          TabSet.TabIndex:=TabSet.Tabs.IndexOf(OrderForm.Caption);
          End;
        //------------------------------------------------
    50: if not MC.Connected Then
      if Conect(@MC) Then Begin
        //MainForm.Caption:='Meneger ['+MC.FOptions.Host+'][Підключенно]'
        //Else MainForm.Caption:='Meneger ['+MC.FOptions.Host+'][Disconect]';
       ToolButton8.ImageIndex:=28;
       Menu4.Caption:=MC.FOptions.Host;
      End;
    51: if not MrC.Connected Then
      if Conect(@MrC) Then ToolButton9.ImageIndex:=27;
  End;
  End;
end;


end.
