
_Secs  = param[0];
_lvl   = param[1]; 
_id    = param[3];
_Ind   = param[4];
_Aggs  = param[5];
_Trg   = param[6];
_Occup = zones param[_Ind] param[2];

/*------------------------------------------------------------------------
Nation check needed in DefineZones triggers condigion, Marker color should be 
gotten from array containing Nation Coulors(FrameWork done). Majority/Objective Based Determinance of who 
conqueres zone when multiple nations are present(WIP).

Objective control and dominance over zone required for capture.
if rivals can take over objectives and restart progress for their own
nation is TBD. HVTs are one time per init of zone, for fluidity of gameplay.(WIP)


countdown concept:

after line 24 args and commands:

_Timer = [_id,_lvl] spawn PI_fnc_ZoneTimer Countdown;
*Spawns global timer*(Almost done, WIP)

Objective Capture can only occur during two states:

1. When dominating the zone
2. When soldiers are undetected.

preliminary however! capture can only occure
when domination is present AND objectives taken.

Variable set to id should contain array with all attacking nations included in it.
Variable setting of simply inactive in ending is very usefuel, as all nations timers
will be reset, preventing captures from stacking.

If statement chekcing return value, if "FAILED" then 
exitWith {some hint about it being too late, retreat would be wise.}
if "SUCESS" then continue with capture script. Possible delay until next capture
Could be good in terms of gameplay. Forces enemies to truly struggle for first capture.
Reinforcment Certainly needs delay.

This script only needs to know WHO is dominating, not by how many.

Zone param[0] is sectors, param[4] is all included territory surrounding them.
------------------------------------------------------------------------*/
//Bottom part to count units in vehicles aswell, broken for some reason

systemChat "ZoneGuardian Activated!";
diag_Log "[---------------ZoneGuardian Activated!---------------]"; 

{
    _Unit = _x;
    if (!(_Unit iskindOf "Man")) then
	{
	    {
		    _Crew = _x;
            if (((_Crew getVariable "NATION") != _Occup) or !((_Crew getVariable "NATION") in ((missionNamespace getVariable _Occup) param[3]))) then 
	        {
			    if ((missionNamespace getVariable (_Crew getVariable "NATION") param[2] param[0]) + _Lvl <= ("MaxZone" call BIS_fnc_getParamValue)) then
				{
	                missionNamespace setVariable [_id,['ALERT',""]];
					
					if !(_Id in ((_Crew getVariable "NATION")param[2] param[1])) then
					{
						[_Crew,_Lvl,_Ind,true,""] call UTL_fnc_NationAOupdt;
					};
                }
                else
                {
                    systemChat "Your nation has too many active AOs, finish them before attacking more!";
				};			
 	        };
		} forEach (Crew _Unit);
	}
	else
	{
	    if (((_Unit getVariable "NATION") != _Occup) or !((_Unit getVariable "NATION") in ((missionNamespace getVariable _Occup) param[3]))) then 
	    {
	        if ((missionNamespace getVariable (_Unit getVariable "NATION") param[2] param[0]) + _Lvl <= ("MaxZone" call BIS_fnc_getParamValue)) then
		    {
	            missionNamespace setVariable [_id,['ALERT',""]];
                
				if !(_Ind in ((_Unit getVariable "NATION")param[2] param[1])) then
					{
						[_Unit,_Lvl,_Ind,true,""] call UTL_fnc_NationAOupdt;
					};
            }
            else
            {
			    systemChat "Your nation has too many active AOs, finish them before attacking more!";
            };			
 	    };
	};
} forEach _Aggs;

_FrstWve = [];
/*
_FrstWve = [];
{
    if (((_x getVariable "NATION") != _Occup) or !((_x getVariable "NATION") in ((missionNamespace getVariable _Occup) param[3]))) then 
	{
	    missionNamespace setVariable [_id,['ALERT',""]];
        _FrstWve append [_x]; 		
 	};
} forEach _Aggs;
*/

