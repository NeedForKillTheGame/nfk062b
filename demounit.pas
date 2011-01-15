{
        game NEED FOR KILL
        variable module
        (c) 3d[Power]
        http://powersite.narod.ru
}

unit demounit;
// HEADERZ ===================================================
interface

uses unit1, Classes,Controls,Windows;

// BOT.DLL
//function ProcessFunction(input:string):string; external 'botz.dll';
//function ProcessFunction2(input:tmyrec):tmyrec; external 'botz.dll';

// demo
CONST
        PUV3_DIR0 = 1;
        PUV3_DIR1 = 2;
        PUV3_DIR2 = 8;
        PUV3_DIR3 = 16;
        PUV3_DEAD0 = 32;
        PUV3_DEAD1 = 64;
        PUV3_DEAD2 = 128;
        PUV3_WPN0 = 256;
        PUV3_WPN1 = 512;
        PUV3_WPN2 = 1024;
        PUV3_WPN3 = 2048;
        PUV3_WPN4 = 4096;
        PUV3_WPN5 = 8192;
        PUV3_WPN6 = 16384;
        PUV3_WPN7 = 32768;
        PUV3B_WPN8 = 1;
        PUV3B_CROUCH = 2;
        PUV3B_BALLOON = 8;
const
        BKEY_MOVERIGHT = 1;
        BKEY_MOVELEFT = 2;
        BKEY_MOVEUP = 8;
        BKEY_MOVEDOWN = 16;
        BKEY_FIRE = 32;

type TDData = PACKED record
        gametic : byte;
        gametime : word;
        type0 : byte;
        end;

type TDDamagePlayer = packed record
        DXID,ATTDXID{,x,y} :  word;
        attwpn,armor : byte;
        health : smallint;
        ext : byte;
        stat_dmggiven,stat_dmgrecvd : word;
        end;

type TDMissile = PACKED record
        DXID,x,y,spawnerDxid : word;
        inertiax,inertiay : single;
        end;

type TDMissileV2 = PACKED record
        DXID,spawnerDxid : word;
        inertiax,x,y,inertiay : single;
        end;


type TDPlayerJump = packed record
        dxid : word;
        end;

type TDVectorMissile = PACKED record
        DXID,x,y,cx,cy,spawnerDxid : word;
        inertiax,inertiay,angle : single;
        dir : byte;
        end;

type TDPlayerRename = packed record
        DXID : word;
        NewName : String[30];
        end;

type TDGrenadeFireV2 = PACKED record
        DXID,spawnerDxid : word;
        x,y,cx,cy,inertiax,inertiay,angle : single;
        dir : byte;
        end;

type TDGrenadeSync = PACKED record
        DXID,x,y : word;
        inertiax,inertiay : single;
        end;

type TDBubble = packed record
        DXID : word;
        end;


type TDPlayerUpdateV3 = PACKED record
        DXID : word;
        x,y,inertiax, inertiay : single;
        PUV3 : word;
        PUV3B : byte;
        wpnang,currammo : byte;
        end;

type TDPlayerHAUpdate = PACKED record
        DXID : word;
        health : smallint;
        armor : byte;
        frags : smallint;
        end;

type TDItemDissapear = PACKED record
        x,y,i : byte;
        end;

type TDDXIDKill = PACKED record
        DXID,x,y : word;
        end;

type TDImmediateTimeSet = PACKED record
        newgametic : byte;
        newgametime : word;
        warmup : word;
        end;

type TDSpawnPlayer = PACKED record
        DXID,x,y : word;
        dir,frame,dead : byte;
        modelname,netname : string[30];
        end;

type TDSpawnPlayerV2 = PACKED record
        DXID,x,y : word;
        dir,dead : byte;
        modelname,netname : string[30];
        team:byte;
        reserved:byte;
        end;

type TDGauntletState = PACKED record
        DXID : word;
        State : byte;
        end;


type TDRespawnFlash = packed record
        x,y : word;
        end;

type TDJumppadSound = packed record
        x,y : word;
        end;

type TDRespawnSound = packed record
        x,y : word;
        end;
type TDFlightSound = packed record
        x,y : word;
        end;

type TDLavaSound = packed record
        x,y : word;
        end;

