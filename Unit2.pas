{
        game NEED FOR KILL
        loading form
        (c) 3d[Power]
        http://powersite.narod.ru
}

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FMOD;

type
  Tloadi = class(TForm)
    cns: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  loadi: Tloadi;

implementation

uses Unit1;

{$R *.DFM}

procedure Tloadi.FormCreate(Sender: TObject);
begin
cns.Ctl3D := false;
end;

procedure Tloadi.Button1Click(Sender: TObject);
begin
application.terminate;
end;

procedure Tloadi.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
application.terminate;
end;

end.
