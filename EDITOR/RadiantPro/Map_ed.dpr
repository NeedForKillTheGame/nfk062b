program Map_ed;

uses
  Forms,
  bzLib in 'bz\bzLib.pas',
  PowerAcrModuleInfo in 'bz\PowerAcrModuleInfo.pas',
  PowerArc in 'bz\PowerArc.pas',
  MyStrings in 'MyStrings.pas',
  MyPalette in 'MyPalette.pas',
  Main in 'Main.pas' {MainForm},
  MyClasses in 'MyClasses.pas',
  MyScroll in 'MyScroll.pas',
  AddObjDialog in 'AddObjDialog.pas' {AddObjDlg},
  MyBuf in 'MyBuf.pas',
  MapPropsForm in 'MapPropsForm.pas' {MapPropsDlg},
  MapPaletteForm in 'MapPaletteForm.pas' {MapPaletteDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'NFK Radiant';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddObjDlg, AddObjDlg);
  Application.CreateForm(TMapPropsDlg, MapPropsDlg);
  Application.CreateForm(TMapPaletteDlg, MapPaletteDlg);
  Application.Run;
end.
