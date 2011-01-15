{ -------------------------------------------------------

        NEED FOR KILL map editor.
        for NFK v0.37.

        Created BY 3d[Power]. 2001-2002
        http://powersite.narod.ru
        haz-3dpower@mail.ru

        SRC REQUIRES:
        Delphi 5.
        DelphiX (DelphiX2000_0717a).

        LICENSE:
        You can modify or upgrade this source code only if you do it for Need For Kill.
        Also u can use this source code for studies.
        Any other use is not resolved.

        Народ, без вареза пожалуйста. И старайтесь не спрашивать меня что тут и как сделано, разбирайтесь сами.

------------------------------------------------------- }

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Menus, DXDraws, DXClass, DXInput, ComCtrls,
  ImgList, ExtCtrls,shellapi, bzlib, PowerTiming;

type
  TForm1 = class(TForm)
    SaveDialog: TSaveDialog;
    OpenDlg: TOpenDialog;
    ImageList: TDXImageList;
    DXInput: TDXInput;
    DXDraw: TDXDraw;
    PopupMenu1: TPopupMenu;
    itisabrush1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    new1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox1: TGroupBox;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    ImageList1: TImageList;
    Screen1: TMenuItem;
    Showcrosslines1: TMenuItem;
    showspecialobjects1: TMenuItem;
    Configure1: TMenuItem;
    Mapproperities1: TMenuItem;
    Operations1: TMenuItem;
    Findmaperrors1: TMenuItem;
    conventer1: TMenuItem;
    N2: TMenuItem;
    LoadoldNFKbeta025map1: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Label6: TLabel;
    Selectobject1: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Label1: TLabel;
    Image1: TImage;
    Brushreplace1: TMenuItem;
    N4: TMenuItem;
    Brushreplace2: TMenuItem;
    NFKRadiantTutorial1: TMenuItem;
    N5: TMenuItem;
    Fillborder1: TMenuItem;
    Startselection1: TMenuItem;
    doselect_pop: TPopupMenu;
    Fill1: TMenuItem;
    Erase1: TMenuItem;
    FlipX1: TMenuItem;
    FlipY1: TMenuItem;
    Copy1: TMenuItem;
    N6: TMenuItem;
    Cansel1: TMenuItem;
    N7: TMenuItem;
    Paste1: TMenuItem;
    Buildnewbrickpalette1: TMenuItem;
    Cut1: TMenuItem;
    Showallteleportlinks1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SpeedButton4: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ListView1: TListView;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    ListView2: TListView;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    selectloc: TMenuItem;
    Showloc1: TMenuItem;
    TestLocations1: TMenuItem;
    DXTimer1: TPowerTimer;
    procedure FormCreate(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject);
    procedure DXDrawInitialize(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure itisabrush1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure saveclk(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure opnclk(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1DblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Showcrosslines1Click(Sender: TObject);
    procedure showspecialobjects1Click(Sender: TObject);
    procedure new1Click(Sender: TObject);
    procedure Findmaperrors1Click(Sender: TObject);
    procedure Mapproperities1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure LoadoldNFKbeta025map1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Selectobject1Click(Sender: TObject);
    procedure ListView1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure About1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure Brushreplace1Click(Sender: TObject);
    procedure Brushreplace2Click(Sender: TObject);
    procedure Extractmapfromdemo1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NFKRadiantTutorial1Click(Sender: TObject);
    procedure Fillborder1Click(Sender: TObject);
    procedure Startselection1Click(Sender: TObject);
    procedure SelectOpClick(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Buildnewbrickpalette1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Showallteleportlinks1Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure selectlocClick(Sender: TObject);
    procedure Showloc1Click(Sender: TObject);
    procedure TestLocations1Click(Sender: TObject);
    procedure ListView2KeyPress(Sender: TObject; var Key: Char);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

TYPE
        TBrick = record
        image : byte;   // graphix index

end;

type TWaypoint = packed record
        x,y:byte;
        number:byte;
        zone:byte;
        items:longword;
        flags:word;
        end;

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

Type TLocationText = Packed Record
        Enabled : boolean;
        X, Y : byte;
        Text : String [64];
end;

procedure Open037map(filename : string);

type THeader = record   // header карты
          ID : Array[1..4] of Char;
          Version : byte;
          MapName      : string[70];
          Author : string[70];
          MapSizeX,MapSizeY,BG,GAMETYPE,numobj : byte;
          numlights : word;
        end;

type TMAPOBJ = record   // специальный объект
        active : boolean;
        x,y,lenght,dir,wait : word;
        targetname,target,objtype,orient,nowanim,special : byte;
        end;

type TMAPOBJV2 = record   // специальный объект
        active : boolean;
        x,y,lenght,dir,wait : word;
        targetname,target,orient,nowanim,special:word;
        objtype : byte;
        end;

var
  Form1: TForm1;
  GX, GY : integer;                     // позиция "камеры"
  selx,sely, // выбранный брик по Х, У
  selbrk,    // выбранный браш из палитры брашей.
  mode,alph,RRRA : integer;
  bbb : array [0..254,0..254] of TBrick; // массив бриков (карта)
  ddd : array[0..255] of TMAPOBJV2;       // массив специальных объектов
  SELECTEDOBJ, SELECTEDLOC : integer;                // текуще выбранный спец объект
  itmsel : TListItem;                   // для добавления свойств в список свойств спец объекта

  brCopy : array [0..254,0..254] of byte;
  LocationsArray : array [1..50] of TLocationText;
  selbminx,selbminy ,
  selbmaxx,selbmaxy : word;
  PaletteFile : TBitmap;
  PaletteStream : TMemoryStream;


CONST   MAXBRUSH = 254;         // всего brush'ей
        MAX_BUF = 2048;         // буфер
        BRICK_X : byte = 20;    // 20
        BRICK_Y : byte = 30;       // 30
        MAP_NAME : string[70] = 'test map';
        MAP_AUTHOR : string[70] = 'unnamed';
        MAP_BG : byte = 0;      // задний фон карты
        SHOWLINES : boolean = true; // показывать диагональные линии
        SHOWOBJ : boolean = true; // показывать спец объекты
        DOSELECT : boolean = false; // селекция
        copysizex : byte = 0;   // копирование
        copysizey : byte = 0;   // копирование
        CUSTOMPALITRE : boolean=false; // своя палитра бриков.
        CUSTOMPALITREFILENAME : string='';
        CUSTOMPALITRETRANSPARENT : boolean =false;
        CUSTOMPALITRETRANSPARENTCOLOR : cardinal = $FFFFF;


procedure loadmapp (filename : string);
procedure BrushName;
procedure Location_Modify(ID:byte);

implementation
uses unit2, teleport_dlg, Unit4, Unit5, Unit6, brshrepls, palette_unit, unit2_locsel;
{$R *.DFM}

function ShiftKeyDown : boolean; begin result:=(Word(GetKeyState(VK_SHIFT)) and $8000)<>0; end;

procedure CleanUpMap;
begin
        if form1.speedbutton1.enabled then form1.speedbutton1.click;
        if form1.speedbutton13.enabled then form1.speedbutton13.click;

        FillChar(LocationsArray, sizeof(LocationsArray),0);
        SELECTEDOBJ := -1;
        SELECTEDLOC := 0;

end;

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin
form1.top := 0;
form1.left := 0;
form1.Width := 640;
form1.height := 480;
ImageList.Items.MakeColorTable;
selbrk := 1;
mode := 1;
alph := 255;
opendlg.initialdir := GetCurrentdir;
savedialog.InitialDir := GetCurrentdir;
for i := 0 to $ff do ddd[i].active := false;
// loadmapp('"'+paramstr(1)+'"');
SELECTEDOBJ := -1;
GX := 32;GY := 32;
PaletteFile := TBitmap.Create;
PaletteStream := TMemoryStream.Create;
CleanUpMap;
if paramstr(1) <> '' then if fileexists(paramstr(1)) then begin
        OpenDlg.InitialDir := extractfilepath(paramstr(1));
//        SaveDialog.initialdir := extractfilepath(paramstr(1));
        SaveDialog.filename := paramstr(1);
        Open037map(paramstr(1));
        end;

end;

procedure BrushName;
begin
with form1 do
        case selbrk of
        0 : label1.caption := 'Brush: none';
        1 : label1.caption := 'Brush: shotgun';
        2 : label1.caption := 'Brush: grenade launcher';
        3 : label1.caption := 'Brush: rocket launcher';
        4 : label1.caption := 'Brush: shaft';
        5 : label1.caption := 'Brush: railgun';
        6 : label1.caption := 'Brush: plasma';
        7 : label1.caption := 'Brush: bfg';
        8 : label1.caption := 'Brush: ammo for machinegun';
        9 : label1.caption := 'Brush: ammo for shotgun';
        10 : label1.caption := 'Brush: ammo for grenade launcher';
        11 : label1.caption := 'Brush: ammo for rocket launcher';
        12 : label1.caption := 'Brush: ammo for shaft';
        13 : label1.caption := 'Brush: ammo for railgun';
        14 : label1.caption := 'Brush: ammo for plasma';
        15 : label1.caption := 'Brush: ammo for bfg';
        16 : label1.caption := 'Brush: shard (+5)';
        17 : label1.caption := 'Brush: yellow armor (+50)';
        18 : label1.caption := 'Brush: red armor (+100)';
        19 : label1.caption := 'Brush: health +5';
        20 : label1.caption := 'Brush: health +25';
        21 : label1.caption := 'Brush: health +50';
        22 : label1.caption := 'Brush: megahealth +100';
        23 : label1.caption := 'Brush: powerup regeneration';
        24 : label1.caption := 'Brush: powerup battlesuit';
        25 : label1.caption := 'Brush: powerup haste';
        26 : label1.caption := 'Brush: powerup quaddamage';
        27 : label1.caption := 'Brush: powerup flight';
        28 : label1.caption := 'Brush: powerup invisibility';
        29 : label1.caption := 'Brush: grenade launcher for trix';
        30 : label1.caption := 'Brush: rocket launcher for trix';
        31 : label1.caption := 'Brush: lava';
        32 : label1.caption := 'Brush: water';
        33 : label1.caption := 'Brush: death area. kills player.';
        34 : label1.caption := 'Brush: respawn. neutral';
        35 : label1.caption := 'Brush: respawn. red team (CTF ONLY)';
        36 : label1.caption := 'Brush: respawn. blu team (CTF ONLY)';
        37 : label1.caption := 'Brush: empty brick';
        38 : label1.caption := 'Brush: jumppad';
        39 : label1.caption := 'Brush: strong jumppad';
        40 : label1.caption := 'Brush: red flag';
        41 : label1.caption := 'Brush: blue flag';
        42 : label1.caption := 'Brush: domination point';
        54..255 : label1.caption := 'Brush: brick';
        else  label1.caption := 'Brush: unknown';
        end;
end;

procedure Save1Click(Sender: TObject); // olde save 025 (or 031) map...
var i,b : byte;
    s : string;
    F : TFileStream;
begin
with form1 do begin
if(SaveDialog.execute) then begin
form2.showmodal;
if form2.ModalResult = mrCancel then begin showmessage('Save aborted :((('); exit; end;
if form2.mapname.text = '' then form2.mapname.text := 'noname';
s := 'A1!'+#$FF+form2.mapname.text+#$FF+form2.desc.text+#$FF+form2.author.text+#$FF+'s1'+#$FF+'s2'+#$FF+'s3'+#$FF+'s4'+#$FF;
for i := 0 to 29 do begin
for b := 0 to 19 do begin
                s := s + chr(bbb[b,i].image);
        end;
end;
s := s+#$FF;
F := TFileStream.Create(savedialog.filename, fmCreate);
F.Write (s[1], Length(s));
F.Free;
showmessage('Map "'+extractfilename(savedialog.filename)+'" saved');
end; // SaveDialog
end;
end;

// LOAD OLD NFKBETA025 MAP (Conventer).
procedure loadmapp (filename : string);
var tmpstr : string;
     F : tfilestream;
     buf : array [0..2048] of char;
     i,a,stp,tx,ty : integer;
begin
stp := 0; tmpstr := '';
tx := 0; ty := 0;
F := TFileStream.Create(filename, fmOpenRead);
F.Read (buf, MAX_BUF); // first read
for i := 0 to 250 do
for a := 0 to 250 do
        bbb[i,a].image := 0;
for i := 0 to 255 do
        ddd[i].active := false;
for i := 0 to MAX_BUF do begin
   if stp = 10 then break;
   if buf[i] = #$FF then begin inc(stp); end;
   if buf[i] = #$FF then begin
       if (stp = 1) then begin
               tmpstr:='';
               continue;
               end else
       if (stp = 2) then begin
               MAP_NAME := tmpstr;
               tmpstr:='';
               continue;
               end else
       if (stp = 3) then begin
               tmpstr:='';
               continue;
               end else
       if (stp = 4) then begin
               MAP_AUTHOR := tmpstr;
               tmpstr:='';
               continue;
               end else
       if (stp = 5) then begin
               tmpstr:='';
               continue;
               end else
       if (stp = 6) then begin
               tmpstr:='';
               continue;
               end else
       if (stp = 7) then begin
               tmpstr:='';
               continue;
               end else
       if (stp = 8) then begin
               tmpstr:='';
               continue;
               tx := 0; ty := 0;
               end else
   end;
      if (stp <= 7) and (i >= 3) then begin
               if buf[i] <> #$FF then tmpstr := tmpstr + buf[i];
      end;
      if (stp = 8) and (buf[i] <> #$FF) then begin
               bbb[tx,ty].image := ord(buf[i]);
               if(tx >= 19) then begin
                        tx := 0;
                        inc(ty);
               end else
               inc(tx);
      end;
end;
BRICK_X := 20;
BRICK_Y := 30;
MAP_BG := 0;
form1.SaveDialog.filename := extractfilename(form1.OpenDlg.filename);
f.free;
end;  // opendlg

// ищет ближайший location к курсору. нужно для тестирования того как игрок будет реагировать на локации.
procedure TestLocations;
var MINDIST,Dist:word;
    Selected, I:byte;
begin
        Selected := 0;
        MINDIST := $FFFF;
        for i:=1 to 50 do if LocationsArray[i].enabled then begin
                Dist := round(sqrt(sqr(LocationsArray[i].x*32 - selx*32)+sqr(LocationsArray[i].y*16 - sely*16)));
                if dist < MINDIST then
                begin
                        MINDIST := DIST;
                        SELECTED := I;
                end;
        end;

  if SELECTED > 0 then
  with form1.DXDraw.Surface.Canvas do
        begin
                Brush.Style := bsClear;
                font.name := 'verdana';
                font.style := [fsBold];
                Font.Color := clYellow;
                Font.Size := 8;
                Textout(5, 146, 'Zone: '+ LocationsARRAY[SELECTED].Text);
                Release; {  Indispensability }
        end;
end;

procedure Open1Click(Sender: TObject);
begin
with form1 do begin
if(opendlg.execute) then begin
        LOADMAPP (opendlg.filename);
end;end;

end; // proc


procedure TForm1.DXTimer1Timer(Sender: TObject);
var i,a,z : byte;
    xxx : TPoint;
    rct : TREct;
    s : string[$AA];
begin
  if not DXDraw.CanDraw then exit;
  GetCursorPos(xxx);
  xxx.x := xxx.x - form1.left-3;
  xxx.y := xxx.y - form1.top-40;
  rct := REct(0,0,181,78);
  DXDraw.Surface.Fill(0);


if SHOWOBJ then
        for i := 0 to $FF do if ddd[i].active = true then
        if ddd[i].objtype = 10 then // water pre draw..
        for z := 0 to ddd[i].special-1 do
        for a := 0 to ddd[i].orient-1 do
        ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, 8);

        // Draw Bricks
        for i := 0 to BRICK_X-1 do begin      // отрисовка кирпичей
        for a := 0 to BRICK_Y-1 do begin
            if bbb[i,a].image > 0 then
            if  (GX+i*32 < dxdraw.Width) and (GX+i*32 >= -32) and (GY+a*16 >= -16) and (GY+a*16 < dxdraw.Height) then

            begin
            if (CUSTOMPALITRE=true) and (bbb[i,a].image <= 181) and (bbb[i,a].image >= 54) then
            ImageList.Items[7].Draw(DXDraw.Surface,GX+i*32,GY+a*16, bbb[i,a].image-54) else // подргруженная юзером палитра бриков...
            ImageList.Items[0].Draw(DXDraw.Surface, GX+i*32,GY+a*16, bbb[i,a].image);
            end;
        end; end;

        // Draw Map Border
        with form1.DXDraw.surface.canvas do begin
                Brush.Style := bsClear;
                pen.color := rgb($FF,$0,$0);
                Pen.Style := psSolid;
                MoveTo(trunc(gx-1), trunc(gy-30));
                LineTo(trunc(gx-1), trunc(gy+16*brick_y+30));
                MoveTo(trunc(gx+32*BRICK_X+1), trunc(gy-30));
                LineTo(trunc(gx+32*BRICK_X+1), trunc(gy+16*brick_y+30));

                MoveTo(trunc(gx-30), trunc(gy-1));
                LineTo(trunc(gx+32*BRICK_X+30), trunc(gy-1));

                MoveTo(trunc(gx-30), trunc(gy+16*brick_y+1));
                LineTo(trunc(gx+32*BRICK_X+30), trunc(gy+16*brick_y+1));


                if SHOWLINES then begin
                        pen.color := rgb($ee,$cc,$cc);
                        MoveTo(trunc(gx), trunc(gy));
                        LineTo(trunc(gx+32*BRICK_X), trunc(gy+16*brick_y));
                        MoveTo(trunc(gx+32*BRICK_X), trunc(gy));
                        LineTo(trunc(gx), trunc(gy+16*brick_y));
                end;
                release;
        end;

// =======================
// Отрисовка спец объектов
// =======================
if SHOWOBJ then begin
  for i := 0 to $FF do if ddd[i].active = true then begin
                if ddd[i].objtype <> 9 then
                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32,GY+ddd[i].y*16, ddd[i].objtype-1);

                // !!!!!!!!!!!!!!!!!!!!!!!!!!!!
                // Show Object Selection
                if SELECTEDOBJ = i then begin
                        with form1.DXDraw.surface.canvas do begin
                                Brush.Style := bsClear;
                                pen.color := rgb($00,$FF,$FF);
                                Pen.Style := psDashDotDot;

                                if ddd[i].objtype = 1 then
                                rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX,ddd[i].y*16+20+GY);
                                if ddd[i].objtype = 2 then
                                rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX,ddd[i].y*16+20+GY);

                                if ddd[i].objtype = 3 then begin
                                        if (ddd[i].orient = 0) or (ddd[i].orient = 2) then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].lenght-32,ddd[i].y*16+20+GY) else
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX,ddd[i].y*16+20+GY+16*ddd[i].lenght-16);
                                end;
                                if ddd[i].objtype = 4 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].lenght-32,ddd[i].y*16+20+GY+16*ddd[i].dir-16);
                                if ddd[i].objtype = 5 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].lenght-32,ddd[i].y*16+20+GY+16*ddd[i].dir-16);
                                if ddd[i].objtype = 6 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].special-32,ddd[i].y*16+20+GY+16*ddd[i].orient-16);
                                if ddd[i].objtype = 7 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].special-32,ddd[i].y*16+20+GY+16*ddd[i].orient-16);
                                if ddd[i].objtype = 8 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].special-32,ddd[i].y*16+20+GY+16*ddd[i].orient-16);
                                if ddd[i].objtype = 9 then begin
                                        if (ddd[i].orient = 0) or (ddd[i].orient = 2) then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].lenght-32,ddd[i].y*16+20+GY) else
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX,ddd[i].y*16+20+GY+16*ddd[i].lenght-16);
                                end;
                                if ddd[i].objtype = 10 then
                                        rectangle(ddd[i].x*32-4+GX,ddd[i].y*16-4+GY,ddd[i].x*32+36+GX+32*ddd[i].special-32,ddd[i].y*16+20+GY+16*ddd[i].orient-16);
                                release;
                        end;
                end;


                // ... в зависимости от типа объекта
                if ddd[i].objtype = 3 then begin
                        if (ddd[i].orient = 0) or (ddd[i].orient = 2) then begin
                                for z := 0 to ddd[i].lenght-1 do ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16, ddd[i].objtype-1);
                                end else
                                for z := 0 to ddd[i].lenght-1 do ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32,GY+ddd[i].y*16+16*z, ddd[i].objtype-1);
                end;

                if ddd[i].objtype = 4 then begin
                                for z := 0 to ddd[i].lenght-1 do
                                for a := 0 to ddd[i].dir -1 do
                                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, ddd[i].objtype-1);
                end;
                if ddd[i].objtype = 5 then begin
                                for z := 0 to ddd[i].lenght-1 do
                                for a := 0 to ddd[i].dir -1 do
                                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, ddd[i].objtype-1);
                end;
                if ddd[i].objtype = 6 then begin
                                for z := 0 to ddd[i].special-1 do
                                for a := 0 to ddd[i].orient-1 do
                                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, ddd[i].objtype-1);
                end;
                if ddd[i].objtype = 7 then begin
                                for z := 0 to ddd[i].special-1 do
                                for a := 0 to ddd[i].orient-1 do
                                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, ddd[i].objtype-1);
                end;
                if ddd[i].objtype = 8 then begin
                                for z := 0 to ddd[i].special-1 do
                                for a := 0 to ddd[i].orient-1 do
                                ImageList.Items[4].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16+a*16, ddd[i].objtype-1);
                end;
                if ddd[i].objtype = 9 then begin // doortrigger draw
                        if (ddd[i].orient = 0) or (ddd[i].orient = 2) then begin
                        for z := 0 to ddd[i].lenght-1 do ImageList.Items[5].Draw(DXDraw.Surface, GX+ddd[i].x*32+32*z,GY+ddd[i].y*16, ddd[i].orient);
                        end else
                                for z := 0 to ddd[i].lenght-1 do ImageList.Items[5].Draw(DXDraw.Surface, GX+ddd[i].x*32,GY+ddd[i].y*16+16*z, ddd[i].orient);
                end;



                with form1.DXDraw.surface.canvas do begin
                        // подписать спец объекты
                        case ddd[i].objtype of
                        1 : s := 'teleport';
                        2 : s := 'button';
                        3 : s := 'door';
                        4 : s := 'trigger';
                        5 : s := 'area_push';
                        6 : s := 'area_pain';
                        7 : s := 'area_ta_end';
                        8 : s := 'area_teleport';
                        9 : s := 'doortrigger';
                        10 : s := 'area_waterillusion';
                        else s := 'unknown';
                        end;
                        s := s + '|#'+inttostr(i);
                        Font.Color := clYellow;
                        Font.Size := 8;
                        textout(GX+ddd[i].x*32,GY+ddd[i].y*16,s);

                        // показать куда ведет телепорт если он выбран.
                        if (ddd[i].objtype = 1) and ((SELECTEDOBJ = i) or (Showallteleportlinks1.checked)) then begin
                        Brush.Style := bsClear;
                        pen.color := rgb($FF,$FF,$0);
                        Pen.Style := psSolid;
                        MoveTo(GX+ddd[i].x*32+16, GY+ddd[i].y*16+8);
                        LineTo(GX+ddd[i].lenght*32+16, GY+ddd[i].dir*16+8);
                        end;

                        // показать куда ведет ареа_телепорт если он выбран.
                        if (ddd[i].objtype = 8) and ((SELECTEDOBJ = i) or (Showallteleportlinks1.checked)) then begin
                        Brush.Style := bsClear;
                        pen.color := rgb($FF,$FF,$0);
                        Pen.Style := psSolid;
                        MoveTo(GX+ddd[i].x*32+16, GY+ddd[i].y*16+8);
                        LineTo(GX+ddd[i].dir*32+16, GY+ddd[i].wait*16+8);
                        end;

                        release;
                end;

        end;
  end;

  // Display Locations.
  for i := 1 to 50 do if LocationsArray[i].Enabled = true then begin
          if (showloc1.checked) or  (i = SELECTEDLOC) then
          ImageList.Items[3].Draw(DXDraw.Surface, GX+LocationsArray[i].x*32-2,GY+LocationsArray[i].y*16-2, 1);
          with form1.DXDraw.surface.canvas do begin
