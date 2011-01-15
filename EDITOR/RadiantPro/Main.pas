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

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Menus, ComCtrls,
  ImgList, ExtCtrls,shellapi, ToolWin, ActnList, StdActns,
  Mask, ActnMan, ActnCtrls, XPStyleActnCtrls,
  ActnMenus, CustomizeDlg,

  MyClasses, MyScroll, MyBuf;

const
   //длина буффера undo/redo
   maxbuf= 20;
   {Константы цвета, строки и.т.п.}
   SelBrkColor = clRed;
   BackBrkColor = clBlack;
   BackBrkColor2 = clGray;
   CW=1;
   CH=1;
   ScrX=20;
   ScrY=20;

   CurColor = clWhite;

   BorderPenColor = clWhite;
   BorderPenStyle : TPenStyle = psSolid;

   LocPenColor= clBlue;
   LocPenStyle: TPenStyle = psDot;
   LocBrushColor= clBlue;
   LocBrushStyle: TBrushStyle = bsClear;

   TeleportPenStyle : TPenStyle = psSolid;
   TeleportPenColor = clRed;

   TeleportPenStyle2 : TPenStyle = psDashDot;
   TeleportPenColor2 = clPurple;

   ObjColors: array [TObjType] of TColor =
     (clWhite, clWhite, clWhite, clWhite, clWhite,
      clWhite, clWhite, clWhite, clWhite, clWhite);
   ObjFontColor = clRed;

   SelObjColor = clAqua;
   SelLocColor = clAqua;

           {Начальные зн-я св-в объектов}
   DefObj : array [TObjType] of TMapObjV2 =
  ((length:0; dir:0; objtype: 1),
   (wait:100; target:0; orient:0; special:0;objtype: 2;),
	(length:4;wait:100; targetname:0; orient:0; special:0; objtype: 3),
	(length:2; dir:2; wait:10; target:0; objtype: 4),
	(length:2; dir:2; wait:10; target:0; orient:0; nowanim:10; special:30;objtype: 5),
	(length:50; dir:10; targetname:0; orient:2; nowanim:10; special:2; objtype: 6),
	(orient:2; special:2; objtype: 7),
	(dir:0; wait:0; orient:2; special:2; objtype: 8),
	(length:4;wait:5; orient:0; objtype: 9),
	(orient:2;special:2;objtype: 10));

   {      otTeleport: Result:='pos x|pos y|goto x|goto y';
      otButton: Result:='pos x|pos y|color|wait|target|shootable';
      otDoor: Result:='pos x|pos y|orientation|length|closed|wait|fastclose|target name';
      otTrigger: Result:='pos x|pos y|length x|length y|wait|target';
      otAreaPush: Result:='pos x|pos y|length x|length y|wait|target|direction|pushspeed';
      otAreaPain: Result:='pos x|pos y|length x|length y|dmginterval|wait|target name|dmg';
      otAreaTrickarena_end: Result:='pos x|pos y|length x|length y';
      otAreaTeleport: Result:='pos x|pos y|length x|length y|goto x|goto y';
      otDoorTrigger: Result:='pos x|pos y|length|orientation|closed|target';
      otAreaWaterIllusion: Result:='pos x|pos y|length x|length y';
}


type
   TEditorMode = (emPen, emLine, emBlock, emFloodBlock, emFloodFill,
   					emSelectBlock, emSelectObj, emSelectLoc, emNewObj, emNewLoc);

