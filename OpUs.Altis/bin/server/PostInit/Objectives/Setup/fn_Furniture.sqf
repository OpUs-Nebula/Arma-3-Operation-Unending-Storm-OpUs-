
params ["_Obj","_Units","_Id","_Occup","_InteriorGrp","_Furn"];


_GerData = ([_Occup] call cfg_fnc_BaseLoadouts) param[0];
_RflMn = _GerData param[0];

{
    _Listnr = configName (selectRandom _Units);
    _Pos  = _Obj modelToWorld (_x param[0]);
    _Dir  = (_x param[1]) + (getDir _Obj);
    _Clss = _x param[2];
	_Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	_Veh setDir _Dir;
	[_Id,_Veh] spawn PI_fnc_ZoneObjClean;
    _SeatPos = _Veh modelToWorld [0,0,0];
    _Unit    = _InteriorGrp createUnit [_Listnr,_SeatPos,[],0,"CAN_COLLIDE"];
	_Unit setVariable ["NATION",_Occup];
	[_Unit,_RflMn] call PI_fnc_AiLoadout;
	[_Unit,true] call PI_fnc_setSkill;
	[_Unit] call cfg_fnc_infiniAmmo;
	_Unit setPosATL _SeatPos;
	_Unit setDir (_Dir + 180);
	
	_Pose = "";
	if (_x param[2] isEqualTo "Land_OfficeChair_01_F") then 
	{
	   _Pose = "SIT_AT_TABLE";
	} 
	else 
	{
	   _Pose = "SIT_U3";
	};
	
    [_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnim;
    [_Unit] spawn PI_fnc_AnimHandler;		
} forEach _Furn;