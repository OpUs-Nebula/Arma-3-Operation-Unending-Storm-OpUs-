
params ["_Obj","_Id","_Props"];

{
	_Pos  = _Obj modelToWorld (_x param[0]);
	_Dir  = (_x param[1]) + (getDir _Obj);
	_Clss = _x param[2];
    _Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	_Veh setDir _Dir;
	[_Id,_Veh] spawn PI_fnc_ZoneObjClean; 
} forEach _Props;