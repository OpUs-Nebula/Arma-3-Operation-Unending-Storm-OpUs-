
_Secs  = param[0];
_lvl   = param[1]; 
_Occup = param[2];
_id    = str (random 999999);
_Ind   = param[3];
systemChat "DefineZones Activated!";
diag_Log "[---------------DefineZones Activated!---------------]"; 

while {(_id in ZoneIDs)} do {_id = str (random 999999);};

ZoneIDs append [_id];

missionNamespace setVariable [_id, 'INACTIVE'];

GLOBALFKNSTR = "CNTSHT";

//function to check if playerNation is allied with Nation occupying probably needed.

//This used as default Trigger statement condition.

//Bool = ((missionNamespace getVariable _id) == 'INACTIVE');
{
    _Store = format ['[%1,%2,%3,%4,%5]',_Secs,_lvl,str _Occup,str _id,_Ind];
    _trg = createTrigger ["EmptyDetector",_x,true];
	_trg setTriggerText _Store;
    _trg setTriggerArea [200,200, 0, true];
    _trg setTriggerActivation ["ANY", "PRESENT", false];
    _trg setTriggerStatements ["([ThisList,ThisTrigger] call PI_fnc_DynTrig) && (missionNamespace GetVariable ((parseSimpleArray (triggerText thisTrigger)) param[3]) isEqualTo 'INACTIVE')",
	                           "_Fin = parseSimpleArray (triggerText thisTrigger); 
							    _Fin append [ThisList];_Fin append [thisTrigger]; 
								_Fin spawn PI_fnc_ZoneGuardian;",
							   "hint 'Why?..1+1+1'"];
} forEach _Secs;

//Maybe start timer until deactivation of zone in third section of statements?
/*
Test:
If variables are updated upon trigger launch, ie not using values inputed at time of statement
declaration, then all triggers should desplay the same id. or not display anything...(Result!) 

if they indeed only use what has been supplied to them at the time of declaration, then
they should all display different values on id.


All triggers need their _Occups changed, only occurs at trigger level.//FIXED THROUGH HANDCRAFTED EH INSIDE SCRIPTS//
*/