/*
PARAMETERS

0: Price in string with suffix K, M, Bn or Tn.

RETURN:

Raw price in integer, can be used to add towards GDP, but not for player funds as these can be floats.
Subtracted directly from funds if bought by player, or Subtracted by GDP if item/Vehicle Destroyed.
Worst case, if suffix is lacking, and raw number is present, it is taken as the price. 

*/


_Price = param[0,"",["",0]];
_Ret = "";

if (!(_Price isEqualTo "") && (_Price isEqualType "")) then 
{
    _Suff = _Price select [(count _Price) - 1,count _Price];   
    switch (True) do
	{
	    case (_Suff == "K"): 
		{
		    _Ret = (parseNumber (_Price select [0,(count _Price) - 1])) * 1000;
		};
		case (_Suff == "M"): 
		{
		    _Ret = (parseNumber (_Price select [0,(count _Price) - 1])) * 1000000;
		};
		case (_Suff == "n"): 
		{
		    _Suff = _Price select [(count _Price) - 2,count _Price];
		    _Num = (parseNumber (_Price select [0,(count _Price) - 2]));
			switch (True) do 
			{
			    case (_Suff == "Bn"): {_Ret = _Num * 1000000000;};
				case (_Suff == "Tn"): {_Ret = _Num * 1000000000000;};
			};
		};
		default {_Ret = parseNumber _Price;};
	};
}
else
{
    if (_Price isEqualType 0) then 
	{
        _Ret = _Price;
    }
    else
    {
	    _Ret = 0;
    };	
};

_Ret