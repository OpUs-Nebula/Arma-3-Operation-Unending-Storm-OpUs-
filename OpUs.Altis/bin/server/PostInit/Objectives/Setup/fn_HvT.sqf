
params ["_Obj","_HVTpos","_GrpSide","_Occup","_Id","_Lvl"];

_KingsGrd = CreateGroup [_GrpSide,true];
_HVT      = _KingsGrd createUnit [_HVTclss,_Obj modelToWorld (_HVTpos param[0] param[0]), [], 0, "CAN_COLLIDE"];
_HVT setVariable ["NATION",_Occup];
[_HVT,"BRIEFING","ASIS"] call BIS_fnc_ambientAnim;
[_HVT] spawn PI_fnc_AnimHandler;
_HVT setVariable ["DOGTAG",[_Desig]];
_HVT setDir ((_HVTpos param [0] param[1]) + (getDir _Obj));
[_HVT,_Id,_Lvl] spawn PI_fnc_Resistance;
_HVT addEventHandler ["Killed",
                     {
                         _Nat = param[1] getVariable "NATION";
	                     hint format ["A Commander has been killed by %1!",_Nat];
                      }];