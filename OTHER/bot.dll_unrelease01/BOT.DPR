{

	BOT.DLL for Need For Kill
	(c) 3d[Power]
	http://www.3dpower.org

        unit: bot.dpr
        purpose: system procedures, try to not modify this unit.

}
library bot;

uses
  SysUtils,
  Classes,
  Windows,
  bot_defs in 'bot_defs.pas',
  bot_ai in 'bot_ai.pas',
  bot_console in 'bot_console.pas',
  bot_register in 'bot_register.pas',
  bot_util in 'bot_util.pas';

// ==========================================

{$include temp.inc}
// --------------------------------------------------------------

// DO NOT MODIFY.
procedure DLL_RegisterProc(AProc : TCallProc; ProcID:byte);
begin
        case ProcID of
        1 : FSExProc := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc2(AProc : TCallTextProc; ProcID:byte);
begin
        case ProcID of
        1 : AddMessage := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc3(AProc : TCallProcSTR; ProcID:byte);
begin
        case ProcID of
        1 : GetSystemVariable := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc4(AProc : TCallProcCreatePlayer; ProcID:byte);
begin
        sys_CreatePlayer := AProc;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc5(AProc : TCallProcWordByteFunc; ProcID:byte);
begin
        case ProcID of
        1 : SetKeys := AProc;
        2 : SetAngle := AProc;
        3 : SetWeapon := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc6(AProc : TCallProcWordWord_Bool; ProcID:byte);
begin
        case ProcID of
        1 : Test_Blocked := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc7(AProc : TCallProcWordWordString; ProcID:byte);
begin
        case ProcID of
        1 : debug_textout := AProc;
        end;
end;

// DO NOT MODIFY.
procedure DLL_RegisterProc8(AProc : TCallProcBrickStruct); begin GetBrickStruct := AProc; end;
procedure DLL_RegisterProc9(AProc : TCallProcObjectsStruct); begin GetObjStruct := AProc; end;
procedure DLL_RegisterProc10(AProc : TCallProcSpecailObjectsStruct); begin GetSpecObjStruct := AProc; end;
procedure DLL_RegisterProc11(AProc : TCallProcWord); begin RemoveBot := AProc; end;
// ================================================

procedure BOT_NEWTHINK (i:byte);
begin
{        players[i].ThinkTime := 50+random(100);
        players[i].currentkeys := 0;

        if random(2)=0 then
        players[i].currentkeys := players[i].currentkeys + BKEY_MOVERIGHT else
        players[i].currentkeys := players[i].currentkeys + BKEY_MOVELEFT;

        if random(4)>0 then
                players[i].currentkeys := players[i].currentkeys + BKEY_MOVEUP else
                players[i].currentkeys := players[i].currentkeys + BKEY_MOVEDOWN;

        if random(4)>0 then
                players[i].currentkeys := players[i].currentkeys + BKEY_FIRE;

//        SetAngle(players[i].dxid, random(255));
        players[i].fangle := random(255);
        SetWeapon(players[i].dxid, random(8));
}
end;

procedure BOT_AI(I:byte);
begin
//        if players[i].ThinkTime = 0 then BOT_NEWTHINK(i) else dec(players[i].ThinkTime);

