unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, inifiles;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure SaveSettings();
var f:TIniFile;
begin
with form1 do begin
        try
        F := TIniFile.Create(getcurrentdir+'\basenfk\nfksetup.ini');

        //fullscreen
        if checkbox1.checked then f.WriteString ('video','fullscreen','1')
        else f.WriteString ('video','fullscreen','0');

        //depth
        if radiobutton2.checked then f.WriteString ('video','bitdepth','32')
        else f.WriteString ('video','bitdepth','16');

        // vsync
        if checkbox2.checked then f.WriteString ('video','vsync','1')
        else f.WriteString ('video','vsync','0');

        //depth
        if radiobutton3.checked then f.WriteString ('sound','soundtype','2'); // hard
        if radiobutton4.checked then f.WriteString ('sound','soundtype','1'); //soft
        if radiobutton5.checked then f.WriteString ('sound','soundtype','0'); //none

        f.free;
        except showmessage('Failed to save setting.. Can''t save to: '+#13+getcurrentdir+'\basenfk\nfksetup.ini'); end;
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
SaveSettings;
close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
try
SaveSettings;
finally winexec('nfk.exe',SW_SHOWNORMAL); end;

close;

end;

procedure TForm1.FormCreate(Sender: TObject);
var f:TIniFile;
begin
        F := TIniFile.Create(getcurrentdir+'\basenfk\nfksetup.ini');

        if f.ReadString ('video','fullscreen','')='0' then checkbox1.checked := false;

        if f.ReadString ('video','bitdepth','')='16' then radiobutton1.checked := true;

        if f.ReadString ('video','vsync','')='1' then checkbox2.checked := true;

        if f.ReadString ('sound','soundtype','')='2' then radiobutton3.checked := true;
        if f.ReadString ('sound','soundtype','')='1' then radiobutton4.checked := true;
        if f.ReadString ('sound','soundtype','')='0' then radiobutton5.checked := true;
        f.free;
end;

end.
