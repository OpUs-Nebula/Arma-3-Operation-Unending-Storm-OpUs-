params ["_id","_lvl","_Trg","_Secs","_Occup","_Ind"];

//USE ID for identfying for which units to merge into super group, when group count approaches
//Limit set in mission Params or description.ext for server owners. While script updating every 10-20s
//keeping track. use _Trg to determine are where enemies enter, maybe avoid spawn inside of it?
//If yes, remove it from temp array with all secs to populate.

//TEMP UNIT GEAR SELECTION//
_GerData = ([_Occup] call cfg_fnc_BaseLoadouts) param[0];

_RflMn  = _GerData param[0];
_SfGrd  = _GerData param[1];

_LndVics = ([_Occup] call cfg_fnc_VehicleParams) param[0];

_VehTrs = ["Light","Medium","Heavy"];
_VehSel = [[],0];

_UnitCnt = 0;
//0 = Allowed Tiers, ei range of selection, 1 = convoy size//


/*
//Removing enter area//
_LocDB = _Secs;
_LocDB deleteAt 
*/
_SqdCnt = 0;
_SqdPwr = 0;

_Distb  = "";

//WHY dis numbers? kavala = 68 secs,_Lvl 4 => total soldiers = _SqdCnt * _SqdPwr,  ceil (68 / 10) * ceil ((7 / 2) * 4) = 98.
//TLDR: PERFORMANCE. We Want Many Active Zones possible.
/*
Lvl 1 = SecCount 1-7,

ceil ((1-7) / 10) = 1;

ceil (7/2 * 1) = 5;

floor ((1-7) / 1) = 1-7

*/

if (_Lvl >= 1) then 
{
    _SqdCnt = ceil (count _Secs / 10);
	_SqdPwr = ceil ((7 / 2) * _Lvl);
	_Distb  = true;
    (_VehSel param[0]) append (_VehSel select [0,(_Lvl - 1)]);
	
	if (_Lvl isEqualTo 1) then
	{
	    _VehSel set [1,_Lvl];
	}
	else
	{
	    _VehSel set [1,(_Lvl - 2)];
	};
}
else
{
    _SqdCnt = count _Secs;
	_SqdPwr = 5;
	_Distb  = false;
};

_SideData = [_Occup] call UTL_fnc_GetSide;

_GrpSide = _SideData param[0];
_Units   = _SideData param[1];

_Qdrnts  = [];
if (_Distb) then
{
    _Bas   = floor (count _Secs / _SqdCnt);
	_Rem   = (count _Secs) mod _SqdCnt;
	
	_Dump  = [];
	for "_i" from 0 to ((count _Secs) - 1) do
	{
	    _Add = "";
	    if (_i <= (_Rem - 1)) then
		{
		    _Add = 1;
		}
		else
		{
		    _Add = 0;
		};
		
		if (count _Dump < _Bas + _Add) then
		{
		    _Dump append [_i];
			if (_i isEqualTo (count _Secs) - 1) then
            {
			    _Qdrnts append [_Dump]; 
            };			
		}
		else
		{
		    _Qdrnts append [_Dump];
			_Dump = [];
			_Dump append [_i];
		};
	};
	systemChat format ["QDRNT SRCH DVSN: %1",_Qdrnts];
	systemChat format ["ZNS INDEX: %1",_Ind];
}
else
{
    {
	    _Qdrnts append [_foreachindex];
	} forEach _Secs;
	systemChat format ["QDRNT SRCH DVSN: %1, DISTRIUBUTED SRCH = FALSE, SECS: %2",_Qdrnts, count _Secs];
	systemChat format ["ZNS INDEX: %1",_Ind];
};

