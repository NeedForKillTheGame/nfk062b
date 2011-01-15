unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, bnet, Psock;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure BnetReceive(Sender:TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ReadBuf : array[0..1023] of Byte;
  end;

var
  Form1: TForm1;
  BNET1 : TUDPDEMON;

type TMP_Warmupis2 = packed record
        DATA:BYTE;
        end;

implementation

{$R *.DFM}

procedure TForm1.BnetReceive;
var
    Data:Pointer;
    FromIP : shortstring;
    FromPort : integer;
    msgsize : word;

begin
//BnetReceive

    Data := @ReadBuf;
    BNET1.ReadData(ReadBuf, FromIP, FromPort);
    listbox1.items.add('Response from '+FromIP);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
        Bnet1 := TUDPDEMON.create;
        Bnet1.ResendFreq := 300;
        Bnet1.ResendTimes := 4;
        Bnet1.onReceive := BnetReceive;
        Bnet1.LocalPort := 29991;
        BNET1.ReportLevel := Status_Routines;
        Bnet1.Active := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var     packet : byte;
        msg : TMP_Warmupis2;


const   MMP_LOBBY_PING=72;
        BNET_GAMEPORT : word = 29991;

begin
        Bnet1.Active := true;
        msg.data := MMP_LOBBY_PING;
//        listbox1.items.add('Sending to '+edit1.text);
        BNET1.SendData(1, msg, sizeof(TMP_Warmupis2), edit1.text, BNET_GAMEPORT);
end;

end.
