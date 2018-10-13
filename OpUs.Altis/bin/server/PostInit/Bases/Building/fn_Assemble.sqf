
params ["_Obj","_Modls","_Nat","_Fort","_Side"]; 

_Pos  = getPos _Obj;
_Clss = typeOf _Obj;
_Dir  = getDir _Obj;

deleteVehicle _Obj;
if (count _Modls > 0) then 
{
    {deleteVehicle (_x param[2]);} forEach _Modls;
};
((findDisplay 356851) displayCtrl 1600) setVariable ['Build',false];

_Data = [_Clss] call cfg_fnc_FactoryParams;
_Tier = _Data param[1];
_ConTime = _Data param[3];
_Srch = true;
_Site = "";

if("Heavy" in _Tier && _Srch) then
{
    _Site = "Land_WIP_F";
    _Srch = false;
};
if("Medium" in _Tier && _Srch) then
{
    _Site = "Land_u_Shed_Ind_F";
    _Srch = false;
};
if("Light" in _Tier && _Srch) then
{
    _Site = "Land_Unfinished_Building_02_F";
    _Srch = false;
};
_Wip = createVehicle [_Site, _Pos, [], 0, "CAN_COLLIDE"];
_Wip setPos _Pos;
_Wip setDir _Dir;

//To replace with while loop, in order to pause and resume before and after restarts.
uiSleep _ConTime;

deleteVehicle _Wip;

_Fac = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
_Fac setPos _Pos;
_Fac setDir _Dir;
_Cmmnd = format ['(_this distance _target < 100) && ((_this getVariable "NATION") isEqualTo %1)',str _Nat];
_Fac setVariable ["Params",[_Fac,_Fort,_Nat,_Side],true];
[
    _Fac,                                                                           // Object the action is attached to
    "Construct Vehicle",                                                                       // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                      // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                      // Progress icon shown on screen
    _Cmmnd,                                                        // Condition for the action to be shown
    "_caller distance _target < 100",                                                      // Condition for the action to progress
    {},                                                                                  // Code executed when action starts
    {},                                                                                  // Code executed on every progress tick
    {(_target getVariable "Params") call CON_fnc_Factory;},                                                // Code executed on completion
    {},                                                                                  // Code executed on interrupted
    [],                                                                                  // Arguments passed to the scripts as _this select 3
    2,                                                                                  // Action duration [s]
    0,                                                                                   // Priority
    false,                                                                                // Remove on completion
    false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",0,_Fac];   

if (isNil {_Fort getVariable "Factories"}) then 
{
    _Fort setVariable ["Factories",[_Fac]];
}
else
{
    _Builds = _Fort getVariable "Factories";
    _Builds append [_Fac];
	_Fort setVariable ["Factories",[_Builds]];
};