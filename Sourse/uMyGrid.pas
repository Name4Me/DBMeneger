unit uMyGrid;

interface
Uses Grids,Classes;
Type
  TMyGrid = class(TStringGrid)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    Strech:integer;
    constructor Create;
    { Public declarations }
  published
    { Published declarations }
    
  end;
  
implementation

procedure Register;
begin
    RegisterComponents('AAA', [TMyGrid]);
  end;
{ TMyGrid }

constructor TMyGrid.Create;
begin
  //inherited;
  Strech:=-1;

end;

end.


//


{
  procedure Register;
  
}
