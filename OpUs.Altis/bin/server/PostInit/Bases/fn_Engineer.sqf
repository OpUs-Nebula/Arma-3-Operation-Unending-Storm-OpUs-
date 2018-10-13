params ["_Nat","_Unit","_Fort","_Side","_GrpSide"];

disableSerialization;

playSound "ZoomIn";

_cfgArray = "( 
    (getNumber (_x >> 'scope') >= 2) && 
    {getNumber (_x >> 'side') == 1 && 
    {getText (_x >> 'vehicleClass') in ['Armored', 'Car', 'Air'] 
        } 
    } 
)" configClasses (configFile >> "CfgVehicles");




createDialog "client_Engineering_Dialog";

waitUntil {!isNull (findDisplay 126851)};

//Setup Flag
_Logo    = (findDisplay 126851) displayCtrl 1200;
_Logo ctrlSetText ((missionNamespace getVariable _Nat) param[8]); 

_ctrl    = (findDisplay 126851) displayCtrl 1500;
_CT_TREE = (findDisplay 126851) displayCtrl 1502;

{
    _txt    = (findDisplay 126851) displayCtrl _x;
	_txt ctrlSetText "";
} forEach [1600,1601,1602,1603,1604,1605];

{
		_ctrl lbAdd gettext (_x >> "displayName");
		_ctrl lbSetPicture [_foreachindex,gettext (_x >> "icon")];
		_ctrl lbSetTooltip [_foreachindex,gettext (_x >> "displayName")];
		_ctrl lbSetData [_foreachindex,(configName _x)];
} foreach _cfgArray;

_DispGDP    = (findDisplay 126851) displayCtrl 1608;
_DispFunds  = (findDisplay 126851) displayCtrl 1607;

_DispGDP  ctrlSetStructuredText (composeText ["GDP: ", lineBreak, ([(missionNamespace getVariable _Nat) param[6]] call cfg_fnc_MoneyDisplay)]);
_DispFunds  ctrlSetStructuredText (composeText ["Cash: ", lineBreak, [player getVariable "Funds"] call cfg_fnc_MoneyDisplay]);

_Bttn = (findDisplay 126851) displayCtrl 1606;
_Bttn buttonSetAction "((findDisplay 126851) getVariable 'LBSL') createVehicle position player";

_Bld = (findDisplay 126851) displayCtrl 1606;
_Bld ctrlSetText "Building Menu";

_Cmmnd = format ['closeDialog 2;[%1,%2,%3] spawn CON_fnc_BuildMenu;',str _Nat,_Fort,_Side];
_Bld buttonSetAction _Cmmnd;

_Desc = (findDisplay 126851) displayCtrl 1001;

 _Txt = "ArmA 3 can be played in both third person and first person view modes. Many vehicles, including tanks, cars, helicopters, and quads, can be driven by players in the game. ArmA 3 also features scuba diving, where the player must accomplish tasks underwater and can hide themselves while submerged. ArmA 3 has multiplayer gameplay with support for over 100 concurrent gamers. Multiplayer servers can be found through the in-game browser or through third-party websites such as ArmA 3 Server List or Game Tracker.";

 [_Desc,_Txt] call UTL_fnc_LBpopul;
 
_CT_TREE tvAdd [[],str player];
{ if !(_x isEqualTo player) then {_CT_TREE tvAdd [[0],str _x];}; } forEach units(group player);

waitUntil {isNull (findDisplay 126851)};

playSound "ZoomOut";
//camDestroy _cam;