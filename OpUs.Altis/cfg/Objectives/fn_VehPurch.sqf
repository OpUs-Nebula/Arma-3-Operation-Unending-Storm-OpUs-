//FORGIVE ME FOR THY BOIS CORNY FNC NAME, FOR RAM IS LIMITED, AND PERFORMANCE DESIRED,
//THUS SHORT NAMES ARE VITAL.

params ["_Fac","_Nat","_Side","_player","_Spawns","_Fort"];

_Veh     = (findDisplay 126851) getVariable 'LBSL';
_VehData = [_Nat,_Veh] call cfg_fnc_VehicleParams;
_Price   = [_VehData param[1]] call cfg_fnc_PriceCalc;
_Funds   = _Player getVariable "Funds";

if (_Funds >= _Price) then 
{
    _player setVariable ["Funds",_Funds - _Price,true];
    [_Fac,_Veh,_Nat,_Player,_Side,_Spawns,_Fort] spawn cfg_fnc_VehConst;
	"Vehicle is Under Construction!" remoteExec ["systemChat",_Player];
}
else
{
    "You don't have enough cash for this purchase!" remoteExec ["systemChat",_Player];
};

