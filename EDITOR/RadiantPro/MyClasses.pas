unit MyClasses;

interface

uses Classes, Types, Graphics, BzLib;

type TMapEntry = packed record
        	EntryType : string[3];
        	DataSize : longint;
        	Reserved1 : byte;
        	Reserved2 : word;
        	Reserved3 : integer;
        	Reserved4 : longint;
        	Reserved5 : cardinal;
        	Reserved6 : boolean;
        end;

{type TWaypoint = packed record
        	x,y:byte;
        	number:byte;
        	zone:byte;
        	items:longword;
        	flags:word;
        end;


type TMAPOBJ = record   // специальный объект
        active : boolean;
        x,y,lenght,dir,wait : word;
        targetname,target,objtype,orient,nowanim,special : byte;
        end;}

type TBrick = record
        			image : byte;   // вот нафиг этот тип нужен???
					end;

type TMAPOBJV2 = record   // специальный объект
        active : boolean;
        x,y,length,dir,wait : word;
        targetname,target,orient,nowanim,special:word;
        objtype : byte;
        end;

//*******************************************
//А теперь... класс TMAP!!!!!!!
//*******************************************

type
    TBrickArray = array [0..254, 0..254] of TBrick;
    String64 = string[64];
    String70 = string[70];
    Array4 = array [1..4] of char;

type THeader = record   // header карты
          ID : Array4;
          Version : byte;
          MapName : string70;
          Author : string70;
          MapSizeX,MapSizeY,BG,GAMETYPE,numobj : byte;
          numlights : word;
        end;

 {1 - телерорт 2- переключатель 3- дверь 4- trigger
 	5-area_push 6- area_pain 7- area_trickarena_end 8- area_teleport
   9- door_trigger 10-area_waterillusion}

    TObjType = (otTeleport=1, otButton=2, otDoor=3, otTrigger=4,
     otAreaPush=5, otAreaPain=6, otAreaTrickarena_end=7,
     otAreaTeleport=8, otDoorTrigger=9, otAreaWaterIllusion=10);

const
   EmptyBrick : TBrick = (image: 0);
   DefHeader : THeader = (ID: ('N', 'M', 'A', 'P'); version: 3;
   	MapName: 'test map'; Author: 'unnamed';
   	MapSizeX:20; MapSizeY:30;BG : 0;GAMETYPE: 0);

type
   TLocationText = Packed Record
        Enabled : boolean;
        X, Y : byte;
        Text : String64;
	end;

type
    TMyObj = class
    private
        Fx,Fy,Flength,Fdir,Fwait : word;
        Ftargetname,Ftarget,Forient,Fnowanim,Fspecial:word;
        Fobjtype : TObjType;
        procedure SetValues(Obj : TMapOBJV2);
        function GetValues: TMapObjV2;
    procedure SetX(const Value: word);
    procedure SetY(const Value: word);
    function GetProps: string;
    function GetProp(name: string): integer;
    procedure SetProp(name: string; const Value: integer);
    function GetName: string;
    procedure SetObjType(const Value: TObjType);
    function GetRect: TRect;
    function GetMask(name: string): string;
    function GetPropsCount: integer;
    public
        property Values: TMapObjV2 read GetValues write SetValues;
        property X: word read FX write SetX;
        property Y: word read FY write SetY;
        property ObjType: TObjType read FObjType write SetObjType;
        property Props : string read GetProps;
        property Prop[name: string]: integer read GetProp write SetProp;
        property Mask[name: string]: string read GetMask;
        property PropsCount: integer read GetPropsCount;
        property Name: string read GetName;
        property Rect: TRect read GetRect;
           end;