for "_A" from 0 to (_SqdCnt - 1) do
{
    _SqdArea = "";
	_SqdPos  = [];
    if(_Distb) then
	{
	    _SqdArea = _Qdrnts param[_A];
        _SqdPos  = _Secs param[_SqdArea param[0]];		
	}
	else
	{
	    _SqdArea = _Qdrnts;
        _SqdPos  = _Secs param[_SqdArea param[_A]]; 		
	};
	
    _Grp = createGroup [_GrpSide,true];

	for "_i" from 1 to _SqdPwr do
	{
	    
	    _Unit = _Grp createUnit [(configName (selectRandom _Units)),_SqdPos,[],0,"FORM"];
		_Unit setVariable ["NATION",_Occup];
	    [_unit,_Id,_Lvl] spawn PI_fnc_Resistance;
	    [_Unit,_RflMn] call PI_fnc_AiLoadout;
	    [_Unit] call PI_fnc_setSkill;
	    [_Unit] call cfg_fnc_infiniAmmo;
		
		_UnitCnt = _UnitCnt + 1;
	};
	
	
	if(_Distb) then
	{
	    _VehArr = [];
	    _VehGrp = createGroup [_GrpSide,true];
        _VehPos = _SqdPos;		
        for "_v" from 0 to (_VehSel param[1]) do
        {
		    _Dta  = (selectRandom _LndVics); 
		    _Veh  = (_Dta param[0]) createVehicle _VehPos;
			_VehPos = _Veh modelToWorld [0,20,0];
			
		    _VehArr append [[_Veh,_Dta]];
		};
            {
			    _Veh = _x param[0];
				_Veh setVariable ["NATION",_Occup];
				_Veh setVariable ["DATA",_x param[1]];
				_Veh setVariable ["DAMAGE",0];
				_Veh addEventHandler ["killed",{[_This,"killed",(_This param[0]) getVariable "DATA"] spawn EH_fnc_OnKillDam;}];
				_Veh addEventHandler ["Hit",{[_This,"Hit",(_This param[0]) getVariable "DATA"] spawn EH_fnc_OnKillDam}];
			    {
				    _Sts = _Veh emptyPositions _x;
					while {_Sts > 0} do
					{
					    _Crw = _VehGrp createUnit [(configName (selectRandom _Units)),_SqdPos,[],0,"FORM"];
					    _Crw setVariable ["NATION",_Occup];
					    [_Crw,_Id,_Lvl] spawn PI_fnc_Resistance;
					    [_Crw,_RflMn] call PI_fnc_AiLoadout;
					    [_Crw] call PI_fnc_setSkill;
					    [_Crw] call cfg_fnc_infiniAmmo;
			            _Crw moveInAny _Veh;
					    _Sts = _Sts - 1;
					};
				} forEach ["Commander","Driver","Gunner","Cargo"];
            } forEach _VehArr;
		{
		    _Pos = _Secs param[_x];		
		    _WP  = _VehGrp addWaypoint [_Pos,200];
		    [_WP,"MOVE","LIMITED"] call AI_fnc_SetWaypoint;
		    if (_foreachindex isEqualTo (count _SqdArea - 1)) then
		    {
			    _Beg = _Secs param[0];
			    _Nd  = _VehGrp addWaypoint [_Pos,200];
			    [_Nd,"CYCLE","LIMITED"] call AI_fnc_SetWaypoint;
		    }; 			
		} forEach _SqdArea;
		
		_Vehs = [];
		{
		    _Vehs append [_x param[0]];
		} forEach _VehArr;
		
		[_VehGrp,_Vehs] spawn AI_fnc_CombEject;
    };		
	{
        _Pos = _Secs param[_x];		
	    _WP  = _Grp addWaypoint [_Pos,200];
        [_WP,"MOVE","LIMITED"] call AI_fnc_SetWaypoint;
        if (_foreachindex isEqualTo (count _SqdArea - 1)) then
        {
		    _Beg = _Secs param[0];
		    _Nd  = _Grp addWaypoint [_Pos,200];
		    [_Nd,"CYCLE","LIMITED"] call AI_fnc_SetWaypoint;
        }; 			
    } forEach _SqdArea;
    _Grp setBehaviour "SAFE";		
};
/*
if (_Lvl isEqualTo 0) then
{
    {
	    _Pos = _x;
		[_Pos,_Occup,""] spawn UTL_fnc_PopulBuil;
	} forEach _Secs;
};
*/