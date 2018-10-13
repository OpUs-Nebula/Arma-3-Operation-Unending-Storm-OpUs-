_Resp = param[0];
_Data = "";
if (_Resp isEqualType "" && {_Resp == "NO DATA" or _Resp == ""}) then
{
    _Resp = "NO DATA";
    _Data = _Resp;
}
else
{
    _Data = _Resp param[0,"NO DATA"];
	if (_Data isEqualTo "") then {_Data = "NO DATA"}; 
};
_RepArr = param[1,""];

_Unit = _RepArr param[0];
//Might use to verify that client still owns player, incase disconnection occurs and another client
//Is now controlling Player unit.
_OwnerID  = _RepArr param[1];
_SetVar   = _RepArr param[4];
_ConfVar  = _RepArr param[2];
_ConfName = _RepArr param[3,"",[""]];


//DEV: [format ["Setting %1 for %2",_Data,name _Unit]] remoteExec ["systemChat",_Unit];
//DEV: [format["[----------------------Setting %1 for %2----------------------]",_Data,name _Unit]] remoteExec ["diag_log",_Unit];

if !(_Data isEqualTo "NO DATA") then
{
    _Unit setVariable [_SetVar,_Data,true];
};

CL_PCKTUPDT =
{
    _Var = param[0];
	_VarName = param[1];
	_Data = param[2];
	missionNamespace setVariable [_VarName,_Data];
};

[_ConfVar,_ConfName,_Data] remoteExec ["CL_PCKTUPDT",_Unit];
systemChat format ["%1 was sent!",_Data];