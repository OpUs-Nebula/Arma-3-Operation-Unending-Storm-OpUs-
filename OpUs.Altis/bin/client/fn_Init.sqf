_Unit   = param[0,objNull,[objNull]];
_IsJIP  = param[1,false,[false]];
_SpnLoc = param[2,[],[[]]];
_Side   = param[3,"",[""]];

LAST_PACKET = "";
//[_Data,[clientOwner,_Unit,getPlayerUID _Unit]] spawn DBC_fnc_GetPlayer
_Cycles = 0;

//Will most likely add Option for timeout, either disconnect or reset of player stats
//(later option bringing with it an increase in probability of cranial implosion via an external
//damage maximization framework, crafted by a lvl 7 rifleman)  
_Limit  = 1000000000;
//waitUntil{sleep 1; _Cycles = _Cycles + 1; (!(LAST_PACKET isEqualTo "") or _Cycles >= _Limit)};

{
    _Data  = _x param[0];
	_Value = _x param[1];
	
	[_Data,[clientOwner,_Unit,getPlayerUID _Unit]] spawn DBC_fnc_GetPlayer;
	waitUntil{sleep 1; _Cycles = _Cycles + 1; (!(LAST_PACKET isEqualTo "") or _Cycles >= _Limit)}; 
	if !(isNil {_Unit getVariable _Data} or {(_Unit getVariable _Data) isEqualTo "NO DATA"}) then
	{
	    SystemChat format["%1 Has Been Loaded!, Qty: %2",_Data,LAST_PACKET];
		LAST_PACKET = "";
	}
	else
	{
	    if (isNil {_Unit getVariable _Data}) then
		{
	        _Unit setVariable _x;
			
			//[SteamID,Column(Ex"Funds"),Data(1000),PlayerVehicle]//
			//Realize this scripts sets, does not add to whats already there. IE it will be deleted.
		    [getPlayerUID _Unit,_Data,_Value,_Unit] spawn DBC_fnc_SetPlayer;
		}
		else
		{
		    systemChat format["%1 Has been loaded from DataBase",_Data];
		};
	};
} forEach [["Funds",35300,true],["Tiers",[["Rifleman",0]],true],["Arsenal",[[_Unit getVariable "Nation",[]]],true]];


//if position exists, then equip from DB. else dont.(only on first join most likely)

//DEV: systemChat "Position Var....";

["position",[clientOwner,_Unit,getPlayerUID _Unit]] spawn DBC_fnc_GetPlayer;
waitUntil {!(LAST_PACKET isEqualTo "")};

//DEV: systemChat "Position Var not found.";

if !(isNil {_Unit getVariable "position"}) then
{
    _Pos = ((_Unit getVariable "position") select {_Side == (_x param[0])}) param[0,[]] param[1,[]];
	systemChat format ["Your side is %1, and position: %2",_Side,_Pos];
	if !(_Pos isEqualTo []) then
	{
        systemChat format["Your last position %1 has been loaded!",LAST_PACKET];
        RESPAWNS append [[_Unit,_Pos,"Last Known Position"] call BIS_fnc_addRespawnPosition];
        SAVE_POS = false;
    }
    else
    {
	    SAVE_POS = true;    
    };	
}
else
{
    _SpnLoc call BIS_fnc_addRespawnPosition;   
    SAVE_POS = true;
};
LAST_PACKET = "";

//DEV: systemChat "Gear Var...";
["gear",[clientOwner,_Unit,getPlayerUID _Unit]] spawn DBC_fnc_GetPlayer;
waitUntil {!(LAST_PACKET isEqualTo "")};

//DEV: systemChat format["Gear Var not found. %1",LAST_PACKET];
LAST_PACKET = "";

//Code for removing FOB spawns if unit is new and/or dead. Nearest base at time of death most likely
//Needs storing in DB, in cases of disconnect.
EQUIP_UNIT = 
{
    _unit = param[0,objNull,[objNull]];
	hint format["Hello %1! You have respawned! Time to give you your gear.",name _unit];
	{
	    _x call BIS_fnc_removeRespawnPosition;
		RESPAWNS deleteAt _ForEachIndex;
	} forEach RESPAWNS;
	//Execute code for retriveing current gear outside of this, with global var saying if
	//Gear exists or not, and if statement for equiping it on respawn or not.
	if !(isNil{_Unit getVariable "gear"}) then 
	{
	    _Gear = ((_Unit getVariable "gear") select {(player getVariable "Nation") in _x}) param[0,[]] param[1,[],[]];
        if !(_Gear isEqualTo []) then
        {
		    _unit setUnitLoadout _Gear;
        }
        else
        {
		    (_Unit getVariable "gear") append [[player getVariable "Nation",getUnitLoadout _unit]];
			[getPlayerUID _Unit,"gear",(_Unit getVariable "gear"),_Unit] spawn DBC_fnc_SetPlayer;
        };		
	}
	else
	{
        [true] spawn client_fnc_SaveGear;
	};
	//Add EH for calculating nearest FOB/Base post mortem, might check for server option aswell.
	//Possibly MHQs aswell.
	
	if (SAVE_POS) then 
	{
	    _PosVar = [[str side _Unit,getPos _unit]]; 
	    [getPlayerUID _Unit,"position",_PosVar,_Unit] spawn DBC_fnc_SetPlayer;
		_Unit setVariable ["position",_PosVar];
	};
	
	_Unit removeEventHandler ["Respawn",EQUIP_INT];
	EQUIP_INT = nil;
	EQUIP_UNIT = nil;
};

EQUIP_INT = _unit addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	[_unit] spawn EQUIP_UNIT;
}];

//Tiers structure:[...["Tier-N",Current XP]...]
//Arsenal Structure: [...["Weapon-N",Amount Stored]...]

//Use XP formula instead of level + XP combo in variable, for simplified storage of data. No need for separation.