type
    TLocation = class
    private
        FX, FY: byte;
        FText: String64;
        procedure SetValues(Loc : TLocationText);
    function GetValues: TLocationText;
    procedure SetX(const Value: byte);
    procedure SetY(const Value: byte);
    procedure SetText(const Value: String64);
    public
        property Values: TLocationText read GetValues write SetValues;
        property X: byte read FX write SetX;
        property Y: byte read FY write SetY;
        property Text: String64 read FText write SetText;
    end;

    TMap = class
    constructor Create;
    destructor Destroy;override;
  private
         {Брики, объекты, локации}
    FMaxY: byte;
    FMaxX: byte;
	 FBrk : TBrickArray;
  	 FObj : TList;
    FLocations : TList;
        {Паллитра}
    FCustomPaletteTransparent: boolean;
    FCustomPalette: boolean;
    FPalette: TBitmap;
    FCustomPaletteTransparentColor: TColor;
        {HEADER}

        {Автор и карта:)}
    FMapAuthor: String70;
    FMapName: String70;
        {Фон}
    FBackGround: byte;
        {Фигня всякая}
    FID: Array4;
    FGameType: byte;
    FVersion: byte;
    FNumLights: integer;

//TagName
    FTagName: string;

    function GetBrick(i, j: integer): TBrick;
    procedure SetBrick(i, j: integer; const Value: TBrick);
    procedure SetMaxX(const Value: byte);
    procedure SetMaxY(const Value: byte);
    function GetObj(i: integer): TMyObj;
    function GetObjCount: integer;
    procedure SetCustomPaletteTransparent(const Value: boolean);
    procedure SetCustomPaletteTransparentColor(const Value: TColor);
    procedure SetPalette(const Value: TBitmap);
    procedure SetCustomPalette(const Value: boolean);
    procedure SetMapAuthor(const Value: String70);
    procedure SetMapName(const Value: String70);
    procedure SetBackGround(const Value: byte);
    procedure SetGameType(const Value: byte);
    procedure SetID(const Value: Array4);
    procedure SetNumLights(const Value: integer);
    procedure SetVersion(const Value: byte);
    function GetHeader: THeader;
    procedure SetHeader(const Value: THeader);
    function GetLoc(i: integer): TLocation;
    function GetLocCount: integer;
    function GetBrk(i, j: integer): byte;
    procedure SetBrk(i, j: integer; const Value: byte);
    procedure SetTagName(const Value: string);
       public
           property Brick[i, j: integer]: TBrick read GetBrick write SetBrick;
           property Brk[i, j: integer]: byte read GetBrk write SetBrk;default;
           property MaxX: byte read FMaxX write SetMaxX;
           property MaxY: byte read FMaxY write SetMaxY;
           property Obj[i: integer]: TMyObj read GetObj;
           property ObjCount: integer read GetObjCount;
           property Locations[i: integer]: TLocation read GetLoc;
           property LocCount: integer read GetLocCount;

           function AddObj: TMyObj;
           procedure DeleteObj(i: integer);overload;
           procedure DeleteObj(obj_: TMyObj);overload;
           function AddLoc: TLocation;
           procedure DeleteLoc(i: integer);overload;
           procedure DeleteLoc(loc_: TLocation);overload;

           property Palette : TBitmap read FPalette write SetPalette;
           property CustomPalette: boolean read FCustomPalette write SetCustomPalette;
           property CustomPaletteTransparent: boolean read FCustomPaletteTransparent write SetCustomPaletteTransparent;
           property CustomPaletteTransparentColor: TColor read FCustomPaletteTransparentColor write SetCustomPaletteTransparentColor;
                   {MapNAme, MapAuthor}
           property ID: Array4 read FID write SetID;
           property NumLights: integer read FNumLights write SetNumLights;
           property MapName: String70 read FMapName write SetMapName;
           property MapAuthor: String70 read FMapAuthor write SetMapAuthor;
           property Version: byte read FVersion write SetVersion;
           property GameType: byte read FGameType write SetGameType;
           property BackGround: byte read FBackGround write SetBackGround;

           property Header : THeader read GetHeader write SetHeader;
                   {Открытие карты:) }
           procedure Clear;
           function Open037Map(FileName: string): integer;
           procedure SaveMap(FileName: string);
                   {Копирование в другое место:)}
           procedure Assign(Source: TMap);
           procedure CopyRect(x1, y1, x2, y2: integer; var Map: TMap; copyObj, copyLoc: boolean);
                   {Св-во для Undo Redo}
           property TagName: string read FTagName write SetTagName;
       end;