type
  TMainForm = class(TForm)
    CmPalette: TImageList;
    DefPalette: TImageList;
    Status: TStatusBar;
    TeleportList: TImageList;
    ButtonList: TImageList;
    BtnImages: TImageList;
    RightPnl: TPanel;
    BrickPnl: TPanel;
    ScrollBrk: TScrollBox;
    BrickPnl2: TPanel;
    BrickLbl: TLabel;
    LogoPnl: TPanel;
    Image1: TImage;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    FileOpen: TFileOpen;
    FileSaveAs: TFileSaveAs;
    FileNew: TAction;
    PenAct: TAction;
    SelObjAct: TAction;
    SelLocAct: TAction;
    FileSave: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    CustomizeDlg: TCustomizeDlg;
    CustomizeAct: TAction;
    AddObj: TAction;
    AddLoc: TAction;
    EditAct: TAction;
    ActionToolBar2: TActionToolBar;
    PropGrid: TStringGrid;
    Image: TPaintBox;
    PopupMenu1: TPopupMenu;
    NewObj: TMenuItem;
    ELEPORT1: TMenuItem;
    BUTTON1: TMenuItem;
    DOOR1: TMenuItem;
    RIGGER1: TMenuItem;
    AREAPUSH1: TMenuItem;
    AREAPAIN1: TMenuItem;
    AREATRICKARENAEND1: TMenuItem;
    AREATELEPORT1: TMenuItem;
    AREADOORTRIGGER1: TMenuItem;
    AREAWATERILLUSION1: TMenuItem;
    AddAction1: TAction;
    AddAction2: TAction;
    AddAction3: TAction;
    AddAction5: TAction;
    AddAction6: TAction;
    AddAction7: TAction;
    AddAction8: TAction;
    AddAction9: TAction;
    AddAction10: TAction;
    AddAction4: TAction;
    NewLoc: TMenuItem;
    NewLocAct: TAction;
    DelObjAct: TAction;
    EditUndo1: TEditUndo;
    MapPropsAct: TAction;
    MapPaletteAct: TAction;
    Splitter1: TSplitter;
    BrkImage: TPaintBox;
    RunNFKAct: TAction;

    procedure FormCreate(Sender: TObject);
    procedure BrkImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileSaveAsAccept(Sender: TObject);
    procedure FileSaveAsBeforeExecute(Sender: TObject);
    procedure FileOpenBeforeExecute(Sender: TObject);
    procedure ChangeEditMode(Sender: TObject);
    procedure PropGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure PropGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure PropGridEnter(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure CustomizeActExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditActExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImagePaint(Sender: TObject);
    procedure AddAction(Sender: TObject);
    procedure NewLocActExecute(Sender: TObject);
    procedure DelObjActExecute(Sender: TObject);
    procedure EditUndo1Execute(Sender: TObject);
    procedure MapPropsActExecute(Sender: TObject);
    procedure MapPaletteActExecute(Sender: TObject);
    procedure BrkImagePaint(Sender: TObject);
    procedure ScrollBrkResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure RunNFKActExecute(Sender: TObject);
  private
    { Private declarations }
      {Map and Coordinates}
    Map: TMap;
    Scroll: TMyScroll;
      {буфер}
    Buf: TMyBuffer;
      {Выделенный тип брика, объект, локация}
    SelBrk: integer;
    Sel_Obj: TMyObj;
    Sel_Loc: TLocation;
      {Текущие положения мыши}
    i_cur, j_cur, i_sel, j_sel: integer;
      {флаги редактирования}
    new, modified, Blocked: boolean;
    loc_mod: boolean;
      {кол-во x бриков и y бриков}
    XBrkCount, YBrkCount : integer;

      {режимы редактирования}
    Mode: TEditorMode;

    procedure SetScroll;
    procedure SetBuf;

  public
    { Public declarations }

    procedure SetSize;

    procedure DrawAll;
    procedure DrawBrk;
    procedure ShowStatusPanel;
    procedure ShowCaption;

    procedure CheckProps;
    procedure ShowProps;
  end;

CONST   MAXBRUSH = 254;         // всего brush'ей
        MAX_BUF = 2048;         // буфер
        SHOWLINES : boolean = true; // показывать диагональные линии
        SHOWOBJ : boolean = true; // показывать спец объекты
        DOSELECT : boolean = false; // селекция
        copysizex : byte = 0;   // копирование
        copysizey : byte = 0;   // копирование

var
  MainForm: TMainForm;

{procedure loadmapp (filename : string);
procedure Location_Modify(ID:byte);}

implementation
uses
	MyStrings, MyPalette,
   AddObjDialog, MapPropsForm, MapPaletteForm;
{$R *.DFM}

//Neoff procedures

//CREATE!!!!

procedure TMainForm.SetSize;
begin
	PropGrid.ColWidths[0]:=60;
 	PropGrid.ColWidths[1]:=PropGrid.Width-60;
   PropGrid.RowCount:=0;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
   Map:=TMap.Create;
   Scroll:=TMyScroll.Create;
   Buf:=TMyBuffer.Create;

   FileOpen.Dialog.InitialDir := extractfilepath(paramstr(0));
   FileSaveAs.Dialog.InitialDir := extractfilepath(paramstr(0));

	LoadPaletteFromFile('graph/040bricks.bmp', DefPalette,
   							clFuchsia, 1, 1);
	if paramstr(1) <> '' then if fileexists(paramstr(1)) then begin
        FileSaveAs.Dialog.filename := paramstr(1);
        Map.Open037Map(paramstr(1));
   end;
   SetScroll;
   SetBuf;

	selbrk := 1;blocked:=false;modified:=false;new:=true;
   Mode:=emSelectObj;loc_mod:=false;

   ScrollBrkResize(Self);

	DrawAll;
end;

{преобразование координат}

procedure TMainForm.SetScroll;
begin
   with Scroll do
   begin
      ZoomX:=Brick_Width;
   	ZoomY:=Brick_Height;
   	MaxI:=Map.MaxX;
   	MaxJ:=Map.MaxY;
   	ScreenWidth:=Image.Width;
   	ScreenHeight:=Image.Height;
   	GX:=GX;
      GY:=GY;
   end;
end;

//Обнуление буфера

procedure TMainForm.SetBuf;
begin
   Buf.Clear;
   Buf.MaxBuf:=MaxBuf;
   Buf.AddCopy(Map, 'current map');
end;

procedure TMainForm.Splitter1Moved(Sender: TObject);
begin
   SetSize;
end;

{прорисовка и все связанное с ней}

procedure TMainForm.FormResize(Sender: TObject);
begin
   SetScroll;
end;

procedure TMainForm.ScrollBrkResize(Sender: TObject);
begin
   XBrkCount:=(ScrollBrk.Width-22) div (Brick_Width+CW);
   YBrkCount:=(254+XBrkCount) div XBrkCount;
   DrawBrk;
end;

procedure TMainForm.DrawAll;
begin
   Image.Repaint;
   DrawBrk;
   CheckProps;
   ShowProps;
   ShowCaption;
end;

procedure TMainForm.DrawBrk;
begin
   BrkImage.RePaint;
end;

procedure TMainForm.BrkImagePaint(Sender: TObject);
var
   i, j, x, y, img: integer;

begin
   with BrkImage, Canvas do
   begin
      Width:=(Brick_Width+CW)*XBrkCount;
      Height:=(Brick_Height+CH)*YBrkCount;

      Brush.Color:=BackBrkColor;
      Pen.Color:=BackBrkColor;
      Rectangle(0, 0, Width, Height);
      for j:=0 to YBrkCount-1 do
         for i:=0 to XBrkCount-1 do
         with Map do
         begin
            x:=i*(Brick_Width+CW);
            y:=j*(Brick_Height+CH);
            img:=i+j*XBrkCount+1;
            if img>255 then Break;
            if img=selbrk then
            begin
               Brush.Color:=SelBrkColor;
               Pen.Color:=SelBrkColor;
               Rectangle( BrickRect(x, y, CW, CH) );
            end;
            Brush.Color:=BackBrkColor2;
            Pen.Color:=BackBrkColor2;
            Rectangle( BrickRect(x, y, 0, 0) );

				if CUSTOMPALETTE and (img >=54) and (img<=181)
          		then CmPalette.Draw(BrkImage.Canvas, x, y, img-54)
          		else	DefPalette.Draw(BrkImage.Canvas, x, y, img);
         end;
   end;
   BrickLbl.Caption:=GetBrushName(SelBrk);
end;

procedure TMainForm.ImagePaint(Sender: TObject);
var
   i, j, x, y, x1, y1: integer;
   img: byte;
   R: TRect;
begin

   with Image, Canvas, Map, Scroll do
   begin
      Brush.Color:=clBlack;
      Pen.Color:=clBlack;

        // Draw Bricks
   	for j := GetJ(0) to GetJ(Height) do       // отрисовка кирпичей
      	for i := GetI(0) to GetI(Width) do
         begin
          x:=GetX(i);
          y:=GetY(j);
          img:=Brk[i, j];
          if img>0 then
          	if CustomPalette and (img >=54) and (img <=181)
          		then 	CmPalette.Draw(Image.Canvas, x, y, img-54)
          		else	DefPalette.Draw(Image.Canvas, x, y, img);
         end;
        // Draw Objects
      Font.Color:=clRed;
      for i:=0 to ObjCount-1 do
      begin
         R:=Obj[i].Rect;
         R.Left:=GetX(R.Left);
         R.Right:=GetX(R.Right+1);
         R.Top:=GetY(R.Top);
         R.Bottom:=GetY(R.Bottom+1);
         X:=GetX(Obj[i].X);
         Y:=GetY(Obj[i].Y);

         case Obj[i].ObjType of
             otTeleport : begin
         						  X1:=GetX(Obj[i].Prop['goto x']);
                             Y1:=GetY(Obj[i].Prop['goto y']-2);
                             Y:=Y-2*Brick_Height;
                             TeleportList.Draw(Canvas, R.Left, R.Top, 0);
{                             TeleportList.Draw(Canvas, x1, y1, 0);}
                             Pen.Style:=TeleportPenStyle2;
                             Pen.Color:=TeleportPenColor2;
                             Brush.Style:=bsClear;
                             Rectangle(X1, Y1, X1+Brick_Width, Y1+3*Brick_Height);
                             Pen.Style:=TeleportPenStyle;
                             Pen.Color:=TeleportPenColor;
                             MoveTo(X+Brick_Width div 2, Y+Brick_Height);
                             LineTo(X1+Brick_Width div 2, Y1+Brick_Height);
                          end;
            otButton : begin
                         ButtonList.Draw(Canvas, R.Left+4, R.Top+4, Obj[i].Prop['shootable']);
                      end;
            otDoor,
            otTrigger,
   			otAreaPush,
   			otAreaPain,
	 		  	otAreaTrickarena_end,
   			otAreaTeleport,
            otDoorTrigger,
   			otAreaWaterIllusion:
      			begin
{                  Brush.Style:=bsClear;}
                  Brush.Style:=bsBDiagonal;

                  Brush.Color:=ObjColors[Obj[i].ObjType];
                  Pen.Style:=psSolid;
                  Pen.Color:=ObjColors[Obj[i].ObjType];
                  Font.Color:=ObjFontColor;
                  Rectangle(R);
                  TextOut(X, Y, Obj[i].Name);
      			end;
        end;
{        TextOut(X, Y, IntToStr(Ord(Obj[i].ObjType)));}
        if (Mode=emSelectObj) and (sel_obj=Obj[i]) then
        begin
           Brush.Style:=bsClear;
           Pen.Style:=psSolid;
           Pen.Color:=SelObjColor;
           Rectangle(R);
        end;
      end;
        //Draw Locations
      for i:=0 to LocCount-1 do
      begin
         x:=GetX(Locations[i].X);
         y:=GetY(Locations[i].Y);
         Pen.Color:=LocPenColor;
         Pen.Style:=LocPenStyle;
         Brush.Color:=LocBrushColor;
         Brush.Style:=LocBrushStyle;
         Ellipse(x, y, x+Brick_Width, y+Brick_Height);

        if (Mode=emSelectLoc) and (sel_loc=Locations[i]) then
        begin
           Brush.Style:=bsClear;
           Pen.Style:=psSolid;
           Pen.Color:=SelLocColor;
           Rectangle(x, y, x+Brick_Width, y+Brick_Height);
        end;
      end;
       // Главные Диагонали:)
      Brush.Style:=bsClear;
      Pen.Color:=BorderPenColor;
      Pen.Style:=BorderPenStyle;
      Rectangle(-GX, -GY, GetMaxX-GX+1, GetMaxY-GY+1);
      MoveTo(-GX, -GY);LineTo(GetMaxX-GX+1, GetMaxY-GY+1);
      MoveTo(-GX, GetMaxY-GY+1);LineTo(GetMaxX-GX+1, -GY);
       // Наш курсор
//      Brush.Style:=bsClear;
//      Pen.Color:=CurColor;
//      Rectangle(GetX(i_cur), GetY(j_cur), GetX(i_cur+1), GetY(j_cur+1));
   end;
end;

//Заполнение StatusBar и.т.п.

procedure TMainForm.ShowStatusPanel;
begin
   Status.Panels[0].Text:=IntToStr(i_sel)+' '+IntToStr(j_sel);
   Status.Panels[1].Text:=IntToStr(i_cur)+' '+IntToStr(j_cur);
end;

procedure TMainForm.ShowCaption;
begin
   if new then
      Caption:='NFK Radiant Pro by Neoff - NEW'
          else
      Caption:='NFK Radiant Pro by Neoff - '+FileSaveAs.Dialog.FileName;
end;

//Обработка мышиных событий:)  на Image

procedure TMainForm.BrkImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   img : integer;
begin
   img:=X div (Brick_Width+CW)+(Y div (Brick_Height+CH))*XBrkCount+1;
   if img<=255 then
   begin
      PenAct.Execute;
   	selbrk:=img;
   end;
   DrawBrk;
end;

procedure TMainForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i: integer;
begin
{}
   Loc_Mod:=false;
   with Scroll do
      if Clip(X, Y) then
      with Map do
      begin
         case Mode of
            emPen:if (ssLeft in Shift) then
                     begin
                        if ssShift in Shift then
                           Map[i_cur, j_cur]:=EmptyBrick.image
                                            else
                           Map[i_cur, j_cur]:=SelBrk;
                        Loc_Mod:=true;
                     end;
            emSelectObj:
            			begin
{                        if ssShift in Shift then
                        begin
                           Sel_Obj:=Map.AddObj;
                        end;}
                        for i:=0 to ObjCount-1 do
                           with Obj[i].Rect do
                              if (Obj[i]<>Sel_Obj) and
                              	(i_cur>=Left) and (i_cur<=Right) and
                                 (j_cur>=Top) and (j_cur<=Bottom) then
                                 Sel_Obj:=Obj[i];
                        ShowProps;
                     end;
            emSelectLoc:
            			begin
                        for i:=0 to LocCount-1 do
                           if (Locations[i]<>Sel_Loc) and
                            	(i_cur=Locations[i].X) and (j_cur=Locations[i].Y)
                              then Sel_Loc:=Locations[i];
                        ShowProps;
            			end;
            emNewObj:begin
                        SelObjAct.Execute;
                        if AddObjDlg.ShowModal=mrOk then
                        begin
                           sel_obj:=AddObj;
                           sel_obj.Values:=DefObj[TObjType(AddObjDlg.Tag)];
                           sel_obj.X:=i_cur;
                           sel_obj.Y:=j_cur;
                        end;
                        Buf.AddCopy(Map, 'Add Object');
                       	ShowProps;
                     end;
            emNewLoc:begin
                        SelLocAct.Execute;
                        sel_loc:=AddLoc;
                        sel_loc.X:=i_cur;
                        sel_loc.Y:=j_cur;
                        sel_loc.Text:='Location';
                        Buf.AddCopy(Map, 'Add Location');
                        ShowProps;
                     end;
         end;
         Image.Repaint;
      end;
   {if ssLeft in Shift then
      if Clip(X, Y) then
   begin
      Map.Brk[i_cur, j_cur]:=SelBrk;
   	DrawImage;
   end;}
end;

procedure TMainForm.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   MustDrawImage: boolean;
{   i, j: integer;}
begin
{}
{   i:=Scroll.GetI(X);
   j:=Scroll.GetJ(Y);
   if (i<>i_cur) or (j<>j_cur) then
   begin
      i_cur:=i;
      j_cur:=j;
//      Прорисовка курсора
      Image.
   end;}
   i_cur:=Scroll.GetI(X);
   j_cur:=Scroll.GetJ(Y);

   ShowStatusPanel;
   with Scroll do
      if Clip(x, y) then
      with Map do
      begin
         MustDrawImage:=true;
      	case Mode of
            emPen:if (ssLeft in Shift) then
                     begin
                        if ssShift in Shift then
                           begin
                           	Map[i_cur, j_cur]:=EmptyBrick.Image;
                              loc_mod:=true;
                           end                           
                                            else
                           begin
                              if	 Map[i_cur, j_cur]<>SelBrk then
                              begin
                                Map[i_cur, j_cur]:=SelBrk;
                                loc_mod:=true;
                              end
                                else MustDrawImage:=false;

                           end;
                     end else MustDrawImage:=false;
            else MustDrawImage:=false;
         end;
         if MustDrawImage then Image.Repaint;
      end;
end;


procedure TMainForm.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if Loc_Mod then
      Buf.AddCopy(Map, 'Brick Paint');
end;

// КЛАВА!!!!!

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
   rp: boolean;
begin
   rp:=true;
   with Scroll do
   if not EditAct.Checked then
   case UpCase(Key) of
      'W':GY:=GY-ScrY;
      'S':GY:=GY+ScrY;
      'A':GX:=GX-ScrX;
      'D':GX:=GX+ScrX;
      else rp:=false;
   end;
   if rp then
   	Image.Repaint;
end;

//обработка show/edit свойств объекта.

procedure TMainForm.CheckProps;
begin
	PropGrid.Options:=PropGrid.Options-[goEditing];
   if EditAct.checked then
   	if (mode=emSelectObj) and (Sel_Obj<>nil) or
      	(mode=emSelectLoc) and (Sel_Loc<>nil) then
				PropGrid.Options:=PropGrid.Options+[goEditing];
end;


procedure TMainForm.ShowProps;
var
   i, k: integer;
   s, s1: string;
begin
   EditAct.Enabled:=false;
   PropGrid.Visible:=true;
   with PropGrid do
   case Mode of
      emSelectObj:
      if sel_obj<>nil then
   	begin
         EditAct.Enabled:=true;
      	s:=sel_obj.Props;
         i:=0;
         while s<>'' do
      	begin
            Inc(i);
            k:=Pos('|', s);
            if k<=0 then
               begin
            		s1:=s;
                  s:='';
               end
               else
               begin
            		s1:=Copy(s, 1, k-1);
                  Delete(s, 1, k);
               end;
         	Cells[0, i-1]:=S1;
         	Cells[1, i-1]:=IntToStr(sel_obj.Prop[S1]);
      	end;
       	RowCount:=i;
   	end;

      emSelectLoc:
      if sel_loc<>nil then
   	begin
         EditAct.Enabled:=true;
         RowCount:=3;
       	Cells[0, 0]:='pos x';
        	Cells[1, 0]:=IntToStr(sel_loc.X);
       	Cells[0, 1]:='pos y';
        	Cells[1, 1]:=IntToStr(sel_loc.Y);
       	Cells[0, 2]:='text';
        	Cells[1, 2]:=sel_loc.Text;
   	end;
      else begin
              PropGrid.Visible:=false;
              RowCount:=1;
              Cells[0, 0]:='';
              Cells[1, 0]:='';
           end;
   end;
	DelObjAct.Enabled:=EditAct.Enabled;
end;

procedure TMainForm.PropGridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
   with PropGrid do
   case Mode of
      emSelectObj:
      begin
      	if Sel_Obj=nil then Exit;
     		Value:=Sel_Obj.Mask[Cells[0, ARow]];
      end;
      emSelectLoc:
      begin
      	if Sel_Loc=nil then Exit;
         if Cells[0, ARow]='text' then Value:=''
            else Value:='000;1;';
      end;
   end;
end;

procedure TMainForm.PropGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
   {привет, кодер!!!}
   with PropGrid do
   begin
      if (Trim(Value)<>'') and
      	((Cells[0, ARow]='pos x') and (StrToInt(Trim(Value))>=Map.MaxX) or
         (Cells[0, ARow]='pos y') and (StrToInt(Trim(Value))>=Map.MaxY))
          then Exit;

   	case Mode of
      	emSelectObj:
    		if (Sel_Obj<>nil) and (Trim(Value)<>'') then
      	begin
         	sel_obj.Prop[Cells[0, ARow]]:=StrToInt(Trim(Value));
            Image.Repaint;
      	end;
      	emSelectLoc:
      	if (Sel_Loc<>nil) and ((Trim(Value)<>'') or (Cells[0, ARow]='text'))
         then
      	begin
      		if Sel_Loc=nil then Exit;
         	if Cells[0, ARow]='text' then	sel_loc.Text:=Value;
         	if Cells[0, ARow]='pos x' then sel_loc.X:=StrToInt(Trim(Value));
         	if Cells[0, ARow]='pos y' then sel_loc.Y:=StrToInt(Trim(Value));
            Image.Repaint;
      	end;
   	end;
   end;
end;

procedure TMainForm.PropGridEnter(Sender: TObject);
begin
   ShowProps;
end;

//А здеся уже Action'ы пошли

procedure TMainForm.FileNewExecute(Sender: TObject);
begin
   Map.Clear;
   SetBuf;
   SetScroll;
   new:=true;
   Sel_Obj:=nil;
   Sel_Loc:=nil;
   DrawAll;
end;

procedure TMainForm.FileOpenBeforeExecute(Sender: TObject);
begin
{ченить да напишем:)}
   Mode:=emSelectObj;
   SelObjAct.Checked:=true;
