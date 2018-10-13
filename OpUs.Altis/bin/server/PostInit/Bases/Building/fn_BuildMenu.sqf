disableSerialization;

params ["_Nat","_Fort","_Side"];

//NOTE: _ctrl LbAdd "item"; does work with displays, not IDC version.
_Facs = ["NONE, ACTUALLY TRIVIAL"] call cfg_fnc_FactoryParams;

_cam = "camcurator" camCreate (position player); 
_cam cameraEffect ["internal", "BACK"];

_Opts = [_Facs];

[] spawn {findDisplay 46 createDisplay 'client_Building_Display'};
waitUntil { !isNull (findDisplay 356851) };

_UIupdt =
{
    
    _Facts = param[0,[],[[]]]; 
    _Lb = (findDisplay 356851) displayCtrl 1500;
	lbClear _Lb;
    {
    		_Lb lbAdd (_x param[1]);
    		_Lb lbSetPicture [_foreachindex,gettext (configFile >> "CfgVehicles" >> (_x param[0]) >> "icon")];
			
			if ((_x param[1]) isEqualType "") then 
			{
    		    _Lb lbSetTooltip [_foreachindex,(_x param[1])];
			}
			else
			{
			    _Lb lbSetTooltip [_foreachindex,configName _x];   
			};
			
			if ((_x param[0]) isEqualType "") then
			{
    		    _Lb lbSetData [_foreachindex,(_x param[0])];
			}
			else
			{
			    _Lb lbSetData [_foreachindex,configName _x];
			};
    } foreach _Facts;
};
	
_LbClss = (findDisplay 356851) displayCtrl 2100;

_LbClss lbAdd "Factories";
_LbClss lbSetData [0,"0"];
_LbClss lbAdd "Defences";
_LbClss lbSetData [1,"1"];

_Sldr = (findDisplay 356851) displayCtrl 1900;
_Buy  = (findDisplay 356851) displayCtrl 1600;

///Debug: _Cmmnd = format ["systemChat str [%1,%2,%3];",_Nat,_Fort,_Side];
_Cmmnd = "(findDisplay 356851) setVariable ['Build',true];";
_Buy buttonSetAction _Cmmnd; 
(findDisplay 356851) setVariable ['Build',false];
		   
