params ["_Shop","_Fort","_Nat"];

_ShwCnd = "(_this distance _target < 3)";
_ConCnd = "_caller distance _target < 3";

_UIfnc = 
{
    disableSerialization;

    _Unit  = param[0,"",[ObjNull]];
	_Nat   = param[1,"",[""]];
	if (_Unit isEqualTo "") exitWith
	{
	    SystemChat "Something went wrong with the Armory UI! Player not Object!";
	};
	_Tiers  = [];
	{
	    _Tiers append [_x param[0]];
	} forEach (_Unit getVariable "TIERS");
	//Most likely will need alternate variable in the future, only taking into account
	//Selected tiers, and not individual ones.
	
	//Allows all weapons/items/equipment in Commons array of WeaponsParams to be bought.
	_Tiers append ["Common"];
	_AcWps = [_Nat,_Tiers] call cfg_fnc_WeaponParams;

	
	//INLINE FNCs
	_CombPrpFnc =
	{
	    disableSerialization;
		
	    _CombLB = param[0];
	    //[["TITLE","LBIMAGE"].....["TITLE","LBIMAGE"]]; will be added to listBox in listed Order.
	    _Cats = 
		[["Primary",""],
		["Secondary",""],
		["Launcher",""],
		["Uniform",""],
		["Vest",""],
		["Backpack",""],
		["Items",""],
		["Attachments",""],
		["Magazines",""]];
		
		lbClear _CombLB;
		{
		    _Index = _CombLB lbAdd (_x param[0]);
            _CombLB lbSetData [_Index,(_x param[0])];
			_CombLB lbSetPicture [_Index,(_x param[1])];
			_CombLB lbSetTooltip [_Index,(_x param[0])];		
		} forEach _Cats;
	};
	_ComboWtch =
	{
	    disableSerialization;
	     
	    _Diag = param[0];
		_Comb = param[1];
		_Data = param[2];
		_LB   = param[3];
		
		_On   = true;
		_Old  = -1;
		while {_On} do
        {
		    waitUntil { isNull _Diag or (!((lbCurSel _Comb) isEqualTo _Old) && !((lbCurSel _Comb) isEqualTo -1))};
			if (isNull _Diag) then
			{
			    _On = false;
			};
			
			if !(_On) exitWith {SystemChat "Thanks for shopping!"};
			lbClear _LB;

			_WPclss = _Comb lbData (lbCurSel _Comb);
            SystemChat format ["WEAPON CLASS: %1",_WPclss];
			
			_Wps = [];
			{
			    _Wps append ((_x param[1]) select {_WPclss in _x})
			} forEach _Data;
			
			_Diag setVariable ["WPS",_Wps];
			
			//SystemChat format ["Setting WPS: %1",_Wps];
			
			systemChat format ["INP DTA: %1, OTPT DTA: %2",_Data,_Wps];
			
			{
			    _Item = _x param[0] param[0];
				_Cfg  = ([_Item,true] call UTL_fnc_IsKindOf) param[1];
			    _LB lbAdd (gettext (configFile >> _Cfg >> _Item >> "displayName"));
		        //_LB lbSetPicture [_foreachindex,gettext (configFile >> "cfgWeapons" >> _Item >> "icon")];
		        _LB lbSetTooltip [_foreachindex,gettext (configFile >> _Cfg >> _Item >> "displayName")];
		        _LB lbSetData [_foreachindex,_Item];
			} forEach _Wps;
			
			_Old = (lbCurSel _Comb);
        };		
	};
	_LBwtch =
	{
	    disableSerialization;
		
	    _Diag = param[0];
		_LB   = param[1];
		_Pic  = param[2];
		_Desc = param[3];
		_Prch = param[4];

		_On   = true;
		_Old  = -1;
        while {_On} do
        {
		    waitUntil { isNull _Diag or (!((lbCurSel _LB) isEqualTo _Old) && !((lbCurSel _LB) isEqualTo -1))};
			if (isNull _Diag) then
			{
			    _On = false;
			};
			if !(_On) exitWith {};
			
			_Item = _LB lbData (lbCurSel _LB);
			
			//systemChat format ["Weapon[] variable: %1",(_Diag getVariable "WPS")];
			
			_Spcs = ((_Diag getVariable "WPS") select {_Item in (_x param[0])}) param[0];
			
			_Cfg  = ([_Item,true] call UTL_fnc_IsKindOf) param[1];
			_Pic ctrlSetText (gettext (configFile >> _Cfg >> _Item >> "Picture"));			
			_Txt = [_Item] call cfg_fnc_Trivia;
	        
			_Cmnd = format ["%1 spawn cfg_fnc_ArmoryPurch",[_Item,player,_Spcs]];
			_Prch buttonSetAction _Cmnd;
			
			if (_Txt isEqualType "") then
			{
			    lbClear _Desc;
				_Desc lbAdd format ["Price: %1",_Spcs param[2]];
				
				_ArCnt = 0;
				_Ar    = (([player,"Arsenal"] call client_fnc_GetVar) select {_Item in _x}) param[0];
				if !(isNil "_Ar") then
				{
				    _ArCnt = _Ar param[1];
				};
				
				_Desc lbAdd format ["Arsenal: %1",_ArCnt];
			    [_Desc,_Txt,false,30] call UTL_fnc_LBpopul; 
			};
			_Old = (lbCurSel _LB); 
        };			
	};
	//INLINE END
	
	//SPAWN AND LABEL UI ELEMENTS	
	
	_Diag = createDialog "client_ItemPurchase_Display";
	WaitUntil {!isNull (findDisplay 312351)};
	
	_Diag = findDisplay 312351;
	_CombLB = _Diag displayCtrl 2100;
	_LB     = _Diag displayCtrl 1500;
	_ItemPic  = _Diag displayCtrl 1201;
	_TierD = _Diag displayCtrl 1100;
	_ItemD = _Diag displayCtrl 19321; 
	_Data = _AcWps;
	_PrchBttn = _Diag displayCtrl 1606;
	
	[_CombLB] call _CombPrpFnc;
	[_Diag,_CombLB,_Data,_LB] spawn _ComboWtch;
	_TierD ctrlSetText ((_Unit getVariable "TIERS") joinString "/");
	
	[_Diag,_LB,_ItemPic,_ItemD,_PrchBttn] spawn _LBwtch;
	
	_Flag = _Diag displayCtrl 1200;
	_Flag ctrlSetText ((missionNamespace getVariable _Nat) param[8]);
	
	_GDP = (_Diag displayCtrl 1608);
	_Funds = (_Diag displayCtrl 1607); 
	
	_GDP ctrlSetStructuredText (composeText ["GDP: ", lineBreak, ([(missionNamespace getVariable _Nat) param[6]] call cfg_fnc_MoneyDisplay)]);
	_Funds ctrlSetStructuredText (composeText ["Cash: ", lineBreak, [player getVariable "Funds"] call cfg_fnc_MoneyDisplay]); 
};
_Shop setVariable ["FNC",_UIfnc,true];
_Shop setVariable ["NATION",_Nat,true];
[
    _Shop,                                                                           // Object the action is attached to
    "Enter Armory",                                                                       // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",                      // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",                      // Progress icon shown on screen
    "_this distance _target < 3",                                                        // Condition for the action to be shown
    "_caller distance _target < 3",                                                      // Condition for the action to progress
    {},                                                                                  // Code executed when action starts
    {},                                                                                  // Code executed on every progress tick
    {[_caller,_target getVariable "NATION"] spawn (_target getVariable "FNC")},                                                // Code executed on completion
    {},                                                                                  // Code executed on interrupted
    [],                                                                                  // Arguments passed to the scripts as _this select 3
    2,                                                                                  // Action duration [s]
    0,                                                                                   // Priority
    false,                                                                                // Remove on completion
    false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd", 0, _Shop];            // example for MP compatible implementation

[
    _Shop,                                                                           // Object the action is attached to
    "Arsenal",                                                                       // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                      // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                      // Progress icon shown on screen
    "_this distance _target < 3",                                                        // Condition for the action to be shown
    "_caller distance _target < 3",                                                      // Condition for the action to progress
    {},                                                                                  // Code executed when action starts
    {},                                                                                  // Code executed on every progress tick
    {[_Caller,_This] call cfg_fnc_Arsenal},                                                // Code executed on completion
    {},                                                                                  // Code executed on interrupted
    [],                                                                                  // Arguments passed to the scripts as _this select 3
    2,                                                                                  // Action duration [s]
    0,                                                                                   // Priority
    false,                                                                                // Remove on completion
    false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd", 0, _Shop];            // example for MP compatible implementation