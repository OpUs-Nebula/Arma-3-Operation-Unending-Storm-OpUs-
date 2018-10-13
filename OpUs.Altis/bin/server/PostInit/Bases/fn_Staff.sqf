
params ["_Side","_GrpSide","_Units","_Nat","_Fort","_GrdsExt","_GrdsInt","_HVTpos","_Furn"];

_Engs  = ["O_engineer_F","B_engineer_F","I_engineer_F"];
_Comnd = ["O_Officer_F","B_Officer_F","I_Officer_F"];

_ExteriorGrp  = CreateGroup [_GrpSide, true];
_ExtAnim  = ["STAND","STAND_IA","LEAN","WATCH","WATCH1","WATCH2"];
{
	_Clss = selectRandom _Units;
    _Pos  = _Fort modelToWorld (_x param[0]);
	_Unit = _ExteriorGrp createUnit [(configName _Clss),_Pos, [], 0, "CAN_COLLIDE"];
	_Unit setVariable ["NATION",_Nat];
	_Unit setDir ((_x param[1]) + (getDir _Fort));
	_Unit setPosATL _Pos;
	_Pose = selectRandom _ExtAnim;
	[_unit,_Pose,"ASIS"] call BIS_fnc_ambientAnimCombat;
	[_Unit,true] spawn PI_fnc_SetSkill;
	_Wpns = ([_Nat] call cfg_fnc_BaseLoadouts) param[0] param[1];
	[_Unit,_Wpns] call PI_fnc_AiLoadout;
	[_Unit] spawn UTL_fnc_GodTillComb;
	[_Unit] call cfg_fnc_infiniAmmo;
	
} forEach _GrdsExt;
	
_InteriorGrp  = CreateGroup [_GrpSide, true];
_IntAnim      = ["GUARD"];
{

	_Clss = selectRandom _Units;
    _Pos  = _Fort modelToWorld (_x param[0]);
	_Unit = _InteriorGrp createUnit [(configName _Clss),_Pos, [], 0, "CAN_COLLIDE"];
	_Unit setVariable ["NATION",_Nat];
	_Unit setDir ((_x param[1]) + (getDir _Fort));
	_Unit setPosATL _Pos;
	_Pose = selectRandom _IntAnim;
	[_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnim;
	
	_Wpns = ([_Nat] call cfg_fnc_BaseLoadouts) param[0] param[0];
	[_Unit,_Wpns] call PI_fnc_AiLoadout;
	[_Unit] spawn UTL_fnc_GodTillComb;
	[_Unit] call cfg_fnc_infiniAmmo;
} forEach _GrdsInt;

_SpecGrp   = CreateGroup [_GrpSide, true];    
_SpecAnim  = ["REPAIR_VEH_STAND","BRIEFING"];
{
    _Clss = _x param[2];
	if (_Clss isEqualTo "B_engineer_F") then 
	{
	    _Clss = _Engs param[_Side];
		_Pos  = _Fort modelToWorld (_x param[0]);
	    _Unit = _SpecGrp createUnit [_Clss,_Pos, [], 0, "CAN_COLLIDE"];
	    _Unit setVariable ["NATION",_Nat,true];
	    _Unit setDir ((_x param[1]) + (getDir _Fort));
		_Unit setPosATL _Pos;
		_Unit allowDamage false;
		[_Unit,_Fort] spawn BAS_fnc_AliveHandler;
		_Unit setVariable ["Params",[_Nat,_Unit,_Fort,_Side,_GrpSide],true];
		[
            _Unit,                                                      // Object the action is attached to
            "Open Engineering",                                                  // Title of the action
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // Idle icon shown on screen
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // Progress icon shown on screen
            "(_this distance _target < 3) && ((_this getVariable 'NATION') isEqualTo (_target getVariable 'NATION'))",                                   // Condition for the action to be shown
            "_caller distance _target < 3",                                 // Condition for the action to progress
            {},                                                             // Code executed when action starts
            {},                                                             // Code executed on every progress tick
            {(_target getVariable "Params") spawn BAS_fnc_Engineer;},                           // Code executed on completion
            {},                                                             // Code executed on interrupted
            [],                                                             // Arguments passed to the scripts as _this select 3
            2,                                                             // Action duration [s]
            0,                                                              // Priority
            false,                                                           // Remove on completion
            false                                                           // Show in unconscious state 
        ] remoteExec ["BIS_fnc_holdActionAdd",0,_Unit];                
                                                                            // example for MP compatible implementation;
	    _Pose = _SpecAnim param[0];
	    [_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnim;
	}
	else
	{
	    _Clss = _Comnd param[_Side];
		_Pos  = _Fort modelToWorld (_x param[0]);
	    _Unit = _SpecGrp createUnit [_Clss,_Pos, [], 0, "CAN_COLLIDE"];
	    _Unit setVariable ["NATION",_Nat];
	    _Unit setDir ((_x param[1]) + (getDir _Fort));
		_Unit setPosATL _Pos;
		_Unit allowDamage false;
	    [_Nat,_Unit,_Fort,_Side,_GrpSide] spawn BAS_fnc_Commander;
		[_Unit,_Fort] spawn BAS_fnc_AliveHandler;
	    _Pose = _SpecAnim param[1];
	    [_Unit,_Pose,"ASIS"] call BIS_fnc_ambientAnim;
	};
} forEach _HVTpos;

{
    _Listnr = configName (selectRandom _Units);
    _Pos  = _Fort modelToWorld (_x param[0]);
    _Dir  = (_x param[1]) + (getDir _Fort);
    _Clss = _x param[2];
	_Veh = createVehicle [_Clss, _Pos, [], 0, "CAN_COLLIDE"];
	
	_Veh enableSimulationGlobal false;
	_Veh allowDamage false;
	[_Veh,_Fort] spawn BAS_fnc_AliveHandler;
	
	_Veh setDir _Dir;
	_Veh setPosATL _Pos;
    _Unit    = _SpecGrp createUnit [_Listnr,_Pos,[],0,"CAN_COLLIDE"];
	_Unit setDir (_Dir + 180);
	_Wpns = ([_Nat] call cfg_fnc_BaseLoadouts) param[1];
	[_Unit,_Wpns] call PI_fnc_AiLoadout;
	_Unit allowDamage false;
	[_Unit,_Fort] spawn BAS_fnc_AliveHandler;
	
	_Pose = "";
	if (_x param[2] isEqualTo "Land_OfficeChair_01_F") then 
	{
	   _Pose = "SIT_AT_TABLE";
	   
	   //_SeatPos = _Veh modelToWorld [0,0,0];
	   [_Unit,_Pose,"NONE"] call BIS_fnc_ambientAnim;
	   //_Unit setPosATL _SeatPos;
	   _Unit setVariable ["NATION",_Nat];
	} 
	else 
	{
	//Diff? before alt after ambientanim call the unit is position is set.
	   _SeatPos = _Veh modelToWorld [0,0,0];
	   _Pose = "SIT_U3";
	   _Unit setPosATL _SeatPos;
	   [_Unit,_Pose,"NONE"] call BIS_fnc_ambientAnim;
	   _Unit setVariable ["NATION",_Nat];
	};
    //[_Unit] spawn PI_fnc_AnimHandler;		
} forEach _Furn;



[_InteriorGrp,_ExteriorGrp]