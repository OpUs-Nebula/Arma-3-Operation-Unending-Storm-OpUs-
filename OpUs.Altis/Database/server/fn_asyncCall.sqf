/*-----------------------------------------------------------
Original Script By f(OPTiX) of Maverick Applications and
RushRedux, Edited by Nebula
-----------------------------------------------------------*/


private["_tickTime","_queryStmt","_queryResult","_key","_mode","_return","_loop","_multiarr","_keyMode"];

_tickTime = diag_tickTime;

_queryStmt = param [0,"",[""]];
_mode = param [1,1,[0]];
_multiarr = param [2,true,[false]];

_result = "extDB3" callExtension str formatText["%1:%2:%3",_mode, sv_db_id, [true,_queryStmt] call DBS_fnc_PrepString];

diag_log str formatText["AsynCall: %1:%2:%3",_mode, sv_db_id, [true,_queryStmt] call DBS_fnc_PrepString];

if(_mode == 1) exitWith {
	true;
};

_result = call compile str formatText["%1",_result];
_key = (_result select 1);
_keyMode = (_result select 0);

uisleep (random .03);

// Get Result via 4:x (single message return)  v19 and later
_queryResult = "";
_loop = true;

while{_loop} do
{
	_queryResult = "extDB3" callExtension str formatText["4:%1", _key];
	switch(_queryResult) do {

		case "[5]": {

			// extDB3 returned that result is Multi-Part Message
			_queryResult = "";

			while{true} do {
				_pipe = "extDB3" callExtension str formatText["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		};

		case "[3]": {
			uisleep 0.3;
		};

		default {
			_loop = false;
		};
	};
};

//diag_log "TEST";
diag_log _queryResult;

//For dealing with SQL output such as bigint(20) from SHOW COLUMNS query, 
_queryResult = parseSimpleArray _queryResult;
{
    if (!(isNil "_x") && {_x isEqualType []}) then
	{
	    _Arr = _x;
		{
	        if (isNil "_x") then
		    {
		        _Arr set [_forEachIndex,""];
		    };
		} forEach _Arr;
	}
	else
	{
	    if (isNil "_x" && {!(_x isEqualType [])}) then
		{
		    (_queryResult param[1]) set [_forEachIndex,""];
		};	
	};
} forEach (_queryResult param[1]);

_queryResult = str _queryResult;

diag_log _queryResult;

_queryResult = call compile _queryResult;

// Not needed, its SQF Code incase extDB ever returns error message i.e Database Died
if ((_queryResult select 0) == 0) exitWith {
	[];
};

_return = (_queryResult select 1);

if(!_multiarr && count _return > 0) then {
	_return = _return select 0;
};
diag_log str formatText ["OUTPUT FROM ASYNCCALL: %1",_return];
_return;