implementation

{ TMyObj }

function TMyObj.GetMask(name: string): string;
begin
   if (name='shootable') or
      (name='orientation') or
      (name='closed') or
      (name='fastclose') or
      (name='direction') then Result:='0;1; '
      else
      if (name='wait') then Result:='00000;1; '
         else Result:='000;1; ';
end;

function TMyObj.GetName: string;
begin
   case FObjType of
      otTeleport: Result:='TELEPORT';
      otButton: Result:='BUTTON';
      otDoor: Result:='DOOR';
      otTrigger: Result:='TRIGGER';
      otAreaPush: Result:='AREA PUSH';
      otAreaPain: Result:='AREA PAIN';
      otAreaTrickarena_end: Result:='TRICKARENA END';
      otAreaTeleport: Result:='AREA TELEPORT';
      otDoorTrigger: Result:='AREA TRIGGER';
      otAreaWaterIllusion: Result:='AREA WATERILLUSION';
   end;
end;

function TMyObj.GetProp(name: string): integer;
begin
   if name='pos x' then Result:=FX;
   if name='pos y' then Result:=FY;
   if name='goto x' then Result:=FLength;
   if name='goto y' then Result:=Fdir;
   if name='color' then Result:=Forient;
   if name='wait' then Result:=FWait;
   if name='target' then Result:=FTarget;
   if name='shootable' then Result:=FSpecial;
   if name='length x' then
      if Ord(ObjType)<=5 then Result:=FLength
         else Result:=FSpecial;
   if name='length y' then
      if Ord(ObjType)<=5 then Result:=FDir
         else Result:=FOrient;
   if name='orientation' then Result:=FOrient and 1;
   if name='closed' then Result:=1-((FOrient and 2) div 2);
   if name='fastclose' then Result:=FSpecial;
   if name='length' then Result:=FLength;
   if name='target name' then Result:=FTargetName;
   if name='direction' then Result:=FOrient;
   if name='pushspeed' then Result:=FSpecial;
   if name='dmginterval' then Result:=FNowanim;
   if name='dmg' then Result:=FDir;
end;

function TMyObj.GetProps : string;
begin
   case FObjType of
      otTeleport: Result:='pos x|pos y|goto x|goto y';
      otButton: Result:='pos x|pos y|color|wait|target|shootable';
      otDoor: Result:='pos x|pos y|orientation|length|closed|wait|fastclose|target name';
      otTrigger: Result:='pos x|pos y|length x|length y|wait|target';
      otAreaPush: Result:='pos x|pos y|length x|length y|wait|target|direction|pushspeed';
      otAreaPain: Result:='pos x|pos y|length x|length y|dmginterval|wait|target name|dmg';
      otAreaTrickarena_end: Result:='pos x|pos y|length x|length y';
      otAreaTeleport: Result:='pos x|pos y|length x|length y|goto x|goto y';
      otDoorTrigger: Result:='pos x|pos y|length|orientation|closed|target';
      otAreaWaterIllusion: Result:='pos x|pos y|length x|length y';
   end;
end;

function TMyObj.GetPropsCount: integer;
begin
   case FObjType of
      otTeleport: Result:=4;
      otButton: Result:=6;
      otDoor: Result:=8;
      otTrigger: Result:=6;
      otAreaPush: Result:=8;
      otAreaPain: Result:=8;
      otAreaTrickarena_end: Result:=4;
      otAreaTeleport: Result:=6;
      otDoorTrigger: Result:=6;
      otAreaWaterIllusion: Result:=4;
   end;
end;

