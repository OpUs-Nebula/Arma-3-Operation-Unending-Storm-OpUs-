
_Id  = param[0];
_Veh = param[1];


waitUntil {(MissionNamespace getVariable _Id) isEqualTo "INACTIVE"};

if !(isNil "_Veh") then 
{
    DeleteVehicle _Veh;
};