unit bot_register;

interface
uses bot_defs, bot_console;

type
  TCallProc = function:integer;
  TCallProcSTR = function(text:string):string;
  TCallTextProc = function(text:string):integer;
  TCallProcCreatePlayer = function(name, model: string; team : byte):integer;
  TCallProcWordByteFunc = function(DXID : word ; value: byte):integer;
  TCallProcWordWord_Bool = function(x, y : word):boolean;
  TCallProcWordWordString = procedure(x, y : word; text : string);
  TCallProcBrickStruct          = function(x, y : word):TBrick;
  TCallProcObjectsStruct        = function(ID : word):TObj;
  TCallProcSpecailObjectsStruct = function(ID : byte):TSpecObj;
  TCallProcWord = procedure(par : WORD);

VAR
  FSExProc      : TCallProc;
  AddMessage    : TCallTextProc;
  GetSystemVariable : TCallProcSTR;
  players       : array[0..7] of TPlayer;
  sys_CreatePlayer : TCallProcCreatePlayer;
  SetAngle      : TCallProcWordByteFunc;
  SetKeys       : TCallProcWordByteFunc;
  SetWeapon     : TCallProcWordByteFunc;
  Test_Blocked  : TCallProcWordWord_Bool;
  debug_textout : TCallProcWordWordString;
  GetBrickStruct: TCallProcBrickStruct;
  GetObjStruct  : TCallProcObjectsStruct;
  GetSpecObjStruct : TCallProcSpecailObjectsStruct;
  RemoveBot     : TCallProcWord;

implementation

end.
