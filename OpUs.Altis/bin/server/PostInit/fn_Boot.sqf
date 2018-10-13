_NatData = (["nations",[["worldname",str worldname],"worlds"],[]] call DBS_fnc_GetData) param[0];

_Nations = [];
{
    missionNamespace setVariable [_x param[0],_x param[1],true];
	_Nations append [_x param[0]];
} forEach _NatData;
Nations = _Nations;

["NATO",FOB1_WEST] call BAS_fnc_BasePop;
["CSAT",FOB1_EAST] call BAS_fnc_BasePop;
["AAF",FOB1_GUER] call BAS_fnc_BasePop;

{
    _x setVariable ["Name","FOB1",true];
} forEach [FOB1_EAST,FOB1_GUER,FOB1_WEST];

//Currently used in DefineZones to that zones dont have similar ID numbers.(Maybe save in DB? Might prevent hacking if randomized.)
ZoneIDs = [];
{
    [_x param[0]] remoteExec ["server_fnc_SpawnMarkers", 0, true];
	_x spawn server_fnc_DefineZones; 
} forEach Zones;

