unit bot_console;

interface
uses windows, sysutils, bot_util;



procedure DLL_CMD(s : string);

implementation
uses bot_register, bot_defs;


// Console commands reaction
procedure DLL_CMD(s : string);

var ls : string;
    par1, par2, par3 : string;
    i : byte;
begin
//        bot_register.players[1].

        ls := lowercase(s);
        par1 := strpar(ls,0);
        par2 := strpar(ls,1);
        par3 := strpar(ls,2);

        // -------------------------------------
        if par1='addbot' then
                sys_CreatePlayer ('bot','sarge+red',0);
        // -------------------------------------
        if par1='removebot' then
                for i := 7 downto 0 do if players[i] <> nil then if players[i].bot then begin
                        RemoveBot(players[i].DXID);
                        break;
                        end;
        // -------------------------------------
        // parse commands here...
end;

end.
