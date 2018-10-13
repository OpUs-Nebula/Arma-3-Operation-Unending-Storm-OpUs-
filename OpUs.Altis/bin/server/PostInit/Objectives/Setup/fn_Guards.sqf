
params ["_Obj","_GrdsExt","_GrdsInt","_Occup","_GrpSide","_Units","_Id","_Lvl"];

_Obj setVariable ["POPUL",true];

_GerInd = "";
if (_Lvl > 2) then 
{
    _GerInd = 1;
}
else
{
    _GerInd = 0;
};

_GerData = ([_Occup] call cfg_fnc_BaseLoadouts) param[0];

_RflMn = _GerData param[_GerInd];
_SfGrd = _GerData param[1];

_ExteriorGrp  = CreateGroup [_GrpSide, true];
_ExtAnim  = ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"];
{
	_Clss = selectRandom _Units;
	_Unit = _ExteriorGrp createUnit [(configName _Clss),_Obj modelToWorld (_x param[0]), [], 0, "CAN_COLLIDE"];
	_Unit setVariable ["NATION",_Occup];
	[_Unit,_RflMn] call PI_fnc_AiLoadout;
	_Unit setDir ((_x param[1]) + (getDir _Obj));
	_Pose = selectRandom _ExtAnim;
	[_unit,_Pose,"ASIS"] call BIS_fnc_ambientAnimCombat;
	[_unit,_Id,_Lvl] spawn PI_fnc_Resistance;
	[_Unit] call PI_fnc_setSkill;
	[_Unit] call cfg_fnc_infiniAmmo;
} forEach _GrdsExt;
	
_InteriorGrp  = CreateGroup [_GrpSide, true];
_IntAnim      = ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"];
{
	_Clss = selectRandom _Units;
	_Unit = _InteriorGrp createUnit [(configName _Clss),_Obj modelToWorld (_x param[0]), [], 0, "CAN_COLLIDE"];
	_Unit setVariable ["NATION",_Occup];
	[_Unit,_SfGrd] call PI_fnc_AiLoadout;
	_Unit setDir ((_x param[1]) + (getDir _Obj));
	_Pose = selectRandom _IntAnim;
	[_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnimCombat;
	[_Unit,_Id,_Lvl] spawn PI_fnc_Resistance;
	[_Unit,true] call PI_fnc_setSkill;
	[_Unit] call cfg_fnc_infiniAmmo;
} forEach _GrdsInt;

[_InteriorGrp,_ExteriorGrp]