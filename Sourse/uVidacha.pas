unit uVidacha;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Spin,ScktComp,Dialogs,Windows, DB, DBTables,
  Grids, DBGrids;

type
  TVidachaForm = class(TForm)
    HC2: THeaderControl;
    HC1: THeaderControl;
    Panel1: TPanel;
    Button1: TButton;
    SB: TStatusBar;
    Button26: TButton;
    Memo1: TMemo;
    Button27: TButton;
    Button28: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    ListBox2: TListBox;
    SpinEdit1: TSpinEdit;
    StringGrid1: TStringGrid;
    SpinEdit2: TSpinEdit;
    Edit1: TEdit;
    procedure GridRefresh;
    procedure ListBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VidachaForm: TVidachaForm;
  Klas: integer;
  ggid,id,rid,rtid:string;
  hComm:THANDLE;
implementation

uses udata,uMainForm;



{$R *.dfm}
procedure TVidachaForm.GridRefresh;
begin
  Label1.Caption:='['+MC.mySQLs('Select Sum(kilkist) From Oper Where Oper='''+Caption+'''and Misce ='''+DefMisce+''' and ip='+SpinEdit2.Text+' and data ='''
      +mds+'''')+']';
  if CheckBox1.Checked then
    MC.mySQLg(StringGrid1,'Select Nazva,Tip,Rozmir,Rist,Kilkist,Data,time,cod From Oper Where Oper='''+Caption+'''and Misce ='''+DefMisce+''' and ip='+SpinEdit2.Text+' and data ='''
      +mds+''' Order By Data,time DESC');
end;

procedure TVidachaForm.ListBoxClick(Sender: TObject);
Var i:integer;
begin
  with HC2 do with TListBox(Sender) do begin
    if ItemIndex=-1 then exit;
    Sections[tag-1].Text:=Items[ItemIndex];
    for i := tag to 4 do Sections[i].Text:='';
    Button1.Enabled:=False;
    SpinEdit1.Enabled:=False;
    Label1.Caption:=' ';
    case tag of
      1:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ggid:=MC.mySQLs('Select id from gg where Nazva = '''+Items[ItemIndex]+'''');
        rid:=MC.mySQLs('Select rid from gg where Nazva = '''+Items[ItemIndex]+'''');
        rtid:=MC.mySQLs('Select rtid from gg where Nazva = '''+Items[ItemIndex]+'''');
        ListBox2.Items.Text:=MC.mySQLf('Select Distinct left(Tip,1) from Types Where GGID = '''+ggid+'''',1);
        ListBox3.Items.Text:=MC.mySQLf('Select Tip from Types Where ggid = '''+ggid+'''order by tip',1);

        End;
      2:Begin
        ListBox4.Clear;
        ListBox5.Clear;
        ListBox3.Items.Text:=MC.mySQLf('Select Tip from Types Where ggid = '''+ggid+''' and tip like '''+Items[ItemIndex]+'%'' order by tip',1);
        End;
      3:Begin
        ListBox5.Clear;
        if rid <> '0' Then
          ListBox4.Items.Text:=MC.mySQLf('Select Rozmir from rozmir Where  rid= '''+rid+''' order by Rozmir',1)
          else SpinEdit1.Enabled:=True;
        if ListBox4.Items.Text<>'' then ListBox4.Enabled:=True else ListBox4.Enabled:=False;

        End;
      4:Begin
        if rtid <> '0' Then
          ListBox5.Items.Text:=MC.mySQLf('Select Rozmir from rozmir Where  rid= 0 order by Rozmir',1)
          else SpinEdit1.Enabled:=True;
        if ListBox5.Items.Text<>'' then ListBox5.Enabled:=True else ListBox5.Enabled:=False;
        End;
      5:SpinEdit1.Enabled:=True;
      end;
    if SpinEdit1.Enabled then Begin
      Button1.Enabled:=true;
      SpinEdit1.Value:=1;
      SpinEdit1.SetFocus;
      id:=MC.mySQLs('select GetTID('''+Sections[0].Text+','+Sections[2].Text+','+
        Sections[3].Text+','+Sections[4].Text+''')');

      //Edit3.Text:=MC.mySQLs('select GetCina('''+DefMisce+''','''+id+''','''')');
      //Edit3.Text:=FloatToStrF(StrToFloat(Edit3.Text)*((100-StrToIntDef(Sections[6].Text,0))/100),ffFixed,7,2);

      End;
  end;
end;

procedure TVidachaForm.SpinEdit2Change(Sender: TObject);
begin
  GridRefresh;
end;

procedure TVidachaForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i,n:integer;
begin
  if Key = 46 Then with StringGrid1 do begin
    n:=0;
    for i := 1 to ColCount-1 do if lowercase(Cells[i,0])='cod' then n:=i;
    if n<>0 then for i := Selection.BottomRight.y downto Selection.TopLeft.y do
      MC.MyEx('Call vidmina('+Cells[n,i]+')');
    end;
  GridRefresh;
end;

procedure TVidachaForm.Button1Click(Sender: TObject);

