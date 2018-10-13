
//copyToClipboard (typeOf(nearestBuilding CENTERPOS));
//Hint "Class of Building hase been Exported to Clipboard";
//Dont get a Heart attack for the need of relative pos for each object, just use
//Relative pos to building for the pickables aswell! problem solved!
//And Random Selection from those labelled shelf for IntelSpawn.

private ["_GrdsExt","_GrdsInt","_Supplies","_Props"];

_Fort     = nearestBuilding CENTERPOS;

_HVTpos = [];
{
    _Offset = _Fort worldToModel (getPosATL _x);
	_RelDir = ((getDir _x) - (getDir _Fort));
    _HVTpos append [[_Offset,_RelDir],'BREAK'];
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
    _Supplies append [[_Offset,_RelDir],'BREAK'];
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



copyToClipboard (format [
    "
    _GrdsExt  = %1;
	_GrdsInt  = %2;
	_Supplies = %3;	
    _Furn     = %4;
	_Props    = %5;
	_Intel    = %6;
	_HVTpos   = %7;
	",_GrdsExt,_GrdsInt,_Supplies,_Furn,_Props,_Intel,_HVTpos
	]);
	
	hint "Offsets extracted!";
