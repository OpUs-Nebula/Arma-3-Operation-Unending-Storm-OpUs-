/*---------------------------------------------------------------------------
-----------------------------------------------------------------------------
Script for Scanning map for locations containg buildings        -------------
(Ie Villages, Towns, Cites) By Nebula                           -------------
																-------------
fn_ScanMap														-------------
																-------------
																-------------
																-------------
																-------------
-----------------------------------------------------------------------------
---------------------------------------------------------------------------*/

Sectors = [];

_MappedPos = [mapped positions];

//_Ents = nearestObjects in mapped position, 2D mode if possible, 300m radius
 
_BuildingCount = 0;
{
  _Ents = count (nearestObjects [_x, ["Building"], 300]);
  _BuildingCount = _Ents; 
 if (_BuildingCount > 30) then 
  {
    Sectors append _x;
  };
} forEach _MappedPos;

{
[_x] spawn server_fnc_SpawnMarkers;
} forEach Sectors;