
_Nat   = param [0,"",[""]];
_Side  = (missionNamespace getVariable _Nat) param[4];
_GrpSide = "";

switch (true) do 
{
    case(_Side isEqualTo 0): { _GrpSide = east; };
	case(_Side isEqualTo 1): { _GrpSide = west; };
	case(_Side isEqualTo 2): { _GrpSide = independent; };
};

 _Fltrs = format ["( 
        (getNumber (_x >> 'scope') >= 2) && 
        {getNumber (_x >> 'side') == %1 && 
        {getText (_x >> 'vehicleClass') in ['Men'] 
            } 
        } 
    )",_Side];

_Units = _Fltrs configClasses (configFile >> "CfgVehicles");

[_GrpSide,_Units]