type TDPowerUpSound = packed record
        x,y : word;
        end;

type TDGameEnd = packed record          //DDEMO_GAMEEND
        EndType : byte;
        end;

type TDRegenWork = packed record
        DXID : word;
        end;

type TDFlightWork = packed record
        DXID : word;
        end;

type TDEarnPowerup = packed record
        DXID : word;
        type1 : byte;
        time : byte;
        end;

type TDEarnReward = packed record
        DXID : word;
        type1 : byte;
        end;

type TDNoAmmoSound = packed record
        x,y : word;
        end;

{type TDStats = packed record
        DXID, stat_kills : word;
        stat_dmggiven : integer;
        stat_dmgrecvd : integer;
        mach_hits : word;
        shot_hits : word;
        gren_hits : word;
        rocket_hits : word;
        shaft_hits : word;
        plasma_hits : word;
        rail_hits : word;
        bfg_hits : word;
        end;

type TDStats2 = packed record
        DXID, stat_kills : word;
        stat_suicide,stat_deaths : word;
        stat_dmggiven,frags : integer;
        stat_dmgrecvd : integer;
        mach_hits : word;
        shot_hits : word;
        gren_hits : word;
        rocket_hits : word;
        shaft_hits : word;
        plasma_hits : word;
        rail_hits : word;
        bfg_hits : word;
        mach_fire,shot_fire,gren_fire,rocket_fire,shaft_fire,plasma_fire,rail_fire,bfg_fire : word;
        end;
}
type TDStats3 = packed record
        DXID, stat_kills : word;
        stat_suicide,stat_deaths : word;
        stat_dmggiven,frags : integer;
        stat_dmgrecvd : integer;
        bonus_impressive,bonus_excellent,bonus_humiliation : word;
        gaun_hits : word;
        mach_hits : word;
        shot_hits : word;
        gren_hits : word;
        rocket_hits : word;
        shaft_hits : word;
        plasma_hits : word;
        rail_hits : word;
        bfg_hits : word;
        mach_fire,shot_fire,gren_fire,rocket_fire,shaft_fire,plasma_fire,rail_fire,bfg_fire : word;
        end;

type TDTrixArenaEnd = packed record
        DXID : word;
        end;

type TDGameState = packed record
        type1 : byte;   //1=5min,2=1min,3=sudden
        end;


type TDReadyPress = packed record
        newmatch_statsin : word;
        end;

type TDObjChangeState = packed record
        objindex : byte;
        state : byte;
        end;

type TDCorpseSpawn = packed record
        DXID:word;
        end;

type TDMultiplayer = packed record
        y : byte;
        pov : word;
        end;

type  TDNetRail = packed record
        x,y,x1,y1,endx, endy : word;
        color : byte;
        end;

type  TDNetShotParticle = packed record
        x,y,x1,y1 : word;
        index : byte;
        end;

type TDNETTimeUpdate = packed record
        Min : WORD;
        WARMUP : boolean;
        end;


type TDNETSV_MatchStart = packed record
        spacer : byte;
        end;

type TDNETKickDropPlayer = packed record
        DXID:WORD;
        end;

type TDNETSpectator = packed record
        netname:string[30];
        action : boolean;
        end;

type TDNETCHATMessage = packed record
        DXID:word;
        messagelenght:byte;
        end;

type TDNETSoundData = packed record
        DXID:word;
        SoundType:byte;
        end;

type TDNETSoundStatData = packed record
        SoundType:byte;
        end;

type TDNETNameModelChange = packed record
        DXID:WORD;
        newstr:string[30]
        end;

type TDNETTeamSelect = packed record
        DXID:WORD;
        team : byte;
        end;

// ctf (demo).
type TDCTF_FlagTaken = packed record
        DXID:word;
        x,y:byte;
        end;

{type TDCTF_FlagDrop = packed record //drop from player..
        DXID,DropDXID:word;
        inertiax,inertiay:single;
        end;
 }
type TDCTF_FlagCapture = packed record //Capture....
        DXID:word;
        end;

{type TDCTF_FlagDroped = packed record // dropped to ground, reupdate coordz.
        DXID:word;
        x,y:single;
        end;
 }
