unit uSQL_Func;

interface
Uses
  Dialogs,SysUtils,Classes,Grids,Contnrs,
  uLibMySQL;
  type

  

  PConnectionOption_ST=^TConnectionOption_ST;
  TConnectionOption_ST = packed record
    Description:String[25];
    Host:String[20];
    User:String[20];
    Pass:String[20];
    DB:String[20];
    Port:integer;
    procedure SetOptions(const ihost,iuser,ipass,idb:PAnsiChar;const iPort:integer);
    end;

  PConnectionOption=^TConnectionOption;
  TConnectionOption = class
    Description:String;
    Host:String;
    User:String;
    Pass:String;
    DB:String;
    Port:integer;
    procedure SetOptions(const co:TConnectionOption_ST);
    end;

  TOptionList = class(TObjectList)
    public
    DBFile: file of TConnectionOption_ST;
    
    DbOpen: Boolean;
    RcCount:Integer;
  
    function CreateDB(const DbName: string): Boolean;
    procedure CloseDB;
    function OpenDB(const DbName: string): Boolean;
  
    procedure TruncateDB(const RecNo: Integer);
    function ReadNextRec: TConnectionOption_ST;
    function ReadRec(const RecNo: Integer): TConnectionOption_ST;
    procedure ModifyRec(const Rec: TConnectionOption_ST);
    procedure ModifyRecN(const RecNo: Integer; const Rec: TConnectionOption_ST);
    procedure AddRec(const Rec: TConnectionOption_ST);

    end;
  PMyCon=^TMyCon;
  TMyCon = class
    private
      
      FConnected:Boolean;
      FConnection: pMySQL;
      FCount: Integer;
      FMyRes:pmysql_res;
    public
      Log:TStrings;
      LastSQL:String;
      FOptions: TConnectionOption;
      LastError:String;
      Function Connect: Boolean;
      Function ReConnect(const Rec: TConnectionOption_ST): Boolean;
      Function MyEx(f:AnsiString): Boolean;
      Function Ping: integer;
      Function mySQLc(f:AnsiString):integer;
      function mySQLv(f: AnsiString): Variant;
      Function mySQLs(f:AnsiString):AnsiString;
      Function mySQLi(f:AnsiString):integer;
      Function mySQLf(const f:AnsiString;const rv: Byte=0;const dl: String ='='):String;
      Function mySQLGetInfo:String;
      Procedure mySQLg(mg:TStringGrid;f:AnsiString);
      //Procedure mySQLmg(const mg:TMyGrid; const f:AnsiString);
      //Procedure mySQLa(var tovar:pTTovar; const f:AnsiString);
      procedure SetOptions(const host,user,pass,db:PAnsiChar;const Port:integer);
      procedure SetOption(const SOptions:TConnectionOption_ST);
      Property Connected:Boolean read FConnected;
      Property Count:Integer read FCount;
      Constructor Create;
      Destructor Destroy;override;

    End;

implementation
Uses uData;


{ TMyCon }
constructor TMyCon.Create;
begin
  inherited;
  FOptions:=TConnectionOption.Create;
  Log:=TStringList.Create;
end;
//--------------------------------------------------Подключение к базе данних---
function TMyCon.Connect: Boolean;
begin
  Result:=False;
  FConnected:=False;
  FCount:=0;
  Try
    if FConnection=nil Then FConnection := mysql_init(FConnection);
    if not FConnected Then begin
      FConnection.options.connect_timeout:=300;
      mysql_options(FConnection,MYSQL_OPT_LOCAL_INFILE, nil);
      if mysql_real_connect(FConnection, @FOptions.host[1], @FOptions.user[1], @FOptions.pass[1],@FOptions.db[1],FOptions.Port,nil,0)<> nil Then Begin
        FConnection.reconnect:=True;
        FConnected:=True;
        Result:=True;
        MyEx('set character_set_database=''cp1251''');
        MyEx('SET character_set_client=''cp1251''');
        MyEx('SET character_set_connection=''cp1251''');
        MyEx('SET character_set_results=''cp1251''');
        MyEx('SET character_set_server=''cp1251''');
        MyEx('set NAMES ''cp1251''');
        End;
    end;
  except on E : Exception do
    ShowMessage('Відсутнє підключення до бази данних!!! '+E.ClassName+' ошибка: '+E.Message);
  end;
