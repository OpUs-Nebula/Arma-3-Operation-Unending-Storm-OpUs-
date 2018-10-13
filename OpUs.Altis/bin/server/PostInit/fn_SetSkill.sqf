
/*
PARAMETERS:
0: AI unit
1:true for superAi(Skill = 1) or custom value;
if AI value is outside range 0 - 1, then 1 is set automatically.(Optional)
2: Custom AIskill value(optional)


*/
_Unit = param[0,objNull,[objNull]];
_Cust = param[1,false,[true,0]];
_Val  = param[2,1,[0]];

_Skill =  ("AISkill" call BIS_fnc_getParamValue) / 5;
if (_Cust) then 
{
	if ((_Val <= 1) && (_Val >= 0)) then 
	{
         _Skill = _Val;
	}
	else
	{
	    _Skill = 1;
	};
    _Unit setSkill _Skill;
}
else
{
	_Unit setSkill _Skill;
};

_Unit addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit, _source, _damage, _instigator] spawn EH_fnc_UnitKillDam;
}];

_Unit addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[_unit, _killer, _instigator, _useEffects] spawn EH_fnc_UnitKillDam;
}];