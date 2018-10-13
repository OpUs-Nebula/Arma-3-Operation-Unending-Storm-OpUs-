params ["_Unit"];

_Unit allowDamage false;

waitUntil { (behaviour _Unit) == "COMBAT" };

_Unit allowDamage true;