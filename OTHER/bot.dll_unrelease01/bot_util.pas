unit bot_util;

interface

function strpar(s:string; pos : word):string;

implementation

// return string between spaces.
function strpar(s:string; pos : word):string;
var     counter, del1 : byte;
        len, i : word;
const   delimeter : char = ' ';
begin
        result := ''; len := length(s);  del1 := 1;
        if len = 0 then exit; counter := 0;

        for i := 1 to len do
        if (s[i]=delimeter) or (i=len) then begin
        if counter = pos then begin
                if (pos=0) and (s[i]<>delimeter) then result := copy(s, del1, i-del1+1) else
                if (pos=0) then result := copy(s, del1, i-del1) else
                if (i=len) and (s[i]<>delimeter) then result := copy(s, del1+1, i-del1+2) else
                result := copy(s, del1+1, i-del1);
                exit;
                end;

                del1 := i;
                inc(counter);
        end;
end;

end.
