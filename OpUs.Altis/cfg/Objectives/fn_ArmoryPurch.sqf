params ["_Item","_Unit","_ItemSpcs"];

_Nat = (_Unit getVariable "Nation");
_NatAr = ((_Unit getVariable "Arsenal") select {_Nat in _x}) param[0,[]];

_Cost = [_ItemSpcs param[2]] call cfg_fnc_PriceCalc;
_ItemAr = ((_NatAr param[1,[]]) select {_Item in _x}) param[0];
_Name = gettext (configFile >> "cfgWeapons" >> _Item >> "displayName");

if (_Unit getVariable "Funds" >= _Cost) then
{
    _Unit setVariable ["Funds",(_Unit getVariable "Funds") - _Cost];
    if !(isNil "_ItemAr") then
    {
        _ItemAr set[1,(_ItemAr param[1]) + 1];
		systemChat format ["You bought an %1 for %2",_Name,_ItemSpcs param[2]];
    }
	else
	{
	    if (_NatAr IsEqualTo []) then
		{
		    (_Unit getVariable "Arsenal") append [[_Nat,[[_Item,1]]]];     
		}
		else
		{
		    (_NatAr param[1]) append [[_Item,1]];
		};
		systemChat format ["You bought an %1 for %2",_Name,_ItemSpcs param[2]];
	};
}
else
{
    systemChat "Not enough cash for purchase";
};