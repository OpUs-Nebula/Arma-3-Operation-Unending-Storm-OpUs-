_Init = param[0,false,[false]];

if (_Init) then
{
    _Var = [[(player getVariable "Nation"),getUnitLoadout player]];
    player setVariable ["gear",_Var];
    [getPlayerUID player,"gear",_Var,player] spawn DBC_fnc_SetPlayer;
}
else
{
    _Gear = player getVariable "gear";
    ((_Gear select {(player getVariable "Nation") == (_x param[0])}) param[0]) set [1,getUnitLoadout player];
    [getPlayerUID player,"gear",_Gear,player] spawn DBC_fnc_SetPlayer;
};