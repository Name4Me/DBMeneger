unit uSinhronaze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    Memo1: TMemo;
    Memo2: TMemo;
    StatusBar1: TStatusBar;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form3: TForm3;
implementation
Uses uData;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  StatusBar1.Panels[1].Text:='In Process...';
  if (pos('select',Lowercase(Memo2.Text))<>0) or
    (pos('show',Lowercase(Memo2.Text))<>0) then MC.mySQLg(StringGrid1,Memo2.Text)
    Else MC.MyEx(Memo2.Text);
    StatusBar1.Panels[1].Text:=MC.LastError;
  //load data local infile 'd:/temp/sklad.sav' into Table sklad Fields Terminated by ',' enclosed by '"' lines Terminated by '\n'
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);

begin
    //('localhost','trp','ozuwsgag','sklad',3306);
    //('192.168.1.55','trp','ozuwsgag','sklad',3306);
    //('name4me.net','name4men_user','testuser','name4men_MyBase',3306);

  MC.Free;
  if Memo1.Text<>'' then Memo1.Lines.SaveToFile('SQL.txt');
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  //MC.SetOptions('localhost','trp','ozuwsgag','sklad',3306);
  //MC.SetOptions('192.168.1.55','trp','ozuwsgag','sklad',3306);
  //MC.SetOptions('192.168.1.1','trp','ozuwsgag','sklad',3306);
  //MC.SetOptions('sline.com.ua','slinecom_test','test','slinecom_sklad',3306);
  //MC.SetOptions('mysql300.1gb.ua','gbua_sklad','cfc1535a','gbua_sklad',3306);
  //MC.SetOptions('name4me.net','name4men_user','testuser','name4men_MyBase',3306);
  Caption:='['+MC.FOptions.Host+'] Підключення...';

  if MC.Connect Then Begin
    Caption:='['+MC.FOptions.Host+'] Підключенно';
    Memo1.Lines.LoadFromFile('SQL.txt');
    End Else Caption:=Caption+' [DB Error]';
end;

procedure TForm3.Memo1Click(Sender: TObject);
var
   Line: Integer;
 begin
   with (Sender as TMemo) do
   begin
     
     Line      := Perform(EM_LINEFROMCHAR, SelStart, 0);
     Memo2.Text:= Memo1.Lines[Line];
     //SelStart  := Perform(EM_LINEINDEX, Line, 0);
     //SelLength := Length(Lines[Line]);
   end;
end;

procedure TForm3.Memo1DblClick(Sender: TObject);
begin
  //LineNumber := SendMessage(Memo1.Handle, EM_LINEFROMCHAR, word(-1), 0);
  //Memo2.Text:=IntTostr(SendMessage(Memo1.Handle, EM_LINEFROMCHAR, word(-1), 0));// .SelText;
end;

end.
