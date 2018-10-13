_Column = param[0];
_Table  = param[1];
_Row    = param[2] param[0];

//Set to true if return of all rows is desired
_RowID  = param[2] param[1];


_Rdata = [];
_RowEx = "";
_TabEx = "";
_DBcolumns = "";
_Ret  = ["UNDEFINED","UNDEFINED"];

_NoRet = param[3,false,[false]];


_DBtables  = ["SHOW TABLES",2,true] call DBS_fnc_asyncCall; 
if (count (_DBtables select {_Table in _x}) > 0) then 
{
    _TabEx = "TABLE EXISTS";
	_DBcolumns = [str formatText ["SHOW COLUMNS FROM %1",_Table],2,true] call DBS_fnc_asyncCall;
	_Affirm = str formatText["SELECT %1 FROM %2 WHERE %1 = '%3'",_Row,_Table,_RowID];
	_Rchck  = [_Affirm,2] call DBS_fnc_asyncCall;
	if (count (_Rchck) > 0) then
	{
	    _RowEx = "ROW EXISTS";
		
		//SteamID if player
		//systemChat str formatText["STRUCTURE OF RETURN: %1",_Rchck]
	}
	else
	{
	    _RowEx = "NO ROW";
		//systemChat str formatText["STRUCTURE OF RETURN: %1",_Rchck]
	};
    diag_log str formatText["Columns have been read, Table is real: %1 %2 %3",_DBcolumns,_Affirm,_Rchck];	
} 
else 
{
    _TabEx = "NO TABLE";
	_RowEx = "NO ROW";
};
if ((_TabEx ==  "TABLE EXISTS") && {count (_DBcolumns select {_Column in _x}) > 0}) then
{  
	if !(_NoRet) then 
	{
	    _Query = str formatText ["SELECT %1 FROM %2 WHERE %3 = %4;",_Column,_Table,_Row,_RowID];
		diag_log str formatText["Columns are more than one, exist in DB: %1",_Query];
	    _Rdata = [_Query,2] call DBS_fnc_asyncCall;
	};
	
	if (((_Rdata param[0,""]) isEqualTo "") or _NoRet) then
	{
	    _Ret = ["COLUMNS EXIST","NO ENTRY",_RowEx,_TabEx];
	}
	else
	{
	    if !(_NoRet) then {_Ret = _Rdata param[0]} 
	};
}
else
{
    _Ret = ["NO COLUMNS","NO ENTRY",_RowEx,_TabEx];
};

diag_log _Ret;
_Ret
 