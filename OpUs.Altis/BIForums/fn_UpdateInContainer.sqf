/*
MADE BY: Larrow
Link to script:
https://forums.bohemia.net/forums/topic/145902-adding-attachments-to-weapon-in-backpack/

Edit By: Nebula

PARAMETERS:
0: OBJECT Container with weapon to alter
1: ARRAY Weapon to alter, Gotten through WeaponsItemsCargo (Container), full data array.

2: STRING or ARRAY Attachment that needs removing/adding-attachments-to-weapon-in-backpack
Only Array if true, uses Param[0] value as _weaponData position EX: [Location,Classname];

3: BOOL (Optional) if true, adds instead of removes(Default: false)


NOTES:
/ATTACHMENT INDICES:
0: !!DO NOT USE!! reserved for weapon classname
1: Suppressor
2: Laser/Flashlights
3: Optics
4: Magazine
5: Bipod
EXAMPLE: 
[ backpackContainer player, ( weaponsItemsCargo (backpackContainer player) ) select 0, "optic_ACO_grn" ] call BIF_fnc_UpdateInContainer;
*/
params[ "_container", "_weaponInfo", "_itemToRemove" ];

_Bool = param[3,false,[false]];
_ContSuff = param[4,"",[""]];
	
_dummy = if ( isNil { player getVariable "dummy" } ) then {
	
	//Pos: [0,0,0]
	_dummy = createAgent ["I_G_Survivor_F", position player, [], 0, "NONE" ];
	_dummy hideObjectGlobal true;
	/*
	{
		_dummy disableAI _x;
	}forEach [
		"TARGET", 
		"AUTOTARGET", 
		"MOVE", 
		"ANIM", 
		"TEAMSWITCH", 
		"FSM", 
		"AIMINGERROR", 
		"SUPPRESSION", 
		"CHECKVISIBLE", 
		"COVER", 
		"AUTOCOMBAT", 
		"PATH"
	];
	*/
	_dummy addBackpack "B_Carryall_mcamo";
	player setVariable[ "dummy", _dummy ];
		
	if (isNil {missionNamespace getVariable "Dummies.Inc"}) then
	{
	    missionNamespace setVariable ["Dummies.Inc",_Dummy];
	}
	else
	{
	    (missionNamespace getVariable "Dummies.Inc") append [_Dummy]; 
	};
	
	_dummy
}else{
	(player getVariable "dummy") setPos (position player);
	player getVariable "dummy";
};


_weaponData = weaponsItemsCargo _container;

_Dump = "";

if ((_weaponInfo param[0]) isEqualType []) then
{
    _Dump = if (isNil {_Dummy getVariable "Dump"}) then
	{
	    clearAllItemsFromBackpack (_Dummy getVariable "Dump");
	    _Dump = createAgent [typeOf _Dummy,position _Dummy,[],0,"NONE"];
		call compile format ["_Dump add%1 %2",_ContSuff,str (typeOf _container)];
		//_Dump addBackpack (TypeOf _container);
		_Dummy setVariable ["Dump",_Dummy];
		_Dump
	}
	else
	{
	    (_Dummy getVariable "Dump") setPos (position _Dummy);
		if (call compile format ['(%1 player) == ""',_ContSuff]) then
		{
		    call compile format ["_Dump add%1 %2",_ContSuff,str (typeOf _container)];    
		}
		else
		{
		    _lklCmnd = format ['%1Container (_Dummy getVariable "Dump")',_ContSuff]; 
		    {
			    call compile format ["Clear%1CargoGlobal %2",_x,_lklCmnd];
			} forEach ["Item","Weapon","Magazine"];
		};
		_Dummy getVariable "Dump"
	};
};