function TMyObj.GetRect: TRect;
begin
   case FObjType of
   otTeleport:
      begin
      	Result.Left:=X-1;
         Result.Right:=X+1;
         Result.Top:=Y-2;
         Result.Bottom:=Y;
      end;
   otButton:
      begin
         Result.Left:=X;
         Result.Right:=X;
         Result.Top:=Y-1;
         Result.Bottom:=Y;
      end;
   otTrigger,
   otAreaPush:
      begin
         Result.Left:=X;
         Result.Right:=X+FLength-1;
         Result.Top:=Y;
         Result.Bottom:=Y+FDir-1;
      end;

   otAreaPain,
   otAreaTrickarena_end,
   otAreaTeleport,
   otAreaWaterIllusion:
     	begin
         Result.Left:=X;
         Result.Right:=X+FSpecial-1;
         Result.Top:=Y;
         Result.Bottom:=Y+FOrient-1;
     	end;

   otDoor,
   otDoorTrigger:
     begin
        Result.Left:=X;
        Result.Right:=X+(1-FOrient and 1)*(FLength-1);
        Result.Top:=Y;
        Result.Bottom:=Y+(FOrient and 1)*(FLength-1);
     end;
   end;
end;

function TMyObj.GetValues: TMapObjV2;
begin
   Result.active:=true;
   Result.x:=Fx;Result.y:=Fy;
   Result.length:=FLength;
   Result.Dir:=FDir;
   Result.Wait:=Fwait;
   Result.TargetName:=Ftargetname;
   Result.target:=Ftarget;
   Result.orient:=Forient;
   Result.nowanim:=Fnowanim;
   Result.Special:=Fspecial;
   Result.objtype:=Ord(Fobjtype);
end;

procedure TMyObj.SetObjType(const Value: TObjType);
begin
  FObjType := Value;
end;

procedure TMyObj.SetProp(name: string; const Value: integer);
begin
	if name='pos x' then FX:=Value;
   if name='pos y' then FY:=Value;
   if name='goto x' then FLength:=Value;
   if name='goto y' then Fdir:=Value;
   if name='color' then Forient:=Value;
   if name='wait' then FWait:=Value;
   if name='target' then FTarget:=Value;
   if name='shootable' then FSpecial:=Value;
   if name='length x' then
      if Ord(ObjType)<=5 then FLength:=Value
         else FSpecial:=Value;
   if name='length y' then
      if Ord(ObjType)<=5 then FDir:=Value
         else FOrient:=Value;
   if name='orientation' then
      if Value=0 then FOrient:=FOrient and not 1
         else FOrient:=FOrient or 1;
   if name='closed' then
   	if Value>=1 then FOrient:=FOrient and not 2
         else FOrient:=FOrient or 2;
   if name='fastclose' then FSpecial:=Value;
   if name='length' then FLength:=Value;
   if name='target name' then FTargetName:=Value;
   if name='direction' then FOrient:=Value;
   if name='pushspeed' then FSpecial:=Value;
   if name='dmginterval' then FNowanim:=Value;
   if name='dmg' then FDir:=Value;
end;

procedure TMyObj.SetValues(Obj: TMapOBJV2);
begin
   Fx:=Obj.x;Fy:=Obj.y;
   Flength:=Obj.Length;
   FDir:=Obj.Dir;
   Fwait:=Obj.Wait;
   Ftargetname:=Obj.TargetName;
   Ftarget:=Obj.target;
   Forient:=Obj.Orient;
   Fnowanim:=Obj.nowanim;
   Fspecial:=Obj.special;
   Fobjtype:=TObjType(obj.ObjType);
end;

procedure TMyObj.SetX(const Value: word);
begin
  FX := Value;
end;

procedure TMyObj.SetY(const Value: word);
begin
  FY := Value;
end;

{ TLocation }

function TLocation.GetValues: TLocationText;
begin
   Result.Enabled:=true;
   Result.X:=FX;
   Result.Y:=FY;
   Result.Text:=FText;
end;

procedure TLocation.SetText(const Value: String64);
begin
  FText := Value;
end;

procedure TLocation.SetValues(Loc: TLocationText);
begin
   FX:=Loc.X;
   FY:=Loc.Y;
   FText:=Loc.Text;
