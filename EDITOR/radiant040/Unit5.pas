unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Spin, StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label5: TLabel;
    SpinEdit3: TSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
uses unit1;
{$R *.DFM}

procedure TForm5.FormCreate(Sender: TObject);
begin
spinedit1.Value := unit1.BRICK_X;
spinedit2.Value := unit1.BRICK_Y;
spinedit3.Value := unit1.MAP_BG;
edit1.text := unit1.MAP_NAME;
edit2.text := unit1.MAP_AUTHOR;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
unit1.BRICK_X := spinedit1.value;
unit1.BRICK_Y := spinedit2.value;
unit1.MAP_BG := spinedit3.value;
unit1.MAP_NAME := edit1.text;
unit1.MAP_AUTHOR := edit2.text;
close;
end;

end.