//                moveto(GX+LocationsArray[i].x*32 -, GY+LocationsArray[i].y*16);
                if showloc1.checked then begin

                        if (i <> SELECTEDLOC) then
                        Pen.Style := psDot
                        else Pen.Style := psSolid;
  //                      if (i = SELECTEDLOC) then
                        pen.Color := clAqua;
//                        else pen.color := $00767600;
                        Brush.Style := bsclear;
                        Ellipse(GX+16+LocationsArray[i].x*32 - 20,
                        GY+8+LocationsArray[i].y*16 - 20,
                        GX+16+LocationsArray[i].x*32 + 20,
                        GY+8+LocationsArray[i].y*16 + 20);
                        Pen.Style := psSolid;

                        moveto(GX+16+LocationsArray[i].x*32 - 20,
                                GY+8+LocationsArray[i].y*16 - 20);
                        lineto(GX+16+LocationsArray[i].x*32 + 20,
                                GY+8+LocationsArray[i].y*16 + 20);

                        moveto(GX+16+LocationsArray[i].x*32 - 20,
                                GY+8+LocationsArray[i].y*16 + 20);
                        lineto(GX+16+LocationsArray[i].x*32 + 20,
                                GY+8+LocationsArray[i].y*16 - 20);
                end;

                 if (showloc1.checked) or (i = SELECTEDLOC) then begin
                        Brush.Style := bsClear;
                        font.name := 'verdana';
                        font.style := [fsBold];
                        if (i = SELECTEDLOC) then
                        Font.Color := clwhite
                        else Font.color := $eeeeee;
                        Font.Size := 8;
                        Textout(GX+25+LocationsArray[i].x*32 - textwidth(locationsarray[i].text) div 2 - 8, -12+GY+LocationsArray[i].y*16, LocationsArray[i].text);
                 end;

                release;
          end;
  end;