type TDCTF_DropFlag = packed record // drop from player.
        DXID:WORD;
        DropperDXID:WORD;
        X, Y: Single;
        Inertiax, Inertiay : Single;
        end;

type TDWPN_DropWeapon = packed record // drop from player.
        DXID:WORD;
        DropperDXID:WORD;
        WeaponID:byte;
        X, Y: Single;
        Inertiax, Inertiay : Single;
        end;

type TDPOWERUP_DropPowerup = packed record // drop from player.
        DXID:WORD;
        DropperDXID:WORD;
        dir, imageindex:byte;
        X, Y: Single;
        Inertiax, Inertiay : Single;
        end;

type TDCTF_DropFlagApply = packed record // drop from player. coorrect flag poz
        DXID:WORD;
        X, Y: Single;
        end;

type TDCTF_FlagPickUp = packed record // pickup flag.
        FlagDXID, PlayerDXID:WORD;
        end;

type TDCTF_FlagReturnFlag = packed record // return flag.
        FlagDXID:WORD;
        team:byte;
        end;

type TDCTF_GameState = packed record
        RedFlagAtBase, BlueFlagAtBase : boolean;
        RedScore, BlueScore : word;
        end;

type TDCTF_GameStateScore = packed record
        RedScore, BlueScore : word;
        end;

type TDCTF_FlagCarrier = packed record
        DXID : word;
        end;

type TDDOM_ScoreChanges = packed record
        RedScore, BlueScore : word;
        end;

type TDDOM_Capture = packed record
        x,y,team : byte;
        end;


type  TD_049t4_ShaftBegin = packed record
        AMMO: byte;
        DXID: WORD;
end;

type  TD_049t4_ShaftEnd = packed record
        DXID: WORD;
end;

// ==========================================
// MULTIPLAYER. Network Packets

const NFK_SIGNNATURE = $BEFA;

type  TMP_RegisterPlayer = packed record  // client try to connect and join game as player
             DATA : BYTE;
             SIGNNATURE : word;
             DXID, ClientId : Word;       // clientid. for returning packed. to catch control.
             netname : string[30];
             nfkmodel : string[30];
end;

type  TMP_CreatePlayer = packed record
             DATA: BYTE;
             Team:byte;
             v1:boolean; //reserved
             X,Y : word;
             v3:word;//reserved
             v4:word;//reserved
             DXID,ClientId : Word; // assign dxid to him... | return ClientID
             netname : string[30];
             nfkmodel : string[30];
             ipaddress_ : string[15];
end;

type TMP_Invite = packed record
             ipaddress_ : string[15];
        end;

// for walking in any direction..
type  TMP_PlayerPosUpdate = packed record
             DATA : BYTE;
             PUV3B, wpnang : byte;
             PUV3, DXID : word;
             inertiax, inertiay : word;
             x,y : single;
end;

// for horizonthal walking....
type  TMP_PlayerPosUpdate_copy = packed record
             DATA : BYTE;
             PUV3B, wpnang : byte;
             PUV3, DXID : word;
             inertiax : word;
             x: single;
end;

type  TMP_ChatMessage = packed record
             DATA: BYTE;
             DXID: word;
//             Len: word;
//             C: array[0..0] of Char;
end;

type  TMP_ItemAppear = packed record
             DATA: BYTE;
             x,y : byte;
end;

type  TMP_ItemDisappear = packed record
             DATA: BYTE;
             x,y,index : byte;
             DXID : word;
end;

type TMP_HAUpdate = packed record
        DATA: BYTE;
        armor : byte;
        ammo : byte;
        DXID : word;
        health : smallint;
        frags : smallint;
        end;

type TMP_DamagePlayer = packed record
        DATA: BYTE;
        dmgtype, exp, armor : byte;
        DXID, AttackerDXID : word;
        health : smallint;
        x, y : single;
end;

type TMP_IamRespawn = packed record
        DATA: BYTE;
        DXID : word;
//        x, y, tmp_lastrespawn : byte;
        end;

type TMP_SV_PlayerRespawn = packed record
        DATA: BYTE;
        x, y : byte;
        DXID : word;
        end;

type  TMP_ShotParticle = packed record
        DATA: BYTE;
        index : byte;
        x,x1,y1,y : word;
end;