end;

procedure TLocation.SetX(const Value: byte);
begin
  FX := Value;
end;

procedure TLocation.SetY(const Value: byte);
begin
  FY := Value;
end;

{ TMap }

function TMap.AddLoc: TLocation;
var
   l: Tlocation;
begin
   l:=TLocation.Create;
   FLocations.Add(l);
   Result:=l;
end;

function TMap.AddObj: TMyObj;
var
   b: TMyObj;
begin
   b:=TMyObj.Create;
   FObj.Add(b);
   Result:=b;
end;

procedure TMap.Assign(Source: TMap);
var
   i: integer;
begin
   Source.Clear;
   Source.FMaxX:=FMaxX;
   Source.FMaxY:=FMaxY;
   Source.FBrk:=FBrk;
   for i:=0 to ObjCount-1 do
   	Source.AddObj.Values:=Obj[i].Values;
   for i:=0 to LocCount-1 do
      Source.AddLoc.Values:=Locations[i].Values;
   Source.Header:=Header;
   Source.Palette.Assign(Palette);
end;

procedure TMap.Clear;
begin
   while ObjCount>0 do
      DeleteObj(0);
   while LocCount>0 do
      DeleteLoc(0);
   FillChar(FBrk, SizeOf(TBrickArray), EmptyBrick.image);
   SetHeader(DefHeader);
   CustomPalette:=false;
end;

procedure TMap.CopyRect(x1, y1, x2, y2: integer; var Map: TMap; copyObj,
  copyLoc: boolean);
var
   i, j: integer;
   obj_: TMyObj;
begin
   Map.Clear;
   Map.FMaxX:=x2-x1+1;
   Map.FMaxY:=y2-y1+1;
   for i:=x1 to x2 do
      for j:=y1 to y2 do
         Map[i-x1, j-y1]:=Brk[i, j];
   if copyObj then
   	for i:=0 to ObjCount-1 do
         with Obj[i].Rect do
         if (Left>=x1) and (Right<=x2) and
            (Top>=y1) and (Bottom<=y2) then
            begin
                obj_:=Map.AddObj;
                obj_.Values:=Obj[i].Values;
                if (obj_.ObjType=otTeleport) or
                   (obj_.ObjType=otAreaTeleport) then
                begin
                   obj_.Prop['goto x']:=obj_.Prop['goto x']-x1;
                   obj_.Prop['goto y']:=obj_.Prop['goto y']-y1;
                end;
            end;
   if copyLoc then
   	for i:=0 to LocCount-1 do
         if (Locations[i].X>=x1) and (Locations[i].X<=x2) and
            (Locations[i].Y>=y1) and (Locations[i].Y<=y2) then
                Map.AddLoc.Values:=Locations[i].Values;
end;

constructor TMap.Create;
begin
   FObj:=TList.Create;
   FLocations:=TList.Create;
   FPalette:=TBitmap.Create;
   Clear;
end;

procedure TMap.DeleteLoc(i: integer);
begin
   TLocation(FLocations[i]).Free;
   FLocations.Delete(i);
end;

procedure TMap.DeleteLoc(loc_: TLocation);
begin
   DeleteLoc(FLocations.IndexOf(loc_));
end;

procedure TMap.DeleteObj(i: integer);
begin
   TMyObj(FObj[i]).Free;
   FObj.Delete(i);
end;

procedure TMap.DeleteObj(obj_: TMyObj);
begin
   DeleteObj(FObj.IndexOf(obj_));
end;

destructor TMap.Destroy;
begin
  FObj.Free;
  FLocations.Free;
  FPalette.Free;
  inherited;
end;

function TMap.GetBrick(i, j: integer): TBrick;
begin
   if (i>=0) and (i<maxx) and
      (j>=0) and (j<maxy)
      	then Result:=FBrk[i, j]
         else Result:=EmptyBrick;
end;

function TMap.GetBrk(i, j: integer): byte;
begin
   Result:=Brick[i, j].image;
