_Unit = param[0,objNull,[objNull]];
//_Crate = param[1,objNull,[objNull]];
_Arsenal = [_Unit,"Arsenal"] call client_fnc_GetVar;

_WepArr   = [];
_MagArr   = [];
_GearArr  = [];
_BackArr  = [];

_Added = [];
{
    _Item = _x param[0];
	if ((_x param[1]) > 0) then
	{
	    { 
	        _KindArr = _x param[0];
	    	_Tar     = _x param[1];
	    	_Cfg     = _x param[2];
			_CmndArr = _x param[3];
	    	{
			    //Command executed from comndArr == same index as ItemClass in _KindArr
			    _CmndLoc = _CmndArr param[_ForEachIndex]; 
	            if ((_Item isKindOf [_x, configFile >> _Cfg]) && !((_Item in _Tar) or (_Item in _Added))) then 
	    		{
	    		    _Tar append [_Item];
					if !(isNil "_CmndLoc") then
					{
					    call compile format [_CmndLoc,_Item];
					};
	    		};
	    	} forEach _KindArr;
	    } 
	    forEach 
	    [
	        [
			    ["Rifle","Launcher","Pistol"],_WepArr,"CfgWeapons",
				[]
			],
	    	[
			    ["ItemCore","Binocular"],_GearArr,"CfgWeapons",
				[]
			],
	    	[
			    ["CA_Magazine"],_MagArr,"CfgMagazines",
				[]
			],
	    	[
			    ["Bag_Base"],_BackArr,"CfgVehicles",
				[]
			]
	    ];
	};
} forEach _Arsenal;

_Eq = getUnitLoadout _Unit;

//Cargo Classes: ["Uniform","Backpack","Vest"]		
		
//False,False means crateSupply is local, and addaction is not added. in that order.
//Adding gear to arsenal
_Scr1 = [missionNamespace,_WepArr,false,false] spawn BIS_fnc_addVirtualWeaponCargo;
_Scr2 = [missionNamespace,_MagArr,false,false] spawn BIS_fnc_addVirtualMagazineCargo;
_Scr3 = [missionNamespace,_BackArr,false,false] spawn BIS_fnc_addVirtualBackpackCargo;
_Scr4 = [missionNamespace,_GearArr,false,false] spawn BIS_fnc_addVirtualItemCargo;

waitUntil {((scriptDone _Scr1) && (scriptDone _Scr2)) && ((scriptDone _Scr3) && (scriptDone _Scr4))};

["Open",false] spawn BIS_fnc_arsenal;

//Wait For open (to hinder instant enter/exit)
SystemChat "Opening Arsenal......";
waitUntil {!( isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) )};
SystemChat "Entered Arsenal";

//Wait For Close(Until player is done)

waitUntil {isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};
SystemChat "Exited Arsenal";

//In order to hinder weapon dupe if arsenal is acessed elsewhere.
//Removing Arsenal Gear
[missionNamespace,_WepArr,false] spawn BIS_fnc_RemoveVirtualWeaponCargo;
[missionNamespace,_MagArr,false] spawn BIS_fnc_RemoveVirtualMagazineCargo;
[missionNamespace,_GearArr,false] spawn BIS_fnc_RemoveVirtualItemCargo;
[missionNamespace,_BackArr,false] spawn BIS_fnc_RemoveVirtualBackpackCargo;

_PostAr = getUnitLoadout player;

_Dept   = [];
_Tested = [];

_Net = [];


{
    if !(_x isEqualType []) then
    {	
        if !(_x in _Tested) then 
	    {
	        _Tested append [_x]; 
	    	_Chkr = _x; 
	    	_Aft  = count (_PostAr select {_x isEqualTo _Chkr});
	    	_Bef  = count (_Eq select {_x isEqualTo _Chkr});
	    	
	    	_Diff = _Bef - _Aft;
	    	_Net append [[_x,_Diff]];
	    };
    }	
} forEach _Eq;

{
    if !(_x isEqualType []) then
    {	 
        if !(_x in _Tested) then 
	    {
	        _Tested append [_x]; 
	    	_Chkr = _x; 
	    	_Aft  = count (_PostAr select {_x isEqualTo _Chkr});
	    	_Bef  = count (_Eq select {_x isEqualTo _Chkr});
	    	
	    	_Diff = _Bef - _Aft;
	    	_Net append [[_x,_Diff]];
	    };
    };		
} forEach _PostAr;

_Const = 1;