// =====================

  // плавная анимация палитры brush'ей
  if (xxx.x < 200) and (xxx.y < 90) then begin
        if alph > 3 then dec (alph,3);
        mode := 2
        end
        else begin
        if alph < 252 then inc (alph,3);
        mode :=1;
  end;


  ImageList.Items[2].DrawAlpha(DXDraw.Surface,rct, 0,alph);

  dxinput.update;

  // Отрисовать "кубик" вокруг текущего, выбранного брика.
  selx := (xxx.x-GX) div 32;
  sely := (xxx.y-GY) div 16;
  if selx > BRICK_X-1 then selx := BRICK_X-1;
  if selx < 0  then selx := 0;
  if sely < 0  then sely := 0;
  if sely > BRICK_Y-1 then sely := BRICK_Y-1;
  ImageList.Items[3].Draw(DXDraw.Surface, GX+selx*32-2,GY+sely*16-2, 0);


  if (isButton3 in dxinput.Mouse.States) or (DXInput.keyboard.keys[ord(27)]) then begin
        GX := GX + dxinput.Mouse.X;
        Gy := Gy + dxinput.Mouse.y;
  end;

  // селекция.
  if doselect then begin

        selbmaxx:=selx;
        selbmaxy:=sely;

        if selbmaxx < selbminx then selbmaxx := selbminx;
        if selx < selbminx then selx := selbminx;
        if selbmaxy < selbminy then selbmaxy := selbminy;
        if sely < selbminy then sely := selbminy;

        for i := selbminx to selbmaxx do
        for a := selbminy to selbmaxy do
                ImageList.Items[6].Draw(DXDraw.Surface, GX+i*32,GY+a*16, 0);
        ImageList.Items[6].Draw(DXDraw.Surface, GX+selbminx*32,GY+selbminy*16, 2);
        ImageList.Items[6].Draw(DXDraw.Surface, GX+selbmaxx*32,GY+selbmaxy*16, 1);

        if (isButton2 in dxinput.Mouse.States) or (DXInput.keyboard.keys[ord(27)]) then doselect := false;

        if isButton1 in dxinput.Mouse.States then begin
                sleep(10);
                doselect_pop.Popup (xxx.x,xxx.y);
                sleep(10);
        end;

  end;