type  TMP_RailTrail = packed record
        DATA: BYTE;
        color : byte;
        x,x1,y1,y,endx, endy : word;
end;

type  TMP_ShaftStreem = packed record
        DATA: BYTE;
        Lenght : byte;
        x,y, angle,DXID : word;
end;

type  TMP_RailShot = packed record
        DATA: BYTE;
        color,ammo : byte;
        DXID : word;
        clippixel : smallint;
        x,y,fangle: single;
end;

type  TMP_GauntletShot = packed record
             DATA: BYTE;
             DXID : word;
             clippixel : smallint;
end;

type  TMP_ClientShot = packed record
        DATA: BYTE;
        index, ammo : byte;
        DXID : word;
        clippixel : smallint;
        x,y,fangle : single;
end;

type  TMP_cl_RocketSpawn = packed record
        DATA: BYTE;
        index : byte;
        spawnerDXID, selfDXID : word;
        fangle : smallint;
        x,y: single;
end;

type  TMP_cl_GrenSpawn = packed record
        DATA: BYTE;
        dir : byte;
        spawnerDXID, selfDXID : word;
        fangle : smallint;
        x,y : single;
        inertiax, inertiay : single;

end;

type  TMP_cl_PlasmaSpawn = packed record
        DATA: BYTE;
        spawnerDXID, selfDXID : word;
        fangle : smallint;
        x,y: Single;
end;

type  TMP_cl_ObjDestroy = packed record
        DATA: BYTE;
        index : byte;   // 0-just to dead1, 1-dead2
        killDXID,x,y : word;
end;

type TMP_SV_send_time = packed record
        DATA: BYTE;
        gametic : byte;
        gametime, warmup : word;
        end;

type TMP_SV_MatchStart = packed record
        DATA: BYTE;
        gameendid : byte;       // reason
        gameend : boolean;      // is gameend?
        end;

type TMP_GauntletState = packed record
        DATA: BYTE;
        state : boolean;  // on\off
        DXID : word;
        end;

type TMP_SV_DisconnectClient = packed record
        DATA: BYTE;
        ID : byte;      // reason.
        end;

type TMP_SV_MapRestart = packed record
        DATA: BYTE;
        reason : byte;      // reason.
        end;

type TMP_SV_Command = packed record
        DATA: BYTE;
        Quiet : boolean;        // notify clients about cmd change or not
        CommandID : byte;
        CommandValue : word;
end;

type TMP_TimeUpdate = packed record
        DATA: BYTE;
        WARMUP : boolean;
        Min : WORD;
        end;

type TMP_Ping = packed record
        DATA : BYTE;
        PING, DXID : word;
        end;

type TMP_AnswerPing = packed record
        DATA : BYTE;
        end;

type TMP_ThrowPlayer = packed record
        DATA : BYTE;
        DXID : word;
        iy, ix : real;
        end;

type TMP_Disconnect = packed record
        DATA : BYTE;
        type0 : byte;
        DXID : word;
        end;

type TMP_HostShutDown = packed record // kill @ll clientz.
        DATA : BYTE;
        end;

type TMP_DisconnectClient = packed record // kill @ll clientz.
        DATA : BYTE;
        ERROR : byte;
        end;

type TMP_ObjChangeState = packed record
        DATA : BYTE;
        objindex,state : byte;
        end;

type TMP_ObjChangeStateFailure = packed record
        DATA : BYTE;
        objindex : byte;
        state : byte;
        end;

type TMP_GAMESTATERequest = packed record
        DATA : BYTE;
        SIGNNATURE : word;
        spectator : boolean;
        end;

type TMP_GAMESTATEAnswer = packed record
        DATA:BYTE;
        MATCH_GAMETYPE : byte;
        DODROP:byte;
        CRC32:cardinal;
        Filename:string[30];
        VERSION:string[30];
        end;


type TMP_ChangeLevel = packed record
        DATA:BYTE;
        NewGameType : byte;
        CRC32:cardinal;
        Filename:string[30];
        end;

type TMP_DropPlayer = packed record
        DATA:BYTE;
        DXID:WORD;
        end;

type TMP_SpectatorJoin = packed record
        DATA:BYTE;
        netname:string[30];
        end;

