unit bot_ai;

interface
uses bot, bot_register, bot_defs;
procedure EVENT_BeginGame;
procedure EVENT_ResetGame;

implementation

//uses bot;
//function Addmessage (text:string):integer;

procedure EVENT_BeginGame;
begin
        // load waypoints here...
//        bot.
        AddMessage('^3bot.dll: Running "sample bot" v 0.0.0');
//        addmessage(GetSystemVariable ('mapcrc32'));
end;

procedure EVENT_ResetGame;
begin
        // reset bot ai here..
end;

begin
end.
