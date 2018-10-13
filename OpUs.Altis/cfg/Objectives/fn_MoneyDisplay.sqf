/*
PARAMETERS:

0: Value
1: Prefix, ie Million, Billion thousand etc(Optional)
*/

_Value  = param[0,"Undefined Value",[999]];
_Prefix = param[1,"",[""]];
_Color = '#05f03c';

//<t color='#05f03c'>$413k<\t>

_Ret  = "";
_oPut = "";
if (_Value isEqualTo "Undefined Value") exitWith {101010};

if (_Prefix isEqualTo "") then 
{
    switch(true) do 
	{
	    case (_Value <= 1000): {};
		case (1000 < _Value && _Value <= 1000000): {_Value = (floor (_Value / 10)) / 100; _Prefix = "K"};
		case (1000000 < _Value && _Value <= 1000000000): {_Value = (floor (_Value / 10000)) / 100; _Prefix = "M"};
		case (1000000000 < _Value && _Value <= 1000000000000): {_Value = (floor (_Value / 10000000)) / 100; _Prefix = "Bn"};
		case (1000000000000 < _Value): {_Value = (floor (_Value / 10000000000)) / 100; _Prefix = "Tn"};
	};
};
_oPut = format ["$%1%2",_Value,_Prefix];

_Ret = parseText format['<t color=%1>%2<\t>',str _Color,_oPut];

_Ret;
