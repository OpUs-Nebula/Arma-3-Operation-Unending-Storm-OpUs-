
scopeName "Main";
_Id     = param[0];
_Lvl    = param[1];
_ProNat = param[2];
_Occup  = param[3];
_Ind    = param[4];

/*
Should get Dominant nation on each cycle, setting _Dom as this. Timer should check
Array of Nations active in zone, if active then not spawning new Timer.
If statement checking for change in zone occupant causes breakout if ttue(line 23 statement)
and setting of return value to "FAILED" otherwise "CAPTURED"

70 shouold actually be 2700, in final version(Maybe even more...)
Countdown is only 0 if the zone level is 0, make these an example of attacking a maximally upgraded base....?

Might use _ret for sending message to respective nation of failure to capture, TBD. 
*/ 

_ret = "";

// _CountDown = ("Occupation" call BIS_fnc_getParamValue) * _Lvl;

/*
_NatData = missionNamespace getVariable _ProNat;
_AOs     = _NatData param[2];
if !(_Id in (_AOs param[1])) then
{
    _AOs set [0,(_AOs param[0]) + _Lvl];
	_AOs param[1] append [_Id];
	_NatData set [2,_AOs];
	
	missionNamespace setVariable [_ProNat,_NatData];
};
*/

_CountDown = (30 * _Lvl);
	
if (_Lvl isEqualTo 0) then {_Countdown = 100/2;};

_Desig = format ["[%1,%2,%3]",_Id,_Lvl,_ProNat];	
_Dom = "";	

missionNamespace setVariable [_Desig,_CountDown,true];

while {(_CountDown > 0) && (((missionNamespace getVariable _id) param[0] == 'ACTIVE') or ((missionNamespace getVariable _id) param[0] == 'ALERT'))} do {
	_Dom = (missionNamespace getVariable _Id) param[1];
    if (_ProNat == _Dom) then {
        _CountDown = _Countdown - 1;
        missionNamespace setVariable [_Desig,_CountDown,true];
	    uiSleep 1;
    };
	if ((_Dom == _Occup) && (_CountDown < (30 * _Lvl))) then {
        _CountDown = _Countdown + 1;
        missionNamespace setVariable [_Desig,_CountDown,true];
	    uiSleep 1;
    };
};

_terA = "";
	
if (_CountDown > 0) then {_ret = ["FAILED"]; _terA = false;} else {missionNamespace setVariable [_id,["CAPTURED",_ProNat]]; _terA = true;};

missionNamespace setVariable [_Desig,nil,true];

[_ProNat,_Lvl,_Ind,false,_terA] call UTL_fnc_NationAOupdt;