type TMP_SpectatorLeave = packed record
        DATA:BYTE;
        netname:string[30];
        end;

type TMP_KickPlayer = packed record
        DATA:BYTE;
        DXID:WORD;
        end;

type TMP_Svcommand = packed record
        DATA:BYTE;
        forcerespawn:byte;
        sync:byte;
        overtime : byte;
        capturelimit: byte;
        railarenainstagib:boolean;
        teamdamage : boolean;
        fraglimit:word;
        timelimit:word;
        warmup:word;
        warmuparmor:Word;
        domlimit: word;
        end;

type TMP_Svcommand_ex = packed record
        DATA:BYTE;
        maxplayers:byte;
        net_predict:boolean;
        reserved1:byte;
        powerup:boolean;
        end;

type TMP_EarnReward = packed record
        DATA:BYTE;
        type0:byte;
        DXID:WORD;
        end;

type TMP_Warmupis2 = packed record
        DATA:BYTE;
        end;

type TMP_Stats3 = packed record
        DATA:BYTE;
        DXID, stat_kills,
        stat_suicide,stat_deaths,
        bonus_impressive,bonus_excellent,bonus_humiliation,
        gaun_hits, mach_hits, shot_hits, gren_hits, rocket_hits, shaft_hits, plasma_hits, rail_hits, bfg_hits,
        mach_fire,shot_fire,gren_fire,rocket_fire,shaft_fire,plasma_fire,rail_fire,bfg_fire : word;
        stat_dmggiven,frags : integer;
        stat_dmgrecvd : integer;
        end;

type TMP_TeleportPlayer = packed record
        DATA:BYTE;
        x1,y1,x2,y2 : word;
        end;

type TMP_NameModelChange = packed record
        DATA:BYTE;
        DXID:WORD;
        newstr:string[30]
        end;

type TMP_SoundData = packed record
        DATA:BYTE;
        SoundType:byte;
        DXID:word;
        end;

type TMP_SoundStatData = packed record
        DATA:BYTE;
        SoundType:byte;
        end;

type TMP_XYSoundData = packed record
        DATA:BYTE;
        SoundType, x, y : byte;
        end;

type TMP_TeamSelect = packed record
        DATA:BYTE;
        team : byte;
        DXID:WORD;
        end;

// CTF. MP
type TMP_CTF_DropFlag = packed record // drop from player.
        DATA:BYTE;
        DXID, DropperDXID:WORD;
        X, Y, Inertiax, Inertiay : Single;
        end;

type TMP_CTF_GameState = packed record
        DATA:BYTE;
        RedFlagAtBase, BlueFlagAtBase : boolean;
        RedScore, BlueScore : word;
        end;

type TMP_CTF_FlagCarrier = packed record
        DATA:BYTE;
        DXID : word;
        end;

type TMP_CTF_DropFlagApply = packed record // drop from player. coorrect flag poz
        DATA:BYTE;
        DXID:WORD;
        X, Y: Single;
        end;

type TMP_CTF_FlagReturnFlag = packed record // return flag.
        DATA:BYTE;
        team:byte;
        FlagDXID:WORD;
        end;

type TMP_CTF_FlagCapture = packed record //Capture....
        DATA:BYTE;
        DXID:word;
        end;

type TMP_CTF_FlagTaken = packed record
        DATA:BYTE;
        x,y:byte;
        DXID:word;
        end;

type TMP_CTF_FlagPickUp = packed record // pickup flag.
        DATA:BYTE;
        FlagDXID, PlayerDXID:WORD;
        end;

type TMP_CTF_GameStateScore = packed record
        DATA:BYTE;
        RedScore, BlueScore : word;
        end;

type TMP_DOM_Capture = packed record
        DATA:BYTE;
        x,y,team : byte;
        end;

type TMP_DOM_ScoreChanges = packed record
        DATA:BYTE;
        RedScore, BlueScore : word;
        end;

type TMP_WPN_DropWeapon = packed record // drop from player.
        DATA:BYTE;
        WeaponID:byte;
        DXID:WORD;
        DropperDXID:WORD;
        X, Y, Inertiax, Inertiay : Single;
        end;

