
//copyToClipboard (typeOf(nearestBuilding CENTERPOS));
//Hint "Class of Building hase been Exported to Clipboard";
//Dont get a Heart attack for the need of relative pos for each object, just use
//Relative pos to building for the pickables aswell! problem solved!
//And Random Selection from those labelled shelf for IntelSpawn.

private ["_GrdsExt","_GrdsInt","_Supplies","_Props"];
/*
_Fort     = nearestBuilding CENTERPOS;

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
*/
	PASTE = [];
{	
    _Logic    = _x;
    _Fort     = nearestObject [_x,"Building"];
    
    _VehSpawn = [];
    {
        _Offset = _Fort worldToModel (getPosATL _x);
    	_RelDir = ((getDir _x) - (getDir _Fort));
		_Class  = typeOf _x;
        _VehSpawn append [[_Offset,_RelDir,_Class],'BREAK'];
    } forEach (synchronizedObjects _Logic);
	
	PASTE append [[(format [
    "
	_Fort     = %1;
	_VehSpawn = %2;
	",typeOf _Fort,_VehSpawn]),'BREAKBUILDING']];
	
} forEach (synchronizedObjects FACTORYLOGIC);

copyToClipboard str PASTE;

hint "Vehicle Spawns have been extracted! Can be found on ClipBoard and in the PASTE variable.";