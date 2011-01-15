unit MyScroll;

interface

uses Classes;

type
   TMyScroll = class
    					constructor Create;
  private
    FGX: integer;
    FGY: integer;
    FZoomX: integer;
    FZoomY: integer;
    FMaxI: integer;
    FMaxJ: integer;
    FScreenWidth: integer;
    FScreenHeight: integer;
    procedure SetGX(const Value: integer);
    procedure SetGY(const Value: integer);
    procedure SetMaxI(const Value: integer);
    procedure SetMaxJ(const Value: integer);
    procedure SetZoomX(const Value: integer);
    procedure SetZoomY(const Value: integer);
    procedure SetScreenHeight(const Value: integer);
    procedure SetScreenWidth(const Value: integer);

       public
           property GX: integer read FGX write SetGX;
           property GY: integer read FGY write SetGY;
           property MaxI: integer read FMaxI write SetMaxI;
           property MaxJ: integer read FMaxJ write SetMaxJ;
           property ScreenWidth: integer read FScreenWidth write SetScreenWidth;
           property ScreenHeight: integer read FScreenHeight write SetScreenHeight;
           property ZoomX: integer read FZoomX write SetZoomX;
           property ZoomY: integer read FZoomY write SetZoomY;
           function GetX(i: integer): integer;
           function GetY(j: integer): integer;
           function GetI(x: integer): integer;
           function GetJ(y: integer): integer;
           function Clip(x, y: integer): boolean;
           function GetMaxX: integer;
           function GetMaxY: integer;
       end;

implementation

{ TMyScroll }

function TMyScroll.Clip(x, y: integer): boolean;
var
   i, j: integer;
begin
   i:=(x+GX) div FZoomX;
   j:=(y+GY) div FZoomY;
   Clip:=(i>=0) and (i<FMaxI) and
         (j>=0) and (j<FMaxJ);
end;

constructor TMyScroll.Create;
begin
   FGX:=0;FGY:=0;
end;

function TMyScroll.GetI(x: integer): integer;
begin
   Result:=(x+GX) div ZoomX;
   if Result<0 then Result:=0;
   if Result>=MaxI then Result:=MaxI-1;
end;

function TMyScroll.GetJ(y: integer): integer;
begin
   Result:=(y+GY) div ZoomY;
   if Result<0 then Result:=0;
   if Result>=MaxJ then Result:=MaxJ-1;
end;

function TMyScroll.GetMaxX: integer;
begin
   Result:=FMaxI*ZoomX;
end;

function TMyScroll.GetMaxY: integer;
begin
   Result:=FMaxJ*ZoomY;
end;

function TMyScroll.GetX(i: integer): integer;
begin
   Result:=i*ZoomX-GX;
end;

function TMyScroll.GetY(j: integer): integer;
begin
   Result:=j*ZoomY-GY;
end;

procedure TMyScroll.SetGX(const Value: integer);
begin
  FGX := Value;
  if FScreenWidth<GetMaxX then
  begin
  	if FGX<-FScreenWidth div 2 then
     	FGX:=-FScreenWidth div 2 else
  		if FGX>GetMaxX-FScreenWidth div 2 then
     		FGX:=GetMaxX-FScreenWidth div 2;
  end else FGX:=(GetMaxX-FScreenWidth) div 2;
end;

procedure TMyScroll.SetGY(const Value: integer);
begin
  FGY:=Value;
  if FScreenHeight<GetMaxY then
  begin
  	if FGY<-FScreenHeight div 2 then
     	FGY:=-FScreenHeight div 2 else
  	if FGY>GetMaxY-FScreenHeight div 2 then
     	FGY:=GetMaxY-FScreenHeight div 2;
  end else FGY:=(GetMaxY-FScreenHeight) div 2;
end;

procedure TMyScroll.SetMaxI(const Value: integer);
begin
  FMaxI := Value;
end;

procedure TMyScroll.SetMaxJ(const Value: integer);
begin
  FMaxJ := Value;
end;

procedure TMyScroll.SetScreenHeight(const Value: integer);
begin
  FScreenHeight := Value;
end;

procedure TMyScroll.SetScreenWidth(const Value: integer);
begin
  FScreenWidth := Value;
end;

procedure TMyScroll.SetZoomX(const Value: integer);
begin
  FZoomX := Value;
end;

procedure TMyScroll.SetZoomY(const Value: integer);
begin
  FZoomY := Value;
end;

end.
