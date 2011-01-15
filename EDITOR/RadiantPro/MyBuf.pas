unit MyBuf;

interface

uses Classes, Types, MyClasses;

type
   TMyBuffer = class
    constructor Create;
    destructor Destroy;override;
  private
    FCopies: TList;
    FCopiesCount: integer;
    FCurCopyIndex: integer;
    FMaxBuf: integer;
    function GetCopies(i: integer): TMap;
    procedure SetCurCopyIndex(const Value: integer);
    function GetCopiesCount: integer;
    procedure SetCopiesCount(const Value: integer);
    procedure SetMaxBuf(const Value: integer);
    function GetCurCopy: TMap;
   public
      property Copies[i: integer]: TMap read GetCopies;
      property CopiesCount: integer read GetCopiesCount;
      property CurCopyIndex: integer read FCurCopyIndex write SetCurCopyIndex;
      property CurCopy: TMap read GetCurCopy;
      property MaxBuf: integer read FMaxBuf write SetMaxBuf;
      function SetCurCopy(i: integer): TMap;
      function AddCopy(Map: TMap; tagname: string): TMap;

      procedure Clear;
   end;

implementation

{ TMyBuffer }

function TMyBuffer.AddCopy(Map: TMap; tagName: string): TMap;
var
   m: TMap;
begin
   if CurCopyIndex<FCopies.Count-1 then
   begin
      Inc(FCurCopyIndex);
      Map.Assign(Copies[FCurCopyIndex]);
      while FCurCopyIndex+1<FCopies.Count do
         FCopies.Delete(FCurCopyIndex+1);
   end else
      begin
      	Inc(FCurCopyIndex);      
      	m:=TMap.Create;
      	Map.Assign(m);
         FCopies.Add(m);
      	Result:=m;
      end;
   Copies[FCurCopyIndex].TagName:=TagName;
   if FCopies.Count>MaxBuf then
   begin
      FCopies.Delete(0);
      Dec(FCurCopyIndex);
   end;
end;

procedure TMyBuffer.Clear;
begin
   FCurCopyIndex:=-1;
   while FCopies.count>0 do
   begin
      Copies[0].Free;
      FCopies.Delete(0);
   end;
end;

constructor TMyBuffer.Create;
begin
   FCopies:=TList.Create;
   FCurCopyIndex:=-1;
end;

destructor TMyBuffer.Destroy;
begin
   Clear;
   FCopies.Free;
   inherited;
end;

function TMyBuffer.GetCopies(i: integer): TMap;
begin
   Result:=TMap(FCopies[i]);
end;

function TMyBuffer.GetCopiesCount: integer;
begin
   Result:=FCopies.Count;
end;

function TMyBuffer.GetCurCopy: TMap;
begin
   Result:=Copies[FCurCopyIndex];
end;

procedure TMyBuffer.SetCopiesCount(const Value: integer);
begin
  FCopiesCount := Value;
end;

function TMyBuffer.SetCurCopy(i: integer): TMap;
begin
   FCurCopyIndex:=i;
   Result:=CurCopy;
end;

procedure TMyBuffer.SetCurCopyIndex(const Value: integer);
begin
  FCurCopyIndex := Value;
end;

procedure TMyBuffer.SetMaxBuf(const Value: integer);
begin
  FMaxBuf := Value;
end;

end.