_Tnet  = [];
{
    if (_x isEqualTo "SWITCH") then
    {
        _Const = -1;
    }
    else
    {
	    if ((_x isEqualType []) && {count _x > 0}) then
		{
		    if ((_x param[1]) isEqualType []) then
			{
			    _Cont = _x param[0];
				if !(count (_Tnet select {_Cont in _x}) > 0) then
				{
				    _Tnet append [[_Cont,1 * _Const]];
				}
				else
				{
				    _Orgn = (_Tnet select {_Cont in _x}) param[0];
				    _Orgn set [1,(_Orgn param[1]) + (1 * _Const)];
				};
				
			    {
				    _Item  = _x param[0];
					if (_Item isEqualType []) then
					{
					    {
						    _WpnTm = _x;
							if !(count (_Tnet select {_WpnTm in _x}) > 0) then
							{
							    _Tnet append [[_WpnTm,1 * _Const]];
							}
							else
							{
							    _Orgn = (_Tnet select {_WpnTm in _x}) param[0];
								_Orgn set [1,(_Orgn param[1]) + (1 * _Const)];
							};
						} forEach (_Item select {(_x isEqualType "") && !(_x isEqualTo "")});
					}
					else
					{
					    if ((_x param[1]) isEqualType 0) then
					    {
					        _Count = _x param[1];
                            if (count (_Tnet select {_Item in _x}) > 0) then
                            {
					            _Orgn = (_Tnet select {_Item in _x}) param[0];
                                _Orgn set [1,(_Orgn param[1]) + (_Count * _Const)];						
                            }
                            else
                            {
					            _Tnet append [[_Item,_Count * _Const]];   
                            };
					    };
                    };						
				} forEach (_x param[1]);
			}
			else
			{
			    {
				    _WpnTm = _x;
					if !(count (_Tnet select {_WpnTm in _x}) > 0) then
					{
					    _Tnet append [[_WpnTm,1 * _Const]];
					}
					else
					{
					    _Orgn = (_Tnet select {_WpnTm in _x}) param[0];
						_Orgn set [1,(_Orgn param[1]) + (1 * _Const)];
					};
				} forEach (_x select {(_x isEqualType "") && !(_x isEqualTo "")});	
			};
		};
    };
} forEach ((_Eq + ["SWITCH"]) + _PostAr);

systemChat format ["NET I/O SCAN: %1",_Tnet];

//DEBUG:
//implimented as acess point if something is wonky with unitloadout organization/operations.
//could input straight to _Net, but would disrupt _Dept system if all items involved are not yet in
//WeaponParams.
if (true) then {_Net append _Tnet};

_DepCrw = [];

{
    _Diff = _x param[1];
	_Item = _x param[0];
	if !(_Item == "") then
	{
	    switch (true) do
	    {
	        case (_Diff < 0): 
	    	{
	    	    _Inv = _Arsenal select {_Item in _x};
                if (_Inv isEqualTo []) then
                {
	    		    systemChat "Youre taking an item you dont have";
	    			_RemCnt = _Diff;
	    			_Dept append [[_Item,_RemCnt]];
                }
                else
                {
	    			_Index = _Arsenal find (_Inv param[0]);
	    		    _ItemArr = _Arsenal param[_Index];
	    			if ((_ItemArr param[1]) >= (abs _Diff)) then
	    			{
	    		        //_ItemArr set [1,(_ItemArr param[1]) + _Diff];
	    				_DepCrw append [[_Item,(_ItemArr param[1]) + _Diff]];
	    		        systemChat "Removed a few items from inventory, were withdrawn.";
	    			}
	    			else
	    			{
	    			    _RemCnt = (_ItemArr param[1]) + _Diff;
	    				
	    			    //_ItemArr set [1,0];
	    				_DepCrw append [[_Item,0]];
	    			    systemChat format ["Too few items in inventory, purchase %1 or lose them.",abs _RemCnt];
	    				_Dept append [[_Item,_RemCnt]];
	    			};
                };			
	    	};
	    	case (_Diff > 0):
	    	{
	    	    _Inv = _Arsenal select {_Item in _x};
	    	    if !(_Inv isEqualTo []) then
	    		{
	    	        _Index = _Arsenal find (_Inv param[0]);
	    		    _ItemArr = _Arsenal param[_Index];
	    		    
	    			//_ItemArr set [1,(_ItemArr param[1]) + _Diff];
	    			_DepCrw append [[_Item,(_ItemArr param[1]) + _Diff]];
	    		    SystemChat format ["Added %1 to arsenal, check inventory.(arsenal variable on player)",[_Item,_Diff]];
	    		}
	    		else
	    		{
	    		    //(_Unit getVariable "Arsenal") append [[_x,_Diff]];
	    			
	    			_DepCrw append [[_Item,_Diff]];
                    SystemChat format ["Added %1 to arsenal, check inventory.(arsenal variable on player)",[_Item,_Diff]];				
	    		};
	    	};
	    	case (_Diff == 0): 
	    	{
	    	    //DEBUG: systemChat "You didnt put in, or take out anything."
	    	};
	    };
	    //DEBUG: systemChat format ["TRANSACTION: %1",_x];
	};
} forEach _Net;

