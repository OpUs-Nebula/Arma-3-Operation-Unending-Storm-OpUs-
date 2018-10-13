
_Id    = param[0];
_Lvl   = param[1];
_Trg   = param[2];
_Secs  = param[3];
_Occup = param[4];
_Objective = "STRATBUILD";

//ClassNames of buildings that can be converted into various objectives, mainly for HVTs and Search and Destroys
_Villas = ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F"]; 
_CompatBuilds = ["Land_MilOffices_V1_F",_Villas];
_Building = "";
_ChkdSctrs = [];

//Custom code for Scanning zones and interrupting upon find, instead of forEaching and ignoring
//Those who dont satisfie, hopefully saving memory and performance. might turn into generall
//Function, who knows.

while { (_Building isEqualTo "") && (count _ChkdSctrs != count _Secs) } do 
{
	_Tmp = selectRandom _Secs;
	if (!(_Tmp in _ChkdSctrs)) then 
	{
//      _DesBuild = selectRandom _CompatBuilds;
	    _DesBuild = _Villas;
	    _ChkdSctrs append [_Tmp];
	    _Ents = nearestObjects [_Tmp,["House"],200];		
		{ 
			if (_DesBuild isEqualType []) then 
			{
			    if ((typeOf _x) in _DesBuild) then
			    {
			        _Building = _x;
			    };
			}
			else
			{
			    if ((typeOf _x) == _DesBuild) then 
			    {
		            _Building = _x;
		        };
			};
		} forEach _Ents;
    };
};



_ret = "";
//An additional array needs implimenting after working test is done, containing all arrays bellow, but with labeling prior to selection for things such as vehicle depots, ATC population, hangers etc.
//EDIT TO TOP: WILL USE SEPARATE SECTIONS OF THE SCRIPT; DEPENDING ON LEVEL, RANDOM SEC ETC.
//CompatBuilds = Objective ScriptReturn, placeHolder already in this one for now.
//_Units should be selected from _Nation parameter. 
//GuardPositions and ItemPositions should be gathered from building params config, however,
//A problem regarding its treating of commas as ends of index element regardless of brackets,quotes etc,
//Might stop that from becoming a reality. Worst case fall back to return values from script function
//Including if statements adjusting return value dependant on Building, and then only
//Get Useful Info through params needed. Possibly setVariable for all AI left in zone past buffer = removed;

if (!(_Building isEqualTo "")) then {
    _Side  = (missionNamespace getVariable _Occup) param[4];
    _Fltrs = format ["( 
        (getNumber (_x >> 'scope') >= 2) && 
        {getNumber (_x >> 'side') == %1 && 
        {getText (_x >> 'vehicleClass') in ['Men'] 
            } 
        } 
    )",_Side];
	
	_Obj      = _Building;
	_Clss     = typeOf _Building;
    _Vars     = [_Clss] call cfg_fnc_BuildingParams;
	_GrdsExt  = _Vars param[0];
	_GrdsInt  = _Vars param[1];
	_Props    = _Vars param[2];
	_Furn     = _Vars param[3];
	_Supplies = _Vars param[4];
	_Intel    = _Vars param[5];
	_Units    = _Fltrs configClasses (configFile >> "CfgVehicles");
	_HVTclss  = (missionNamespace getVariable _Occup) param[5];
    _GrpSide  = "";
    switch (true) do {
	    case(_Side isEqualTo 0): { _GrpSide = east; };
		case(_Side isEqualTo 1): { _GrpSide = west; };
		case(_Side isEqualTo 2): { _GrpSide = independent; };
	};
	
	_FortGrps    = [_Obj,_GrdsExt,_GrdsInt,_Occup,_GrpSide,_Units,_Id,_Lvl] call SET_fnc_Guards;
	_InteriorGrp = _FortGrps param[0];
	_ExteriorGrp = _FortGrps param[1];
	
	[_Obj,_Id,_Props] call SET_fnc_Props; 
	[_Obj,_Units,_Id,_Occup,_InteriorGrp,_Furn] call SET_fnc_Furniture;
	[_Obj,_Intel,_Id,_Lvl,_Occup] call SET_fnc_Intel;
	[_Obj,_Intel,_Id,_Lvl,_Occup] call SET_fnc_Supplies;
	
	

	
	_ret = "true";	
} else {_ret = "false";};

if (_ret == "true") then {hint format ["%1 Building populated! Now find it, sucker...",_Building];} else {hint "Error: No Compatible Building Found";};

//Desig should be variable attached to vehicle, ie final point, data terminal etc, and have the same value
//as Desig.
//Ending script, adding to objective count when completed.
/*
_Cnt = (MissionNamespace getVariable _Desig) - 1;
MissionNamespace SetVariable [_Desig,_Cnt];
*/