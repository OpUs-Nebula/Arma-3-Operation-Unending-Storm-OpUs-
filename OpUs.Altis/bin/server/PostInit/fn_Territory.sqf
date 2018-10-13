//Calculates territory occupation based on distance from sector to block.
//_Root = "PI_fnc_Territory";
//_Info = "Cycle error??";
{
    _Block   = _x;
	//[distance,Index]
	_Closest = [0,0];
    {
	    _ZoneInd = _forEachIndex;
	    _Secs = _x param[0];
	    if (!(_Block in _Secs) && !(_Block in Sectors)) then 
		{
		    {
			    if (((_Block distance _x) <= _Closest param[0]) or (_Closest isEqualTo [0,0])) then 
				{
				    _Closest = [(_Block distance _x),_ZoneInd];
				};
			} forEach _Secs;
		};
	} forEach Zones;
	if (!(_Closest isEqualTo [0,0])) then 
	{
        if (isNil { Zones param[(_Closest param[1])] param[4] }) then
	    {
	        Zones param[(_Closest param[1])] append [[_Block]]; 
	    }
	    else
	    {
	        (Zones param[(_Closest param[1])] param[4]) append [_Block];
	    };
	};	
} forEach (MappedPos param[0] param[0]);