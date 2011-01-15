unit MapPropsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask;

type
  TMapPropsDlg = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    AuthorEd: TEdit;
    NameEd: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BGEd: TEdit;
    MaxXEd: TEdit;
    MaxYEd: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MapPropsDlg: TMapPropsDlg;

implementation

{$R *.dfm}

end.
