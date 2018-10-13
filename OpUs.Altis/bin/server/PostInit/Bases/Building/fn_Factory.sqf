params ["_Fac","_Fort","_Nat","_Side"];

disableSerialization;

playSound "ZoomIn";

_FacName = "Factory";
_FacList = ["NOTIN"] call cfg_fnc_FactoryParams;

{
    if ((_x param[0]) isEqualTo (typeOf _Fac)) then {_FacName = _x param[1];};
} forEach _FacList;

_Data   = [typeOf _Fac] call cfg_fnc_FactoryParams;
_LndVics   = ([_Nat] call cfg_fnc_VehicleParams) param[0];
_Tags   = _Data param[1];

/*
_cfgArray = "( 
    (getNumber (_x >> 'scope') >= 2) && 
    {getNumber (_x >> 'side') == 1 && 
    {getText (_x >> 'vehicleClass') in ['Armored', 'Car', 'Air'] 
        } 
    } 
)" configClasses (configFile >> "CfgVehicles");
*/

//Most likely temprorary system, will need cleaning up for performance, probably not huge issue
//since this is clientside, and client is pretty much unloaded at this point.
//NoArmor(Civ) land class still needs to be accounted for.


//-----------------LAND-----------------//
//HEAVY VEHICLES
_Spawns = [];
_Vics   = [];
{
   if ((_x param[2]) isEqualTo "B_MBT_01_cannon_F") then 
    {
        _Spawns append [_Fac modelToWorld (_x param[0])];
	};
} forEach (_Data param[0]);
{
    if ((_x param[2]) == "Heavy") then
	{ 
	    _Vics append [_x];
	};
} forEach _LndVics;
_Heavy = [_Vics,_Spawns];

//MEDIUM VEHICLES
_Spawns = [];
_Vics   = [];
{
   if ((_x param[2]) isEqualTo "B_APC_Wheeled_01_cannon_F") then 
    {
        _Spawns append [_Fac modelToWorld (_x param[0])];	
	};
} forEach (_Data param[0]);
{
    if ((_x param[2]) == "Medium") then
	{ 
	    _Vics append [_x];
	};
} forEach _LndVics;
_Medium = [_Vics,_Spawns];

//LIGHT VEHICLES
_Spawns = [];
_Vics   = [];
{
   if (((_x param[2]) isEqualTo "B_MRAP_01_F") or ((_x param[2]) isEqualTo "C_Offroad_01_F")) then 
    {
        _Spawns append [_Fac modelToWorld (_x param[0])];
	};
} forEach (_Data param[0]);
{
    if ((_x param[2]) == "Light") then
	{ 
	    _Vics append [_x];
	};
} forEach _LndVics;
_Light = [_Vics,_Spawns];


createDialog "client_Engineering_Dialog";

waitUntil {!isNull (findDisplay 126851)};
_Logo    = (findDisplay 126851) displayCtrl 1200;
_Logo ctrlSetText ((missionNamespace getVariable _Nat) param[8]); 


_ctrl    = (findDisplay 126851) displayCtrl 1500;
_CT_TREE = (findDisplay 126851) displayCtrl 1502;


_Head = (findDisplay 126851) displayCtrl 1000;
_Head ctrlSetText _FacName;

_DispGDP    = (findDisplay 126851) displayCtrl 1608;
_DispFunds  = (findDisplay 126851) displayCtrl 1607;

_DispGDP  ctrlSetStructuredText (composeText ["GDP: ", lineBreak, ([(missionNamespace getVariable _Nat) param[6]] call cfg_fnc_MoneyDisplay)]);
_DispFunds  ctrlSetStructuredText (composeText ["Cash: ", lineBreak, [player getVariable "Funds"] call cfg_fnc_MoneyDisplay]);


{
    _txt    = (findDisplay 126851) displayCtrl _x;
	_txt ctrlSetText "";
} forEach [1600,1601,1602,1603,1604,1605];
_Start    = 1600;


{
    if (_foreachindex <= 5) then 
	{
        _txt = (findDisplay 126851) displayCtrl (1600 + _foreachindex);
	    _txt ctrlSetText _x;
		_Cmmnd = format ['(findDisplay 126851) setVariable ["vTier",%1]',str _x];
		_txt buttonSetAction _Cmmnd;
	};
} forEach _Tags;
_Buy = (findDisplay 126851) displayCtrl 1606;
_Buy ctrlSetText "Purchase";

(findDisplay 126851) setVariable ['vTier',(_Tags param[0])];
_CurLb = "";

while {!isNull (findDisplay 126851)} do 
{
    if !(_CurLb isEqualTo ((findDisplay 126851) getVariable 'vTier')) then 
	{
	    lbClear _ctrl;
	    _CurLb = ((findDisplay 126851) getVariable 'vTier'); 
        _Prods = [];
		
        switch (_CurLb) do
		{
		    case "Heavy": {_Prods = _Heavy;};
			case "Medium": {_Prods = _Medium;};
			case "Light": {_Prods = _Light;};
			case "NoArmor": {_Prods = _Light;};
		};
 		
        {
        	_ctrl lbAdd gettext (configFile >> "CfgVehicles" >> (_x param[0]) >> "displayName");
        	_ctrl lbSetPicture [_foreachindex,gettext (configFile >> "CfgVehicles" >> (_x param[0]) >> "icon")];
        	_ctrl lbSetTooltip [_foreachindex,gettext (configFile >> "CfgVehicles" >> (_x param[0]) >> "displayName")];
        	_ctrl lbSetData [_foreachindex,(_x param[0])];
        } foreach (_Prods param[0]);
		
		//First Structure(test of spawn positions along with classnames)
		//_Cmmnd = format ['((findDisplay 126851) getVariable "LBSL") createVehicle (selectRandom %1)',_Prods param[1]];
		
		//Second Structure(Brken, might be script error, or the fact that its all stored in string, and/or objNames treated as disjointed, unquoted string)
		//_Cmmnd = format ["[call compile '%1','%2','%3',call compile '%4',%5] remoteExec ['CON_fnc_VehPurch',2];",_Fac,_Nat,_Side,player,_Prods param[1]];
		
		//Working!
		(findDisplay 126851) setVariable ["PurchParams",[_Fac,_Nat,_Side,player,_Prods param[1],_Fort]];
		
		//Causes error due to lack of server knowledge of params, use different method instead
		//_Cmmnd = "((findDisplay 126851) getVariable 'PurchParams') remoteExec ['cfg_fnc_VehPurch',2]";
		
		_Cmmnd = format ["%1 remoteExec ['cfg_fnc_VehPurch',player]",((findDisplay 126851) getVariable 'PurchParams')];
		
        _Buy buttonSetAction _Cmmnd;
	};
};