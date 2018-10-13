/*
Had a short issue with territory changes propagating to all nations, init didnt just add
all territory to AAF nation, but all of the nations. redeclaring each variable before 
using setVariable in this script was critical in allowing independant redeclaring variables
inside of the arrays later on.

*/

//missionNamespace setVariable [_NATION,[MARKERCOLOR,HQWORLD,ACTIVEZONES[Zones index,_Lvl],ALLIED NATIONS]];
_RES  = param[0];
_NAT  = param[1];
_CST  = param[2];

//GDP stored in millions(Multiply by 1000000)

//_HstGDP    = ("HostGDP" call BIS_fnc_getParamValue) * 1000000;
//_InvGDP    = ("InvadGDP" call BIS_fnc_getParamValue) * 1000000;
_HstGDP    = 0;
_InvGDP    = 0;

//BROADCAST ACTIVEZs, if necassary the whole variable, avoid if possible.
//EDIT// using index of zones variable instead.
_ToDB = [];

//GUERILLA SETUP
_Desig   = "colorIndependent";
_HQworld = "";
_ActiveZ = [0,[]];
_Allies  = [_RES];
_ConSide = 2;
_Bases   = [];
_HVT     = "I_G_officer_F";
_Flag    = "\A3\Data_F\Flags\Flag_AAF_CO.paa";
_Territory = [];
missionNamespace setVariable [_RES,[_Desig,_HQworld,_ActiveZ,_Allies,_ConSide,_HVT,_HstGDP,_Territory,_Flag],true];

//BLUFOR SETUP
_Desig   = "colorBLUFOR";
_HQworld = "";
_ActiveZ = [0,[]];
_Allies  = [_NAT];
_ConSide = 1;
_Bases   = [];
_HVT     = "B_officer_F";
_Flag    = "\A3\Data_F\Flags\Flag_nato_CO.paa";
_Territory = [];
missionNamespace setVariable [_NAT,[_Desig,_HQworld,_ActiveZ,_Allies,_ConSide,_HVT,_InvGDP,_Territory,_Flag],true];

//OPFOR SETUP
_Desig   = "colorOPFOR";
_HQworld = "";
_ActiveZ = [0,[]];
_Allies  = [_CST];
_ConSide = 0;
_Bases   = [];
_HVT     = "O_officer_F";
_Flag    = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
_Territory = [];
missionNamespace setVariable [_CST,[_Desig,_HQworld,_ActiveZ,_Allies,_ConSide,_HVT,_InvGDP,_Territory,_Flag],true];

["NATO",FOB1_WEST] call BAS_fnc_BasePop;
["CSAT",FOB1_EAST] call BAS_fnc_BasePop;
["AAF",FOB1_GUER] call BAS_fnc_BasePop;

{
    _x setVariable ["Name","FOB1",true];
} forEach [FOB1_EAST,FOB1_GUER,FOB1_WEST];

_ToDB = [];
{
    _ToDB append [[_x,missionNamespace getVariable _x]];
} forEach [_RES,_CST,_NAT];

[["worldname",worldname],"nations",_ToDB,"worlds"] call DBS_fnc_SetData;
