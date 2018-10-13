/*---------------------------------------------------------------------------
-----------------------------------------------------------------------------
Script for Scanning map for locations containg buildings        -------------
(Ie Villages, Towns, Cites) By Nebula                           -------------
																-------------
fn_Init														    -------------
																-------------
																-------------
																-------------
																-------------
-----------------------------------------------------------------------------
---------------------------------------------------------------------------*/

//Array of zones unique IDs used in DefineZones for Zone Sorting
ZoneIDs = [];


//Getting Map Borders
MapLimNE = position BorderNE;
MapLimSE = position BorderSE;
MapLimSW = position BorderSW;
MapLimNW = position BorderNW;

XBord = [MapLimSW param[0],MapLimSE param[0]];
YBord = [MapLimSW param[1],MapLimNW param[1]];

Sectors = [];

MappedPos =  [[XBord,YBord] call server_fnc_WorldScan];

//Ents = nearestObjects in mapped position, 2D mode if possible, 400m radius

MasterPos = MappedPos param[0] param[0];
//Prev NearRadius: 400

{
    _Pos = _x;
    _BuildingCount = 0;
    _Ents  = nearestObjects [_Pos,["Building"], 400];		
    _Popul = count _Ents;
    _BuildingCount = _BuildingCount + _Popul; 
        if (_BuildingCount > 60) then 
        {
          Sectors append [_Pos];
        };
} forEach MasterPos;


{_x remoteExec ["server_fnc_SpawnMarkers", 0, true];} forEach Sectors;

Zones = [];
//ZoneBorders = Zones param [_i] param[1];
_GrpBrk = (Count Sectors) - 1;
_CntedSctrs = [];

For "_i" from 0 to _GrpBrk do 
{
    _ChekSector = [Sectors param[_i]];
    _Pos = _ChekSector param[0];
    _Neighbors = [];
    _Zone = [[]];
	_BoolRet = [];	
//Creating of first set of neighbors, near the first selected sector.	
	    {
            if (((((_Pos) distance2D (_x)) <= ((sqrt 2) * 420)) && ((_Pos) distance2D (_x) >= (400)))) then 
			{
                _Neighbors append [_x];
	        }; 
        } forEach Sectors;
	 
	
//Checking for bordering sectors, if 0 then turn into zone, otherwise cluster them into one big zone.
	
    if ((count _Neighbors) >= 1) then 
	{
	
//_CrntPos == selection from _Neighbors using forEach, cycles through neighbors adding sectors and counting until number of sectors before cycle == number of sectors after.
        _cBef = 0;
        _cAft =	1;
        while {!(_cBef == _cAft)} do	
	    { 	 
	        _cBef = count _Neighbors;		
            {
                _CrntPos = _x;		
                {
                    if (!(_Pos isEqualTo _x) && ((((_CrntPos) distance2D (_x)) <= ((sqrt 2) * 420)) && (( _CrntPos) distance2D (_x) >= (400))) && !(_x in _Neighbors)) then 
				    {		
                        _Neighbors append [_x];
	                };				
                } forEach Sectors;			
		    } forEach _Neighbors;		
            _cAft = count _Neighbors;		
	};
    {
        if (_x in _CntedSctrs) then {_BoolRet append [true];};
    } forEach _Neighbors;		
	    if (!(_ChekSector param[0] in _CntedSctrs) && !(true in _BoolRet)) then 
		{
		    _CntedSctrs append _ChekSector;
			_CntedSctrs append _Neighbors;
		    _Zone param[0] append _Neighbors;
            _Zone param[0] append _ChekSector;
			
			_Ind = (count Zones);
            _Cnt = Count (_Zone Param[0]);	
		    _Lvl = floor (ln _Cnt);
	        _Zone append [_lvl];
  			_Zone append [Nations param[0],_Ind];
			_Zone spawn server_fnc_DefineZones;
			
            Zones append [_Zone];
        };		
    } else {
	    _Zone param[0] append _ChekSector;
		
		_Ind = (count Zones);
        _Cnt = Count (_Zone Param[0]);	
		_Lvl = floor (ln _Cnt);
	    _Zone append [_lvl];
  		_Zone append [Nations param[0],_Ind];
		_Zone spawn server_fnc_DefineZones;
			
        Zones append [_Zone];	
	};
};

HandTerr = [] spawn PI_fnc_Territory;

waitUntil { scriptDone HandTerr };

//Territory stored in Namespace(probably never again, just indexes instead):
/*
{

    _Terr = [];
    _Terr append (_x param[0]);
	_Terr append (_x param[4]);
	_Occup = missionNamespace getVariable "AAF";
	(_Occup param[7]) append _Terr;
	missionNamespace setVariable ["AAF",_Occup];


_Occup = missionNamespace getVariable "AAF";
(_Occup param[7]) append [_foreachindex];
missionNamespace setVariable ["AAF",_Occup];
} forEach Zones;	
*/

//Zones structure: [...[Sectors,Level,Occupant(Nation),Territory]...]//
for "_i" from 0 to (count Zones - 1) do
{
    _Occup = missionNamespace getVariable "AAF";
    (_Occup param[7]) append [_i];
    missionNamespace setVariable ["AAF",_Occup]; 
};

[["worldname",worldname],"zones",Zones,"worlds"] call DBS_fnc_SetData;
["Init has finished and zones have been calculated!","server_fnc_init","Calculates zones, sectors and spawns first time markers.",false,false] call DEV_fnc_rptDump;


