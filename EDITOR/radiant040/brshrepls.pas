unit brshrepls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin;

type
  TForm2_ = class(TForm)
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Buttn1: TButton;
    Button2: TButton;
    procedure Buttn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpinEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2_: TForm2_;

implementation
uses unit1;
{$R *.DFM}

procedure TForm2_.Buttn1Click(Sender: TObject);
var i, a: word;
begin
for i := 0 to BRICK_X - 1 do
for a := 0 to BRICK_Y - 1 do
if bbb[i,a].image = spinedit1.value then bbb[i,a].image := spinedit2.value;
BrushName;
close;
end;

procedure TForm2_.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm2_.SpinEdit2KeyPress(Sender: TObject; var Key: Char);
begin
//if key=#13 then Buttn1Click(sender);
end;

end.
