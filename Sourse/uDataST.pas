unit uDataST;

interface
Uses dialogs;
  Type
  pTTovar = ^TTovar;
  TTovar = record
    GID: String[2];
    TID: String[3];
    ID: String[10];
    Nazva: String[25];
    Tip: String[25];
    Rozmir: String[5];
    Rist: String[5];
    Cina: String[10];
    Kilkist:integer;
    AllKilkist:integer;
    rid:String[2];
    rtid:String[2];
    Next:pTTovar;
    First:pTTovar;
    End;
  Function anal(s:string):TTovar;
  Procedure FreeT(T:pTTovar);

implementation
Function anal(s:string):TTovar;
var
  i:integer;
begin
  Result.Nazva:='';
  Result.Tip:='';
  Result.Rozmir:='';
  Result.Rist:='';
  if s<>'' then begin
    for i:= 1 to length(s) do
      case s[i] of
        '0'..'9':

        Begin
          if i<=2 then Result.Nazva:=Result.Nazva+s[i] else
            if (pos('!',s)<i)and(length (Result.Rozmir)<=3) then
              Result.Rozmir:=Result.Rozmir+s[i]
              Else Result.Tip:= Result.Tip+s[i];
          end;
        ' ': if  Result.Tip<>'' then  Result.Tip:= Result.Tip+s[i];
        '!': ;
        else  Result.Tip:= Result.Tip+s[i];
        end;
    if (length(Result.Rozmir)=3) and (Result.Rozmir[1]<>'1') then Begin
      Result.Rist:=Result.Rozmir[3];
      Result.Rozmir:=Result.Rozmir[1]+Result.Rozmir[2];
    End;
  end;
End;

Procedure FreeT(T:pTTovar);
Var CurentT,NextT:pTTovar;
Begin
  if T.Next=Nil then Dispose(T)
  Else Begin
    CurentT:=T;
    while CurentT<>Nil do Begin
      NextT:=CurentT^.Next;
      Dispose(CurentT);
      CurentT:=NextT;
      End;
    End;

End;
end.
