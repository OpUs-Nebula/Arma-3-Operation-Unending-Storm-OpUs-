_Item = param[0,101,[""]];
_Cond = param[1,false,[false]];

if (_Item isEqualTo 101) exitWith {"WRONG DATATYPE!"};

_Ret = "";
_Tar = [];
{ 
    _KindArr = _x param[0];
	_Cfg     = _x param[2];
	{
        if ((_Item isKindOf [_x, configFile >> _Cfg]) && !(_Item in _Tar)) then 
		{
            _Tar append [_Item];
			if (_Cond) then
			{
			    _Ret = [_x,_Cfg];
			}
			else
			{
			    _Ret = _x;
			};
		};
	} forEach _KindArr;
} 
forEach 
[
    [
	    ["Rifle","Launcher","Pistol"],[],"CfgWeapons",
		[]
	],
	[
	    ["ItemCore","Binocular"],[],"CfgWeapons",
		[]
	],
	[
	    ["CA_Magazine"],[],"CfgMagazines",
		[]
	],
	[
	    ["Bag_Base"],[],"CfgVehicles",
		[]
	]
];

_Ret