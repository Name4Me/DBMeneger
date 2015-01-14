unit uArgox203;

interface
  function  A_Set_Darkness ( darkness:integer):integer;stdcall;external 'WINPPLA.DLL';

  function  A_CreatePrn    ( selection:integer;FileName:pchar):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Print_Out    ( width,height,copies,amount:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Prn_Text     ( x,y,ori,font,typee,hor_factor,ver_factor:integer;mode:char;numeric:integer;data:pchar):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Prn_Barcode  ( x,y,ori:integer;typee:char;narrow,width,height:integer;mode:char;numeric:integer;data:pchar):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Prn_Text_TrueType ( x,y,FSize:integer;FType:pchar;Fspin,FWeight,FItalic,FUnline,FStrikeOut:integer;id_name,data:pchar;mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Load_Graphic ( x,y:integer;id_name:pchar):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Get_Graphic  ( x,y,mem_mode:integer;format:char;filename:pchar):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Draw_Box     ( mode, x, y, width, height, top, side:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Draw_Line    (mode, x, y, width, height:integer):integer;stdcall;external 'WINPPLA.DLL';
  Procedure A_ClosePrn     ();stdcall;external 'WINPPLA.DLL';
  Procedure A_Feed_Label   ();stdcall;external 'WINPPLA.DLL';
  function  A_Set_Prncomport (baudint,parity,data,stop:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Set_Prncomport_PC (nBaudRate,nByteSize,nParity,nStopBits,nDsr,nCts,nXonXoff:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Set_ProcessDlg(nShow:integer):integer;stdcall;external 'WINPPLA.DLL';
  function  A_Set_Backfeed(back:integer):integer;stdcall;external 'WINPPLA.DLL';

implementation

end.
