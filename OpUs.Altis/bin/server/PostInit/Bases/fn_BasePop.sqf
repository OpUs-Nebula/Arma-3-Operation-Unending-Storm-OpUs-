
hint "Script starting! time for side declaring...";
params ["_Nat","_Fort"];
private ["_GrpSide"];

//To be replaced with condition checking if owned territory = 0, then FOB1 can be destroyed.
_Fort allowDamage false;

    _Side  = (missionNamespace getVariable _Nat) param[4];
    _Fltrs = format ["( 
        (getNumber (_x >> 'scope') >= 2) && 
        {getNumber (_x >> 'side') == %1 && 
        {getText (_x >> 'vehicleClass') in ['Men'] 
            } 
        } 
    )",_Side];
    _Units = _Fltrs configClasses (configFile >> "CfgVehicles");
	
    switch (true) do {
	    case(_Side isEqualTo 0): { _GrpSide = east; };
		case(_Side isEqualTo 1): { _GrpSide = west; };
		case(_Side isEqualTo 2): { _GrpSide = independent; };
	};	
hint "Sides declared, time for params...";

(_Fort call CFG_fnc_BaseParams) params 
[
    "_GrdsExt",
    "_GrdsInt",
    "_Supplies",
    "_Furn",
    "_Props",
    "_Intel",
    "_HVTpos",
    "_Flips",
    "_FstDwn"];
hint "Params declared, time for action...";

[_Side,_GrpSide,_Units,_Nat,_Fort,_GrdsExt,_GrdsInt,_HVTpos,_Furn] call BAS_fnc_Staff;
[_Fort,_FstDwn,_Flips,_Props,_Nat] call BAS_fnc_Decs;
//if (("VisResc" call BIS_fnc_getParamValue) isEqualTo 1) then {[_Fort,_Supplies,_Nat] spawn BAS_fnc_BaseStorage;};
[_Fort,_Intel,_Nat] call BAS_fnc_IntelObjs;

hint "Done!";
