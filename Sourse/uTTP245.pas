unit uTTP245;

interface

  procedure openport(a :pchar);stdcall; external 'tsclib.dll';
  procedure closeport; stdcall;  external 'tsclib.dll';
  procedure sendcommand(Command:pchar);stdcall;far;external 'tsclib.dll';
  procedure setup(LabelWidth, LabelHeight, Speed, Density, Sensor, Vertical,Offset:pchar);stdcall;  external 'tsclib.dll';
  procedure downloadpcx(Filename,ImageName:pchar);stdcall;far;external 'tsclib.dll';
  procedure barcode(X, Y, CodeType, Height, Readable, Rotation, Narrow,Wide, Code :pchar); stdcall; far; external 'tsclib.dll';
  procedure printerfont(X, Y, FontName, Rotation, Xmul, Ymul, Content:pchar);stdcall;far; external 'tsclib.dll';
  procedure clearbuffer; external 'tsclib.dll';
  procedure printlabel(NumberOfSet, NumberOfCopoy:pchar);stdcall; far;external 'tsclib.dll';
  procedure formfeed;external 'tsclib.dll';
  procedure nobackfeed; external 'tsclib.dll';
  procedure windowsfont (X, Y, FontHeight, Rotation, FontStyle,FontUnderline : integer; FaceName,TextContect:pchar);stdcall;far;external 'tsclib.dll';
implementation

end.
