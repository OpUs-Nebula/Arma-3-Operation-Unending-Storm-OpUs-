disableSerialization;

playSound "ZoomIn";
/*
_Configs = "true" configClasses (configfile >> "CfgWeapons");

_realWeapons = [];

{
_name = configName _x;

  if (!isNull (configfile >> "CfgWeapons" >> _name >> "displayName")) then {
  
    _addWeapon = [getText (configfile >> "CfgWeapons" >> _name >> "displayName")];
    _realWeapons append _addWeapon;     
  };
} forEach _Configs;

_List = [];



_shopItems = _realWeapons;
*/
createDialog "client_GunShop_Dialog";

waitUntil {!isNull (findDisplay 99999)};

_ctrl = (findDisplay 99999) displayCtrl 1500;

{
		_ctrl lbAdd gettext (_x >> "displayName");
		_ctrl lbSetPicture [_foreachindex,gettext (_x >> "texture")];
		_ctrl lbSetTooltip [_foreachindex,gettext (_x >> "displayName")];
	} foreach ("isclass _x" configclasses (configfile >> "CfgWeapons"))
/*
{
_ctrl lbAdd _x;
} forEach _shopItems;
*/