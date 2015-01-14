unit uData;

interface
Uses uSQL_Func,uLibMySQL,Controls,SysUtils,StrUtils,dialogs,IniFiles,Classes,IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient; //
Const TSName='Склад';
      TrSName='sklad';   //TrSName='Склад';
  Row_s=1;
  Field_s=0;
Var
  LabelPrinter:string;
  MDs,tmp:string;
  CurrentPatch,RestorePath:string;
  MD:TDate;
  DefMisce:string;
  User,Password:string;
  MC,MrC:TMyCon;
  Kurs:real;
  Local:Boolean;
  UserID:String='13';

  IsInPing:boolean=False;
  IsLanConnect:boolean=True;
  PingResult:boolean=True;
  PingS:TIdIcmpClient;

  MyIni:TIniFile;
  dc:TConnectionOption_ST;
  Function Conect(con:PMyCon):Boolean;
  Function FloatSTS(const s:string):String;
  Function FloatSTSQL(const s:string):String;
  Function FloatTSQL(const r:real):String;
  Function kil2p(ins:String):String;
  Function cc(const f:string):String;

  Procedure PingReply(ASender: TComponent; const AReplyStatus: TReplyStatus);
  Procedure CloseMC;
implementation

Procedure CloseMC;
Begin
  if MC<>Nil then MC.Free;
  if MrC<>Nil then MrC.Free;
  if MyIni<>Nil then MyIni.Free;;

End;


  procedure PingReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
  Begin
      IsInPing:=False;
      ShowMessage('+');
      if (AReplyStatus.ReplyStatusType=rsEcho) and IsLanConnect then PingResult:=true;
    End;
    
  Procedure Ping;
  Begin
      IsInPing:=True;
      if PingS=nil Then Begin
        PingS:=TIdIcmpClient.Create(nil);
        PingS.ReceiveTimeout:=1000;
        @PingS.OnReply:=@PingReply;
        PingS.Host:=MC.FOptions.Host;
        End;
      try
        PingS.Ping;
        except IsLanConnect:=false;;
        end;
    End;




Function cc(const f:string):String;
Begin
  Result:='';
  if f<>'' then Result:=f+',';
End;
Function Conect(con:PMyCon):Boolean;
Begin
  Result:=con.Connect;
End;

Function FloatSTS(const s:string):String;
begin
  if pos('.',s)<>0 then Result:= AnsiReplaceStr(s, '.', ',')
    else Result:=s;
  Result:=FloatToStrF(StrToFloat(Result),ffFixed,7,2);
end;

Function FloatSTSQL(const s:string):String;
begin
  if pos('.',s)<>0 then Result:=AnsiReplaceStr(s, '.', ',')
    else Result:=s;
  Result:=FloatToStrF(StrToFloat(Result),ffFixed,7,2);
  Result:=AnsiReplaceStr(Result, ',', '.');
end;
Function FloatTSQL(const r:real):String;
begin
  Result:=AnsiReplaceStr(FloatToStrF(r,ffFixed,7,2), ',', '.');
end;

Function kil2p(ins:String):String;
Begin
  while pos('  ',ins)<>0 do delete(ins,pos('  ',ins),1);
  result:=trim(ins);
End;

Begin
  
  CurrentPatch:=GetCurrentDir;
  dc.SetOptions('LocalHost','trp','ozuwsgag','sklad',3306);
  DefMisce:='Склад-магазин';
  User:='';
  kurs:=8.5;
  MyIni:= TIniFile.Create(CurrentPatch+'\option.ini');
  tmp:=MyIni.ReadString('Main','Host','LocalHost');
  RestorePath:=MyIni.ReadString('Main','RestorePath','c:\');
  LabelPrinter:=MyIni.ReadString('Main','LabelPrinter','');
  MyIni.WriteString('Main','LabelPrinter',LabelPrinter);
  MyIni.WriteString('Main','Host',tmp);
  MyIni.WriteString('Main','RestorePath',RestorePath);



  MC:=TMyCon.Create;
  MrC:=TMyCon.Create;
  MC.SetOptions(pansichar(tmp),'trp','ozuwsgag','sklad',3306);

  //ShowMessage(Mc.FOptions.Host);
  if lowercase(tmp)='78.152.168.80' then MC.SetOptions('78.152.168.80','trp','ozuwsgag','sklad',3306);
  MrC.SetOptions('komp1.ath.cx','trp','ozuwsgag','sklad',3306);


    if lowercase(tmp)<> 'localhost' then ping;
    while IsInPing do;
    if not PingResult then MC.SetOptions('LocalHost','trp','ozuwsgag','sklad',3306);
end.
  //MC.SetOptions('localhost','trp','ozuwsgag','sklad',3306);
  //MC.SetOptions('192.168.1.55','trp','ozuwsgag','sklad',3306);
  //MC.SetOptions('sline.com.ua','slinecom_test','test','slinecom_sklad',3306);
  //MC.SetOptions('mysql300.1gb.ua','gbua_sklad','cfc1535a','gbua_sklad',3306);
  //MC.SetOptions('name4me.net','name4men_user','testuser','name4men_MyBase',3306);
