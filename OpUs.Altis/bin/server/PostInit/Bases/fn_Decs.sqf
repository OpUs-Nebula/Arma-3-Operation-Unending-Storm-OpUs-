params ["_Fort","_FstDwn","_Flips","_Props","_Nat"];

_UnSim = [];

{
	_Pos  = _Fort modelToWorld (_x param[0]);
	_Dir  = (_x param[1]) + (getDir _Fort);
	_Clss = _x param[2];
    _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	
	_Veh enableSimulationGlobal false;
	_Veh allowDamage false;
	
	_Veh setPosATL _Pos;
	_Veh setDir _Dir;
	[_Veh,_Fort] spawn BAS_fnc_AliveHandler;
	if (_Clss == "B_CargoNet_01_ammo_F") then
	{
	    [_Veh,_Fort,_Nat] spawn BAS_fnc_Armory;
	};
} forEach _FstDwn;

{
	_Pos  = _Fort modelToWorld (_x param[0]);
	_Dir  = (_x param[1]) + (getDir _Fort);
	_Clss = _x param[2];
    _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	
	_Veh enableSimulationGlobal false;
	_Veh allowDamage false;
	
	_Veh setPosATL _Pos;
	_Veh setDir _Dir;
	[_Veh,_Fort] spawn BAS_fnc_AliveHandler;
} forEach _Props;

{
	_Pos  = _Fort modelToWorld (_x param[0]);
	_Dir  = (_x param[1]) + (getDir _Fort);
	_Clss = _x param[2];
    _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	
	
	_Veh enableSimulationGlobal false;
	_Veh allowDamage false;
	
	_Veh setPosATL _Pos;
	_Veh setDir _Dir;
	[_Veh,180,0] call BIS_fnc_setPitchBank;
	[_Veh,_Fort] spawn BAS_fnc_AliveHandler;
} forEach _Flips;