end;

function TMap.GetHeader: THeader;
begin
   Result.ID:=FID;
   Result.Version:=FVersion;
   Result.MapName:=FMapName;
   Result.Author:=FMapAuthor;
   Result.MapSizeX:=FMaxX;
   Result.MapSizeY:=FMaxY;
   Result.BG:=FBackGround;
   Result.GAMETYPE:=FGameType;
   Result.numobj:=ObjCount;
   Result.numlights:=FNumLights;
end;

function TMap.GetLoc(i: integer): TLocation;
begin
   Result:=TLocation(FLocations[i]);
end;

function TMap.GetLocCount: integer;
begin
   Result:=FLocations.Count;
end;

function TMap.GetObj(i: integer): TMyObj;
begin
   Result:=TMyObj(FObj[i]);
end;

function TMap.GetObjCount: integer;
begin
   Result:=FObj.Count;
end;

//**************************************************************
// OPEN37MAP!!!
//**************************************************************

function TMap.Open037Map(FileName: string): integer;
var F, decompstr, PaletteStream : TMemoryStream;
    i, j: Integer;
    Header     : THeader;
    Obj: TMapObjV2;
    Location : TLocationText;
    buf : array [0..$FE] of byte;
    Entry : TMAPENTRY;

begin
  Result:=0;
  F := TMemoryStream.create;
  F.loadfromfile(filename);
  F.Read(Header, Sizeof(Header));
  if (header.ID <> 'NMAP') and (header.ID <> 'NDEM') then begin
        f.free;
        Result:=-1;
        exit;
        end;
  if (header.Version <> 3) then begin
        f.free;
        Result:=-2;
        exit;
        end;
  Clear;
  SetHeader(Header);
  for j := 0 to MaxY - 1 do begin
        f.read(buf, MaxX);
        for i := 0 to MaxX - 1 do
                FBrk[i, j].image := buf[i];
  end;
  for i := 0 to header.numobj-1 do
  begin
     f.Read(Obj,sizeof(Obj));
     AddObj.SetValues(Obj);
  end;

  while F.Position < f.size do begin
        f.read(entry,sizeof(entry));
        if entry.EntryType = 'pal' then
        begin // reading pal
           CustomPaletteTransparentColor := Entry.Reserved5;
           CustomPaletteTransparent := Entry.Reserved6;
           CustomPalette := TRUE;

           decompstr := TMemoryStream.Create;
           PaletteStream:=TMemoryStream.Create;
           decompstr.CopyFrom (F, Entry.Datasize);
           decompstr.position := 0;
           BZDecompress(decompstr,PaletteStream, nil);
           PaletteStream.Position:=0;

           // apply to scene...
           Palette.LoadFromStream(PaletteStream);
           palettestream.free;
           decompstr.free;
        end
   else if entry.EntryType = 'loc' then begin // reading location table.
                for i := 1 to Entry.DataSize div Sizeof(TLocationText) do
                begin
                   f.Read (Location, Sizeof(TLocationText));
                   AddLoc.SetValues(Location);
                end;
        end
   else f.position := f.position + Entry.DataSize;
  end;
  F.free;
end;

// END OPEN037MAP

//**************************************************************
// SAVEMAP!!!
//**************************************************************


procedure TMap.SaveMap(FileName: string);
var i, j : Integer;
    buf : array [0..$FE] of byte;
    Entry : TMapEntry;
    PaletteStream, CompressedPaletteStream, MapFile  :TMemoryStream;
    Head: THeader;
    obj_: TMapObjV2;
    loc_: TLocationText;
