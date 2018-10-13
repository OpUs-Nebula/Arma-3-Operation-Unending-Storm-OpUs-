_PosVar = player getVariable "Position";
((_PosVar select {(str side player) == (_x param[0])}) param[0]) set [1,getPos player];
[getPlayerUID player,"position",_PosVar,player] spawn DBC_fnc_SetPlayer;