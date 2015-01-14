unit uSearchForm;

interface

uses
  uSQL_Func,Forms, ComCtrls, StdCtrls, Grids, Classes, Controls, ImgList,SysUtils
  ,uData,uDataST,Dialogs;

type
  TSearchForm = class(TForm)
    E1: TEdit;
    TV: TTreeView;
    IL: TImageList;
    PC: TPageControl;
    TS1: TTabSheet;
    TS2: TTabSheet;
    TS3: TTabSheet;
    SG3: TStringGrid;
    SG1: TStringGrid;
    SG2: TStringGrid;
    E2: TEdit;
    E3: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    procedure SQL(obj:integer;T:TTovar);
    procedure MyKeyPress(Sender: TObject; var Key: Char);
    procedure TVClick(Sender: TObject);
    procedure MyChange(Sender: TObject);
    procedure SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchForm: TSearchForm;
  t1,t2,t3:TTovar;
implementation
Uses uMainForm;

{$R *.dfm}
procedure TSearchForm.SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if Sender is TStringGrid then with TStringGrid(Sender) do
     case tag of
      1: if ColCount>3 Then Begin
        case ACol of
          1: Begin
            //TV.sel
            End;
          3: Begin
            t1.Tip:=Cells[3, ARow];
            if (TV.SelectionCount = 1) and (TV.Selections[0].Text<>'¬Ò≥ Ï≥Òˆˇ') Then
              Begin
                t1.TID:=MC.mySQLs('SELECT GetID('''+t1.Nazva+''','''+t1.Tip+''') as TID');
                //ShowMessage('SELECT GetTID('''+t1.Nazva+''','''+t1.Tip+''') as TID'+t1.TID);
                ListBox1.Items.Text:=MC.mySQLf('SELECT loc From Location Where misce='''+TV.Selections[0].Text+''' and TID='''+t1.TID+''' order by loc',Row_s);
              End;
            End;
          4: t1.Rozmir:=Cells[4, ARow];
          5: t1.Rist:=Cells[5, ARow];
          end;
        Label1.Caption:=t1.Nazva+' '+t1.Tip+' '+t1.Rozmir+' '+t1.Rist;
        E1.Text:=t1.Nazva+t1.Tip+'!'+t1.Rozmir+t1.Rist;
        SQL(1,t1);
        End;
       2: if ColCount>3 Then Begin
        case ACol of
          3: t2.Tip:=Cells[3, ARow];
          4: t2.Rozmir:=Cells[4, ARow];
          5: t2.Rist:=Cells[5, ARow];
          end;
  
        E2.Text:=t2.Nazva+t2.Tip+'!'+t2.Rozmir+t2.Rist;
        SQL(2,t2);
        End;
       3: if ColCount>3 Then Begin
        case ACol of
          3: t3.Tip:=Cells[3, ARow];
          4: t3.Rozmir:=Cells[4, ARow];
          5: t3.Rist:=Cells[5, ARow];
          end;
  
        E3.Text:=t3.Nazva+t3.Tip+'!'+t3.Rozmir+t3.Rist;
        SQL(3,t3);
        End;
     end;
end;

procedure TSearchForm.SQL(obj:integer;T:TTovar);
Var ft,s:string;
m:integer;
begin
    ft:='';
    //Caption:=IntToStr(TV.SelectionCount);
    if TV.SelectionCount = 1 Then
    if TV.Selections[0].Text<>'¬Ò≥ Ï≥Òˆˇ' Then ft:='Misce = '''+TV.Selections[0].Text+'''';
    if TV.SelectionCount > 1 Then Begin
      ft:='(Misce = '''+TV.Selections[0].Text+'''';
      For m:= 1 to TV.SelectionCount-1 Do ft:=ft+' or Misce = '''+TV.Selections[m].Text+'''';
      ft:=ft+')';
      End;
     s:='';
    if t.Nazva<>'' then s:='id like '''+t.Nazva+'%%''';
    if ( t.Tip<>'') and (s<>'') then s:=s+' and tip like '''+ t.Tip+'%%''';
    if ( t.Tip<>'') and (s='') then s:=s+' tip like '''+ t.Tip+'%%''';
    if (t.Rozmir<>'')  and (s<>'') then s:=s+' and rozmir like '''+t.Rozmir+'%%''';
    if (t.Rozmir<>'')  and (s='') then s:=s+' rozmir like '''+t.Rozmir+'%%''';
    if (t.Rist<>'') and (s<>'') then s:=s+' and rist = '+t.Rist;
    if (t.Rist<>'') and (s='') then s:=s+'rist = '+t.Rist;
    if ft='' then ft:=s else ft:=ft+ ' and ' +s;
    ft:='Select Misce,Nazva,Tip,Rozmir,Rist,Kilkist,Cina from —ÍÎ‡‰ Where '+ft+
      ' Order by Misce,Nazva,Tip,Rozmir,Rist limit 100';
    //ShowMessage('+');
    if (ft <> '') and (obj=1) Then MC.mySQLg(SG1,ft);
    //ShowMessage(MC.LastError);
    if (ft <> '') and (obj=2) Then MC.mySQLg(SG2,ft);
    if (ft <> '') and (obj=3) Then MC.mySQLg(SG3,ft);
    
End;
procedure TSearchForm.MyChange(Sender: TObject);
begin
  if Sender is TEdit then with TEdit(Sender) do
   if length(Text)>1 Then case tag of
    1: Begin
      t1:=anal(Text);
      Label1.Caption:=t1.Nazva+' '+t1.Tip+' '+t1.Rozmir+' '+t1.Rist;
      SQL(1,t1);
      End;
    2: Begin
      t2:=anal(Text);
      SQL(2,t2);
      End;
    3: Begin
      t3:=anal(Text);
      SQL(3,t3);
      End;
   end;

end;


procedure TSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With MainMForm.TabSet.Tabs do Delete(IndexOf(Caption));
  Free;
  MainMForm.SetFocus;
end;

procedure TSearchForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if (key=#13) then
      case PC.ActivePageIndex of
        0: Begin
          E1.SetFocus;
          E1.SelectAll;
          End;
        1: Begin
          E2.SetFocus;
          E2.SelectAll;
          End;
        2: Begin
          E3.SetFocus;
          E3.SelectAll;
          End;
      end;
end;

procedure TSearchForm.FormShow(Sender: TObject);
Var m:integer;
  ml:^TStrings;
begin

  //MC.SetOptions('192.168.1.1','trp','ozuwsgag','sklad',3306);
  {MC.SetOptions('LocalHost','trp','ozuwsgag','sklad',3306);
  if MC.Connect Then Begin

    
    End Else Caption:=Caption+' [DB Error]';   }
  New(ml);
    ml^:=Tstringlist.Create;
    E2.Hint:=MC.mySQLf('Select ID,Nazva From gg order by ID',Row_s);
    ml^.Text:=MC.mySQLf ('SELECT misce FROM misce WHERE Status>0 AND kilkistbyid(misce,'''')>0 order by Status,misce',Row_s);
    //showmessage(MC.LastError);
    For m:= 0 to ml^.Count-1 Do Begin
      TV.Items.AddChild(tv.Items[0],ml^[m]);
      TV.Items[m+1].ImageIndex:=1;
      TV.Items[m+1].SelectedIndex:=1;
      end;
    TV.Items[0].Expand(True);
    Dispose(ml);
end;

procedure TSearchForm.TVClick(Sender: TObject);
begin
  Case PC.ActivePageIndex of
    0: SQL(1,t1);
    1: SQL(2,t2);
    2: SQL(3,t3);
    End;
end;

procedure TSearchForm.MyKeyPress(Sender: TObject; var Key: Char);
Begin
 if key=#13 then with Sender as TEdit do SelectAll;

end;

end.
