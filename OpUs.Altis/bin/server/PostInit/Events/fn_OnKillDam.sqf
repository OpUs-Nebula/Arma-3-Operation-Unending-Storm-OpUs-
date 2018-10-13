_Info = param[0];
_Det  = param[1,"",[""]];
_VehData = param[2,[],[[]]];

//Potential fix for repair/Damage money dupe? variable cutting off money supply if total damage done exceeds
//value 1. Dont add if not player, to ensure that crashes or ai shots drain potential cash.
//NOTE// DAMAGE VARIABLE NEEDS TO BE SET BEFORE USE OF THIS FUNCTION, PREFERABLY RIGHT AFTER VEH CREATION
if (_Det == "hit") then
{
    _Info Params ["_Unit","_Cause","_DmgV","_Shttr"];
	_Payout  = ceil ((([_VehData param[1]] call cfg_fnc_PriceCalc) / 10) * _DmgV);
	
	_Allies = (missionNamespace getVariable (_Unit getVariable "NATION")) param[3];
	
	if !((_Shttr getVariable "NATION") in _Allies) then
	{
	    if ((_Unit getVariable "DAMAGE") < 1) then
	    {
	    	[_Shttr,_Payout] call UTL_fnc_EarnFunds;
	    	_Unit setVariable ["DAMAGE",(_Unit getVariable "DAMAGE") + _DmgV];
	    	SystemChat format ["VEH HIT, PAYOUT: %1",_Payout];
            SystemChat format ["DATA : %1",_Info];
	    }
	    else
	    {
	        systemChat "DONT TRY DAT DUPUING SHIT ON ME BOI";
	    };
	}
	else
	{
	    systemChat "FRIENDLY FIRE! LAWSUIT WILL MOST LIKELY FOLLOW!";
	};
}
else
{
    if (_Det == "Killed") then
	{
	    _Info Params ["_Unit","_Killer","_Shttr"];
	    _Allies = (missionNamespace getVariable (_Unit getVariable "NATION")) param[3];
	    if !((_Shttr getVariable "NATION") in _Allies) then
	    {
			_Payout  = ceil (([_VehData param[1]] call cfg_fnc_PriceCalc) / 40);
			[_Shttr,_Payout] call UTL_fnc_EarnFunds;
			systemChat format ["KILLED VEH INFO: %1, PAYOUT: %2",_Info,_Payout];
			
			[getPlayerUID _Shttr,"Funds",_Shttr getVariable "Funds",_Shttr] spawn DBC_fnc_SetPlayer;
		}
		else
		{
		    systemChat "FRIENDLY KILL! WTF MAN!";
		};
	}
	else
	{
	    if (true) exitWith {hint "Unit was neither killed nor hurt?? must be script errah..."};
	};
};