end;
//------------------------------------------------------------------------------
//---------------------------------------------------------Виполнение запроса---
Function TMyCon.MyEx(f: AnsiString): Boolean;
var i:integer;
  t:Double;
begin
  //ShowMessage(f);
  LastSQL:=f;
  Result:=False;
  FCount:=0;
  Try
    if (FConnected) Then Begin
      mysql_ping(FConnection);
      T:=Time;
      i:=mysql_query(FConnection,PAnsichar(f));
      

    if (i=0) then Begin
      LastError:='Success '+FormatDateTime('nn:ss.zzz',(time-t));
      //ShowMessage(LastError);
      Result:=True;
      End else Begin
        LastError:=mysql_error(FConnection);
        while log.Count>30 do log.Delete(log.Count-1);
        Log.Text:='SQL: '+LastSQL+#13+'Error: '+LastError+#13+Log.Text;
        End;
        End;
  except on E : Exception do
    ShowMessage('ОШИБКА MyEx!!! '+#13+f+#13+E.ClassName+' ошибка: '+E.Message);
  end;
end;
//------------------------------------------------------------------------------
//----------------------------------------------Чтение из бази поля (Строрки)---
function TMyCon.mySQLv(f: AnsiString): Variant;
var rs:string;
Begin
  Result:='';
  try
    if MyEx(f) then Begin
      FMyRes:=mysql_store_result(FConnection);
      FCount:=FMyRes.row_count;
      if FMyRes<>nil then Begin
        rs:=mysql_fetch_row(FMyRes)[0];
        if FMyRes.fields._type in [4,5] then Begin
          if rs='' then rs:='0';
          Result:=FloatSTS(rs);
          End else Result:=rs;
        End;
      mysql_free_result(FMyRes);
      End;
  except on E : Exception do
    ShowMessage('ОШИБКА mySQLv!!! '+E.ClassName+' ошибка: '+E.Message);
  end;
End;
//----------------------------------------------Чтение из бази поля (Строрки)---
function TMyCon.mySQLs(f: AnsiString): AnsiString;
Begin
  Result:='';
  try
    if not MyEx(f) then exit;
    FMyRes:=mysql_store_result(FConnection);
    if FMyRes = nil Then Begin
        mysql_free_result(FMyRes);
        exit;
        End;
    FCount:=FMyRes.row_count;
    if FCount > 0 then Result:=mysql_fetch_row(FMyRes)[0];
    if FMyRes.fields._type in [4,5] then Begin
      if Result='' then Result:='0';
      Result:=FloatSTS(Result);
      End;

    mysql_free_result(FMyRes);

  except on E : Exception do
    ShowMessage('ОШИБКА mySQLs!!! '+E.ClassName+' ошибка: '+E.Message+#13+LastSQL+#13+LastError);
  end;
End;

function TMyCon.Ping: integer;
begin
  Result:=0;
  if FConnection<>nil Then Result:=mysql_ping(FConnection);
end;

function TMyCon.ReConnect(const Rec: TConnectionOption_ST): Boolean;
begin
  //ShowMessage(rec.db+#13+rec.host+#13+rec.user+#13+rec.pass);
  Result:=False;
  if (rec.Host<>'') then Begin
    //if FConnection <> nil then mysql_close(FConnection);
    FOptions.SetOptions(rec);
    FConnected:=False;
    if Connect Then Result:=True;
    end;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


destructor TMyCon.Destroy;
begin
  FConnected:=false;
  //if FConnection <> nil then FConnection.free_me:=True;
  if FConnection <> nil then mysql_close(FConnection);
  if FOptions<> nil Then FOptions.Free;
  if Log<> nil Then Log.Free;
  inherited
end;



//------------------------------------------------------------------------------


//-------------------------------------------------------Возврат полей записи---
function TMyCon.mySQLf(const f:AnsiString;const rv: byte =0;const dl: String ='='):String;
Var
  Myfields:pmysql_fields;
  MyRow:pmysql_row;
  n:integer;
Begin
  Result:='';
  try
    if MyEx(f) then Begin
      FMyRes:=mysql_store_result(FConnection);
      if FMyRes = nil Then Begin
        mysql_free_result(FMyRes);
        exit;
        End;
      FCount:=FMyRes.row_count;
      if FMyRes.row_count <> 0 then case rv of
        0: Begin
          Myfields:=mysql_fetch_fields(FMyRes);
          Myrow:=mysql_fetch_row(FMyRes);
          for n:= 0 to FMyRes.field_count - 1 do Result:=Result+Myfields[n].name+dl+MyRow[n]+#13;
          End;
        1: for n:= 0 to FMyRes.row_count - 1 do begin
          Myrow:=mysql_fetch_row(FMyRes);
          if FMyRes.field_count > 1 Then Result:=Result+MyRow[0]+dl+MyRow[1]+#13
            else Result:=Result+MyRow[0]+#13;
          end;
      end;
      mysql_free_result(FMyRes);
    End;
  except on E : Exception do
    ShowMessage('ОШИБКА mySQLf!!! '+E.ClassName+' ошибка: '+E.Message);
  end;
End;
//------------------------------------------------------------------------------

//------------------------------------------------Чтение из бази поля (Числа)---
function TMyCon.mySQLi(f: AnsiString): integer;

Begin
  Result:=-1;
  try
    if MyEx(f) then Begin
      FMyRes:=mysql_store_result(FConnection);
      if FMyRes = nil Then Begin
        mysql_free_result(FMyRes);
        exit;
        End;
      FCount:=FMyRes.row_count;
      if FCount>0 then Result:=StrToIntDef(mysql_fetch_row(FMyRes)[0],-1);
      mysql_free_result(FMyRes);
    End;
  except on E : Exception do
    ShowMessage('ОШИБКА mySQLi!!! '+#13+mc.LastSQL+#13+Mc.LastError+#13+E.ClassName+' ошибка: '+E.Message);
  end;
End;

{
  procedure TMyCon.mySQLmg(const mg: TMyGrid; const f: AnsiString);
  Var
    Myfields:pmysql_fields;
    MyRow:pmysql_row;
    n,c:integer;
  Begin
    try
      mg.RowCount:=0;
      mg.ColCount:=0;
      if MyEx(f) then with mg do with Canvas do Begin
        FMyRes:=mysql_store_result(FConnection);
        FCount:=FMyRes.row_count;
        if FMyRes.row_count <> 0 then Begin
            ColCount:=FMyRes.field_count+1;
            FixedCols:=1;
            RowCount:=FMyRes.row_count+1;
            Myfields:=mysql_fetch_fields(FMyRes);
            FixedRows:=1;
            //ShowMessage('!');
            ColWidths[0]:=15;
            for n:= 0 to FMyRes.field_count-1 do Begin
              Cells[n+1,0]:=Myfields[n].name;
              ColWidths[n+1]:=TextWidth(Myfields[n].name+'WI');
              //ShowMessage('>'+Cells[n+1,0]+'<');
              End;
  
            for n:= 0 to FMyRes.row_count - 1 do begin
              Myrow:=mysql_fetch_row(FMyRes);
              for c:= 0 to FMyRes.field_count-1 do Begin
                if (Myfields[c]._type in [4,5]) and (MyRow[c]<>'') Then Cells[c+1,n+1]:=FloatSTS(MyRow[c])
                  Else Cells[c+1,n+1]:=MyRow[c];
                if ColWidths[c+1]<TextWidth(Cells[c+1,n+1]+'WI') then
                  ColWidths[c+1]:=TextWidth(Cells[c+1,n+1]+'WI');
                End;
  
  
              end;
             if mg.RowCount>1 then mg.Row:=1;
             //ShowMessage(IntTostr(Height)+'/'+IntTostr(CellRect(0,mg.RowCount-1).Bottom));
             if mg.Strech>0 then
             if RowCount>VisibleRowCount then
              ColWidths[ColCount-1]:=Width-mg.CellRect(mg.ColCount-1,0).Left-22
              else ColWidths[ColCount-1]:=Width-mg.CellRect(mg.ColCount-1,0).Left-5;
  
            End;
        mysql_free_result(FMyRes);
      End;
    except on E : Exception do
      ShowMessage('ОШИБКА mySQLmg!!! '+E.ClassName+' ошибка: '+E.Message);
    end;  


end;  }

//------------------------------------------------------------------------------




//------------------------------------------------------------------------------

procedure TMyCon.SetOption(const SOptions: TConnectionOption_ST);
begin
  FOptions.host:=SOptions.host;
  FOptions.user:=SOptions.user;
  FOptions.pass:=SOptions.pass;
  FOptions.db:=SOptions.db;
  FOptions.Port:=SOptions.Port;
end;

procedure TMyCon.SetOptions(const host,user,pass,db:PAnsiChar;const Port:integer);
begin
  FOptions.host:=host;
  FOptions.user:=user;
  FOptions.pass:=pass;
  FOptions.db:=db;
  FOptions.Port:=Port;
end;

//-----------------------------------возврат количества, полей (строк) записи---
{
  procedure TMyCon.mySQLa(var tovar:pTTovar; const f:AnsiString);
  Var n:integer;
    MyRow:pmysql_row;
    CurentT:pTTovar;
  begin
    if MyEx(f) then Begin
      FMyRes:=mysql_store_result(FConnection);
      FCount:=FMyRes.row_count;
      CurentT:=tovar;
      if FCount > 0 then For n:=0 to FCount-1 do Begin
        MyRow:=mysql_fetch_row(FMyRes);
        CurentT^.Nazva:=MyRow[0];
        if n<FCount-1 then Begin
          New(CurentT^.Next);
          CurentT:=CurentT^.Next;
          CurentT.Next:=nil;
          CurentT.First:=tovar;
          End;
  
        End;
      mysql_free_result(FMyRes);
        //ShowMessage(MyRow1[0]);
      End;
  end;  
}

function TMyCon.mySQLc(f: AnsiString): integer;
begin
  Result:=0;
  if MyEx(f) then Begin
    FMyRes:=mysql_store_result(FConnection);
    FCount:=FMyRes.row_count;
    Result:=FMyRes.row_count;
    End;
end;


//------------------------------------------------------------------------------
Procedure TMyCon.mySQLg(mg:TStringGrid;f:AnsiString);
Var
  Myfields:pmysql_fields;
  MyRow:pmysql_row;
  n,c:integer;
Begin
  try
    mg.RowCount:=0;
    mg.ColCount:=0;
    if MyEx(f) then with mg do with Canvas do Begin
      FMyRes:=mysql_store_result(FConnection);
      FCount:=FMyRes.row_count;
      //ShowMessage(inttostr(FCount));
      if FCount <> 0 then Begin
          ColCount:=FMyRes.field_count+1;
          FixedCols:=1;
          RowCount:=FMyRes.row_count+1;
          Myfields:=mysql_fetch_fields(FMyRes);
          FixedRows:=1;
          //ShowMessage('!');
          ColWidths[0]:=15;
          for n:= 0 to FMyRes.field_count-1 do Begin
            Cells[n+1,0]:=Myfields[n].name;
            ColWidths[n+1]:=TextWidth(Myfields[n].name+'WI');
            //ShowMessage('>'+Cells[n+1,0]+'<');
            End;

          for n:= 0 to FMyRes.row_count - 1 do begin
            Myrow:=mysql_fetch_row(FMyRes);
            for c:= 0 to FMyRes.field_count-1 do Begin
              if (Myfields[c]._type in [4,5]) and (MyRow[c]<>'') Then Cells[c+1,n+1]:=FloatSTS(MyRow[c])
                Else Cells[c+1,n+1]:=MyRow[c];
              if ColWidths[c+1]<TextWidth(Cells[c+1,n+1]+'WI') then
                ColWidths[c+1]:=TextWidth(Cells[c+1,n+1]+'WI');
              End;


            end;
           if mg.RowCount>1 then mg.Row:=1;
           //ShowMessage(IntTostr(Height)+'/'+IntTostr(CellRect(0,mg.RowCount-1).Bottom));
                      {
             if RowCount>VisibleRowCount then
                         ColWidths[ColCount-1]:=Width-mg.CellRect(mg.ColCount-1,0).Left-22
                         else ColWidths[ColCount-1]:=Width-mg.CellRect(mg.ColCount-1,0).Left-5;  
           }

          End;
      mysql_free_result(FMyRes);
    End;
  except on E : Exception do
    ShowMessage('ОШИБКА mySQLg!!! '+E.ClassName+' ошибка: '+E.Message);
  end;
End;

function TMyCon.mySQLGetInfo: String;
begin
  if (FConnected) Then result:=IntToStr(mysql_ping(FConnection));
end;

{ TConnectionOption }

procedure TConnectionOption.SetOptions(const co:TConnectionOption_ST);
begin
  if co.Description<>'' then Begin
    Description:=co.Description;
    host:=co.host;
    user:=co.user;
    pass:=co.pass;
    db:=co.db;
    Port:=co.Port;
    End;
end;

{ TOptionList }


//----------------------------------------Добавить новую запись в конец файла---
procedure TOptionList.AddRec(const Rec: TConnectionOption_ST);
begin
  Seek(DBFile, RcCount); // переместиться на последнею запись
  ModifyRec(Rec);             // и добавить запись
  RcCount := FileSize(DBFile);  // новое кол. записей
end;


//--------------------------------------------------------------закрытие базы---
procedure TOptionList.CloseDB;
begin
  if DbOpen then CloseFile(DBFile);
end;


//----------------------------------------создание новой базы и инициализация---
// не пытаться работать с базой если результат = FALSE
function TOptionList.CreateDB(const DbName: string): Boolean;
begin
  AssignFile(DBFile, DbName);
  try
    Rewrite(DBFile);        //---открываем базу---
    DbOpen := TRUE;             //---открытие прошло нормально---
  except
    DbOpen := FALSE;
  end;
  RcCount := 0;             //---записей нет---
  Result := DbOpen;
end;

//----------------------------------------------------изменить текущую запись---
procedure TOptionList.ModifyRec(const Rec: TConnectionOption_ST);
begin
  Write(DBFile, Rec);
end;

//--------------------------------------------------изменить указанную запись---
procedure TOptionList.ModifyRecN(const RecNo: Integer;
  const Rec: TConnectionOption_ST);
begin
  Seek(DBFile, RecNo);
  ModifyRec(Rec);
end;

//-----------------------------------------------открытие базы и нициализация---
// не пытаться работать с базой если результат = FALSE
function TOptionList.OpenDB(const DbName: string): Boolean;
begin
  AssignFile(DBFile, DbName);
  try
    Reset(DBFile);            // открываем базу
    RcCount := FileSize(DBFile); // текущее кол. записей
    DbOpen := TRUE;               // открытие прошло нормально
  except
    RcCount := 0;
    DbOpen := FALSE;
  end;
  Result := DbOpen;
end;

//----------------------------------------------------Читать следующую запись---
function TOptionList.ReadNextRec: TConnectionOption_ST;
begin
  Read(DBFile, Result);
end;

//----------------------------------------------------Читать указанную запись---
function TOptionList.ReadRec(const RecNo: Integer): TConnectionOption_ST;
begin
  Seek(DBFile, RecNo);
  Result := ReadNextRec;
end;

//-----------------------------------------Удалить все после указанной записи---
procedure TOptionList.TruncateDB(const RecNo: Integer);
begin
  Seek(DBFile, RecNo);
  Truncate(DBFile);
  RcCount := FileSize(DBFile);
end;

{ TConnectionOption_ST }

procedure TConnectionOption_ST.SetOptions(const ihost, iuser, ipass, idb: PAnsiChar;
  const iPort: integer);
begin
  host:=ihost;
  user:=iuser;
  pass:=ipass;
  db:=idb;
  Port:=iPort;
end;

end.