end;

procedure TMainForm.FileOpenAccept(Sender: TObject);
begin
   with Map do
   case Open037map(FileOpen.Dialog.FileName) of
       0:
       begin
          if CustomPalette then
       		 LoadPaletteFromBitmap(Palette, CmPalette,
              					CustomPaletteTransparentColor, 0, 0);
          SetScroll;
          DrawAll;
  	 		 FileSaveAs.Dialog.InitialDir:=ExtractFilePath(FileOpen.Dialog.FileName);
   		 FileSaveAs.Dialog.FileName:=FileOpen.Dialog.FileName;
       end;
      -1:ShowMessage('error');
      -2:ShowMessage('error');
   end;

   Sel_Obj:=nil;
   Sel_Loc:=nil;
   new:=false;
   SetBuf;
   SetScroll;
   DrawAll;
end;

procedure TMainForm.FileSaveExecute(Sender: TObject);
begin
   if new or (FileSaveAs.dialog.Filename='') then
      FileSaveAs.Execute
      else FileSaveAsAccept(FileSave);
end;

procedure TMainForm.FileSaveAsBeforeExecute(Sender: TObject);
begin
   if new then
   	FileSaveAs.Dialog.FileName:='new.mapa';
end;

procedure TMainForm.FileSaveAsAccept(Sender: TObject);
begin
   Map.SaveMap(FileSaveAs.Dialog.FileName);
   FileOpen.Dialog.InitialDir:=ExtractFilePath(FileSaveAs.Dialog.FileName);
   FileOpen.Dialog.FileName:=FileSaveAs.Dialog.FileName;
   ShowCaption;
   new:=false;