begin
  // Сохранение карте в формате nfkbeta031
  MapFile := TMemoryStream.Create;
  MapFile.Position := 0;
  MapFile.Size := 0;
  Head:=GetHeader;
  MapFile.Write(Head, Sizeof(THeader));
  for j:=0 to MaxY-1 do
  begin
      for i := 0 to MaxX-1 do
      	buf[i]:= Brk[i, j];
  		MapFile.Write(buf, MaxX);
  end;

  for i:=0 to ObjCount-1 do
  begin
     Obj_:=Obj[i].Values;
     MapFile.Write(Obj_, SizeOf(TMapObjV2));
  end;

  if CUSTOMPALETTE then
  begin
        FillChar(Entry, SizeOf(Entry), 0);
        Entry.EntryType := 'pal';
        Entry.Reserved5 := CUSTOMPALETTETRANSPARENTCOLOR;
        Entry.Reserved6 := CUSTOMPALETTETRANSPARENT;

        // do compression...
        	CompressedPaletteStream := TMemoryStream.Create;
         PaletteStream:=TMemoryStream.Create;
         Palette.SaveToStream(PaletteStream);
         PaletteStream.Position:=0;
        	BZCompress(PaletteStream, CompressedPaletteStream);
        	Entry.DataSize := CompressedPaletteStream.Size;
        	CompressedPaletteStream.Position := 0;
        	MapFile.Write(Entry,sizeof(Entry));
        	MapFile.CopyFrom(CompressedPaletteStream,CompressedPaletteStream.size);
        	CompressedPaletteStream.Free;
         PaletteStream.Free;
  end;

  Fillchar(entry,sizeof(entry),0);
  Entry.EntryType := 'loc';
  Entry.DataSize := sizeof(TLocationText)*LocCount;
  MapFile.Write(Entry,sizeof(Entry));
  for i := 0 to LocCount-1 do
  begin
     loc_:=Locations[i].Values;
     MapFile.Write(loc_, sizeof(TLocationText));
  end;

  MapFile.SaveToFile(FileName);
  MapFile.Free;
end;

// END SAVEMAP

procedure TMap.SetBackGround(const Value: byte);
begin
  FBackGround := Value;
end;

procedure TMap.SetBrick(i, j: integer; const Value: TBrick);
begin
   if (i>=0) and (i<maxx) and
      (j>=0) and (j<maxy)
      	then FBrk[i, j]:=value;
end;

procedure TMap.SetBrk(i, j: integer; const Value: byte);
var
   b: TBrick;
begin
   b.image:=Value;
   Brick[i, j]:=b;
end;

procedure TMap.SetCustomPalette(const Value: boolean);
begin
  FCustomPalette := Value;
end;

procedure TMap.SetCustomPaletteTransparent(const Value: boolean);
begin
  FCustomPaletteTransparent := Value;
end;

procedure TMap.SetCustomPaletteTransparentColor(const Value: TColor);
begin
  FCustomPaletteTransparentColor := Value;
end;

procedure TMap.SetGameType(const Value: byte);
begin
  FGameType := Value;
end;

procedure TMap.SetHeader(const Value: THeader);
begin
   FID:=Value.ID;
   FVersion:=Value.Version;
   FMapName:=Value.MapName;
   FMapAuthor:=Value.Author;
   FMaxX:=Value.MapSizeX;
   FMaxY:=Value.MapSizeY;
   FBackGround:=Value.BG;
   FGAMETYPE:=Value.GameType;
   Fnumlights:=Value.NumLights;
end;

procedure TMap.SetID(const Value: Array4);
begin
  FID := Value;
end;

procedure TMap.SetMapAuthor(const Value: String70);
begin
  FMapAuthor := Value;
end;

procedure TMap.SetMapName(const Value: String70);
begin
  FMapName := Value;
end;

procedure TMap.SetMaxX(const Value: byte);
begin
  FMaxX := Value;
end;

procedure TMap.SetMaxY(const Value: byte);
begin
  FMaxY := Value;
end;

procedure TMap.SetNumLights(const Value: integer);
begin
  FNumLights := Value;
end;

procedure TMap.SetPalette(const Value: TBitmap);
begin
  FPalette := Value;
end;

procedure TMap.SetTagName(const Value: string);
begin
  FTagName := Value;
end;

procedure TMap.SetVersion(const Value: byte);
begin
  FVersion := Value;
end;

end.
