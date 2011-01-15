unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, ComCtrls;

type
  TForm4 = class(TForm)
    ListView1: TListView;
    ImageList1: TImageList;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
uses unit1;
{$R *.DFM}

procedure addprop (st1,st2,st3,st4 : string);
var item : TListItem;
begin
item := form4.listview1.items.add;
item.caption := st1;
item.SubItems.Add(st2);
item.SubItems.Add(st3);
item.SubItems.Add(st4);
end;


procedure TForm4.FormCreate(Sender: TObject);
var s : shortstring;
    i : byte;
begin
listview1.items.Clear;
unit1.SELECTEDOBJ := -1;
for i := 0 to $FF do if unit1.ddd[i].active = true then begin
        case ddd[i].objtype of
        1 : s := 'teleport';
        2 : s := 'button';
        3 : s := 'door';
        4 : s := 'trigger';
        5 : s := 'area_push';
        6 : s := 'area_pain';
        7 : s := 'area_ta_end';
        8 : s := 'area_teleport';
        9 : s := 'doortrigger';
        10 : s := 'area_waterillusion';
        end;
        addprop(s,inttostr(i),inttostr(ddd[i].x),inttostr(ddd[i].y));
end;
end;

procedure TForm4.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
unit1.SELECTEDOBJ := strtoint(item.SubItems[0]);
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
unit1.SELECTEDOBJ := -1;
close;
end;

end.