end;

procedure TMainForm.CustomizeActExecute(Sender: TObject);
begin
   CustomizeDlg.Show;
end;

procedure TMainForm.EditActExecute(Sender: TObject);
begin
   if not EditAct.Checked then
      Buf.AddCopy(Map, 'Edit object');
   CheckProps;
   ShowProps;
end;

procedure TMainForm.AddAction(Sender: TObject);
var
   obj_: TMyObj;
begin
   obj_:=Map.AddObj;
   obj_.Values:=DefObj[TObjType(TAction(Sender).Tag)];
   obj_.X:=i_cur;
   obj_.Y:=j_cur;
   sel_obj:=obj_;
   SelObjAct.Execute;
   Buf.AddCopy(Map, 'Add Object');
   Image.Repaint;
end;

procedure TMainForm.NewLocActExecute(Sender: TObject);
begin
   sel_loc:=Map.AddLoc;
   sel_loc.X:=i_cur;
   sel_loc.Y:=j_cur;
   sel_loc.Text:='Location';
   SelLocAct.Execute;
   Buf.AddCopy(Map, 'Add Location');
end;

procedure TMainForm.DelObjActExecute(Sender: TObject);
begin
   if (Mode=emSelectObj) and (sel_obj<>nil) then
   begin
      Buf.AddCopy(Map, 'Delete object '+sel_obj.Name);
      Map.DeleteObj(sel_obj);
      sel_obj:=nil;
      Image.Repaint;
   	ShowProps;
   end;
   if (Mode=emSelectLoc) and (sel_loc<>nil) then
   begin
      Buf.AddCopy(Map, 'Delete location ');
      Map.DeleteLoc(sel_loc);
      sel_loc:=nil;
      Image.Repaint;
   	ShowProps;
   end;
