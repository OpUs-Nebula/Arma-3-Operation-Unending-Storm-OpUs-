
_Id    = param[0];
_Lvl   = param[1];
_Trg   = param[2];
_Secs  = param[3];
_Occup = param[4];
 
_Elim    = compile "[_id,_lvl,_Trg,_Secs,_Occup] spawn OBJ_fnc_Elimination;";
_CommDis = compile "[_id,_lvl,_Trg,_Secs,_Occup] spawn OBJ_fnc_CommDisrupt;";
_Sabo    = compile "[_id,_lvl,_Trg,_Secs,_Occup] spawn OBJ_fnc_Sabotage;";
_Strat   = compile "[_id,_lvl,_Trg,_Secs,_Occup] spawn OBJ_fnc_StrategicBuilding;";

//Un-Comment when all modes have been made functional, at least for lvl 1(Zaros testing area), 
//selects random objective for capture. Elim, Strat available.
 /*-------------------------------------------------------------------------------------
 _TskCnt = _Lvl;
 _Pool   = [_Elim,_CommDis,_Strat];
if (_TskCnt > 0) then {
    _Coming = [];
    while { count _Add < _TskCnt } do {
	    _Nukes = selectRandom _Pool;
		if (!(_Nukes in _Coming) && (_TskCnt <= 3)) then {
		    _Coming append [_Nukes];
		} else {
		//Just stay calm, everything will be all..........WHO THE FUCK AM I KIDDING!?!?!? FUCKING RUN DUDE!!!!!!!
        };
        if (((_TskCnt > 3)) && !((_Nukes == _CommDis) && (_Nukes in _Coming))) then {
		_Coming append [_Nukes];
		};	
	};
	MissionNamespace SetVariable [_Desig,_TskCnt];
	{call _x} forEach _Coming;
} else {
    MissionNamespace SetVariable [_Desig,_TskCnt];
}; 
-------------------------------------------------------------------------------------*/


call _Strat;