if ((missionNamespace getVariable _id) param[0] == 'ALERT') then 
{
    /*
    _AOpwr = missionNamespace getVariable _Occup;
    (_AOpwr param[2]) set [0,(_AOpwr param[2] param[0]) + _Lvl];
    (_AOpwr param[2] param[1]) append [_id];
    missionNamespace setVariable [_Occup,_AOpwr];
	*/
	[_Occup,_Lvl,_Ind,true,""] call UTL_fnc_NationAOupdt;
	
    {
		_Structs = nearestObjects [_x,["Building"],200];
		{_x setDammage 0;} forEach _Structs;
    } forEach _Secs;
	
	[_id,_lvl,_Trg,_Secs,_Occup,_Ind] call PI_fnc_ZonePopulation;
	
    _HanTime = "";
	_HanTime = [_id,_lvl,_Trg,_Secs,_Occup,_Ind] spawn PI_fnc_ZoneTracker;
	hint format ["UNDER ATTACK: Check [%1,%2]",_id,_lvl];
	
	[_id,_lvl,_Secs,_Occup,_FrstWve] spawn AMB_fnc_ZoneEnter;
	
	waitUntil { scriptDone _HanTime };
	_Capper = "";
    if ((missionNamespace getVariable _id) param[0] == "CAPTURED") then 
	{
	
	    _Capper = (missionNamespace getVariable _id) param[1];
        {
            _xCord = _x param[0];
            _yCord = _x param[1];

            _name = format ["Location: %1 %2",_xCord,_yCord];

            [_name,((missionNamespace getVariable _Capper) param[0])] remoteExec ["setMarkerColor",0,true];

        } forEach _Secs;
        (Zones param[_Ind]) set [2,_Capper];
        _Store = format ['[%1,%2,%3,%4,%5]',_Secs,_lvl,str _Capper,str _id,_Ind];
        _Trg setTriggerText _Store;
		
		//Former comment, other below buff was actual
		_TimeParam = "Occupation" call BIS_fnc_getParamValue;
        _Buff = ((_TimeParam * _Lvl) * 2) + _TimeParam;
		
//		_Buff = (_lvl * 1800) + 2100;
	    (format ["Zone Captured! Captured by %2, It used to be occupied by %1. Reinforcments inbound!",_Occup,_Capper]) remoteExec ["hint"];
        
		//Removing AO points from Defender, allowing for offensive if low enough. Might replace with timer
        //script that also. Currnt system: Buff + lowered points after attack, allowing for counter attack. if not facing overwhelming force.
		[_Occup,_Lvl,_Ind,false,false] call UTL_fnc_NationAOupdt;
        /*		
		_AOpwr = missionNamespace getVariable _Occup;
        _AOpwr param[2] set [0,(_AOpwr param[2] param[0]) - _Lvl];
		_IdGrp = _AOpwr param[2] param[1];
        _AOpwr param[2] param[1] deleteAt (_IdGrp find _id);
        missionNamespace setVariable [_Occup,_AOpwr];
		*/
		
		uiSleep _Buff;	
        missionNamespace setVariable [_id,'INACTIVE'];
		{
		    _Structs = nearestObjects [_x,[],200];
		    {_x setDammage 0;} forEach _Structs;
		} forEach _Secs;
		
		{ 
		    if (!(isplayer _x)) then 
			{ 
			    deleteVehicle _x
            };			
		} forEach allDead;
	} 
	else 
	{
	    hint format ["Zone Deactivated, Held by %1",Zones param[_Ind] param[2],_Ind];
    };	
} 
else 
{
	hint format ["Welcome to Zone %1, Controlled by %2",_id,_Occup];
};

 

/*
Possible return of array containing previous params, with the occup changed to capturing
Nation, and then storing it in the trigger text. making the activation script valid once again.
(Functonality pretty much accomplished above)
*/


/*-------------------------------------------------------------------------------------------------------

LEGACY SOLUTION UFN

_Activ   = param[0];
_Present = param[1];
_Trigger = param[2];

[_Activ,_Present,_Trigger] execFSM "bin\server\FSM\Zones\ZoneTriggers.fsm";

//Possible system using the FSM to determine side number based on Side controlled by Zone. Sub-Factions can take over friendly zones, if they wage war on them. Same goes for guerilla factions. 
-------------------------------------------------------------------------------------------------------*/
