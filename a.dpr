{
        game NEED FOR KILL
        dpr file
        Created by 3d[Power]

        http://www.3dpower.org
        http://powersite.narod.ru

        haz-3dpower@mail.ru
        3dpower@3dpower.org
}

program a;

uses
  Forms,
  Unit1 in 'Unit1.pas' {mainform},
  Unit2 in 'Unit2.pas' {loadi},
  demounit in 'demounit.pas',
  net_unit in 'net_unit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Need For Kill';
  Loadi := TLoadi.Create(Application);
  loadi.Show;
  loadi.Update;
  Application.CreateForm(Tmainform, mainform);
  loadi.hide;
  Application.Run;
end.
