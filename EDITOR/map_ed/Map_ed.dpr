program Map_ed;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  teleport_dlg in 'teleport_dlg.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  brshrepls in 'brshrepls.pas' {Form2_};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'NFK Radiant';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm2_, Form2_);
  Application.Run;
end.
