unit Unit2_locsel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ImgList;

type
  Tloc_sel = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  loc_sel: Tloc_sel;
  itmsel_ : Tlistitem;
  
implementation

uses Unit4, unit1;

{$R *.DFM}

procedure addprop (st1,st2,st3,st4 : string);
var item : TListItem;
begin
Item := loc_sel.listview1.Items.add;
Item.caption := st1;
Item.SubItems.Add(st2);
Item.SubItems.Add(st3);
Item.SubItems.Add(st4);
end;

procedure Tloc_sel.FormCreate(Sender: TObject);
var i: byte;
begin
        listview1.items.Clear;
        for i := 1 to 50 do
        if LocationsArray[I].enabled then begin
                addprop(inttostr(I),
                        inttostr(LocationsArray[I].x),
                        inttostr(LocationsArray[I].y),
                        LocationsArray[I].text);
        end;
end;

procedure Tloc_sel.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
          unit1.SELECTEDLOC := strtoint(Item.Caption);
          Location_Modify(SELECTEDLOC);
end;

end.