//  dxinput.keyboard.update;
  // скроллинг карты по WSAD
  if DXInput.keyboard.keys[ord(#65)] then inc (GX,6);
  if DXInput.keyboard.keys[ord(#87)] then inc (GY,6);
  if DXInput.keyboard.keys[ord(#68)] then dec (GX,6);
  if DXInput.keyboard.keys[ord(#83)] then dec (GY,6);
  if DXInput.keyboard.keys[ord(#27)] then begin gx := 0; gy := 0; end;

  if isButton1 in DXInput.keyboard.States then
  begin
        bbb[selx,sely].image := selbrk;
  end;

  if isButton2 in DXInput.keyboard.States then
        bbb[selx,sely].image := 0;


  // скроллинг в палитре брашей
  if RRRA = 0 then begin
  if isLeft in DXInput.keyboard.States then begin
         if  isButton5 in DXInput.keyboard.States then begin
                if selbrk > 10 then selbrk := selbrk - 10 else selbrk := 0;
           end  else
          if selbrk > 0 then dec(selbrk);
          RRRA := 5;
         BrushName;
  end;

  // скроллинг в палитре брашей
  if isright in DXInput.keyboard.States then begin
         if isButton5 in DXInput.keyboard.States then begin
               if selbrk < MAXBRUSH then selbrk := selbrk + 10 else selbrk := MAXBRUSH;
         end  else

         if selbrk < MAXBRUSH then inc(selbrk);
         RRRA := 5;
         BrushName;
  end;
  end;

  // RRRA - это исключение слишком быстрого повторного нажатия кнопок.
  if RRRA > 0 then dec(RRRA);

  // Отрисовать видимые браши в палитре брашей
  for i := 0 to 3 do begin
          if selbrk <= MAXBRUSH then
          if mode = 1 then begin
                if (CUSTOMPALITRE=true) and (selbrk+i-3 <= 181) and (selbrk+i-3 >= 54) then
                ImageList.Items[7].Draw(DXDraw.Surface, 0+28+i*34,38, selbrk+i-3-54) else // подргруженная юзером палитра бриков...
                ImageList.Items[0].Draw(DXDraw.Surface, 0+28+i*34,38, selbrk+i-3);
          end;
  end;

  with DXDraw.Surface.Canvas do
        begin
                Brush.Style := bsClear;
                font.name := 'verdana';
                font.style := [fsBold];
                Font.Color := clWhite;
                Font.Size := 8;
                if mode = 1 then
                Textout(116, 9, inttostr(selbrk));
                Textout(5, 80, 'GX:'+inttostr(GX));
                Textout(5, 92, 'GY:'+inttostr(GY));
                Textout(5, 110, 'BRICKX:'+inttostr(selx));
                Textout(5, 122, 'BRICKY:'+inttostr(sely));
                Textout(5, 134, 'BRUSH:'+inttostr(bbb[selx,sely].image));
                Release; {  Indispensability }
        end;

  if (TestLocations1.checked) then
        TestLocations;


  DXDraw.Flip;
end;

procedure TForm1.DXDrawInitialize(Sender: TObject);
begin
DXTimer1.MayProcess := True;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var i : byte;
begin
// Меню по правой кнопке мыши.
        try
                itisabrush1.caption := 'Select Brush: '+inttostr(bbb[selx,sely].image);
        except itisabrush1.caption := 'unknown'; end;

        Selectobject1.visible := false;
        selectloc.visible := false;

        if (copysizex=0) or (copysizey=0) then Paste1.visible := false else Paste1.visible := true;

        for i := 0 to 255 do if ddd[i].active = true then begin
                if (ddd[i].x = selx) and (ddd[i].y = sely) then
                begin
                Selectobject1.visible := true;
                Selectobject1.caption := 'Select object: #'+inttostr(i);
                break;
                end;
        end;

        for i := 1 to 50 do if LocationsArray[i].enabled = true then
                if (LocationsArray[i].x = selx) and (LocationsArray[i].y = sely) then
                begin
                        selectloc.visible := true;
                        selectloc.caption := 'Select location: #'+inttostr(i);
                        break;
                end;

end;

procedure TForm1.itisabrush1Click(Sender: TObject);
begin
try
selbrk := bbb[selx,sely].image;
brushname;
except exit; end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
dxdraw.initialize;
dxtimer1.MayProcess := true;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
dxdraw.finalize;
dxtimer1.MayProcess := false;
end;

procedure TForm1.saveclk(Sender: TObject);
var F : File;
    i,a : Integer;
    Header     : THeader;
    buf : array [0..$FE] of byte;
    Entry : TMapEntry;
    CompressedPaletteStream, MapFile  :TMemoryStream;
    ProgressCallBack : TProgressEvent;
begin
  // Сохранение карте в формате nfkbeta031
  if SaveDialog.filename <> '' then
        SaveDialog.initialdir := extractfilepath(SaveDialog.filename);
//        showmessage(SaveDialog.initialdir);
//        end;

  if not (SaveDialog.execute) then exit;

  MapFile := TMemoryStream.Create;
  MapFile.Position := 0;
  MapFile.Size := 0;

  header.ID      := 'NMAP';
  header.Version := 3;
  header.Author := MAP_AUTHOR;
  header.mapname := MAP_NAME;
  header.BG := MAP_BG;
  header.MapSizeX := BRICK_X;
  header.MapSizeY := BRICK_Y;
  header.GAMETYPE := 0;
  a:= 0;
  for i := 0 to $FF do if ddd[i].active = true then inc(a);
  header.numobj := a;
  header.numlights := 0;
  header.GAMETYPE := 0;
  MapFile.Write(Header, Sizeof(Header));
  for a := 0 to BRICK_Y-1 do begin
          for i := 0 to BRICK_X do buf[i]:= bbb[i,a].image ;
          MapFile.Write(buf, BRICK_X);
  end;
  for i := 0 to $FF do
        if ddd[i].active = true then
                MapFile.Write(ddd[i],sizeof(ddd[i]));

  if CUSTOMPALITRE then begin
        Entry.EntryType := 'pal';
        Entry.Reserved1 := 0;
        Entry.Reserved2 := 0;
        Entry.Reserved3 := 0;
        Entry.Reserved4 := 0;
        Entry.Reserved5 := CUSTOMPALITRETRANSPARENTCOLOR;
        Entry.Reserved6 := CUSTOMPALITRETRANSPARENT;

        try
        // do compression...
//        PaletteStream := TMemoryStream.Create;
  //      PaletteStream.Clear;
        CompressedPaletteStream := TMemoryStream.Create;
        CompressedPaletteStream.Clear;
//        PaletteStream.LoadFromFile(CUSTOMPALITREFILENAME);
        PaletteStream.Position := 0;
        ProgressCallBack := nil;
        BZCompress(PaletteStream, CompressedPaletteStream,ProgressCallBack);
        Entry.DataSize := CompressedPaletteStream.Size;
        CompressedPaletteStream.Position := 0;
        MapFile.Write(Entry,sizeof(Entry));
        MapFile.CopyFrom(CompressedPaletteStream,CompressedPaletteStream.size);
//        PaletteStream.Free;
        CompressedPaletteStream.Free;
        except showmessage('ERROR: Cannot compress palette file... may be source file does not exists...'); end;

  end;

  // save locations entry
  a := 0;
  for i := 1 to 50 do if LocationsArray[i].Enabled = true then inc(a);
  if a > 0 then begin
        fillchar(entry,sizeof(entry),0);
        Entry.EntryType := 'loc';
        Entry.DataSize := sizeof(TLocationText)*a;
        MapFile.Write(Entry,sizeof(Entry));
        for i := 1 to 50 do if LocationsArray[i].Enabled = true then
                MapFile.Write(LocationsArray[i],sizeof(LocationsArray[i]));
  end;

  MapFile.SaveToFile(SaveDialog.filename);
  MapFile.Free;

end;

procedure Loadv031map(filename:string);
var tempobj : TMapOBJ;
    f : file;
    header : THeader;
    i,a,z : word;
    buf : array [0..$FE] of byte;

begin
        if not fileexists(filename) then begin showmessage(filename+' not found.');exit; end;
        AssignFile(F, filename);
        Reset(F,1);
        BlockRead(F, Header, Sizeof(Header));
        if (header.ID <> 'NMAP') and (header.ID <> 'NDEM') then begin
        closefile(f);
        showmessage(filename + ' is not NFK map');
        exit;
        end;
        if (header.Version >= 3) then begin
        closefile(F);
        showmessage('incorrect map version ('+inttostr(header.version)+'). Im can load only earlier map.');
        exit;
        end;

        form1.savedialog.FileName := filename;
        form1.savedialog.InitialDir := extractfilepath(filename);


        for i := 0 to 255 do
                ddd[i].active := false;
        MAP_AUTHOR := header.Author;
        MAP_NAME := header.MapName ;
        MAP_BG := header.BG;
        BRICK_X := header.MapSizeX ;
        BRICK_Y := header.MapSizeY;
        for a := 0 to header.MapSizeY - 1 do begin
        blockread(f,buf,header.MapSizeX);
        for z := 0 to header.MapSizeX - 1 do begin
                // convert it here!
                bbb[z,a].image := buf[z];
                if buf[z]=9 then bbb[z,a].image := 8;
                if buf[z]=10 then bbb[z,a].image := 9;
                if buf[z]=11 then bbb[z,a].image := 10;
                if buf[z]=12 then bbb[z,a].image := 11;
                if buf[z]=13 then bbb[z,a].image := 12;
                if buf[z]=14 then bbb[z,a].image := 13;
                if buf[z]=15 then bbb[z,a].image := 14;
                if buf[z]=16 then bbb[z,a].image := 15;
                if buf[z]=17 then bbb[z,a].image := 16;
                if buf[z]=18 then bbb[z,a].image := 17;
                if buf[z]=19 then bbb[z,a].image := 18;
                if buf[z]=20 then bbb[z,a].image := 20;
                if buf[z]=21 then bbb[z,a].image := 21;
                if buf[z]=22 then bbb[z,a].image := 22;
                if buf[z]=23 then bbb[z,a].image := 19;
                if buf[z]=24 then bbb[z,a].image := 23;
                if buf[z]=25 then bbb[z,a].image := 24;
                if buf[z]=26 then bbb[z,a].image := 25;
                if buf[z]=27 then bbb[z,a].image := 26;
                if buf[z]=8 then bbb[z,a].image := 27;
                if buf[z]=28 then bbb[z,a].image := 29;
                if buf[z]=29 then bbb[z,a].image := 30;
                if buf[z]=30 then bbb[z,a].image := 37;
                if buf[z]=31 then bbb[z,a].image := 39;
                if buf[z]=32 then bbb[z,a].image := 33;
                if buf[z]=33 then bbb[z,a].image := 38;
                if buf[z]=34 then bbb[z,a].image := 31;
                if buf[z]=35 then bbb[z,a].image := 34;
                if buf[z]>=36 then bbb[z,a].image := 54 + buf[z]- 36;
                end;
        end;

                if header.numobj > 0 then
                for a := 0 to header.numobj-1 do begin
                       blockread(f,tempobj,sizeof(tempobj));
                       ddd[a].active := tempobj.active;
                       ddd[a].x := tempobj.x;
                       ddd[a].y := tempobj.y;
                       ddd[a].lenght := tempobj.lenght;
                       ddd[a].dir := tempobj.dir;
                       ddd[a].wait := tempobj.wait;
                       ddd[a].targetname := tempobj.targetname;
                       ddd[a].target := tempobj.target;
                       ddd[a].orient := tempobj.orient;
                       ddd[a].nowanim := tempobj.nowanim;
                       ddd[a].special:= tempobj.special;
                       ddd[a].objtype := tempobj.objtype;
                end;
        CloseFile(F);

end;


procedure Open037map(filename : string); // open 040 map.
var F, decompstr : TMemoryStream;
    i,a,z : Integer;
    Header     : THeader;
    buf : array [0..$FE] of byte;
    Entry : TMAPENTRY;
    ProgressCallback : TProgressEvent;
    tempbmp : TBitmap;
begin

  Form1.listview1.Items.Clear;

  F := TMemoryStream.create;
  F.loadfromfile(filename);
  F.Read(Header, Sizeof(Header));

  if (header.ID <> 'NMAP') and (header.ID <> 'NDEM') then begin
        f.free;
        showmessage(filename + ' is not NFK map');
        exit;
        end;

  if (header.Version <> 3) then begin
        f.free;
        showmessage('incorrect map version ('+inttostr(header.version)+'). Only version 3 supported.');
        exit;
        end;

  for i := 0 to 255 do
        ddd[i].active := false;

  CleanUpMap;
  fillchar(LocationsArray, sizeof(LocationsArray),0);

  form1.SaveDialog.filename := filename;
  MAP_AUTHOR := header.Author;
  MAP_NAME := header.MapName ;
  MAP_BG := header.BG;
  BRICK_X := header.MapSizeX ;
  BRICK_Y := header.MapSizeY;
  for a := 0 to header.MapSizeY - 1 do begin
        f.read(buf,header.MapSizeX);
        for z := 0 to header.MapSizeX - 1 do
                bbb[z,a].image := buf[z];
  end;
  for a := 0 to header.numobj-1 do
       f.read(ddd[a],sizeof(ddd[a]));

  if CUSTOMPALITRE then palette.button1.click; // clear old palette.


  while F.Position < f.size do begin
        f.read(entry,sizeof(entry));
        if entry.EntryType = 'pal' then begin // reading pal
                CUSTOMPALITRETRANSPARENTCOLOR := Entry.Reserved5;
                CUSTOMPALITRETRANSPARENT := Entry.Reserved6;
                CUSTOMPALITRE := TRUE;

                decompstr := TMemoryStream.Create;
                decompstr.clear;
                PaletteStream.Clear;
                decompstr.CopyFrom (F, Entry.Datasize);
                decompstr.position := 0;
                ProgressCallback := nil;
                BZDecompress(decompstr,PaletteStream,ProgressCallback);
                palettestream.Position := 0;
                decompstr.free;

                // apply to scene...
                PaletteFile.loadfromstream(PaletteStream);
                form1.ImageList.Items[7].picture.assign(PaletteFile);
                form1.ImageList.Items[7].Transparent := CUSTOMPALITRETRANSPARENT;
                form1.ImageList.Items[7].TransparentColor := CUSTOMPALITRETRANSPARENTCOLOR;
                form1.ImageList.Items[7].restore;
        end
        else if entry.EntryType = 'loc' then begin // reading location table.
                For a := 1 to Entry.DataSize div Sizeof(TLocationText) do
                        f.Read (LocationsArray[a],sizeof(TLocationText));
        end
        else f.position := f.position + Entry.DataSize;
  end;

  F.free;
end;

procedure TForm1.opnclk(Sender: TObject);
var F : File;
    i,a,z : Integer;
    Header     : THeader;
    buf : array [0..$FE] of byte;
begin
  // Открытие карты nfkbeta030 или nfkbeta031.
  if opendlg.filter = 'extractor' then  opendlg.filter := 'Nfk demo (*.ndm)|*.ndm' else
  opendlg.filter := 'Nfk maps (*.mapa)|*.mapa';
  if extractfilepath(opendlg.filename) <> '' then begin
        opendlg.initialdir := extractfilepath(opendlg.filename);
        savedialog.initialdir := extractfilepath(opendlg.filename);
        end;
if not (opendlg.execute) then exit;

        Open037map( opendlg.filename);

end;


procedure TForm1.FormResize(Sender: TObject);
begin
// Изменение размеров
form1.dxdraw.width  := form1.width - 170;
form1.dxdraw.height := form1.height - 60;
groupbox1.left := form1.width - 165;
image1.left := form1.width - 135;
image1.top := 490;
pagecontrol1.left := form1.width - 165;
end;


procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
if item = nil then exit;
label2.caption := item.Caption;
itmsel := item;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
// Редактирование свойств в списке спец объектов.
var n,s : string;
nn : integer;
begin
//showmessage(itmsel.Caption);
if ddd[SELECTEDOBJ].objtype = 1 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='goto_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='goto_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='goto_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='goto_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].dir  := nn;
                        itmsel.SubItems.Text := n;
                        end;

end;
if ddd[SELECTEDOBJ].objtype = 2 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='color' then  s := 'value(0-5). (0=grn;1=red;2=blu;3=aqua;4=fuch;5=olive)';
        if itmsel.Caption ='shootable' then  s := 'value(0-1). (0=no, 1=yes)';
        if itmsel.Caption ='wait' then  s := 'value(10-65535). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='target' then  s := 'value(0-255). target to activate. 0=no target.';
        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='color' then if (nn < 0) or (nn > 5) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='shootable' then if (nn < 0) or (nn > 1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='wait' then if (nn < 10) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].wait  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='target' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].target  := nn;
                        itmsel.SubItems.Text := n;
                        end;

end;

if ddd[SELECTEDOBJ].objtype = 3 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='orientation' then begin s := 'value(0-3).';
                showmessage('value:'+#13+'0=closed, horizontal'+#13+'1=closed, vertical'+#13+'2=opened, horizontal'+#13+'3=opened, vertical');
                end;
        if itmsel.Caption ='wait' then  s := 'value(10-65535). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='targetname' then  s := 'value(0-255). targetname to be activated, 0=no targetname.';
        if itmsel.Caption ='lenght' then  s := 'value(1-255). door lenght (bricks)';
        if itmsel.Caption ='fastclose' then  s := 'value(0-1). 0=no. 1=yes';

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='orientation' then if (nn < 0) or (nn > 3) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='wait' then if (nn < 10) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].wait  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='targetname' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].targetname  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='fastclose' then if (nn < 0) or (nn > 1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;

if ddd[SELECTEDOBJ].objtype = 4 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-255).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-255).';
        if itmsel.Caption ='wait' then  s := 'value(1-65535). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='target' then  s := 'value(0-255). target to activate, 0=no target.';

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].dir := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='target' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].target := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='wait' then if (nn < 1) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].wait  := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;
if ddd[SELECTEDOBJ].objtype = 5 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-255).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-255).';
        if itmsel.Caption ='wait' then  s := 'value(1-65535). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='target' then  s := 'value(0-255). target to activate, 0=no target.';
        if itmsel.Caption ='pushspeed' then  s := 'value(10-70). 10=very slow; 70=very fast.';
        if itmsel.Caption ='direction' then begin
                 showmessage('value:'+#13+'0=push left'+#13+'1=push up'+#13+'2=push right'+#13+'3=push down');
                 s := 'value(0-3).';
                 end;

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].dir := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='target' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].target := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='direction' then if (nn < 0) or (nn > 3) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='wait' then if (nn < 1) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].wait  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pushspeed' then if (nn < 10) or (nn > 70) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;