type TMP_Powerup_DropPowerup = packed record // drop from player.
        DATA:BYTE;
        dir:byte;
        imageindex:byte;
        DXID:WORD;
        DropperDXID:WORD;
        X, Y, Inertiax, Inertiay : Single;
        end;

type TMP_TrixArenaWin = packed record
        DATA:BYTE;
        gametic : byte;
        DXID, gametime : word;
        end;

type TMP_LOBBY_Gamestate_result = packed record
        DATA:BYTE;
        SIGNNATURE : word;
        CurrentPlayers, MaxPlayers,Gametype:Byte;
        Hostname, MapName : String[30];
        end;

type TNFKPLANET_CMD = record
        _cmd : char;
        _data : array[0..14] of char ; //ASCIIZ
        end;

type TLOBBY_STAT_BACK = record
        _sequencenr : dword;            // 0xFFFFFFFF - last in sequence;
        name : array[0..14] of char;    // ASCIIZ
        mapname : array[0..14] of char; // ASCIIZ
        peer_ip : array[0..15] of char; // ASCIIZ
        _port : word;
        _max_users : word;
        _users : word;
        end;

type  TMP_049t4_ShaftBegin = packed record
        DATA: BYTE;
        AMMO: byte;
        DXID: WORD;
end;

type  TMP_049t4_ShaftEnd = packed record
        DATA: BYTE;
        DXID: WORD;
end;

type  TMP_IpInvite = packed record
        DATA: BYTE;
        ACTION: BYTE;
end;

type TMP_Vote = packed record
        DATA:BYTE;
        VOTE:BYTE;
        DXID:WORD;
        end;

type TMP_StartVote = packed record
        DATA:BYTE;
        DXID:WORD;
        VoteText:string[40];
        end;

type TMP_VoteResult = packed record
        DATA:BYTE;
        Result:byte;
        end;

type TMP_CommandResult = packed record
        DATA:byte;
        command : byte;
        value : word;
        end;

type TPlayerPosUpdate_Packed = packed record
        DATA:byte;
        Count : byte;
//        Size : byte;
        end;



