_Unit = param[0,"",[ObjNull]];
if ((_Unit isEqualTo "") or {!(_Unit isKindOf "Man")}) exitWith {hint "Error! Unit is Not Object/Man!(UnitKillDam)"};
_KilShtr   = param[1,"",[objNull]];
_InstDam   = param[2,"",[0,objNull]];
_ShttrBool = param[3,"",[objNull,false]];

_RewardConst = 2500;//TBD, should enable strider within 1-2 days of fighting(300-600 kills)
//If "Hit" EH was initiator
if (_InstDam isEqualType 0) then
{
    [_KilShtr,_RewardConst * _InstDam] spawn UTL_fnc_EarnFunds;
    systemchat format ["Shot Connected, %1 Rewarded",(_RewardConst * _InstDam) * (1.5 * (skill _Unit))];	
}
else // if "Killed" EH was initiator
{
    [_KilShtr,_RewardConst / 2] spawn UTL_fnc_EarnFunds;
    systemchat format ["Unit Killed, %1 Rewarded",_RewardConst / 2];
    
	[getPlayerUID _KilShtr,"Funds",_KilShtr getVariable "Funds",_KilShtr] spawn DBC_fnc_SetPlayer;    
};