end;

procedure TMainForm.EditUndo1Execute(Sender: TObject);
begin
   if Buf.CurCopyIndex>1 then
      Buf.SetCurCopy(Buf.CurCopyIndex-1).Assign(Map);
   Image.Repaint;
   sel_obj:=nil;
   sel_loc:=nil;
end;

procedure TMainForm.MapPropsActExecute(Sender: TObject);
begin
   with MapPropsDlg do
   begin
      AuthorEd.Text:=Map.MapAuthor;
      NameEd.Text:=Map.MapName;
      BGEd.Text:=IntToStr(Map.BackGround);
      MaxXEd.Text:=IntToStr(Map.MaxX);
      MaxYEd.Text:=IntToStr(Map.MaxY);
      if ShowModal=mrOk then
      begin
      	Map.MapAuthor:=AuthorEd.Text;
      	Map.MapName:=NameEd.Text;
      	Map.BackGround:=StrToInt(Trim(BGEd.Text));
      	Map.MaxX:=StrToInt(Trim(MaxXEd.Text));
      	Map.MaxY:=StrToInt(Trim(MaxYEd.Text));
         SetScroll;
      end;
   end;
end;


procedure TMainForm.MapPaletteActExecute(Sender: TObject);
begin
   MapPaletteDlg.Map:=Map;
   MapPaletteDlg.ShowModal;
   with MapPaletteDlg do
   if PalFile<>'' then
   begin
      Map.CustomPalette:=true;
      Map.Palette.LoadFromFile(PalFile);
      LoadPaletteFromBitmap(Map.Palette, CmPalette, ColorDlg.Color, 0, 0);
      DrawBrk;
   end;
end;

procedure TMainForm.RunNFKActExecute(Sender: TObject);
begin
   if not new then
   	ShellExecute(Handle, 'open', 'd:\games\nfk\nfk.exe',
      	pchar('map '+ExtractFileName(FileSaveAs.Dialog.FileName)), '', SW_HIDE);
end;

//УУУУ а вот это уже выбор режима редактирования

procedure TMainForm.ChangeEditMode(Sender: TObject);
begin
   Mode:=TEditorMode(TAction(Sender).Tag);
   ShowProps;
end;

end.

