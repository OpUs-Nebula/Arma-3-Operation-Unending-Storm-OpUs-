/*--------------------------------------------------------------------------
Template for timer function in format: (H,M,S)

File = InitPlayerLocal.sqf



-------------------------------------------------------------------------*/
_Unit = _this select 0;
_IsJIP  = _this select 1;

//CountDown spawn client_fnc_CreateTimer;

_unit addAction ["Gun Shop", "[] spawn client_fnc_showGunShopDialog;"];
_Unit addEventHandler ["Respawn", 
{
	params ["_unit", "_corpse"];

	removeAllActions _corpse;
	_Unit addAction ["Missions", "[] spawn client_fnc_MissionMenu","",1.5,true,true,"","_Target isEqualTo _This"];
}];

/*
//Necessary variables 
_unit setVariable ["Funds",1000,true];
_unit setVariable ["Tiers",["Rifleman"],true];
_unit setVariable ["Arsenal",[],true];
*/

//Dev:
//_Unit addBackpack "B_AssaultPack_dgtl";

_SpnLoc = [];
_Side   = str side _Unit; 
switch (side _Unit) do {

    case west: 
	{
	    _Unit setVariable ["NATION","NATO",true];
		_SpnLoc = [_Unit,FOB1_WEST,"FOB1"];
	};
	case east: 
	{
	    _Unit setVariable ["NATION","CSAT",true];
		_SpnLoc = [_Unit,FOB1_EAST,"FOB1"];
	};
	case resistance: 
	{
	    _Unit setVariable ["NATION","AAF",true];
		_SpnLoc = [_Unit,FOB1_GUER,"FOB1"];
		
	};
    	
};

RESPAWNS = [];

//Why store side? It is registered as civ for dead players, initation seems random, but
//earliest post InitPlayerLocal. I.E you cannot reliable gather it from inside the script below.
[_Unit,_IsJIP,_SpnLoc,_Side] spawn client_fnc_Init;

/*-------------------------------------------------------------------------------
_Ind = selectRandom [1,2,3];

switch (true) do {

    case (_ind == 1): {playSound "intro1"};
	case (_ind == 2): {playSound "intro2"};
	case (_ind == 3): {playSound "intro3"};
	
};
-------------------------------------------------------------------------------*/
/*
//Garage

_unit addAction ["Open Garage",{

 	//Create a position 30 meters infront of the player
	_pos = getPos GARAGE;
	
	//Pass created vehicle to function for use as position
	["open",[ true, _pos ]] call BIS_fnc_garage; 
}];
*/
// Arsenal EH:

/*
[missionNamespace, "arsenalOpened", 
    {
		disableSerialization;
		params ["_display"];
		_display displayAddEventHandler ["keydown", "_this select 3"];
		{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
	}] call BIS_fnc_addScriptedEventHandler;
*/