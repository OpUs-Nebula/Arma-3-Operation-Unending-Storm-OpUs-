params ["_Unit","_PayOut"];
if ((isPlayer _Unit) or (isPlayer (leader group _Unit))) then
{
    if !(vehicle _Unit isKindOf "Man") then
	{
	    {
		    if (isPlayer _x) then
			{
			    _x setVariable ["FUNDS",(_x getVariable "FUNDS") + _PayOut,true];
			};
        } forEach (crew(vehicle _Unit));		
	}
	else
	{
	    if (isPlayer _Unit) then
		{
		    _Unit setVariable ["FUNDS",(_Unit getVariable "FUNDS") + _PayOut,true];
		};
	};
	{
	    if ((isPlayer _x) && !((_x in (crew(vehicle _Unit))) or (_x isEqualTo _Unit))) then
		{
		    if (_x distance _Unit < 1000) then
			{
			    _x setVariable ["FUNDS",(_x getVariable "FUNDS") + (_PayOut * (1 / 2)),true];
			};
		};
	} forEach (units group _Unit);
};