//DEBUG: 
systemChat format ["DEBT ITEMS: %1",_Dept];


//Gear reset will allow players to dupe items, if all gear is deposited, and gear not present in
//Arsenal var is taken out, they regain all other gear free of charge. will need stoping of
//Deposit aswell, if _Dept > 0.
if ((count _Dept) > 0) then
{
    player setUnitLoadout _Eq;
    _RstArr = [];
	_Sum = 0;
    _Rcpt = [];	
    {
	    _Item = _x param[0];
		_Del = abs (_x param[1]);
		
		_Dta = [(player getVariable "NATION"),"",[_Item]] call cfg_fnc_weaponParams;
		_Price = 0;
		if (count (_Dta select {_Item in _x}) > 0) then
		{
		    _Price = [((_Dta select {_Item in _x}) param[0]) param[1]] call cfg_fnc_PriceCalc;
			//DEBUG: systemChat format ["%1 was magazine, recignized",_Item];
		}
		else
		{
		    //DEBUG: systemChat format ["%1 was Not magazine, Unrecognized",_Item];
		    //systemChat format ["DebtItem DTA: %1, Magazine not recognized, %2",_Dta,_Item];
			//Item not found in WeaponsParams(most likely)
		    _PrcDta  = (_Dta select 
			{
			    if ((_x param[0]) isEqualType []) then
				{
			        count ((_x param[0]) select 
				    {
				        _Item == _x
				    }) > 0
					//systemChat format ["%1 param[0] is array",_x];
					//_Item == (_x param[0] param[0])
				}
				else
				{
				    //systemChat format ["%1 not array",_x];
				    false 
				}
			});
			//systemChat format["_PrcDta: %1,_Dta: %2,_Item: %3",_PrcDta,_Dta,_Item];
			//DEBUG: systemChat format ["Debt: %1",_Dept];
			//May throw error here if weapon is not present in Params/ConfigRip is off and no mag is written.
			//All mags stored in common, preferably.
			_PriceRw = (_PrcDta select {_Item in (_x param[0])}) param[0] param[2];
			_Price   = [_PriceRw] call cfg_fnc_PriceCalc;
		};
		
		_Sum = _Sum + (_Del * _Price);
		_Cfg = ([_Item,true] call UTL_fnc_isKindOf) param[1];
		_Rcpt append [format ["%1x %2",_Del,gettext (configFile >> _Cfg >> _Item >> "DisplayName")]];
		
	} forEach _Dept;
	
    _result = [format ["Items added through Arsenal: %1, Price: %2",_Rcpt,[_Sum] call cfg_fnc_MoneyDisplay], "Confirm", "Purchase", "Remove"] call BIS_fnc_guiMessage;
	if (_result) then
	{
	    //DEBUG systemChat format ["AGREED TO PURCHASE: %1, SHOULD BE AGREED/TRUE",_Result];
		_Funds = player getVariable "Funds";
		if (_Funds >= _Sum) then
		{
		    player setVariable ["Funds",(_Funds - _Sum)];
			_Unit setUnitLoadout _PostAr;
			
			{
			    _DepWth = _x;
                if !(count (_Arsenal select {(_DepWth param[0]) in _x}) > 0) then
                {
				    _Arsenal append [_x];
                }
                else
                {
				    _Arsenal set [_Arsenal find ((_Arsenal select {(_DepWth param[0]) in _x}) param[0]),_x];    
                };				
			} forEach _DepCrw;
			
			systemChat "Surplus purchased, Rest of items added to inventory!";
		}
		else
		{
		    systemChat format ["insufficient funds: Current %1, Needed %2",_Funds,_Sum]; 
		};
	}
	else
	{
		SystemChat format ["Gear was reset"];
	};
	//systemChat "AGREED TO PURCHASE: MACHINE BRUAKKMAN!!!!";
}
else
{
    {
	    _DepWth = _x;		
        if !(count (_Arsenal select {(_DepWth param[0]) in _x}) > 0) then    
        {    
		    _Arsenal append [_x];	
        }    
        else    
        {    
		    _Arsenal set [_Arsenal find ((_Arsenal select {(_DepWth param[0]) in _x}) param[0]),_x]; 	
        };				    
	} forEach _DepCrw;	
};
[] spawn client_fnc_SaveFunds;
[] spawn client_fnc_SaveGear;
[] spawn client_fnc_SaveArsenal;
[] spawn client_fnc_SavePosition;



