const
MMP_REGISTERPLAYER      = 1;
MMP_CREATEPLAYER        = 2;
MMP_PLAYERPOSUPDATE     = 3;
MMP_CHATMESSAGE         = 4;
MMP_ITEMAPPEAR          = 5;
MMP_ITEMDISAPPEAR       = 6;
MMP_HAUPDATE            = 7;
MMP_DAMAGEPLAYER        = 8;
MMP_IAMRESPAWN          = 9;
MMP_SHOTPARTILE         = 10;
MMP_CLIENTSHOT          = 11;
MMP_RAILTRAIL           = 12;
MMP_CLIENTRAILSHOT      = 13;
MMP_SHAFTSTREEM         = 14;
MMP_CL_ROCKETSPAWN      = 15;
MMP_CL_GRENADESPAWN     = 16;
MMP_CL_PLAZMASPAWN      = 17;
//MMP_CL_BFGSPAWN         = 18;
MMP_CL_OBJDESTROY       = 19;
MMP_SV_SEND_TIME        = 20;
MMP_SV_COMMAND          = 21;
MMP_TIMEUPDATE          = 22;
MMP_MATCHSTART          = 23;
MMP_DISCONNECT          = 24;
MMP_MAPRESTART          = 25;
MMP_PING                = 26;
MMP_ANSWERPING          = 27;
MMP_THROWPLAYER         = 28;
MMP_PLAYERRESPAWN       = 29;
MMP_GAUNTLETSTATE       = 30;
MMP_GAUNTLETFIRE        = 31;
MMP_OBJCHANGESTATE      = 32;
MMP_GAMESTATEREQUEST    = 33;
MMP_GAMESTATEANSWER     = 34;
MMP_HOSTSHUTDOWN        = 35;
MMP_DROPPLAYER          = 36;
MMP_SPECTATORCONNECT    = 37;
MMP_SPECTATORDISCONNECT = 38;
MMP_CHANGELEVEL         = 39;
MMP_KICKPLAYER          = 40;
MMP_EARNREWARD          = 41;
MMP_WARMUPIS2           = 42;
MMP_STATS               = 43;
MMP_TELEPORTPLAYER      = 44;
MMP_NAMECHANGE          = 45;
MMP_MODELCHANGE         = 46;
MMP_SENDSOUND           = 47;
MMP_SENDSTATESOUND      = 48;
MMP_XYSOUND             = 49;
MMP_TEAMSELECT          = 50;
MMP_CTF_EVENT_FLAGTAKEN         =51;
MMP_CTF_EVENT_FLAGCAPTURE       =52;
MMP_CTF_EVENT_FLAGDROP          =53;
MMP_CTF_EVENT_FLAGPICKUP        =54;
MMP_CTF_EVENT_FLAGDROP_APPLY    =55;
MMP_CTF_EVENT_FLAGRETURN        =56;
MMP_CTF_GAMESTATE               =57;
MMP_CTF_EVENT_FLAGDROPGAMESTATE =58;
MMP_CTF_GAMESTATESCORE          =59;
MMP_CTF_FLAGCARRIER             =60;
MMP_DOM_CAPTURE                 =61;
MMP_DOM_SCORECHANGED            =62;
MMP_WPN_EVENT_WEAPONDROP        =63;
MMP_WPN_EVENT_PICKUP            =64;
MMP_WPN_EVENT_WEAPONDROP_APPLY  =65;
MMP_WPN_EVENT_WEAPONDROPGAMESTATE =66;
MMP_CHATTEAMMESSAGE             =67;
MMP_DOM_CAPTUREGAMESTATE        =68;
MMP_CHANGEGAMETYPE              =69;
MMP_MULTITRIX_WIN               =70;
MMP_LOBBY_GAMESTATE             =71;
MMP_LOBBY_PING                  =72;
MMP_LOBBY_ANSWERPING            =73;
MMP_PLAYERPOSUPDATE_COPY        =74;
MMP_IAMQUIT                     =75;
MMP_049test4_SHAFT_BEGIN        =76;
MMP_049test4_SHAFT_END          =77;
MMP_INVITE                      =78;
MMP_VOTE                        =79;
MMP_STARTVOTE                   =80;
MMP_VOTERESULT                  =81;
MMP_SV_COMMANDEX                =82;
MMP_YOUAREREALYKILLED           =83;
MMP_FLOOD                       =84;
MMP_LOBBY_GAMESTATE_RESULT      =85;
MMP_KILL_CLIENT                 =86;
MMP_SV_COMMAND_CHANGED          =87;
MMP_PLAYERPOSUPDATE_PACKED      =88;
MMP_POWERUP_EVENT_PICKUP        =89;
MMP_POWERUP_EVENT_POWERUPDROP   =90;
MMP_POWERUP_EVENT_POWERUPGAMESTATE=91;
MMP_RCON_MESSAGE                =92;
MMP_RCON_ANSWER                 =93;

const // sounds for FMOD
SND_1_MIN = 1;
SND_5_MIN = 2;
SND_ammopkup = 3;
SND_armor = 4;
SND_bfg_fire = 5;
SND_Bounce = 6;
SND_Button = 7;
SND_Damage2 = 8;
SND_Damage3 = 9;
SND_Dr1_end = 10;
SND_Dr1_strt = 11;
SND_error = 12;
SND_excellent = 13;
SND_expl = 14;
SND_fight = 15;
SND_flight = 16;
SND_gameend = 17;
SND_gauntl_r1 = 18;
SND_gauntl_r2 = 19;
SND_Gib1 = 20;
SND_Gib2 = 21;
SND_Grenade = 22;
SND_haste = 23;
SND_health100 = 24;
SND_health25 = 25;
SND_health5 = 26;
SND_health50 = 27;
SND_hit = 28;
SND_holdable = 29;
SND_humiliation = 30;
SND_impressive = 31;
SND_invisibility = 32;
SND_jumppad = 33;
SND_lava = 34;
SND_lg_hum = 35;
SND_lg_start = 36;
SND_machine = 37;
SND_menu2 = 38;
SND_menu3 = 39;
SND_noammo = 40;
SND_one = 41;
SND_plasma = 42;
SND_poweruprespawn = 43;
SND_prepare = 44;
SND_protect3 = 45;
SND_quaddamage = 46;
SND_rail = 47;
SND_regen = 48;
SND_regeneration = 49;
SND_respawn = 50;
SND_rocket = 51;
SND_shard = 52;
SND_shotgun = 53;
SND_sudden_death = 54;
SND_talk = 55;
SND_three = 56;
SND_two = 57;
SND_wearoff = 58;
SND_wpkup = 59;
SND_gauntl_a = 60;
SND_takenlead = 61;
SND_lostlead = 62;
SND_tiedlead = 63;
SND_redleads = 64;
SND_blueleads = 65;
SND_teamstied = 66;
SND_flagcap = 67;
SND_flagret = 68;
SND_flagtk = 69;
SND_domtake = 70;
SND_domtake2 = 71;
SND_vote=72;