_CurrBuild = "";
_Obj       = "";
_ObjPos    = [];
_ObjDir    = 0;
_Modls     = [];
_RetPos    = getPos player;
_OldClss   = "";
while {!isNull (findDisplay 356851)} do 
{
    if !(isNil {(findDisplay 356851) getVariable "LBCL"}) then
    {
	    if (_OldClss isEqualTo ((findDisplay 356851) getVariable "LBCL")) then
		{
		    _OldClss = parseNumber ((findDisplay 356851) getVariable "LBCL");
            [_Opts param[_OldClss]] call _UIupdt;		
		};
    };	
    if (_Cam distance _Fort > 550) then 
	{
	    _Pos = getPos _Fort; 
		_Diff = _RetPos vectorDiff _Pos;
	    _Cam setPos (_Pos vectorAdd _Diff);
		hint str _Diff;
	}
    else
    {
	    _RetPos = getPos _Cam;
    };	
	if (!isNil {(findDisplay 356851) getVariable 'LBSL'}) then 
	{
	    if (!(_CurrBuild IsEqualTo ((findDisplay 356851) getVariable 'LBSL'))) then
        {
		    //Debug
			/*
		    _Inf = (findDisplay 356851) getVariable 'LBSL';
            ["CurrBuild Not Changed.","CON_fnc_Buildmenu",(format ["BuildMenu not detected in LB, LB_DATA == %1",_Inf]),true] call DEV_fnc_rptDump;
  			*/
		    if (!(_CurrBuild IsEqualTo "")) then 
			{
			    deleteVehicle _Obj;
			    {
				    deleteVehicle (_x param[2]);
				} forEach _Modls;
			};
			_Clss = (findDisplay 356851) getVariable 'LBSL';
	        _Obj  = _Clss createVehicleLocal (screenToWorld [0.5,0.5]);
			_Obj setDir 0;
			_Obj allowDamage false;
			_Sldr sliderSetPosition 0;
			
			_Data = [_Clss] call cfg_fnc_FactoryParams;
			_Modls     = [];
			_ObjPos    = [];
			{
			    _Offst = _x param[0];
				_Dir   = _x param[1];
				_Holo  = "";
				switch (_x param[2]) do 
				{
				        case "B_MBT_01_cannon_F": { _Holo = "Land_VR_Target_MBT_01_cannon_F"; };
						case "B_APC_Wheeled_01_cannon_F": { _Holo = "Land_VR_Target_APC_Wheeled_01_F"; };
						case "B_MRAP_01_F": { _Holo = "Land_VR_Target_MRAP_01_F"; };
						default { _Holo = _x param[2]; };
				};
			    _Veh   = _Holo createVehicleLocal (_Obj modelToWorld _Offst);
				_Veh allowDamage false;
				_Veh setDir (_Dir + (getDir _Obj));
			    _Pckt  = [_Offst,_Dir,_Veh];
				
				_Modls append [_Pckt];
			} forEach (_Data param[0]);
			_CurrBuild = _Clss;
        };
        if !(isNull _Obj) then 
		{
		    if (!(surfaceIsWater (screenToWorld [0.5,0.5])) && (!((getPos _Obj) isEqualTo (screenToWorld [0.5,0.5])) && ((_Fort distance (screenToWorld [0.5,0.5])) <= 500))) then
			{
		        _Obj setPos (screenToWorld [0.5,0.5]);
			};
			_sDir = (360 / 10) * (sliderPosition _Sldr);
			if !(_sDir isEqualTo _ObjDir) then 
			{
			    _Obj setDir _sDir;
				_ObjDir = _sDir;
			};	
		};	
		//Debug
		/*
        _Inf = (findDisplay 356851) getVariable 'LBSL';
        ["CurrBuild Changed!","CON_fnc_Buildmenu",(format ["BuildMenu position spawn detected change in LB, LB_DATA == %1",_Inf]),true] call DEV_fnc_rptDump;  		
		*/
		if !(_ObjPos isEqualTo (getPos _Obj)) then //((isNull _Obj) or (_ObjPos isEqualTo (getPos _Obj)))
		{    
		    {			   
		        (_x param[2]) setPos (_Obj modelToWorld (_x param[0]));
		    	(_x param[2]) setDir ((_x param[1]) + (getDir _Obj));
			} forEach _Modls; 
            _ObjPos = getPos _Obj;			
		};
//		systemChat format["Condition = %1,",(findDisplay 356851) getVariable 'Build'];
        if (((findDisplay 356851) getVariable 'Build') && (!isNull _Obj)) then 
        {
		    systemChat "Launching Building Factory...";
		    _Price = (([typeOf _Obj] call cfg_fnc_FactoryParams) param[2]) call cfg_fnc_PriceCalc;
//			_Funds = player getVariable "Funds";
		    
			if !(isNil {player getVariable "Funds"} or (player getVariable "Funds") < _Price) then 
			{
			    systemChat "Launching fnc!";
				_Funds = (player getVariable "Funds") - _Price;
				player setVariable ["Funds",_Funds]; 
				
		        [_Obj,_Modls,_Nat,_Fort,_Side] spawn CON_fnc_Assemble;
            }
            else
            {
			    systemChat "You don't have enough funds to construct this building!";
            };
            (findDisplay 356851) setVariable ['Build',false];			
        };		
	};	
};

if !(isNull _Cam) then 
{
    _cam cameraEffect ["Terminate", "Back"];
    camDestroy _cam;
};

if !(_Obj isEqualTo "") then { if !(isNull _Obj) then {deleteVehicle _Obj;}; };
if (count _Modls > 0) then 
{
    {deleteVehicle (_x param[2]);} forEach _Modls;
};