if ddd[SELECTEDOBJ].objtype = 6 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-255).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-255).';
        if itmsel.Caption ='dmginterval' then  s := 'value(1-255). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='wait' then  s := 'value(1-65535). 50 - means 1 second. 100=2sec. etc';
        if itmsel.Caption ='targetname' then  s := 'value(0-255). targetname to be actvtd, 0=no need to actvtd.';
        if itmsel.Caption ='dmg' then  s := 'value(1-500). Makes the specified damage.';

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='targetname' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].targetname := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='dmg' then if (nn < 1) or (nn > 500) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].dir := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='dmginterval' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].nowanim := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='wait' then if (nn < 1) or (nn > $FFFF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght  := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;
if ddd[SELECTEDOBJ].objtype = 7 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-255).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-255).';
        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;
if ddd[SELECTEDOBJ].objtype = 8 then begin
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-255).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-255).';
        if itmsel.Caption ='goto_x' then s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='goto_y' then s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;

        if itmsel.Caption ='goto_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].dir  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='goto_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].wait  := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;
if ddd[SELECTEDOBJ].objtype = 9 then begin // DOOR TRIGGED, Property edit.
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='orientation' then begin s := 'value(0-3).';
                showmessage('value:'+#13+'0=up'+#13+'1=left'+#13+'2=down'+#13+'3=right');
                end;
        if itmsel.Caption ='target' then  s := 'value(0-255). target to activate, 0=no target';
        if itmsel.Caption ='lenght' then  s := 'value(1-255). door lenght (bricks)';
        if itmsel.Caption ='fastclose' then  s := 'value(0-1). 0=no. 1=yes';

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='orientation' then if (nn < 0) or (nn > 3) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='target' then if (nn < 0) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].target  := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght' then if (nn < 1) or (nn > $FF) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].lenght := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;
if ddd[SELECTEDOBJ].objtype = 10 then begin // AREA_WATERILLUSION, Property edit.
        if itmsel.Caption ='pos_x' then  s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then  s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='lenght_x' then s := 'value(1-4).';
        if itmsel.Caption ='lenght_y' then s := 'value(1-4).';

        if not inputquery('edit object property "'+itmsel.Caption+'"',s,n) then exit;
        try strtoint(n);
        except showmessage('invalid value "'+n+'"'); exit; end;

        nn := strtoint(n);

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].x := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].y := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_x' then if (nn < 1) or (nn > 4) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].special := nn;
                        itmsel.SubItems.Text := n;
                        end;
        if itmsel.Caption ='lenght_y' then if (nn < 0) or (nn > 4) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        ddd[SELECTEDOBJ].orient := nn;
                        itmsel.SubItems.Text := n;
                        end;
