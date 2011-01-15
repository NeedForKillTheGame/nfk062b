unit MapPaletteForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  MyClasses, ImgList, ExtDlgs;

type
  TMapPaletteDlg = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PaletteBox: TScrollBox;
    Panel2: TPanel;
    Image: TPaintBox;
    MyPalette: TImageList;
    Button1: TButton;
    OpenDlg: TOpenPictureDialog;
    ColorDlg: TColorDialog;
    Label1: TLabel;
    ColorPnl: TPanel;
    procedure ImagePaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ColorPnlClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Map: TMap;
    PalFile: string;
    YBrkCount: integer;
  end;

var
  MapPaletteDlg: TMapPaletteDlg;

implementation

uses MyPalette;

{$R *.dfm}

const
   XBrkCount = 5;
   CW=0;CH=0;

   BackBrkColor = clGray;

procedure TMapPaletteDlg.ImagePaint(Sender: TObject);
var
   i, j, x, y, img: integer;

begin
   with Image, Canvas do
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
            if img>=MyPalette.Count then Exit;
          	MyPalette.Draw(Canvas, x, y, img);
         end;
   end;
end;

procedure TMapPaletteDlg.Button1Click(Sender: TObject);
begin
   with OpenDlg do
      if Execute then
      try
         LoadPaletteFromFile(FileName, MyPalette, ColorDlg.Color, 0, 0);
      	YBrkCount:=(MyPalette.Count+XBrkCount-1) div XBrkCount;
   		ImagePaint(Self);
         PalFile:=FileName;
      except
         ShowMessage('I can''t load this bitmap!!!');
         PalFile:='';
      end;
end;

procedure TMapPaletteDlg.ColorPnlClick(Sender: TObject);
begin
   ColorDlg.Execute;
   ColorPnl.Color:=ColorDlg.Color;
   if PalFile<>'' then
   begin
      LoadPaletteFromFile(palFile, MyPalette, ColorDlg.Color, 0, 0);
 		ImagePaint(Self);
   end;
end;

procedure TMapPaletteDlg.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ColorDlg.Color:=Image.Canvas.Pixels[X, Y];
   ColorPnl.Color:=ColorDlg.Color;
   if PalFile<>'' then
   begin
      LoadPaletteFromFile(palFile, MyPalette, ColorDlg.Color, 0, 0);
 		ImagePaint(Self);
   end;
end;

procedure TMapPaletteDlg.FormShow(Sender: TObject);
begin
   if Map.CustomPalette then
   	LoadPaletteFromBitmap(Map.Palette, MyPalette, ColorDlg.Color, 0, 0)
      else MyPalette.Clear;
   YBrkCount:=(MyPalette.Count+XBrkCount-1) div XBrkCount;
	ImagePaint(Self);
end;

end.
