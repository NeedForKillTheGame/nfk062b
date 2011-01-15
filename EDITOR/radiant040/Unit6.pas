unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm6 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
uses unit1;
{$R *.DFM}



procedure TForm6.FormCreate(Sender: TObject);
var i,z : word;
r : boolean;
begin
memo1.clear;
for i := 0 to $FF do if ddd[i].active = true then begin
                if ddd[i].objtype = 1 then begin
                        if bbb[ddd[i].x,ddd[i].y].image > 0 then
                        memo1.lines.add('>>> TELEPORT #'+inttostr(i)+' not stand on empty position.');
                        if bbb[ddd[i].lenght ,ddd[i].dir ].image >= 36 then
                        memo1.lines.add('>>> TELEPORT #'+inttostr(i)+' teleport player to non empty position.');
                        if ddd[i].y < 2 then
                        memo1.lines.add('>>> TELEPORT #'+inttostr(i)+' have incorrect "pos_y" value. it must be >= 2.');
                        if ddd[i].dir < 2 then
                        memo1.lines.add('>>> TELEPORT #'+inttostr(i)+' have incorrect "goto_y" value. it must be >= 2.');
                end;
                if ddd[i].objtype = 2 then begin
                        if bbb[ddd[i].x,ddd[i].y].image > 0 then
                        memo1.lines.add('>>> BUTTON #'+inttostr(i)+' not stand on empty position.');

                        if ddd[i].target = 0 then
                        memo1.lines.add('>>> BUTTON #'+inttostr(i)+' have not a target.');
                        r := false;
                        if ddd[i].target > 0 then begin
                        for z := 0 to $FF do if ddd[z].active = true then
                        if (ddd[z].objtype = 2) and (ddd[z].targetname = ddd[i].target) then begin r := true; break; end;
                        if r = false then memo1.lines.add('>>> BUTTON #'+inttostr(i)+' have null target. door with same targetname does not exists.');
                        end;
                end;
        end;
end;


end.
