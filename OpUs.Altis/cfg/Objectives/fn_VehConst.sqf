
params ["_Fac","_Veh","_Nat","_Player","_Side","_Spawns","_Fort"];


//To introduce timer, maybe based on price and fac combined with tier(equation) or just tier.
//Most likely equation. Not to volatile with regards to price, modders might want
//More expensive vehicles and more generous funds.

_Veh createVehicle (selectRandom _Spawns);

_DispVeh  = gettext (configFile >> "CfgVehicles" >> _Veh >> "displayName");
_NearCity = nearestLocation [getPos _Fort,"nameCity"];
_Base     = _Fort getVariable "Name";
_Hint = format ["Your %1 has been built at %2, %3m from %4",_DispVeh,_Base,floor ((getPos _Fort) distance _NearCity),text _NearCity];
_Hint remoteExec ["systemChat",_Player];