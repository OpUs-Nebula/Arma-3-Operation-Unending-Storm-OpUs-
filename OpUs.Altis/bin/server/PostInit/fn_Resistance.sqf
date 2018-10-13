params ["_Unit","_Id","_lvl"];

WaitUntil { ((missionNamespace getVariable _Id) param[0] isEqualTo "CAPTURED") or !(Alive _Unit) };

_Buff = (_lvl * 900) + 1050;
sleep _Buff;

if (!(isNil "_Unit")) then {
    deleteVehicle _Unit;
};