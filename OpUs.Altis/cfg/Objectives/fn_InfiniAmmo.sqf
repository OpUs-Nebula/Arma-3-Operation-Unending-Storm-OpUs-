params ["_Unit"];

_Unit addEventHandler   
["Reloaded", 
{
    _Ent = param[0]; 
    _MagInf = param[3]; 
    _OldMag = param[4] param[1]; 
    _Mag = _MagInf param[0]; 
    _Ent addItem _Mag;
	if !(_OldMag isEqualTo 0) then
	{
        _Ent removeItem _Mag;
//Debug		hint str !(_OldMag isEqualTo 0);
    };
//Debug    hint str !(_OldMag isEqualTo 0);	
} 
]; 