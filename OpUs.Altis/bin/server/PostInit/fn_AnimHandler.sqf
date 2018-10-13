
_Unit = param[0];
waitUntil { Behaviour _Unit == "COMBAT" };
_Unit call BIS_fnc_ambientAnim__terminate;
