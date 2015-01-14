unit uTreeFunction;

interface
Uses ComCtrls;
Function NSearch(noddy:TTreenode;Const SearchText:String):TTreenode;

implementation
Function NSearch(noddy:TTreenode;Const SearchText:String):TTreenode;
Var Searching:boolean;
begin
  Result:=nil;
  if noddy<>nil Then Searching:=true;
  while (Searching) and (noddy<>nil) do
    if noddy.Text=SearchText then Begin
      Searching:=false;
      Result:=noddy;
      End else noddy:=noddy.GetNext;
end;
end.
