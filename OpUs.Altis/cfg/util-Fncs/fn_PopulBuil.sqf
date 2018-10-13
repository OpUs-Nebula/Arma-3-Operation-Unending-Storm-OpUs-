/*
Super-Groups cause MASSIVE performance hits, Went from 3-6 FPS stutter to 30 FPS stable
simply by dividing each unit into its own group. 2 Possible actions:
1: Hoping HCs and Beffy servers can take care of the problem, seeing as it isEqualType
most certainly AI computation related and avoid group limitation issue.
2: construct different system, dynamically scaling groups for performance.

How i found this? tried filling all buildings by buildingPos with all being one super-group, alt
all of them in individual groups.
*/
params ["_Pos","_Nat","_Pool"];

_AnimSt   = ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"];
_GearPool = "";

if (_Pool isEqualType []) then
{
    _GearPool = _Pool;
}
else
{
    _GearPool = ([_Nat] call cfg_fnc_BaseLoadouts) param[0];
};

_Builds = nearestObjects [_Pos, ["House", "Building"], 400];

_NatData = [_Nat] call UTL_fnc_GetSide;

_GrpSide = _NatData param[0];
_Units   = _NatData param[1];

_IntGrp = createGroup [_GrpSide,true];
{
    if (isNil {_x getVariable "POPUL"}) then
	{
	    _Build = _x;
	    {
		    _Pos = _x;
            _Unit = _IntGrp createUnit [configName (SelectRandom _Units),_Pos,[],0,"CAN_COLLIDE"];
			_Unit setVariable ["NATION",_Nat];
	        [_Unit,selectRandom _GearPool] call PI_fnc_AiLoadout;
            _Pose = selectRandom _AnimSt;
	        [_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnimCombat;            
			[_Unit] call PI_fnc_setSkill;
	        [_Unit] call cfg_fnc_infiniAmmo;
		} forEach (_Build buildingPos -1);
		_x setVariable ["POPUL",true];
	};
} forEach _Builds;