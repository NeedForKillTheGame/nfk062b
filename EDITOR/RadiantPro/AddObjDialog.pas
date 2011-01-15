unit AddObjdialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TAddObjDlg = class(TForm)
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddObjDlg: TAddObjDlg;

implementation

{$R *.dfm}

procedure TAddObjDlg.RadioButton1Click(Sender: TObject);
begin
   Tag:=TRadioButton(Sender).Tag;
end;

end.
