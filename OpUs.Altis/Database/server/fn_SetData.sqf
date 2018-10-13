/*--------------------------------------------
WARNING! When using this function, beware of the risk of table columns growing out of control,
if care toward spelling of column names when setting data is not taken. Type Of data needs to be
the same type as all that will come later aswell.
Thanks for reading! Here's some ASCII art:
    1{0<^--------^>0}1
    1{  0<^----^>0  }1
    1{   0<^-^>0    }1
    1{   0<^-^>0    }1
    1{  0<^----^>0  }1
    1{0<^--------^>0}1
--------------------------------------------*/
_Row    = param[0] param[0];
_RowID  = param[0] param[1];
_Column = param[1];
_Data   = param[2];
_Table  = param[3];

diag_Log format["ROW: %1, ROWID: %2, _Column: %3, DATA: %4, TABLE:%5",_Row,_RowID,_Column,_Data,_Table]; 

_Return = [_Column,_Table,[_Row,_RowID],true] call DBS_fnc_EntryExists;

diag_Log format["ROW: %1, ROWID: %2, _Column: %3, DATA: %4, TABLE:%5",_Row,_RowID,_Column,_Data,_Table];
//Query variable is mostly used for readability. Can be inputed straight to call if performance
//Gains are looked for.

if !((_Return param[3]) == "TABLE EXISTS") then
{
    _Query = str formattext["CREATE TABLE %1 (%2 %3);",_Table,_Row,[_RowID] call UTL_fnc_SQLdtype];
	[_Query,1] call DBS_fnc_asyncCall;
	//waitUntil {(([_Column,_Table,[_Row,_RowID],true] call DBS_fnc_EntryExists) param[3]) == "TABLE EXISTS"; sleep 0.7};
};
if ((_Return param[2]) == "NO ROW") then
{
    _Query = str formattext["INSERT INTO %1 (%2) VALUES ('%3');",_Table,_Row,[true,_RowID] call DBS_fnc_PrepString];
    [_Query,1] call DBS_fnc_asyncCall;
	//waitUntil {(([_Column,_Table,[_Row,_RowID],true] call DBS_fnc_EntryExists) param[2]) == "COLUMNS EXIST"; sleep 0.7};
};    	
if !((_Return param[0]) == "COLUMNS EXIST") then
{
    _Query = str formattext["ALTER TABLE %1 ADD %2 %3",_Table,_Column,[_Data] call UTL_fnc_SQLdtype];
    [_Query,1] call DBS_fnc_asyncCall;
    //waitUntil {(([_Column,_Table,[_Row,_RowID],true] call DBS_fnc_EntryExists) param[0]) == "COLUMNS EXIST"; sleep 0.7};	
};

_Query = str formattext["UPDATE %1 SET %2 = '%3' WHERE %4 = '%5'",_Table,_Column,[true,_Data] call DBS_fnc_PrepString,_Row,[true,_RowID] call DBS_fnc_PrepString];
[_Query,1] call DBS_fnc_asyncCall;
