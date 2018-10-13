params ["_Veh","_Fort"];

waitUntil { !Alive _Fort };

_Veh enableSimulationGlobal true;
_Veh allowDamage true;
_Veh setDamage 1;

uiSleep 30;

deleteVehicle _Veh;