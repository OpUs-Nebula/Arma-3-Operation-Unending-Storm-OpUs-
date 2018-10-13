//_VehArr = [[Class,Price,Tier],....] available tiers: Land("Heavy","Medium","Light")
//Available tags: "Land" "Air" "Sea"
//for Diags: on press of class switch button, call fnc that sets variable on diag containing 
//all vehicle data for class. Buy script then searches data for class that is to be bought, 
//and gets price from there. //NOTE// no need for extra array for noArmor, defined in Tier.
//Select to detect prefix, parseNumber to convert into number to multiply by prefix.(price)
//WIP: [Class,Price,Tier,[variant1,variant2,....]]
scopeName "Main";

params ["_Nat"];

_Veh = param[1,"",[""]];
_Tag = param[2,"",[""]];
_Ret = [];

/*-----------------------------------------------------------------------
NATION DATA                                                     --------- 
                                                                ---------
                                                                ---------
AAF                                                             ---------
-----------------------------------------------------------------------*/
if (_Nat == "AAF") then 
{
    _LandArr = 
	[
	    ["I_MBT_03_cannon_F","5.74M","Heavy"],
	    ["I_MRAP_03_F","520K","Light"],
	    ["I_APC_Wheeled_03_cannon_F","1.85M","Medium"],
	    ["I_Truck_02_transport_F","98K","Light"]
	];
	_SeaArr  = 
	[
	"AAF - SEA"
	];
	_AirArr  = 
	[
	"AAF - AIR"
	];
	
	
	_All     = [_LandArr,_AirArr,_SeaArr];
	_ChkArr  = "";
	
    if !(_Veh isEqualTo "") then 
	{
	    if !(_Tag isEqualTo "") then 
		{
		    switch(_Tag) do 
			{
			    case "Land": {_ChkArr = _LandArr;};
				case "Sea":  {_ChkArr = _SeaArr;};
				case "Air":  {_ChkArr = _AirArr;};
				default {if (true) exitWith {_Ret = _All; breakTo "Main";};};
			};
            _Ret = (_ChkArr select {_x isEqualTo _Veh}) param[0];
		}
		else
		{
		    _ChkArr = _All;
		    {
			    _VehArr = _x;
			    {
					if ((_Veh) isEqualTo (_x param[0])) then
					{
					    _Ret = _x;
					};
			    } forEach _VehArr;
			} forEach _ChkArr;
		};
	}
	else
	{
	    _Ret = _All;
	};
};

/*-----------------------------------------------------------------------
NATION DATA                                                     --------- 
                                                                ---------
                                                                ---------
NATO                                                             ---------
-----------------------------------------------------------------------*/
if (_Nat == "NATO") then 
{
    _LandArr = 
	[
	    ["B_MBT_01_cannon_F","4.5m","Heavy"],
	    ["B_APC_Wheeled_01_cannon_F","2.2m","Medium"],
	    ["B_MRAP_01_F","470K","Light"],
	    ["B_T_Truck_01_transport_F","135k","Light"]
	];
	_SeaArr  = 
	[
	];
	_AirArr  = 
	[
	];
	
	
	_All     = [_LandArr,_AirArr,_SeaArr];
	_ChkArr  = "";
	
    if !(_Veh isEqualTo "") then 
	{
	    if !(_Tag isEqualTo "") then 
		{
		    switch(_Tag) do 
			{
			    case "Land": {_ChkArr = _LandArr;};
				case "Sea":  {_ChkArr = _SeaArr;};
				case "Air":  {_ChkArr = _AirArr;};
				default {if (true) exitWith {_Ret = _All; breakTo "Main";};};
			};
			{
			    if ((_Veh) isEqualTo (_x param[0])) then
			    {
			        _Ret = _x;
                }; 
			} forEach _ChkArr;
		}
		else
		{
		    _ChkArr = _All;
		    {
			    _VehArr = _x;
			    {
					if ((_Veh) isEqualTo (_x param[0])) then
					{
					    _Ret = _x;
					};
			    } forEach _VehArr;
			} forEach _ChkArr;
		};
	}
	else
	{
	    _Ret = _All;
	};
};

/*-----------------------------------------------------------------------
NATION DATA                                                     --------- 
                                                                ---------
                                                                ---------
CSAT                                                            ---------
-----------------------------------------------------------------------*/
if (_Nat == "CSAT") then 
{
    _LandArr = 
	[
	    ["O_MBT_02_cannon_F","3.7m","Heavy"],
	    ["O_APC_Tracked_02_cannon_F","1.65M","Medium"],
	    ["O_MRAP_02_F","350K","Light"],
	    ["O_Truck_03_transport_F","112K","Light"],
	    ["O_Truck_02_transport_F","98K","Light"]
	];
	_SeaArr  = 
	[
	];
	_AirArr  = 
	[
	];
	
	
	_All     = [_LandArr,_AirArr,_SeaArr];
	_ChkArr  = "";
	
    if !(_Veh isEqualTo "") then 
	{
	    if !(_Tag isEqualTo "") then 
		{
		    switch(_Tag) do 
			{
			    case "Land": {_ChkArr = _LandArr;};
				case "Sea":  {_ChkArr = _SeaArr;};
				case "Air":  {_ChkArr = _AirArr;};
				default {if (true) exitWith {_Ret = _All; breakTo "Main";};};
			};
			{
			    if ((_Veh) isEqualTo (_x param[0])) then
			    {
			        _Ret = _x;
                }; 
			} forEach _ChkArr;
		}
		else
		{
		    _ChkArr = _All;
		    {
			    _VehArr = _x;
			    {
					if ((_Veh) isEqualTo (_x param[0])) then
					{
					    _Ret = _x;
					};
			    } forEach _VehArr;
			} forEach _ChkArr;
		};
	}
	else
	{
	    _Ret = _All;
	};
};

_Ret