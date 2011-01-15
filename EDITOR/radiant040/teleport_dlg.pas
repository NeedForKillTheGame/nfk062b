unit teleport_dlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, ExtCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Bevel1: TBevel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key='1' then RadioButton1.SetFocus;
if key='2' then RadioButton2.SetFocus;
if key='3' then RadioButton3.SetFocus;
if key='4' then RadioButton4.SetFocus;
if key='5' then RadioButton5.SetFocus;
if key='6' then RadioButton6.SetFocus;
if key='7' then RadioButton7.SetFocus;
if key='8' then RadioButton8.SetFocus;
if key='9' then RadioButton9.SetFocus;
if key='0' then RadioButton10.SetFocus;
if key=#13 then button1.Click;
if key=#27 then button2.Click;
end;

end.
