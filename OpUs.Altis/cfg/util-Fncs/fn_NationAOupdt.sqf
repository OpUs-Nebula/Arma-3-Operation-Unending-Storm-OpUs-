params ["_Ent","_Lvl","_Ind","_aoA"];

_terA = param[4,"",["",false]];
/*
PARAMETERS:

0: Nation in string or Object with embeded nation variable
1: Zone level, number
2: Zones variable index of current zone
3: Boolean that if true, will add to AO count, else remove.
4: Boolean that if true, will add zone to nation territory, else remove.

*/

_ProNat = "";
if (_Ent isEqualType ObjNull) then
{
    _ProNat  = (_Ent getVariable "NATION");
}
else
{
    _ProNat = _Ent;
};

if (_aoA) then
{
    _NatData = missionNamespace getVariable _ProNat;
    _AOs     = _NatData param[2];
    if !(_Ind in (_AOs param[1])) then
    {
        _AOs set [0,(_AOs param[0]) + _Lvl];
    	_AOs param[1] append [_Ind];
    	_NatData set [2,_AOs];
    	
    	missionNamespace setVariable [_ProNat,_NatData];
    };
}
else
{
    _NatData = missionNamespace getVariable _ProNat;
    _AOs     = _NatData param[2];
    _AOs set[0,(_AOs param[0]) - _Lvl];
    (_AOs param[1]) deleteAt ((_AOs param[1]) find _Ind);
    _NatData set[2,_AOs];
    
    missionNamespace setVariable [_ProNat,_NatData];
};

if (_terA isEqualType true) then
{
    if (_terA) then
	{
	    _NatData = missionNamespace getVariable _ProNat;;
        (_NatData param[7]) append [_Ind];
        missionNamespace setVariable [_ProNat,_NatData];
	}
	else
	{
	    _NatData = missionNamespace getVariable _ProNat;;
        (_NatData param[7]) deleteAt ((_NatData param[7]) find _Ind);
        missionNamespace setVariable [_ProNat,_NatData];
	};
};























