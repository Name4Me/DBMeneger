unit uFileFunction;

interface
Uses SysUtils,Windows;

  Procedure DelAll(Const Path,mask:String);
  Function GetFS(Const FName:String):integer;
  Function Exist(Const FName:String):Boolean;
  function GetFileVersion(FileName: string): string;

implementation

Function Exist(Const FName:String):Boolean;
var
  SearchRec: TSearchRec;
Begin
  Result:=False;
  if SysUtils.FindFirst(FName, faAnyFile, SearchRec)=0 Then Result:=True;
  SysUtils.FindClose(SearchRec);
End;

Function GetFS(Const FName:String):integer;
var
  SearchRec: TSearchRec;
Begin
  Result:=-1;
  if SysUtils.FindFirst('rar.e*', faAnyFile, SearchRec)=0 Then Result:=SearchRec.Size;
  SysUtils.FindClose(SearchRec);
End;

Procedure DelAll(Const Path,mask:String);
var
  SearchRec: TSearchRec;
  I : Integer;
begin
  //Showmessage(Path);
  I := SysUtils.FindFirst(Path+mask, faAnyFile, SearchRec);
  while I = 0 do begin
    //Showmessage(SearchRec.Name);
    SysUtils.deletefile(Path+SearchRec.Name);
    I := SysUtils.FindNext(SearchRec);
    end;
  SysUtils.FindClose(SearchRec);
end;

function GetFileVersion(FileName: string): string;
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  Result:='';
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);
  if InfoSize = 0 then exit;
  GetMem(Info, InfoSize);
  try
    GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
    VerQueryValue(Info, '\', pointer(FileInfo), FileInfoSize);
    Result := inttostr(FileInfo.dwFileVersionMS shr 16)+
      '.'+inttostr(FileInfo.dwFileVersionMS and $FFFF)+
      '.'+inttostr(FileInfo.dwFileVersionLS shr 16)+
      '.'+inttostr(FileInfo.dwFileVersionLS and $FFFF);
    finally
      FreeMem(Info, FileInfoSize);
      end;
    end;
end.
