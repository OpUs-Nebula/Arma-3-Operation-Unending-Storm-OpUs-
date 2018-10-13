
params ["_id","_lvl","_Secs","_Occup","_FrstWve"];
//Music = index is level, first is day music, second is night music.
sleep 4;

_Attckrs = [];
_Defndrs = [];

//Since songs might aswell be the same atm. All players array from which music targets are selected.
_AcPlrs  = [];

_Music   = [["BackgroundTrack02_F_EPC","BackgroundTrack04_F_EPC"],
            ["LeadTrack02_F_Mark","AmbientTrack02a_F_Tacops"],
			["EventTrack03_F_EPA","LeadTrack03a_F_EPB"],
			["LeadTrack03_F","LeadTrack05_F"],
			["LeadTrack01_F_EXP","LeadTrack02_F_EXP"]];
			

//Whole mission broke after adding code below, might need backtracking to see if this truly was the issue. 
//Had just taken out headphones and shutdown via task manager prior though.
//(EDIT: was fixed after letting it load once, then restarting. might be an issue worth investegating later.
 if (_lvl < 3) then 
{
//    [(_Music param[_lvl] param[0])] remoteExec ["playMusic",0];
	
	{
		_Ents = _x nearEntities ["AllVehicles", 283];
		{
            _Veh = _x;
            if (_Veh isKindOf "Man") then 
			{			
			    if (isPlayer _Veh) then 
		        {
                    _Nat = _Veh getVariable "NATION";			
			        if !((_Nat == _Occup) or (_Veh in _Attckrs)) then
			    	{
			    	    _Attckrs append [_Veh];   
			    	};
			    	
			    	if ((_Nat == _Occup) && !(_Veh in _Defndrs)) then
			        {
			    		_Defndrs append [_Veh];
			        };
                };
        	}
            else
            {       
			    {
                    if (isPlayer _x) then 
				    {
			            _Nat = _x getVariable "NATION";			
			            if !((_Nat == _Occup) or (_x in _Attckrs)) then
			        	{
			        	    _Attckrs append [_x];   
			        	};
			        	
			        	if ((_Nat == _Occup) && !(_x in _Defndrs)) then
			            {
			        		_Defndrs append [_x];
                        };
                    };
			    } forEach (crew _Veh);
            };			
		} forEach _Ents;
	} forEach _Secs;
	    _AcPlrs append _Attckrs;
	    _AcPlrs append _Defndrs;
	{
	    _Nat = _x getVariable "NATION";
        switch (true) do 
		{
	        case(_Nat == _Occup): 
			{
				if ((DayTime < 4) or (DayTime > 20)) then 
				{    
					[(_Music param[_lvl] param[1])] remoteExec ["playMusic",_x];
				}
				else
				{
					[(_Music param[_lvl] param[0])] remoteExec ["playMusic",_x];
				};
		    };
		
		    case(_Nat != _Occup): 
			{
				if (DayTime < 4 or DayTime > 20) then 
				{    
					[(_Music param[_lvl] param[1])] remoteExec ["playMusic",_x];
				}
				else
				{
					[(_Music param[_lvl] param[0])] remoteExec ["playMusic",_x];
				};
		    };
        };
    } forEach _AcPlrs;			
}
else
{
/*
    if (_lvl <= 4) then 
	{    
	    {
	        _Player  = _x;
            _Nat     = _x getVariable "NATION";
	        _Present = false;
	
	    } forEach (allPlayers - entities "HeadlessClient_F");
	}
	else
	{
	};
*/
};
