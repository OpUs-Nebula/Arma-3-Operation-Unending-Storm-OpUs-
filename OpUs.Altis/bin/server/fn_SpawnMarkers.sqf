/*---------------------------------------------------------------------------
-----------------------------------------------------------------------------
Script for Marking Positions of viable locations                -------------
(Ie Villages, Towns, Cites) By Nebula                           -------------
                                                                -------------
fn_SpawnMarkers													-------------
																-------------
																-------------
																-------------
																-------------
																-------------
-----------------------------------------------------------------------------
---------------------------------------------------------------------------*/

//_CheckPos = param[0];
_tmp = param[0];
_Color = param[2,"colorIndependent",[""]];
if (_tmp isEqualType []) then
{
    {
	    _xCord = _x param[0];               
		_yCord = _x param[1];		   
				   
		//_MarkerPos = [_CheckPos param[0],_CheckPos param[1]];		   
		_name = format["Location: %1 %2",_xCord,_yCord];		   
				   
		_marker = createMarker [_name,[_xCord,_yCord]];		   
		_marker setMarkerShape "RECTANGLE";		   
		_marker setMarkerSize [200,200];		   
		_marker setMarkerColor _Color;		         
	} forEach _tmp;
}
else
{
    _xCord = param[0];
    _yCord = param[1];
    
    //_MarkerPos = [_CheckPos param[0],_CheckPos param[1]];
    _name = format["Location: %1 %2",_xCord,_yCord];
    
    _marker = createMarker [_name,[_xCord,_yCord]];
    _marker setMarkerShape "RECTANGLE";
    _marker setMarkerSize [200,200];
    _marker setMarkerColor _Color;
};