//Columns to pick from in MySQL DB(or maria) follow SQL syntax for multiselection 
_Data = param[0];

//_Adress = [RowID(ID Column,Value to find),Table(Table to select info from)]
_Adress = param[1] param[1];
_RowInfo  = param[1] param[0];

//Should be feed as array from script that initiated GetData. Use [] if no response is needed.
_RespData = param[2,[],[[]]];

_Ret = "";



_Return = [_Data,_Adress,_RowInfo,false] call DBS_fnc_EntryExists;

diag_Log format["Return from getData: %1",_Return];
if (!(isNil {_Return param[1]}) && {((_Return param[1]) isEqualTo "NO ENTRY")}) then
{
    systemChat format["Didnt Find %1 in DB",_Data];
	_Ret = "NO DATA";
	_Return = _Ret;
}
else
{
    //DEV: systemChat format["Found %1 in DB, Return: %2",_Data,_Return];
	//DEV: diag_Log format["[----------------Found %1 in DB, Return: %2----------------]",_Data,_Return];
	
	//Last Arg of _RespData should always be respfunction.
};
if !(_RespData isEqualTo []) then
{
    _Size = count _RespData;
    [_Return,_RespData select [0,_Size - 1]] spawn (_RespData param[_Size - 1]);
}
else
{
    //_Ret = _Return;
};
//Return Info Directly in case of Direct Call(Only ServerSide! Else reach through remoteExec)
//if !(canSuspend) then {_Ret};
_Ret