{
    _Exit = false;
	if ( (!(_Dump isEqualTo "") && {_wpItm = _x; count (_weaponInfo select {_x isEqualTo _wpItm}) > 0}) or {_x isEqualTo _weaponInfo} ) then 
	{
	    _Exit = true;
		
		_RelItem = "";
		if !(_Dump isEqualTo "") then
		{
		    _wpItm = _x;
		    _RelItem = _itemToRemove param[_weaponInfo find (selectRandom (_weaponInfo select {_x isEqualTo _wpItm}))];
		}
		else
		{
		    _RelItem = _itemToRemove;
		};
		
	    _Ntry = _weaponData select _forEachIndex;
		if (_Bool) then
		{
		    if (_RelItem isEqualType []) then
			{
			    _Dta = _x;
                _PrFrNd = _forEachIndex;
                {
                    (_weaponData select _PrFrNd) set [_x param[0], _x param[1]];
			    } forEach _RelItem;				
			}
			else
			{
		        (_weaponData select _forEachIndex) set [(_RelItem param[0]),(_RelItem param[1])];
			};	
		}
		else
		{
		    if (_RelItem isEqualType []) then
			{
			    _Dta = _x;
				_PrFrNd = _forEachIndex;
                {
				    (_weaponData select _PrFrNd) set [_Dta find _x, ""];
                } forEach _RelItem;				
			}
			else
			{
			    (_weaponData select _forEachIndex) set [_x find _RelItem, ""];
			};
		};
		(_weaponData select _forEachIndex) set [0, (_Ntry param[0]) call BIS_fnc_baseWeapon];
		if (_Exit) exitWith {};
		
		
	};
}forEach _weaponData;
/*
if !(_ContSuff == "") then
{
    //call compile format ["player removeItemFrom%1 %2",_ContSuff,str (_weaponInfo param[0])];
}
else
{
    clearWeaponCargoGlobal _container;
};
*/
removeAllWeapons _dummy;
removeAllItems _dummy;
removeAllAssignedItems _dummy;


{
	_x params[ "_weapon" ];
	
	_BaseWpn = (_weapon call BIS_fnc_baseWeapon);
	_dummy addWeapon _BaseWpn;
	{
		if !( ( _x isEqualType "" && { _x isEqualTo "" } ) || ( _x isEqualType [] && { _x isEqualTo [] } ) ) then {
			if !( _x isEqualType [] ) then {
				_x = [ _x ];
			};
			//_Weapon
			_dummy addWeaponItem [ _BaseWpn, _x ];
		};
	} forEach ( _x - [ _weapon ] );
	
	if !(_Dump isEqualTo "") then
	{
	    _dummy action [ "DropWeapon", call compile format ["%1Container _Dump",_ContSuff], _BaseWpn ];
		waitUntil {currentWeapon _Dummy == ""};
		sleep 1;
	}
	else
	{
	    _dummy action [ "DropWeapon", _container, _BaseWpn ];
	};
} forEach _weaponData;


//Should probably be done before Weapon Add, in order to prevent duping through this.
//add Dumps backpack back to player after all operations.
{

    _Commnd = "";
    if (_ForeachIndex isEqualTo 0) then
	{
	    _Commnd = "addMagazineCargoGlobal";
        _CargoArr = _x;
        {
		    (BackPackContainer _Dump) addMagazineCargoGlobal [_x,_CargoArr param[1] param[_ForeachIndex]];   
        } forEach (_CargoArr param[0]);		
	}
	else
	{
	    _Commnd = "addItemCargoGlobal";
        _CargoArr = _x;
        {
		    (BackPackContainer _Dump) addItemCargoGlobal [_x,_CargoArr param[1] param[_ForeachIndex]];    
        } forEach (_CargoArr param[0]);		
	};
	/*
	{
	    systemChat format ["(call compile %1) %2 %3",str (str (backpackContainer _Dump)),_Commnd,[_x,_CargoArr param[1] param[_ForeachIndex]]];
	    call compile format ["(call compile %1) %2 %3",str (str (backpackContainer _Dump)),_Commnd,[_x,_CargoArr param[1] param[_ForeachIndex]]];
	} forEach (_CargoArr param[0]);
	*/
} forEach [getMagazineCargo _container,getItemCargo _container];

systemChat format ["Added to DUMP: %1",_weaponData];

/*
[_Dummy] spawn 
{
   _Dummy = param[0];
    sleep 20;
    deleteVehicle _dummy;
}
*/	