var DMissile : TDMissile;
    DMissileV2 : TDMissileV2;
    DVectorMissile : TDVectorMissile;
    DGrenadeSync : TDGrenadeSync;
    DGameState : TDGameState;
    DCorpseSpawn : TDCorpseSpawn;
    DReadyPress : TDReadyPress;
    DEarnPowerup : TDEarnPowerup;
    DEarnReward : TDEarnReward;
    DJumppadSound : TDJumppadSound;
    DRespawnSound : TDRespawnSound;
    DLavaSound : TDLavaSound;
    DPowerUpSound : TDPowerUpSound;
    DFlightSound : TDFlightSound;
    DData : TDData;
    DPlayerUpdateV3 : TDPlayerUpdateV3;
//    DPlayerUpdateV2 : TDPlayerUpdateV2;
//    DPlayerUpdate : TDPlayerUpdate;
    DImmediateTimeSet : TDImmediateTimeSet;
    DGrenadeFireV2 : TDGrenadeFireV2;
    DNoAmmoSound : TDNoAmmoSound;
    DSpawnPlayer : TDSpawnPlayer;
    DSpawnPlayerV2 : TDSpawnPlayerV2;
    DDXIDKill : TDDXIDKill;
    DBubble : TDBubble;
    DGauntletState : TDGauntletState;
    DMultiplayer : TDMultiplayer;
    DItemDissapear : TDItemDissapear;
    DDamagePlayer : TDDamagePlayer;
    DPlayerJump : TDPlayerJump;
    DRespawnFlash : TDRespawnFlash;
    DGameEnd : TDGameEnd;
//    DStats : TDStats;
//    DStats2 : TDStats2;
    DStats3 : TDStats3;
    DTrixArenaEnd : TDTrixArenaEnd;
    DNetShotParticle : TDNetShotParticle;
    DPlayerHAUpdate : TDPlayerHAUpdate;
    DObjChangeState : TDObjChangeState;
// MULTIPLAYER
    DNetRail : TDNetRail;
    DNETTimeUpdate : TDNETTimeUpdate;
    DNETSV_MatchStart : TDNETSV_MatchStart;
    DNETKickDropPlayer : TDNETKickDropPlayer;
    DNETSpectator : TDNETSpectator;
    DNETCHATMessage : TDNETCHATMessage;
    DNETSoundData : TDNETSoundData;
    DNETSoundStatData : TDNETSoundStatData;
    DNETNameModelChange : TDNETNameModelChange;
    DNETTeamSelect : TDNETTeamSelect;

    // ctf (demo)
    DCTF_DropFlag:TDCTF_DropFlag;
    DCTF_FlagTaken:TDCTF_FlagTaken;
    DCTF_FlagCapture:TDCTF_FlagCapture;
    DCTF_DropFlagApply:TDCTF_DropFlagApply;
    DCTF_FlagPickUp:TDCTF_FlagPickUp;
    DCTF_FlagReturnFlag:TDCTF_FlagReturnFlag;
    DCTF_GameState:TDCTF_GameState;
    DCTF_GameStateScore:TDCTF_GameStateScore;
    DCTF_FlagCarrier:TDCTF_FlagCarrier;

    // dom
    DDOM_Capture : TDDOM_Capture;
    DDOM_ScoreChanges : TDDOM_ScoreChanges;


    DWPN_DropWeapon : TDWPN_DropWeapon;
    DPOWERUP_DropPowerup : TDPOWERUP_DropPowerup;

    D_049t4_ShaftBegin : TD_049t4_ShaftBegin;
    D_049t4_ShaftEnd : TD_049t4_ShaftEnd;
implementation



end.