{        if Test_Blocked (trunc(players[i].x + 15),trunc(players[i].y)) then
                players[i].ThinkTime := 0;

{       if Test_Blocked (trunc(players[i].x - 15),trunc(players[i].y)) then
                players[i].ThinkTime := 0; }

//        SetAngle(players[i].dxid, trunc(players[i].fangle));
//        Setkeys(players[i].dxid,  players[i].currentkeys);
//      addmessage('BOTAI:'+inttostr(players[i].dxid));
end;

// gets player count
function PLCOUNT:byte;
var i : byte;
begin
        result :=0;
        for i := 0 to 7 do if players[i]<> nil then inc(result);
end;


// MainLoop. NFK.EXE calls this procedure 50 times per second. (in game)
procedure DLL_MainLoop();
var i : byte;
        tmp : TBrick;
begin
{       for i := 0 to 7 do if players[i] <> nil then if players[i].bot then
               BOT_AI(i);

       if Test_Blocked(trunc(players[0].x+20),trunc(players[0].y)) then
             debug_textout (100,100,'blocked') else
             debug_textout (100,100,'not blocked');

       tmp := GetBrickStruct(round(players[0].x / 32), round(players[0].y / 16));
       debug_textout (100,120, inttostr( tmp.image  ) );
//        addmessage(players[0].netname);
 }
end;

// NFK loads a map. and begin game. It should be warmup time for now..
procedure DLL_EVENT_BeginGame;
begin
        EVENT_BeginGame;
end;

// Game Reborn. It happends at game start, or at map restart. (it also called after DLL_EVENT_BeginGame (once));
procedure DLL_EVENT_ResetGame;
begin
        EVENT_ResetGame;
end;

// DO NOT MODIFY
procedure DLL_SYSTEM_AddPlayer(Player : TPlayerEx);
begin
end;

// DO NOT MODIFY
procedure DLL_SYSTEM_RemoveAllPlayers();
var i : byte;
begin
        for i := 0 to high(Players) do if players[i] <> nil then // free cell
        players[i] := nil;
end;

// DO NOT MODIFY
procedure DLL_SYSTEM_RemovePlayer(DXID:word);
var i : byte;
begin
{        for i := 0 to high(Players) do if players[i] <> nil then // free cell
        if players[i].dxid = dxid then begin
                players[i] := nil;
                exit;
                end;
}                
end;

// DO NOT MODIFY
procedure DLL_SYSTEM_UpdatePlayer(Player : TPlayerEx);
var i : byte;
begin
{        // update all player info
        for i := 0 to 7 do if players[i] <> nil then // free cell
        if players[i].DXID = Player.DXID then
        with players[i] do begin
                dead := player.dead;
                bot  := player.bot;
                refire  := player.refire;
                weapchg  := player.weapchg;
                weapon  := player.weapon;
                threadweapon  := player.threadweapon;
                dir := player.dir;
                gantl_state := player.gantl_state;
                air := player.air;
                team := player.team;
                health := player.health;
                armor := player.armor;
                frags := player.frags;
                netname := player.netname;
                nfkmodel := player.nfkmodel;
                crouch := player.crouch;
                balloon := player.balloon;
                flagcarrier := player.flagcarrier;
                Location := player.Location;
                item_quad := player.item_quad;
                item_regen := player.item_regen;
                item_battle  := player.item_battle;
                item_flight := player.item_flight;
                item_haste := player.item_haste;
                item_invis := player.item_invis;
                have_rl := player.have_rl;
                have_gl  := player.have_gl;
                have_rg  := player.have_rg;
                have_bfg := player.have_bfg;
                have_sg := player.have_sg;
                have_sh   := player.have_sh;
                have_mg   := player.have_mg;
                have_pl  := player.have_pl;
                ammo_mg := player.ammo_mg;
                ammo_sg := player.ammo_sg;
                ammo_gl := player.ammo_gl;
                ammo_rl := player.ammo_rl;
                ammo_sh := player.ammo_sh;
                ammo_rg := player.ammo_rg;
                ammo_pl := player.ammo_pl;
                ammo_bfg := player.ammo_bfg;
                x := player.x;
                y := player.y;
                cx := player.cx;
                cy := player.cy;
                InertiaX := player.InertiaX;
                InertiaY := player.InertiaY;
                exit;
        end;
}
end;

procedure AddMessageEx(text : string);
begin
        addmessage(text);
end;

exports DLL_RegisterProc, DLL_RegisterProc2, DLL_RegisterProc3,
        DLL_RegisterProc4, DLL_RegisterProc5,DLL_RegisterProc6,
        DLL_RegisterProc7,DLL_RegisterProc8,DLL_RegisterProc9,
        DLL_RegisterProc10,DLL_RegisterProc11,
        DLL_EVENT_BeginGame, DLL_EVENT_ResetGame, DLL_MainLoop,
        DLL_SYSTEM_UpdatePlayer, DLL_SYSTEM_AddPlayer, DLL_CMD,
        DLL_SYSTEM_RemoveAllPlayers, DLL_SYSTEM_RemovePlayer;

//implementation


begin
end.
