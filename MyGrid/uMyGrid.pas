unit uMyGrid;

interface

uses
  Windows,SysUtils, Classes, Controls, Grids,Graphics,Dialogs;

type
  TMyGrid = class(TStringGrid)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    Stretch:integer;
    FielList:TStrings;
    { Public declarations }
  published

    { Published declarations }
  Constructor Create(AOwner: TComponent);override;
  Destructor Destroy; override;
  
  procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TMyGrid]);
end;
{ TMyGrid }

constructor TMyGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //RowCount:=1;
  Stretch:=-1;
  FielList:=TStringList.Create;
  //Canvas.Pen.Style:=psDot;
end;

destructor TMyGrid.Destroy;
begin
  if FielList<>nil then FielList.Free;
  inherited;
end;

procedure TMyGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
begin
  //inherited;
  //ShowMessage(IntToStr(ACol));
  //if ARow mod 2 = 0 then
  //Canvas.Brush.Color:=ClGreen;
  Canvas.Pen.Style:=psDot;
  Canvas.MoveTo(ARect.Right,ARect.Top);
  Canvas.LineTo(ARect.Right,ARect.Bottom);
  // .Brush.Style:=bsHorizontal;
  //Canvas.Rectangle(ARect.Left,ARect.Top,ARect.Right,ARect.Bottom);
  //Canvas.FillRect(ARect);
end;

Begin

end.
