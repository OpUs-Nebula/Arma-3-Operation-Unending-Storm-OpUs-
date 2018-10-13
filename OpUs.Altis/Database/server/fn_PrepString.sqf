scriptName "fn_db_prepareString";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_prepareString.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_prepareString.sqf"

// Parameters
_toDatabase = param[0,false,[false]];
_string		= param[1,"",[]];

// Exceptions
//if (_string isEqualType "") then {""};
if (!isServer) exitWith {};

// Code
_stringArray = [];
_Ret = false;

if (_toDatabase && (_string isEqualType "")) then {
	_stringArray = toArray _string;
	_newString = [];
	{
		switch (_x) do
		{
			//case 34:
			//{
			//	_newString pushBack 94;
			//};
			case 92:
			{
				_newString pushBack 92;
				_newString pushBack 92; // Escape char
			};
			default
			{
				_newString pushBack _x;
			};
		};
	} forEach _stringArray;

	_stringArray = _newString;
} else {
	//_stringArray = toArray _string;
	//{
	//	if (_x == 94) then {
	//		_stringArray set[_forEachIndex,34];
	//	};
	//} forEach _stringArray;
	_Ret = true;
};

if(_Ret) exitWith {_string};
(toString _stringArray)