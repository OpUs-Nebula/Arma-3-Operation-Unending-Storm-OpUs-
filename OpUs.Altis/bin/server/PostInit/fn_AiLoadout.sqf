/*
FNC PARAMS:
0: AI or UNIT that needs dressing
1: Loadout to be applied
//NOTE FOR param[1]//using predifined format found in baseparams, define where inputed or in base param for consistent global use.
2: Custom Primary format: [weapon,Magazine]([] for loadout defined)
3: Custom launcher/Backpack in format: [backPack,[launcher,launcherAmmo]]([] for loadout defined)
*/

params ["_Unit","_Loadout"];

_cPrim = param[2,[],[[]]];
_cLnch = param[3,[],[[]]];

_Loadout params ["_Uni",                
                "_SecAmmo",
                "_Grends",
                "_PrimAmmo",
                "_BkPak",
                "_LnchrAmmo",
                "_PrimWpn",
                "_PrimAttch",
                "_Lnchr",
                "_Second",
                "_Bino",
				"_Links",
				"_Insig",
				"_Helm",
				"_Goggl",
				"_Vest"];

if !(_cPrim isEqualTo []) then
{
    _cPrimW  = _cPrim param[0,"",[""]];
	_cPrimM  = _cPrim param[1,"",[""]];
	if !(_cPrimW isEqualTo "") then
	{
        _PrimWpn = _cPrimW;
		if !(_cPrimM isEqualTo "") then
		{
		    _PrimAmmo = _cPrimM;    
		}
		else
		{
		    _PrimAmmo = (getArray (configFile >> "CfgWeapons" >> _cPrimW >> "Magazines")) param[0];
		};
	};
};				

if !(_cLnch isEqualTo []) then
{
	_cLnchA = _cLnch param[1,[],[[]]];
	
	_cLnchL = _cLnchA param[0,"",[""]];
	_cLnchM = _cLnchA param[1,"",[""]];
	if !(_cLnchL isEqualTo "") then
	{
	    _Lnchr = _cLnchL;
		if !(_cLnchM isEqualTo "") then
		{
		    _LnchrAmmo = _cLnchM;   
		}
		else
		{
		    _LnchrAmmo = (getArray (configFile >> "CfgWeapons" >> _cLnchL >> "Magazines")) param[0];
		};
	};
	
	_lBkPk = _cLnch param[0,"",[""]];
	if !(_lBkPk isEqualTo "") then
	{
	    _BkPak = _lBkPk;
	};
};
				
comment "Remove existing items";
removeAllWeapons _Unit;
removeAllItems _Unit;
removeAllAssignedItems _Unit;
removeUniform _Unit;
removeVest _Unit;
removeBackpack _Unit;
removeHeadgear _Unit;
removeGoggles _Unit;

comment "Add containers";
//_Ubool = false;
//_Vbool = false;

//if !(_Uni isEqualTo "") then { _Unit forceAddUniform _Uni; _Ubool = true; };
//if !(_Vest isEqualTo "") then { _Unit addVest _Vest; _Vbool = true; };
// if !(_Helm isEqualTo "") then { _Unit addHeadgear _Helm; };
_Unit forceAddUniform _Uni;
_Unit addVest _Vest; 
_Unit addHeadgear _Helm;


_Unit addItemToUniform "FirstAidKit";


if !(_Goggl isEqualTo "") then { _Unit addGoggles _Goggl; };

comment "BackPack items";
if !(_BkPak isEqualTo "") then 
{
    _Unit addBackpack _BkPak;
	
	if !(_Lnchr isEqualTo "") then 
	{
		_Unit addWeapon _Lnchr;
	};
	if !(_LnchrAmmo isEqualTo "") then   
	{   
	    for "_i" from 1 to 4 do {_Unit addItemToBackpack _LnchrAmmo;};
	};
	
	{
	    if !((_x param[0]) isEqualTo "") then
		{
			for "_i" from 1 to (_x param[1]) do
			{
			    _Unit addItemToBackpack (_x param[0]);
			};
		};
	} forEach [[_PrimAmmo,4],[_SecAmmo,2],[_Grends param[1],1],[_Grends param[0],1]];			   
};

comment "Uniform Items";
//if (_Ubool) then 
//{
    {
        if !((_x param[0]) isEqualTo "") then
    	{
    			for "_i" from 1 to (_x param[1]) do
    			{
    			    _Unit addItemToUniform (_x param[0]);
    			};
    	};
    } forEach [[_SecAmmo,1],[_PrimAmmo,5],["Smokeshell",1],[_Grends param[0],1]];
//};
comment "Vest Items";
//if (_Vbool) then
//{
    {
        if !((_x param[0]) isEqualTo "") then
    	{
    			for "_i" from 1 to (_x param[1]) do
    			{
    			    _Unit addItemToVest (_x param[0]);
    			};
    	};
    } forEach [[_SecAmmo,2],["Smokeshell",1],[_Grends param[1],1],["FirstAidKit",2]];
//};
comment "Add weapons";
{
    if !(_x isEqualTo "") then
	{
	    _Unit addWeapon _x;
		if ((_x isEqualTo _PrimWpn) && (count _PrimAttch > 0)) then
		{
		    {_Unit addPrimaryWeaponItem _x;} forEach _PrimAttch;
		};
	};
} forEach [_PrimWpn,_Second,_Bino];

if (count _Links > 0) then
{
    {_Unit linkItem _x;} forEach _Links;
};

if !(_Insig isEqualTo "") then
{
    [_Unit,_Insig] call bis_fnc_setUnitInsignia;
};