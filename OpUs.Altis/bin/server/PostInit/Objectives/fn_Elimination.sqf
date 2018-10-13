
/*-----------------------------------------------------------------
HVT ELIMINATION                                          ----------
                                                         ----------
Made by: OpUs-Nebula                                     ----------
-----------------------------------------------------------------*/
_Id    = param[0];
_Lvl   = param[1];
_Trg   = param[2];
_Secs  = param[3];
_Occup = param[4];
_Objective = "ELIM";

//ClassNames of buildings that can be converted into various objectives, mainly for HVTs and Search and Destroys 
_CompatBuilds = ["Land_i_House_Big_01_V1_F"];
_Building = "";
_ChkdSctrs = [];

//Custom code for Scanning zones and interrupting upon find, instead of forEaching and ignoring
//Those who dont satisfie, hopefully saving memory and performance. might turn into generall
//Function, who knows.
while {_Building isEqualTo ""} do {
	_Tmp = selectRandom _Secs;
	if (!(_Tmp in _ChkdSctrs)) then {
	    _ChkdSctrs append [_Tmp];
	    _Ents = nearestObjects [_Tmp,["House"],200];		
		{ 
		    if ((typeOf _x) in _CompatBuilds) then {
		       _Building = _x;
		    };
		} forEach _Ents;
    };
};



_ret = "";
//An additional array needs implimenting after working test is done, containing all arrays bellow, but with labeling prior to selection for things such as vehicle depots, ATC population, hangers etc.
//EDIT TO TOP: WILL USE SEPARATE SECTIONS OF THE SCRIPT; DEPENDING ON LEVEL, RANDOM SEC ETC.
//CompatBuilds = Objective ScriptReturn, placeHolder already in this one for now.
//_Units should be selected from _Nation parameter. 


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
	_HVTpos   = _Vars param[6];
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
	[_Obj,_Units,_Id,_Occup,_InteriorGrp,_Furn] call SET_fnc_Furniture;;
	[_Obj,_HVTpos,_GrpSide,_Occup,_Id,_Lvl] call SET_fnc_HvT;
	
	_ret = "true";	
} else {_ret = "false";};


if (_ret == "true") then {hint format ["%1 Building populated! Now find it, sucker...",_Desig];} else {hint "Error: Building incompatible";};
_ret




//Thought Process
/*----------------------------------------------------------------------------------------------
IDEA SKELETON:

Parameters of Extractor:
Param[0] = Desc of Position, param[1] = ModelToWorld offset, param[2] =
Relative Direction, _Dir of building unit is placed at needs adding.
 
if {_Building in _CompatBuilds) then {...code... _ret = true} else {_ret = false};


//if _ret = false, then script that called should keep searching area for compatible buildings. 
_ret

//For getting relPos
_nBuilding = Building selected;
_dir = getDir _nBuilding; 
_MtW = nBuilding worldtoModel (getPos this);
 
//for setting down at relPos
_Grd setPos (_nBuilding modelToWorld _MtW);
_guardDir = selected dir of position - original building dir.

offset = _GrdPos;  
RelDir = (getDir this) - (getDir _nBuilding);

//Relative Dir formula
(_guardDir + _dir)


_nBuilding = nearestBuilding this; 
_Typ = TypeOf _nBuilding; 
hint format ["ExtGuard is near %1! and is %2m away from you!",_Typ,(this distance2D player)];


//example
offset = Ref1 worldToModel position player; 
RelDir = (getDir player) - (getDir Ref1); 
player setPos (Ref2 ModelToWorld offset); 
player setDir (RelDir + (getDir ref2));

//Extractor FrameWork, Add to unit init for collection of unit/Object positions and directions for use in objectives
nBuilding = nearestBuilding this; MtW = nBuilding worldtoModel (getPos this); 
hint str MtW; 
offset = nBuilding worldToModel position this;  
RelDir = (getDir this) - (getDir nBuilding); 
if (isNil "Extractor") then {  
    Extractor = [];  
    Extractor append [["ExtSit1",MtW,RelDir]]; 
} else { 
Extractor append [["ExtSit1",MtW,RelDir]]; 
};
----------------------------------------------------------------------------------------------*/