end;

end;


procedure addprop (st1, st2 : string);
var item : TListItem;
begin
item := form1.listview1.items.add;
item.caption := st1;
item.SubItems.Add(st2);
end;

procedure addprop_loc (st1, st2 : string);
var item : TListItem;
begin
item := form1.listview2.items.add;
item.caption := st1;
item.SubItems.Add(st2);
end;


procedure ADDobjPROP(nn:integer;n : string);
begin
// Добавление свойств объекта в список свойств.
with Form1 do begin

if ddd[nn].objtype = 1 then begin
label3.caption := 'TELEPORT | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('goto_x',inttostr(ddd[nn].lenght));
addprop('goto_y',inttostr(ddd[nn].dir));
end;

if ddd[nn].objtype = 2 then begin
label3.caption := 'BUTTON | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('color',inttostr(ddd[nn].orient));
addprop('wait',inttostr(ddd[nn].wait));
addprop('target',inttostr(ddd[nn].target));
addprop('shootable',inttostr(ddd[nn].special));
end;

if ddd[nn].objtype = 3 then begin
label3.caption := 'DOOR | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('orientation',inttostr(ddd[nn].orient));
addprop('wait',inttostr(ddd[nn].wait));
addprop('fastclose',inttostr(ddd[nn].special));
addprop('targetname',inttostr(ddd[nn].targetname));
addprop('lenght',inttostr(ddd[nn].lenght));
end;

if ddd[nn].objtype = 4 then begin
label3.caption := 'TRIGGER | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].lenght));
addprop('lenght_y',inttostr(ddd[nn].dir));
addprop('wait',inttostr(ddd[nn].wait));
addprop('target',inttostr(ddd[nn].target));
end;
if ddd[nn].objtype = 5 then begin
label3.caption := 'AREA_PUSH | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].lenght));
addprop('lenght_y',inttostr(ddd[nn].dir));
addprop('wait',inttostr(ddd[nn].wait));
addprop('target',inttostr(ddd[nn].target));
addprop('direction',inttostr(ddd[nn].orient));
addprop('pushspeed',inttostr(ddd[nn].special));
end;
if ddd[nn].objtype = 6 then begin
label3.caption := 'AREA_PAIN | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].special));
addprop('lenght_y',inttostr(ddd[nn].orient));
addprop('dmginterval',inttostr(ddd[nn].nowanim));
addprop('wait',inttostr(ddd[nn].lenght));
addprop('targetname',inttostr(ddd[nn].targetname));
addprop('dmg',inttostr(ddd[nn].dir));
end;
if ddd[nn].objtype = 7 then begin
label3.caption := 'AREA_TA_END | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].special));
addprop('lenght_y',inttostr(ddd[nn].orient));
end;
if ddd[nn].objtype = 8 then begin
label3.caption := 'AREA_TELEPORT | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].special));
addprop('lenght_y',inttostr(ddd[nn].orient));
addprop('goto_x',inttostr(ddd[nn].dir));
addprop('goto_y',inttostr(ddd[nn].wait));
end;
if ddd[nn].objtype = 9 then begin
label3.caption := 'DOORTRIGGER | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('orientation',inttostr(ddd[nn].orient));
addprop('target',inttostr(ddd[nn].target));
addprop('lenght',inttostr(ddd[nn].lenght));
end;
if ddd[nn].objtype = 10 then begin
label3.caption := 'AREA_WATERILLUSION | #'+n;
addprop('pos_x',inttostr(ddd[nn].x));
addprop('pos_y',inttostr(ddd[nn].y));
addprop('lenght_x',inttostr(ddd[nn].special));
addprop('lenght_y',inttostr(ddd[nn].orient));
end;

end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
n : string;
nn : integer;
begin
showspecialobjects1.Checked := true;
SHOWOBJ := true;
form4.showmodal;
if SELECTEDOBJ < 0 then exit;
listview1.Items.Clear;
speedbutton1.enabled := true;
speedbutton2.enabled := true;
speedbutton3.enabled := false;
speedbutton4.enabled := false;
listview1.enabled := true;
nn := SELECTEDOBJ;
n := inttostr(nn);
ADDOBJPROP   (nn,n);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
// Нажали на кнопку APPLY. Убирам редактирование текущего, выбранного объекта
if SELECTEDOBJ < 0 then begin
        showmessage('no special object selected.');
        exit;
        end;

SELECTEDOBJ := -1;
listview1.Items.Clear;
label3.caption := 'not selected';
label2.caption := '';
speedbutton1.enabled := false;
speedbutton2.enabled := false;
speedbutton3.enabled := true;
speedbutton4.enabled := true;
listview1.enabled := false;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
// Удаление объекта
begin
if SELECTEDOBJ < 0 then begin
        showmessage('no special object selected.');
        exit;
        end;
