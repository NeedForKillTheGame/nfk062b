unit MyStrings;

interface

const
   Br_count = 42;

const
   BrushNames: array [-2..Br_Count] of String =
   	(
        {-2} 'Brush: unknown',
        {-1} 'Brush: brick',
        {0} 'Brush: none',
        {1} 'Brush: shotgun',
        {2} 'Brush: grenade launcher',
        {3} 'Brush: rocket launcher',
        {4} 'Brush: shaft',
        {5} 'Brush: railgun',
        {6} 'Brush: plasma',
        {7} 'Brush: bfg',
        {8} 'Brush: ammo for machinegun',
        {9} 'Brush: ammo for shotgun',
        {10} 'Brush: ammo for grenade launcher',
        {11} 'Brush: ammo for rocket launcher',
        {12} 'Brush: ammo for shaft',
        {13} 'Brush: ammo for railgun',
        {14} 'Brush: ammo for plasma',
        {15} 'Brush: ammo for bfg',
        {16} 'Brush: shard (+5)',
        {17} 'Brush: yellow armor (+50)',
        {18} 'Brush: red armor (+100)',
        {19} 'Brush: health +5',
        {20} 'Brush: health +25',
        {21} 'Brush: health +50',
        {22} 'Brush: megahealth +100',
        {23} 'Brush: powerup regeneration',
        {24} 'Brush: powerup battlesuit',
        {25} 'Brush: powerup haste',
        {26} 'Brush: powerup quaddamage',
        {27} 'Brush: powerup flight',
        {28} 'Brush: powerup invisibility',
        {29} 'Brush: grenade launcher for trix',
        {30} 'Brush: rocket launcher for trix',
        {31} 'Brush: lava',
        {32} 'Brush: water',
        {33} 'Brush: death area. kills player.',
        {34} 'Brush: respawn. neutral',
        {35} 'Brush: respawn. red team (CTF ONLY)',
        {36} 'Brush: respawn. blu team (CTF ONLY)',
        {37} 'Brush: empty brick',
        {38} 'Brush: jumppad',
        {39} 'Brush: strong jumppad',
        {40} 'Brush: red flag',
        {41} 'Brush: blue flag',
        {42} 'Brush: domination point'
      );


function GetBrushName(Brush: integer): string;

implementation

function GetBrushName(Brush: integer): string;
begin
   case brush of
      0..42 : Result:=BrushNames[Brush];
      54..255 : Result:=BrushNames[-1];
      else Result:=BrushNames[-2];
   end;
end;

end.
