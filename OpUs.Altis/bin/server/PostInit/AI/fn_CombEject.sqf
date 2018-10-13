params["_VehGrp","_VehArr"];

waitUntil {behaviour leader _VehGrp == "COMBAT"};

{
    _Veh = _x;
	{
	    commandGetOut _x;
	} forEach (assignedCargo _Veh);
} forEach _VehArr;