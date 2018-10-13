
//copyToClipboard (typeOf(nearestBuilding CENTERPOS));
//Hint "Class of Building hase been Exported to Clipboard";
//Dont get a Heart attack for the need of relative pos for each object, just use
//Relative pos to building for the pickables aswell! problem solved!
//And Random Selection from those labelled shelf for IntelSpawn.

private ["_GrdsExt","_GrdsInt","_Supplies","_Props","_FstDwn","_Flip"];

_Fort     = nearestBuilding CENTERPOS;
_BuildingC = typeOf _Fort;

_HVTpos = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _HVTpos append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (units HVT);

_GrdsExt  = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
    _GrdsExt append [[_Offset,_RelDir],'BREAK'];
} forEach (units EXTGUARDS);

_GrdsInt  = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
    _GrdsInt append [[_Offset,_RelDir],'BREAK'];
} forEach (units INTGUARDS);

_Supplies = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _Supplies append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects SUPPLYLOGIC);


_Furn     = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _Furn append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects SEATLOGIC);

_Props    = []; 
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _Props append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects PROPLOGIC);
_Intel    = []; 
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _Intel append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects INTELLOGIC);

_FstDwn = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _FstDwn append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects FSTDOWNLOGIC);

_Flip = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
	_Class  = typeOf _x;
    _Flip append [[_Offset,_RelDir,_Class],'BREAK'];
} forEach (synchronizedObjects FLIPLOGIC);


copyToClipboard (format [
    "
	FORT: %10
	
    _GrdsExt  = %1;
	_GrdsInt  = %2;
	_Supplies = %3;	
    _Furn     = %4;
	_Props    = %5;
	_Intel    = %6;
	_HVTpos   = %7;
	_Flips    = %8;
	_FstDwn   = %9;
	",_GrdsExt,_GrdsInt,_Supplies,_Furn,_Props,_Intel,_HVTpos,_Flip,_FstDwn,_BuildingC
	]);
	
	hint "Base Offsets extracted!";
