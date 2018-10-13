params ["_Fort","_Intel","_Nat"];

{
	_Pos  = _Fort modelToWorld (_x param[0]);
	_Dir  = (_x param[1]) + (getDir _Fort);
	_Clss = _x param[2];
    _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	_Veh setDir _Dir;
	_Veh setPosATL _Pos;
	[_Veh,_Fort] spawn BAS_fnc_AliveHandler; 
} forEach _Intel;