case MessageDlg ('delete object #'+inttostr(SELECTEDOBJ)+' ?', mtConfirmation, [mbYes,mbNo], 0) of
IDNO : exit;
end;
ddd[SELECTEDOBJ].active := false;
SELECTEDOBJ := -1;
listview1.Items.Clear;
label3.caption := 'not selected';
label2.caption := '';
speedbutton1.enabled := false;
speedbutton2.enabled := false;
speedbutton3.enabled := true;
speedbutton4.enabled := true;
listview1.enabled := false;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var i : byte;
begin
        // Добавление нового спец объекта
        if SELECTEDOBJ >= 0 then begin
        showmessage('finish editing current object');
        exit;
        end;

        form3.showmodal;
        if form3.ModalResult = mrOK then begin // add new obj
                for i := 0 to $FF do if ddd[i].active = false then begin
                        if form3.RadioButton1.checked then begin        // tele
                        ddd[i].active := true;
                        ddd[i].objtype := 1;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].lenght  := 0;    // goto_x
                        ddd[i].dir := 0;        // goto_y
                        showmessage('teleport created at 0:0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton2.checked then begin        // btn
                        ddd[i].active := true;
                        ddd[i].objtype := 2;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].target := 0;     // target
                        ddd[i].wait := 100;     // wait time;
                        ddd[i].orient := 0;     // color
                        ddd[i].special := 0;    // shoot
                        showmessage('button created at 0:0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton3.checked then begin        // door
                        ddd[i].active := true;
                        ddd[i].objtype := 3;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].targetname := 0; // targetname
                        ddd[i].special := 0;    // fastclose;
                        ddd[i].wait := 100;     // wait time;
                        ddd[i].orient := 0;     // orientation
                        ddd[i].lenght := 1;     // door brick  lenght
                        showmessage('door created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton4.checked then begin        // trigger
                        ddd[i].active := true;
                        ddd[i].objtype := 4;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].target := 0;     // target
                        ddd[i].lenght := 2;     // lenght_x
                        ddd[i].dir := 2;        // lenght_y
                        ddd[i].wait := 10;      // retoggle time;
                        showmessage('trigger created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton5.checked then begin        // area_push
                        ddd[i].active := true;
                        ddd[i].objtype := 5;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].target := 0;     // target
                        ddd[i].lenght := 2;     // lenght_x
                        ddd[i].dir := 2;        // lenght_y
                        ddd[i].wait := 10;      // retoggle time;
                        ddd[i].orient := 0;     // push direction
                        ddd[i].special := 30;   // push speed;
                        showmessage('area_push created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton6.checked then begin        // area_dmg
                        ddd[i].active := true;
                        ddd[i].objtype := 6;
                        ddd[i].x := 0;           // pos_x
                        ddd[i].y := 0;           // pos_y
                        ddd[i].targetname := 0;  // targetname
                        ddd[i].special := 2;     // lenght_x
                        ddd[i].orient := 2;      // lenght_y
                        ddd[i].nowanim := 10;    // DMGINTERVAL;
                        ddd[i].dir := 10;        // DMG
                        ddd[i].lenght := 50;     // wait. if targetname > 0
                        showmessage('area_pain created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton7.checked then begin        // area_dmg
                        ddd[i].active := true;
                        ddd[i].objtype := 7;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].special := 2;    // lenght_x
                        ddd[i].orient := 2;     // lenght_y
                        showmessage('area_trickarena_end created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton8.checked then begin        // area_teleport
                        ddd[i].active := true;
                        ddd[i].objtype := 8;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].special := 2;    // lenght_x
                        ddd[i].orient := 2;     // lenght_y
                        ddd[i].dir := 0;        // goto_x
                        ddd[i].wait := 0;       // goto_y
                        showmessage('area_teleport created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton9.checked then begin        // area_teleport
                        ddd[i].active := true;
                        ddd[i].objtype := 9;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].wait := 5;       // wait time;
                        ddd[i].orient := 0;     // orientation
                        ddd[i].lenght := 1;     // doortrigger brick lenght
                        showmessage('doortrigger created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                        if form3.RadioButton10.checked then begin        // area_waterillusion
                        ddd[i].active := true;
                        ddd[i].objtype := 10;
                        ddd[i].x := 0;          // pos_x
                        ddd[i].y := 0;          // pos_y
                        ddd[i].special := 1;    // lenght_x
                        ddd[i].orient := 1;     // lenght_y
                        showmessage('area_waterillusion created at x0y0. with #'+inttostr(i));
                        exit;
                        end;
                end;
        end;
end;

procedure TForm1.Showcrosslines1Click(Sender: TObject);
begin
// диагональные линии
showcrosslines1.Checked := not showcrosslines1.Checked;
SHOWLINES := showcrosslines1.Checked;
end;

procedure TForm1.showspecialobjects1Click(Sender: TObject);
begin
// [не]показывать спец объекты
showspecialobjects1.Checked := not showspecialobjects1.Checked;
SHOWOBJ := showspecialobjects1.Checked;
end;

procedure TForm1.new1Click(Sender: TObject);
var i, a : word;
// Новая карта, удаление прежней информации.
begin
       case MessageDlg ('Discard all map information?', mtConfirmation, [mbYes,mbNo], 0) of
       IDNO : exit;
       end;
listview1.Items.Clear;

for i := 0 to 250 do
for a := 0 to 250 do
        bbb[i,a].image := 0;
for i := 0 to 255 do
        ddd[i].active := false;
BRICK_X := 20;
BRICK_Y := 30;
MAP_NAME := 'test map';
MAP_AUTHOR := 'unnamed';
SaveDialog.filename := 'unnamed.mapa';
MAP_BG := 0;
SHOWLINES := true;
SHOWOBJ := true;
CleanUpMap;
if CUSTOMPALITRE then palette.Button1.Click;
form5.showmodal;
end;

procedure TForm1.Findmaperrors1Click(Sender: TObject);
begin
        form6.showmodal;
end;

procedure TForm1.Mapproperities1Click(Sender: TObject);
begin
form5.showmodal;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.LoadoldNFKbeta025map1Click(Sender: TObject);
begin
// конвентер 025 карт.
   opendlg.filter := 'Old nfk maps (*.mapa)|*.mapa';
   if extractfilepath(opendlg.filename) <> '' then opendlg.initialdir := extractfilepath(opendlg.filename);
   if not (opendlg.execute) then exit;
   listview1.Items.Clear;
// загрузка старой карты
   Loadv031map(opendlg.FileName);
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
// Навигация
with sender as TSpeedButton do
        case tag of
        1 : inc(gy,32);
        2 : inc(gx,32);
        3 : dec(gy,32);
        4 : dec(gx,32);
        5 : if selbrk > 0 then dec(selbrk);
        6 : if selbrk < MAXBRUSH then inc(selbrk);
        7 : if selbrk > 10 then selbrk := selbrk - 10 else selbrk := 0;
        8 : if selbrk < MAXBRUSH then selbrk := selbrk + 10 else selbrk := MAXBRUSH;
        end;
        BrushName;
end;

procedure TForm1.Selectobject1Click(Sender: TObject);
var i,nn : byte;
 n : string;
begin
// Выбор спец объекта
if selectedobj >= 0 then begin
        showmessage('some object already selected');
        exit;
        end;
for i := 0 to 255 do if ddd[i].active = true then
        if (ddd[i].x = selx) and (ddd[i].y = sely) then
        begin
                SELECTEDOBJ := i;
listview1.Items.Clear;
speedbutton1.enabled := true;
speedbutton2.enabled := true;
speedbutton3.enabled := false;
speedbutton4.enabled := false;
listview1.enabled := true;
Form1.PageControl1.ActivePageIndex := 0;
if form1.speedbutton13.enabled then form1.speedbutton13.click;
nn := SELECTEDOBJ;
n := inttostr(nn);

AddOBJPROP(NN,n);

                break;
                end;
end;

procedure TForm1.ListView1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then ListView1DblClick(sender);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i,a : byte;
begin
// Рандомный генератор карт :)))
if (key=VK_F12) and (ShiftKeyDown) then begin
                randomize;
                for i := 0 to BRICK_X-1 do
                for a := 0 to BRICK_y-1 do
                        if random(5) = 0 then
                        bbb[i,a].image := 54 else bbb[i,a].image := 0;
        end;

        if (key=VK_F5) then begin
                if SelectedLoc <> 0 then if LocationsArray[SELECTEDLOC].enabled then begin
                        LocationsArray[SELECTEDLOC].x := selx;
                        LocationsArray[SELECTEDLOC].y := sely;
                        if listview2.Items[0].Caption='pos_x' then listview2.Items[0].SubItems.Text := inttostr(selx);
                        if listview2.Items[1].Caption='pos_y' then listview2.Items[1].SubItems.Text := inttostr(sely);
                end;

                if SELECTEDOBJ >= 0 then if ddd[SELECTEDOBJ].active then begin
                        ddd[SELECTEDOBJ].x := selx;
                        ddd[SELECTEDOBJ].y := sely;
                        if listview1.Items[0].Caption='pos_x' then listview1.Items[0].SubItems.Text := inttostr(selx);
                        if listview1.Items[1].Caption='pos_y' then listview1.Items[1].SubItems.Text := inttostr(sely);
                end;

        end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
showmessage(form1.caption+#13+'created by   3d[Power]'+#13+'several upgrades by   [LD]:Surgeon'+#13#13+'http://www.3dpower.org');
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
// Загрузка help файла
ShellExecute(Application.Handle,'open',pchar(extractfilepath(application.exename)+'\radiant_help.htm'),nil,nil,0);
end;

procedure TForm1.Brushreplace1Click(Sender: TObject);
begin
form2_.showmodal;
end;

procedure TForm1.Brushreplace2Click(Sender: TObject);
begin
form2_.SpinEdit1.value := bbb[selx,sely].image;
form2_.showmodal;
end;

procedure TForm1.Extractmapfromdemo1Click(Sender: TObject);
begin
opendlg.filter := 'extractor';
opnclk(sender);
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
case MessageDlg ('quit?'+#13+'dont forget to save map', mtConfirmation, [mbYes,mbCancel], 0) of
        mrCancel : canclose := false;
end;
end;

procedure TForm1.NFKRadiantTutorial1Click(Sender: TObject);
begin
// Загрузка help файла
ShellExecute(Application.Handle,'open',pchar(extractfilepath(application.exename)+'\rocky_tutorial\help.htm'),nil,nil,0);

end;

// border filler.
procedure TForm1.Fillborder1Click(Sender: TObject);
var i: word;
begin
        IF selbrk < 54 then selbrk := 54;

        for i := 0 to BRICK_X-1 do begin
        bbb[i,0].image := selbrk;
        bbb[i,BRICK_Y-1].image := selbrk;
        end;
        for i := 0 to BRICK_Y-1 do begin
        bbb[0,I].image := selbrk;
        bbb[BRICK_X-1,i].image := selbrk;
        end;

END;

procedure TForm1.Startselection1Click(Sender: TObject);
begin
        if not doselect then begin
                doselect := true;
                selbminx := selx;
                selbminy := sely;
                selbmaxx := selx;
                selbmaxy := sely;
        end;
end;

// selection orepations
procedure TForm1.SelectOpClick(Sender: TObject);
var i,a:word;
    t:byte;
begin
        doselect:=false;
        with sender as TMenuitem do
        case tag of
               1: for i := selbminx to selbmaxx do for a := selbminy to selbmaxy do bbb[i,a].image := selbrk; // fill
               2: for i := selbminx to selbmaxx do for a := selbminy to selbmaxy do bbb[i,a].image := 0; // erase
               3: for i := selbminx to (selbminx + (selbmaxx - selbminx) div 2) do // flip_x
                  for a := selbminy to selbmaxy do begin
                        t := bbb[i,a].image;
                        bbb[i,a].image := bbb[selbminx+selbmaxx-i,a].image;
                        bbb[selbminx+selbmaxx-i,a].image := t;
                  end;
               4: for a := selbminy to (selbminy + (selbmaxy - selbminy) div 2) do // flip_y
                  for i := selbminx to selbmaxx do begin
                        t := bbb[i,a].image;
                        bbb[i,a].image := bbb[i,selbminy+selbmaxy-a].image;
                        bbb[i,selbminy+selbmaxy-a].image := t;
                  end;
               5: begin // copy
                       copysizex := selbmaxx - selbminx+1;
                       copysizey := selbmaxy - selbminy+1;
                       for i := 0 to copysizex-1 do
                       for a := 0 to copysizey-1 do
                                brCopy[i,a] := bbb[selbminx+i,selbminy+a].image;
                  end;
               6: begin // cut...
                       copysizex := selbmaxx - selbminx+1;
                       copysizey := selbmaxy - selbminy+1;
                       for i := 0 to copysizex-1 do for a := 0 to copysizey-1 do
                                brCopy[i,a] := bbb[selbminx+i,selbminy+a].image;
                       for i := selbminx to selbmaxx do for a := selbminy to selbmaxy do bbb[i,a].image := 0; // erase
               end;
        end;
end;

procedure TForm1.Paste1Click(Sender: TObject);
var i,a:word;
begin
//        showmessage(inttostr(copysizex));
        if (copysizex=0) or (copysizey=0) then exit;
        for i:= 0 to copysizex-1 do
        for a:= 0 to copysizey-1 do
                bbb[selx+i,sely+a].image := brCopy[i,a];

end;

procedure TForm1.Buildnewbrickpalette1Click(Sender: TObject);
begin
palette.showmodal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
PaletteFile.Free;
end;

procedure TForm1.Showallteleportlinks1Click(Sender: TObject);
begin
// [не]показывать телепорт линки
Showallteleportlinks1.Checked := not Showallteleportlinks1.Checked;
end;

procedure Location_Apply();
begin
        form1.listview2.Items.Clear;
        form1.SpeedButton16.enabled := true;
        form1.SpeedButton13.enabled := false;
        form1.SpeedButton14.enabled := true;
        form1.SpeedButton15.enabled := false;
        form1.listview2.enabled := false;
        SELECTEDLOC := 0;

end;

procedure Location_Delete(ID:BYTE);
begin
        LocationsArray[ID].Enabled := false;
        LocationsArray[ID].Text := '';
        Location_Apply();
end;

procedure Location_Modify(ID:byte);
begin
        if form1.speedbutton1.enabled then form1.speedbutton1.click;
        form1.listview2.Items.Clear;
        Addprop_loc('pos_x',inttostr(LocationsArray[ID].X));
        Addprop_loc('pos_y',inttostr(LocationsArray[ID].Y));
        Addprop_loc('text',LocationsArray[ID].Text);
        SELECTEDLOC := ID;
        Form1.PageControl1.ActivePageIndex := 1;
        form1.SpeedButton16.enabled := false;
        form1.SpeedButton13.enabled := true;
        form1.SpeedButton15.enabled := true;
        form1.SpeedButton14.enabled := false;
        form1.listview2.enabled := true;
end;
// New locations...
procedure TForm1.SpeedButton16Click(Sender: TObject);
var i : byte;
begin
        for i := 1 to 50 do if LocationsArray[i].Enabled = false then begin
                LocationsArray[I].X := 0;
                LocationsArray[I].Y := 0;
                LocationsArray[I].Text := 'LocationName';
                LocationsArray[i].Enabled := TRUE;
                Location_Modify(i);
                break;
        end;
end;

procedure TForm1.ListView2DblClick(Sender: TObject);
var nn : integer;
 s,n : string;
begin
        if itmsel.Caption ='pos_x' then s := 'value(0-'+inttostr(BRICK_X-1)+').';
        if itmsel.Caption ='pos_y' then s := 'value(0-'+inttostr(BRICK_Y-1)+').';
        if itmsel.Caption ='text' then begin
                s := 'value(64 chars max).';
                n := LocationsArray[SELECTEDLOC].Text;
                end;

        if itmsel.Caption ='radius' then s := 'value(100-1000).';
        if not inputquery('edit object property "'+itmsel.Caption+'"',s, n) then exit;

        if itmsel.Caption <> 'text' then begin
                try strtoint(n);
                except showmessage('invalid value "'+n+'"'); exit; end;
                nn := strtoint(n);
        end;

        if itmsel.Caption ='pos_x' then if (nn < 0) or (nn > BRICK_X-1) then begin
                 showmessage('out of range "'+n+'"'); exit; end else begin
                        LocationsArray[SELECTEDLOC].x := nn;
                        itmsel.SubItems.Text := n;
                        end;

        if itmsel.Caption ='pos_y' then if (nn < 0) or (nn > BRICK_Y-1) then begin
        showmessage('out of range "'+n+'"'); exit; end else begin
                        LocationsArray[SELECTEDLOC].y := nn;
                        itmsel.SubItems.Text := n;
                        end;

        if itmsel.Caption ='text' then begin
                        LocationsArray[SELECTEDLOC].Text := n;
                        itmsel.SubItems.Text := n;
                        end;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
    Location_Apply();
end;

// loc select
procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
      application.CreateForm(Tloc_sel, loc_sel);
      loc_sel.FormCreate(sender);
      loc_sel.showmodal;
      if loc_sel.ModalResult <> mrOk then Location_Apply();
      loc_sel.free;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
case MessageDlg ('delete location #'+inttostr(SELECTEDLOC)+' ('+LocationsArray[SELECTEDLOC].text+') ?', mtConfirmation, [mbYes,mbNo], 0) of
IDNO : exit;
end;
Location_Delete(SELECTEDLOC);
end;

procedure TForm1.selectlocClick(Sender: TObject);
var i :byte;
begin
        for i := 1 to 50 do if LocationsArray[i].enabled then
                if (LocationsArray[i].x = selx) and
                   (LocationsArray[i].y = sely) then begin
                       Location_Modify(i);
                       break;
               end;
end;

procedure TForm1.Showloc1Click(Sender: TObject);
begin
Showloc1.Checked := not Showloc1.Checked;
end;

procedure TForm1.TestLocations1Click(Sender: TObject);
begin
 TestLocations1.checked := not TestLocations1.checked;
end;

procedure TForm1.ListView2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then ListView2DblClick(sender);
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
if speedbutton13.enabled then speedbutton13.click;
if speedbutton1.enabled then speedbutton1.click;
end;

end.

