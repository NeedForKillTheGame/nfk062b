unit palette_unit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ExtDlgs, shellapi;

type
  Tpalette = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    Image1: TImage;
    OPD1: TOpenPictureDialog;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Button4: TButton;
    Button5: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  palette: Tpalette;

implementation
uses unit1;
{$R *.DFM}

procedure Tpalette.FormShow(Sender: TObject);
begin
if CUSTOMPALITRE then label1.caption :='Current Brick Palette: CUSTOM' else
label1.caption :='Current Brick Palette: DEFAULT';

Image1.Picture.Bitmap.Assign(PaletteFile);
image1.Update;

image1.visible := CUSTOMPALITRE;

button1.visible := CUSTOMPALITRE;
button2.visible := not CUSTOMPALITRE;
button5.visible := CUSTOMPALITRE;
CheckBox1.visible := CUSTOMPALITRE;
Panel1.visible := CheckBox1.checked;

end;

procedure Tpalette.Button2Click(Sender: TObject);
begin
if not opd1.execute then exit;
PaletteFile.LoadFromFile(opd1.filename);

PaletteStream.Clear;
PaletteStream.LoadFromFile(opd1.filename);

if (PaletteFile.Width > 256) or
   (PaletteFile.Height > 256) then begin
        Showmessage('Can''t use this bitmap'+#13+'Width (Height) must me less or equal 256');
        exit;
   end;

CUSTOMPALITRE := TRUE;
form1.ImageList.Items[7].Picture.LoadFromFile(opd1.filename);
form1.ImageList.Items[7].Transparent := CheckBox1.checked;
form1.ImageList.Items[7].TransparentColor := CUSTOMPALITRETRANSPARENTCOLOR;
form1.ImageList.Items[7].restore;
CUSTOMPALITREFILENAME := opd1.filename;

FormShow(sender);

end;

procedure Tpalette.Button3Click(Sender: TObject);
begin
close;
end;

procedure Tpalette.Panel1Click(Sender: TObject);
var    cdlg : TColorDialog;
begin
        if not CheckBox1.checked then exit;
        cdlg := TColorDialog.Create(self);
        cdlg.Color := CUSTOMPALITRETRANSPARENTCOLOR;
        if not cdlg.Execute then exit;
        panel1.color := cdlg.Color;

        if CUSTOMPALITRE then begin
                CUSTOMPALITRETRANSPARENTCOLOR := cdlg.Color;
                CUSTOMPALITRETRANSPARENT := CheckBox1.checked;
                form1.ImageList.Items[7].Transparent := CheckBox1.checked;
                form1.ImageList.Items[7].TransparentColor := CUSTOMPALITRETRANSPARENTCOLOR;
                form1.ImageList.Items[7].restore;
        end;

        cdlg.free;
end;

// assign transparent
procedure Tpalette.CheckBox1Click(Sender: TObject);
begin
panel1.visible := checkbox1.checked;

        if CUSTOMPALITRE then begin
                form1.ImageList.Items[7].Transparent := CheckBox1.checked;
                CUSTOMPALITRETRANSPARENT := CheckBox1.checked;
                form1.ImageList.Items[7].restore;
        end;
end;

// destroy palette
procedure Tpalette.Button1Click(Sender: TObject);
begin
      CUSTOMPALITRE := FALSE;
      CUSTOMPALITREFILENAME := '';
      Checkbox1.checked := false;
      Formshow(sender);
end;

procedure Tpalette.Button4Click(Sender: TObject);
begin
// Загрузка help файла
showmessage('You can import you own brick pallette. '+#13#13+'Brick pallette it is a BMP file'+#13+'which contain bricks graphics.'+#13+'Please check sample_brickpalette.bmp'); 
//ShellExecute(Application.Handle,'open',pchar(extractfilepath(application.exename)+'\palettes\palettehelp.htm'),nil,nil,0);
end;

procedure Tpalette.Button5Click(Sender: TObject);
begin
        if savedialog1.execute then try
        image1.picture.savetofile(savedialog1.filename);
        except showmessage('An error occured while exporting palette file'); end;
end;

procedure Tpalette.FormCreate(Sender: TObject);
begin
        palette.CheckBox1.checked := CUSTOMPALITRETRANSPARENT;
        palette.Panel1.color := CUSTOMPALITRETRANSPARENTCOLOR;
end;

end.
