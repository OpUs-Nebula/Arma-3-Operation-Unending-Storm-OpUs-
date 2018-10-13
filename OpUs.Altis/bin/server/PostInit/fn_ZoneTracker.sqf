

//Might use _Ret here in the future aswell, for sending some kind of information with regard to loss of zone or failure to capture.
scopeName "Main";
_Id    = param[0];
_Lvl   = param[1];
_Trg   = param[2];
_Secs  = param[3];
_Occup = param[4];
_Ind   = param[5];

_ObjDes  = format ["[%1,%2]",_Id,"OBJ"];
if (isNil {missionNamespace getVariable _ObjDes}) then {
    _ObjHand = [_id,_lvl,_Trg,_Secs,_Occup] spawn PI_fnc_ObjectiveCreator;
	waitUntil { scriptDone _ObjHand };
	missionNamespace setVariable [_ObjDes,true];
};

_Boot = 0;
_TimeHand = "";
_Ret = ""; 
while {((missionNamespace getVariable _id) param[0] == 'ACTIVE') or ((missionNamespace getVariable _id) param[0] == 'ALERT')} do 
{    
    _Desig  = "";
	_DomBef = (missionNamespace getVariable _id) param[1];
    _Ents   = [];
    _Parts  = [];
    {
	    _Frsh = (_x nearEntities ["AllVehicles", 283]);
		{
		    _Unit = _x;
			if (_Unit isKindOf "Man") then 
			{
		        if !(_Unit in _Ents) then {_Ents append [_x]};
			}
			else
			{
			    {
			        if (((_x isKindOf "Man") && (Alive _x)) && !(_x in _Ents)) then 
				    {
				       _Ents append [_x];
				    };
				} forEach (Crew _Unit);
			};
        } forEach _Frsh;			
	} forEach _Secs;

    
//	{_Ents append (_x nearEntities ["Man", 200]);} forEach _Secs;

    if (count _Ents > 0) then {	
        {
		    if (!isNil {_x getVariable "NATION"}) then 
			{
	            _Rep = _x getVariable "NATION";
		        if (!(_Rep in _Parts)) then 
			    {
			     _Parts append [_Rep,1];
		        } 
			    else 
			    {
		            _Loc = (_Parts find _Rep) + 1;
		            _Val = _Parts param[_Loc];
		            _Parts set [_Loc,_Val + 1];			
		        };
            } 
			else
            {
			    _Data = [(typeOf _x),(side _x),(getPosATL _x), _x];
				_Info = "Unit Nation is nil";
				_Root = "PI_fnc_ZoneTracker";
				
				[_Data,_Root,_Info,true] call DEV_fnc_rptDump;
            };			
        } forEach _Ents;	
	    _DomNat = _Parts param [(_Parts find (_Parts call BIS_fnc_greatestNum)) - 1];
	    _Desig = format ["[%1,%2,%3]",_Id,_Lvl,_DomNat];
	
	    if (!(_DomNat == _DomBef)) then {
	        missionNamespace setVariable [_id,['ACTIVE',_DomNat]];
	        if ((isNil {missionNamespace getVariable _Desig}) && (_DomNat != _Occup)) then {		
	            _TimeHand = [_Id,_Lvl,_DomNat,_Occup,_Ind] spawn PI_fnc_ZoneTimer;
                hint format ["UNDER ATTACK: Check [%1,%2,%3]",_id,_lvl,_DomNat];	
					
	        };
	    };
    };	
    sleep 5;	
};
missionNamespace setVariable [_ObjDes,nil,true];	