begin
  with HC2 do begin
    ID:=MC.mySQLs('select GetTID('''+Sections[0].Text+','+Sections[2].Text+','+
      Sections[3].Text+','+Sections[4].Text+''')');

    if Caption='Повернення' Then MC.MyEx('call Vidacha('''+DefMisce+''','''+ID+''','+SpinEdit1.Text+','+SpinEdit2.Text+','''+User+''','''+MDs+''',2)');
    if Caption='Видача' Then MC.MyEx('call Vidacha('''+DefMisce+''','''+ID+''','+SpinEdit1.Text+','+SpinEdit2.Text+','''+User+''','''+MDs+''',1)');
    //Edit1.Text:=MC.LastSQL;
    if Edit1.Text<>'' then Edit1.Visible:=True;
  end;
  SpinEdit1.Value:=1;
  Button1.Enabled:=false;
  GridRefresh;
end;

procedure TVidachaForm.FormActivate(Sender: TObject);
begin
  SpinEdit2.Value:=MC.mySQLi('Select max(ip) From Oper Where Oper='''+Caption+
    '''and Misce ='''+DefMisce+''' and data ='''+mds+'''');
end;

procedure TVidachaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TVidachaForm.FormCreate(Sender: TObject);
begin
  ListBox1.Items.Text:=MC.mySQLf('Select Distinct Nazva from gg',1);
  GridRefresh;
end;

procedure TVidachaForm.Button26Click(Sender: TObject);
{
  Var
    ID:string;
    TL,Rm,Rt: integer;  
}
begin
{
          id:=edit2.Text;
          z.Oper:=caption;
          z.Opt:=False;
          z.Nazva:=mySQLs('Select nazva from gg where id = '''+Copy(ID,1,2)+'''');
          TL:=length(mySQLs('Select max(id) from Types where ggid = '''+Copy(ID,1,2)+''''));
          z.Tip:=mySQLs('Select tip from Types where ggid = '''+Copy(ID,1,2)+''' and id='''+Copy(ID,3,Tl)+'''');
          Rm:=mySQLi('Select RID  from gg where id = '''+Copy(ID,1,2)+'''');
          Rt:=mySQLi('Select RtID  from gg where id = '''+Copy(ID,1,2)+'''');
          if Rt<>0 Then Begin
            z.Rist:=Copy(id,length(id),1);
            z.Rozmir:=Copy(id,3+TL,length(id)-3-TL);
            End else if Rm<>0 Then z.Rozmir:=Copy(id,3+TL,length(id)-2-TL);
          z.Misce:=MF.Misce;
          z.Kilkist:=StrToInt(Edit1.Text);
          z.Cina:=MyCina(z);
          z.BCina:='';
          z.Inf:=Edit3.Text;
          z.User:=MF.User;
          z.Data:=FormatDateTime('dd.mm.yyyy',MD);
          z.Time:=FormatDateTime('hh:nn:ss',Time);
          z.IP:=ipn.Text;
          z.ID:=ID;
    MyVidaca(z);
  IPNChange(Sender);
}
end;

procedure TVidachaForm.Button27Click(Sender: TObject);
{
  Var
     nChar:DWORD;
     szRead:array[1..128]of byte;
     cRet:byte;
     i, dwTime,k:integer;
     f,f1:bool;
     //ct:TCommTimeOuts;
     s:string;
}
Begin
{
  f:=true;
  f1:=true;
    memo1.Clear;
    hComm:=OpenIrCom (1, 115200);
    WriteFile(hComm,'READ'+chr(13),5,nChar,nil);
    Sleep (400);
    WriteFile(hComm,'ACK'+chr(13),4,nChar,nil);
    Sleep (100);
    k:=0;
    while f do begin
  	  dwTime:= GetTickCount ();
      cRet:=0;
      WHILE (cRet<>13) and f do begin
        if ((GetTickCount() - dwTime > 3000)) then Begin f:=false; f1:=false; end;
        ReadFile (hComm, szRead, 100, nChar, NiL);
        
        s:='';
        for i:= 1 to nChar do begin
        //Memo2.Lines.Add(Char(szRead[i])+' - '+inttostr(szRead[i]));
        if (szRead[i]>=48)or(szRead[i]=44) then s:=s+chr(szRead[i]);
        if (szRead[i]=32) and (s<>'') and (pos(',',s)<>0) then Begin
          Memo1.Lines.Add(s);
          k:=k+StrToInt(Copy(s,pos(',',s)+1,length(s)-pos(',',s)));
          s:='';
        End;
        if s='OVER' Then f:=false;
        if (szRead[i]=13) then s:='';
        cRet:=szRead[i];
        end;
      end;
      WriteFile(hComm,'ACK'+chr(13),4,nChar,nil);
      Sleep (100);
      End;
  CloseIrCom ();
  Label1.Caption:=inttostr(memo1.Lines.Count)+'/'+IntToStr(k);
  if not f1 then if MessageDlg('Читання данних з пристрою не виконано, спробувати ще раз?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then button27.Click;

}
end;

procedure TVidachaForm.Button28Click(Sender: TObject);
{
  Var
    m:integer;
    s:string;
}
begin
{
     For m:= 1 to Memo1.Lines.Count do begin
     if pos(',',Memo1.Lines.Strings[0])<>0 Then
     begin
      s:=Memo1.Lines.Strings[0];
      Edit2.Text:=Copy(s,1,pos(',',s)-1);
      Edit1.Value:=StrToInt(Copy(s,pos(',',s)+1,length(s)-pos(',',s)));
      Button26.Click;
      End;
      Memo1.Lines.Delete(0);
      end;
}
End;        
end.
